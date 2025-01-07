module 0x7bea29ad1b0d33daab5eb8bf2c05512683f45ac48fa44c16382f7d0f5c73856::suibums {
    struct SUIBUMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBUMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBUMS>(arg0, 6, b"SUIBUMS", b"SUI BUMS", b"BUMS LIVE ON SUI! 1M IMO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3506_a2c6b6b42f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBUMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBUMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

