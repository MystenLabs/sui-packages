module 0x1f744865fb01fcf7a22db7e5c699c9ce2d52a34366ae2384560332a675b3b155::hawksui {
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

