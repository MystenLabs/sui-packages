module 0x2fcacddcf7046b67f1847634d631c726b402e9e7c160e9ec6b5ddbab230a6349::turbo {
    struct TURBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBO>(arg0, 9, b"TURBO", b"Baby Turbo", b"Baby Turbo Token on Sui is a fast, scalable cryptocurrency optimized for quick, low-cost transactions. It powers seamless, secure transfers within the Sui blockchain, ideal for high-speed trading and decentralized apps.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/964186552292143106/Fhlpdf_M.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TURBO>(&mut v2, 220000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

