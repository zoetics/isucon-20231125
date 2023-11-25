package main

import (
	"database/sql"
	"errors"
	"net/http"

	"github.com/labstack/echo/v4"
)

type Tag struct {
	ID   int64  `json:"id"`
	Name string `json:"name"`
}

type TagModel struct {
	ID   int64  `db:"id"`
	Name string `db:"name"`
}

type TagsResponse struct {
	Tags []*Tag `json:"tags"`
}

func GetTags() []Tag {
	return []Tag{
		{1, "ライブ配信"},
		{2, "ゲーム実況"},
		{3, "生放送"},
		{4, "アドバイス"},
		{5, "初心者歓迎"},
		{6, "プロゲーマー"},
		{7, "新作ゲーム"},
		{8, "レトロゲーム"},
		{9, "RPG"},
		{10, "FPS"},
		{11, "アクションゲーム"},
		{12, "対戦ゲーム"},
		{13, "マルチプレイ"},
		{14, "シングルプレイ"},
		{15, "ゲーム解説"},
		{16, "ホラーゲーム"},
		{17, "イベント生放送"},
		{18, "新情報発表"},
		{19, "Q&Aセッション"},
		{20, "チャット交流"},
		{21, "視聴者参加"},
		{22, "音楽ライブ"},
		{23, "カバーソング"},
		{24, "オリジナル楽曲"},
		{25, "アコースティック"},
		{26, "歌配信"},
		{27, "楽器演奏"},
		{28, "ギター"},
		{29, "ピアノ"},
		{30, "バンドセッション"},
		{31, "DJセット"},
		{32, "トーク配信"},
		{33, "朝活"},
		{34, "夜ふかし"},
		{35, "日常話"},
		{36, "趣味の話"},
		{37, "語学学習"},
		{38, "お料理配信"},
		{39, "手料理"},
		{40, "レシピ紹介"},
		{41, "アート配信"},
		{42, "絵描き"},
		{43, "DIY"},
		{44, "手芸"},
		{45, "アニメトーク"},
		{46, "映画レビュー"},
		{47, "読書感想"},
		{48, "ファッション"},
		{49, "メイク"},
		{50, "ビューティー"},
		{51, "健康"},
		{52, "ワークアウト"},
		{53, "ヨガ"},
		{54, "ダンス"},
		{55, "旅行記"},
		{56, "アウトドア"},
		{57, "キャンプ"},
		{58, "ペットと一緒"},
		{59, "猫"},
		{60, "犬"},
		{61, "釣り"},
		{62, "ガーデニング"},
		{63, "テクノロジー"},
		{64, "ガジェット紹介"},
		{65, "プログラミング"},
		{66, "DIY電子工作"},
		{67, "ニュース解説"},
		{68, "歴史"},
		{69, "文化"},
		{70, "社会問題"},
		{71, "心理学"},
		{72, "宇宙"},
		{73, "科学"},
		{74, "マジック"},
		{75, "コメディ"},
		{76, "スポーツ"},
		{77, "サッカー"},
		{78, "野球"},
		{79, "バスケットボール"},
		{80, "ライフハック"},
		{81, "教育"},
		{82, "子育て"},
		{83, "ビジネス"},
		{84, "起業"},
		{85, "投資"},
		{86, "仮想通貨"},
		{87, "株式投資"},
		{88, "不動産"},
		{89, "キャリア"},
		{90, "スピリチュアル"},
		{91, "占い"},
		{92, "手相"},
		{93, "オカルト"},
		{94, "UFO"},
		{95, "都市伝説"},
		{96, "コンサート"},
		{97, "ファンミーティング"},
		{98, "コラボ配信"},
		{99, "記念配信"},
		{100, "生誕祭"},
		{101, "周年記念"},
		{102, "サプライズ"},
		{103, "椅子"},
	}
}

