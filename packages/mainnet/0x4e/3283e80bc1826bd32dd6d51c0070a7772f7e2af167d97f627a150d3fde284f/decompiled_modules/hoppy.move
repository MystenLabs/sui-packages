module 0x4e3283e80bc1826bd32dd6d51c0070a7772f7e2af167d97f627a150d3fde284f::hoppy {
    struct HOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPY>(arg0, 9, b"HOPPY", b"SuiBunny", b"SuiBunny is a fast, secure token on the SUI blockchain, combining innovation with a playful vibe. It fosters a vibrant ecosystem, perfect for users seeking a fun yet powerful DeFi experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1458918461585956866/TVxs951o.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOPPY>(&mut v2, 800000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

