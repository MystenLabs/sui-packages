module 0x64af99148f31c17d52208ad8c59c422ac99334a6f3d342ef8d2aa0ccc45a84ec::stress {
    struct STRESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRESS>(arg0, 6, b"STRESS", b"STRESS PUMP", b"I CAN'T SLEEPPPPPPPP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dscsdcdc_ab4129777a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