func getTagHandler(c echo.Context) error {
	tags := []*Tag{
		{1, "ライブ配信"},
		{2, "ゲーム実況"},
		{3, "生放送"},
		{4, "アドバイス"},
		{5, "初心者歓迎"},
		{6, "プロゲーマー"},
		{7, "新作ゲーム"},
		{8, "レトロゲーム"},
		{9, "RPG"},
		{10, "FPS"},
		{11, "アクションゲーム"},
		{12, "対戦ゲーム"},
		{13, "マルチプレイ"},
		{14, "シングルプレイ"},
		{15, "ゲーム解説"},
		{16, "ホラーゲーム"},
		{17, "イベント生放送"},
		{18, "新情報発表"},
		{19, "Q&Aセッション"},
		{20, "チャット交流"},
		{21, "視聴者参加"},
		{22, "音楽ライブ"},
		{23, "カバーソング"},
		{24, "オリジナル楽曲"},
		{25, "アコースティック"},
		{26, "歌配信"},
		{27, "楽器演奏"},
		{28, "ギター"},
		{29, "ピアノ"},
		{30, "バンドセッション"},
		{31, "DJセット"},
		{32, "トーク配信"},
		{33, "朝活"},
		{34, "夜ふかし"},
		{35, "日常話"},
		{36, "趣味の話"},
		{37, "語学学習"},
		{38, "お料理配信"},
		{39, "手料理"},
		{40, "レシピ紹介"},
		{41, "アート配信"},
		{42, "絵描き"},
		{43, "DIY"},
		{44, "手芸"},
		{45, "アニメトーク"},
		{46, "映画レビュー"},
		{47, "読書感想"},
		{48, "ファッション"},
		{49, "メイク"},
		{50, "ビューティー"},
		{51, "健康"},
		{52, "ワークアウト"},
		{53, "ヨガ"},
		{54, "ダンス"},
		{55, "旅行記"},
		{56, "アウトドア"},
		{57, "キャンプ"},
		{58, "ペットと一緒"},
		{59, "猫"},
		{60, "犬"},
		{61, "釣り"},
		{62, "ガーデニング"},
		{63, "テクノロジー"},
		{64, "ガジェット紹介"},
		{65, "プログラミング"},
		{66, "DIY電子工作"},
		{67, "ニュース解説"},
		{68, "歴史"},
		{69, "文化"},
		{70, "社会問題"},
		{71, "心理学"},
		{72, "宇宙"},
		{73, "科学"},
		{74, "マジック"},
		{75, "コメディ"},
		{76, "スポーツ"},
		{77, "サッカー"},
		{78, "野球"},
		{79, "バスケットボール"},
		{80, "ライフハック"},
		{81, "教育"},
		{82, "子育て"},
		{83, "ビジネス"},
		{84, "起業"},
		{85, "投資"},
		{86, "仮想通貨"},
		{87, "株式投資"},
		{88, "不動産"},
		{89, "キャリア"},
		{90, "スピリチュアル"},
		{91, "占い"},
		{92, "手相"},
		{93, "オカルト"},
		{94, "UFO"},
		{95, "都市伝説"},
		{96, "コンサート"},
		{97, "ファンミーティング"},
		{98, "コラボ配信"},
		{99, "記念配信"},
		{100, "生誕祭"},
		{101, "周年記念"},
		{102, "サプライズ"},
		{103, "椅子"},
	}

	return c.JSON(http.StatusOK, &TagsResponse{
		Tags: tags,
	})
}

// 配信者のテーマ取得API
// GET /api/user/:username/theme
func getStreamerThemeHandler(c echo.Context) error {
	ctx := c.Request().Context()

	if err := verifyUserSession(c); err != nil {
		// echo.NewHTTPErrorが返っているのでそのまま出力
		c.Logger().Printf("verifyUserSession: %+v\n", err)
		return err
	}

	username := c.Param("username")

	tx, err := dbConn.BeginTxx(ctx, nil)
	if err != nil {
		return echo.NewHTTPError(http.StatusInternalServerError, "failed to begin transaction: "+err.Error())
	}
	defer tx.Rollback()

	userModel := UserModel{}
	err = tx.GetContext(ctx, &userModel, "SELECT id FROM users WHERE name = ?", username)
	if errors.Is(err, sql.ErrNoRows) {
		return echo.NewHTTPError(http.StatusNotFound, "not found user that has the given username")
	}
	if err != nil {
		return echo.NewHTTPError(http.StatusInternalServerError, "failed to get user: "+err.Error())
	}

	themeModel := ThemeModel{}
	if err := tx.GetContext(ctx, &themeModel, "SELECT * FROM themes WHERE user_id = ?", userModel.ID); err != nil {
		return echo.NewHTTPError(http.StatusInternalServerError, "failed to get user theme: "+err.Error())
	}

	if err := tx.Commit(); err != nil {
		return echo.NewHTTPError(http.StatusInternalServerError, "failed to commit: "+err.Error())
	}

	theme := Theme{
		ID:       themeModel.ID,
		DarkMode: themeModel.DarkMode,
	}

	return c.JSON(http.StatusOK, theme)
}
