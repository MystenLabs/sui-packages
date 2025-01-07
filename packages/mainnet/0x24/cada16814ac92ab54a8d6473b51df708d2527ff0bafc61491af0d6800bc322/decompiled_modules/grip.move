module 0x24cada16814ac92ab54a8d6473b51df708d2527ff0bafc61491af0d6800bc322::grip {
    struct GRIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRIP>(arg0, 6, b"GRIP", b"King Pinch", b"Pinching jeeeeetzzz and surfing the waves. You could ssy I'm a bit rough around the edges, but gets things done.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a5531411_2df0_47ed_abff_db124bdd93ee_adb0b075b9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

