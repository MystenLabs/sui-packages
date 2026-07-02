module 0x9bf74cf02a8b1810b254bbbedd8f502ab911a663bd92e72629b70324d84408b8::stretch_gang_music_nft {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Release has key {
        id: 0x2::object::UID,
        release_number: u64,
        track_title: 0x1::string::String,
        artist_alias: 0x1::string::String,
        cover_art: 0x2::url::Url,
        audio_url: 0x2::url::Url,
        price_mist: u64,
        max_supply: u64,
        minted: u64,
        royalty_bps: u64,
        is_open: bool,
    }

    struct MusicNFT has store, key {
        id: 0x2::object::UID,
        release_number: u64,
        serial: u64,
        track_title: 0x1::string::String,
        artist_alias: 0x1::string::String,
        cover_art: 0x2::url::Url,
        audio_url: 0x2::url::Url,
        royalty_bps: u64,
        minted_at: u64,
    }

    public entry fun create_release(arg0: &AdminCap, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 <= 10000, 4);
        let v0 = Release{
            id             : 0x2::object::new(arg9),
            release_number : arg1,
            track_title    : 0x1::string::utf8(arg2),
            artist_alias   : 0x1::string::utf8(arg3),
            cover_art      : 0x2::url::new_unsafe_from_bytes(arg4),
            audio_url      : 0x2::url::new_unsafe_from_bytes(arg5),
            price_mist     : arg6,
            max_supply     : arg7,
            minted         : 0,
            royalty_bps    : arg8,
            is_open        : true,
        };
        0x2::transfer::share_object<Release>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: &mut Release, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_open, 3);
        assert!(arg0.minted < arg0.max_supply, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.price_mist, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0xb735145d8976ab7b26e868a88c2d789dbda9b5ace13e956889a7d03c1927fcf0);
        arg0.minted = arg0.minted + 1;
        let v0 = MusicNFT{
            id             : 0x2::object::new(arg2),
            release_number : arg0.release_number,
            serial         : arg0.minted,
            track_title    : arg0.track_title,
            artist_alias   : arg0.artist_alias,
            cover_art      : arg0.cover_art,
            audio_url      : arg0.audio_url,
            royalty_bps    : arg0.royalty_bps,
            minted_at      : 0x2::tx_context::epoch(arg2),
        };
        0x2::transfer::public_transfer<MusicNFT>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun royalty_bps(arg0: &MusicNFT) : u64 {
        arg0.royalty_bps
    }

    public entry fun set_open(arg0: &AdminCap, arg1: &mut Release, arg2: bool) {
        arg1.is_open = arg2;
    }

    public fun treasury() : address {
        @0xb735145d8976ab7b26e868a88c2d789dbda9b5ace13e956889a7d03c1927fcf0
    }

    // decompiled from Move bytecode v7
}

