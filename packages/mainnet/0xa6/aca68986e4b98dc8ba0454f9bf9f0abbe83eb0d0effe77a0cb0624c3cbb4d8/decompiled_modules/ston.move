module 0xa6aca68986e4b98dc8ba0454f9bf9f0abbe83eb0d0effe77a0cb0624c3cbb4d8::ston {
    struct STON has drop {
        dummy_field: bool,
    }

    fun init(arg0: STON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STON>(arg0, 6, b"STON", b"SuiTon", b"SuiTon is a combination of Sui and Ton. I was inspired by coin memes on Ton and Sui, so I combined the two chains", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiton_logo_5b53c8905b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STON>>(v1);
    }

    // decompiled from Move bytecode v6
}

