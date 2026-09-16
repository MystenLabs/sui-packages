module 0xb3badfae45854071b863784e61d03f44da07e4f6d07faa7ab55e04948254a215::party_social {
    struct XData has copy, drop, store {
        handle: 0x1::string::String,
    }

    struct InstagramData has copy, drop, store {
        handle: 0x1::string::String,
    }

    struct ThreadsData has copy, drop, store {
        handle: 0x1::string::String,
    }

    struct TikTokData has copy, drop, store {
        handle: 0x1::string::String,
    }

    struct YouTubeData has copy, drop, store {
        handle: 0x1::string::String,
    }

    struct DiscordData has copy, drop, store {
        handle: 0x1::string::String,
    }

    struct TelegramData has copy, drop, store {
        handle: 0x1::string::String,
    }

    struct RedditData has copy, drop, store {
        handle: 0x1::string::String,
    }

    struct TwitchData has copy, drop, store {
        handle: 0x1::string::String,
    }

    struct FacebookData has copy, drop, store {
        handle: 0x1::string::String,
    }

    public fun discord(arg0: 0x1::string::String) : 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<DiscordData> {
        validate_handle(&arg0);
        let v0 = DiscordData{handle: arg0};
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::new<DiscordData>(v0)
    }

    public fun discord_handle(arg0: &DiscordData) : 0x1::string::String {
        arg0.handle
    }

    public fun facebook(arg0: 0x1::string::String) : 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<FacebookData> {
        validate_handle(&arg0);
        let v0 = FacebookData{handle: arg0};
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::new<FacebookData>(v0)
    }

    public fun facebook_handle(arg0: &FacebookData) : 0x1::string::String {
        arg0.handle
    }

    public fun instagram(arg0: 0x1::string::String) : 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<InstagramData> {
        validate_handle(&arg0);
        let v0 = InstagramData{handle: arg0};
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::new<InstagramData>(v0)
    }

    public fun instagram_handle(arg0: &InstagramData) : 0x1::string::String {
        arg0.handle
    }

    public fun reddit(arg0: 0x1::string::String) : 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<RedditData> {
        validate_handle(&arg0);
        let v0 = RedditData{handle: arg0};
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::new<RedditData>(v0)
    }

    public fun reddit_handle(arg0: &RedditData) : 0x1::string::String {
        arg0.handle
    }

    public fun telegram(arg0: 0x1::string::String) : 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<TelegramData> {
        validate_handle(&arg0);
        let v0 = TelegramData{handle: arg0};
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::new<TelegramData>(v0)
    }

    public fun telegram_handle(arg0: &TelegramData) : 0x1::string::String {
        arg0.handle
    }

    public fun threads(arg0: 0x1::string::String) : 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<ThreadsData> {
        validate_handle(&arg0);
        let v0 = ThreadsData{handle: arg0};
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::new<ThreadsData>(v0)
    }

    public fun threads_handle(arg0: &ThreadsData) : 0x1::string::String {
        arg0.handle
    }

    public fun tiktok(arg0: 0x1::string::String) : 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<TikTokData> {
        validate_handle(&arg0);
        let v0 = TikTokData{handle: arg0};
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::new<TikTokData>(v0)
    }

    public fun tiktok_handle(arg0: &TikTokData) : 0x1::string::String {
        arg0.handle
    }

    public fun twitch(arg0: 0x1::string::String) : 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<TwitchData> {
        validate_handle(&arg0);
        let v0 = TwitchData{handle: arg0};
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::new<TwitchData>(v0)
    }

    public fun twitch_handle(arg0: &TwitchData) : 0x1::string::String {
        arg0.handle
    }

    fun validate_handle(arg0: &0x1::string::String) {
        assert!(!0x1::string::is_empty(arg0), 0);
        assert!(0x1::string::length(arg0) <= 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::max_identifier_length(), 1);
    }

    public fun x(arg0: 0x1::string::String) : 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<XData> {
        validate_handle(&arg0);
        let v0 = XData{handle: arg0};
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::new<XData>(v0)
    }

    public fun x_handle(arg0: &XData) : 0x1::string::String {
        arg0.handle
    }

    public fun youtube(arg0: 0x1::string::String) : 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<YouTubeData> {
        validate_handle(&arg0);
        let v0 = YouTubeData{handle: arg0};
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::new<YouTubeData>(v0)
    }

    public fun youtube_handle(arg0: &YouTubeData) : 0x1::string::String {
        arg0.handle
    }

    // decompiled from Move bytecode v7
}

