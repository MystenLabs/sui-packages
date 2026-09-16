module 0x37724a2ee9f642afe6aefdfe9aa9bf620e3e9251ca47174e4f530edcfa756a62::party_music {
    struct SpotifyData has copy, drop, store {
        artist_id: 0x1::string::String,
    }

    struct BandcampData has copy, drop, store {
        subdomain: 0x1::string::String,
    }

    struct SoundCloudData has copy, drop, store {
        username: 0x1::string::String,
    }

    struct AppleMusicData has copy, drop, store {
        artist_id: 0x1::string::String,
    }

    struct DeezerData has copy, drop, store {
        artist_id: 0x1::string::String,
    }

    struct TidalData has copy, drop, store {
        artist_id: 0x1::string::String,
    }

    struct AmazonMusicData has copy, drop, store {
        artist_id: 0x1::string::String,
    }

    struct AudiomackData has copy, drop, store {
        username: 0x1::string::String,
    }

    public fun amazon_music(arg0: 0x1::string::String) : 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<AmazonMusicData> {
        validate_id(&arg0);
        let v0 = AmazonMusicData{artist_id: arg0};
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::new<AmazonMusicData>(v0)
    }

    public fun amazon_music_artist_id(arg0: &AmazonMusicData) : 0x1::string::String {
        arg0.artist_id
    }

    public fun apple_music(arg0: 0x1::string::String) : 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<AppleMusicData> {
        validate_id(&arg0);
        let v0 = AppleMusicData{artist_id: arg0};
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::new<AppleMusicData>(v0)
    }

    public fun apple_music_artist_id(arg0: &AppleMusicData) : 0x1::string::String {
        arg0.artist_id
    }

    public fun audiomack(arg0: 0x1::string::String) : 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<AudiomackData> {
        validate_id(&arg0);
        let v0 = AudiomackData{username: arg0};
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::new<AudiomackData>(v0)
    }

    public fun audiomack_username(arg0: &AudiomackData) : 0x1::string::String {
        arg0.username
    }

    public fun bandcamp(arg0: 0x1::string::String) : 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<BandcampData> {
        validate_id(&arg0);
        let v0 = BandcampData{subdomain: arg0};
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::new<BandcampData>(v0)
    }

    public fun bandcamp_subdomain(arg0: &BandcampData) : 0x1::string::String {
        arg0.subdomain
    }

    public fun deezer(arg0: 0x1::string::String) : 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<DeezerData> {
        validate_id(&arg0);
        let v0 = DeezerData{artist_id: arg0};
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::new<DeezerData>(v0)
    }

    public fun deezer_artist_id(arg0: &DeezerData) : 0x1::string::String {
        arg0.artist_id
    }

    public fun soundcloud(arg0: 0x1::string::String) : 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<SoundCloudData> {
        validate_id(&arg0);
        let v0 = SoundCloudData{username: arg0};
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::new<SoundCloudData>(v0)
    }

    public fun soundcloud_username(arg0: &SoundCloudData) : 0x1::string::String {
        arg0.username
    }

    public fun spotify(arg0: 0x1::string::String) : 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<SpotifyData> {
        validate_id(&arg0);
        let v0 = SpotifyData{artist_id: arg0};
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::new<SpotifyData>(v0)
    }

    public fun spotify_artist_id(arg0: &SpotifyData) : 0x1::string::String {
        arg0.artist_id
    }

    public fun tidal(arg0: 0x1::string::String) : 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<TidalData> {
        validate_id(&arg0);
        let v0 = TidalData{artist_id: arg0};
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::new<TidalData>(v0)
    }

    public fun tidal_artist_id(arg0: &TidalData) : 0x1::string::String {
        arg0.artist_id
    }

    fun validate_id(arg0: &0x1::string::String) {
        assert!(!0x1::string::is_empty(arg0), 0);
        assert!(0x1::string::length(arg0) <= 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::max_identifier_length(), 1);
    }

    // decompiled from Move bytecode v7
}

