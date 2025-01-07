module 0x802042b1b3655268be9deb540e6ff2055bcb00d2c75d86141e5c04da8bf24949::chadx {
    struct CHADX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHADX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHADX>(arg0, 9, b"CHADX", b"SuiChad", b"SuiChad is the ultimate meme platform for those who embody the bold, confident, and legendary spirit of the Sui ecosystem. Filled with top-tier, alpha-status humor, SuiChad is where memes go from ordinary to iconic. Whether you're looking to flex your Sui knowledge or simply enjoy some high-energy laughs, this is the place for the Sui elite. Join the ranks of the SuiChads and embrace the humor of champions!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1828137222903828480/2bKWSRMo.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHADX>(&mut v2, 1250000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHADX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHADX>>(v1);
    }

    // decompiled from Move bytecode v6
}

