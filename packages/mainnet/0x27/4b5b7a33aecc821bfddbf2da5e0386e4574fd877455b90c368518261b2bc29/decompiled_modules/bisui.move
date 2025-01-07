module 0x274b5b7a33aecc821bfddbf2da5e0386e4574fd877455b90c368518261b2bc29::bisui {
    struct BISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BISUI>(arg0, 6, b"BISUI", b"BI SUI", b"Whats hidden underneath those bicep, is it muscle or is it love.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_19_01_10_361760c593.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

