module 0xf80bf61b0301dde00917045a7365bb69419ddb7c43abeb370348ee6c12b45c54::hawksui {
    struct HAWKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAWKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAWKSUI>(arg0, 6, b"HAWKSUI", b"HAWK SUI", b"Hawk Tuah Comunnity welcome, we need a twitter! join the tele and lets set it up to fly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_12_8d3ac4d3d8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAWKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAWKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

