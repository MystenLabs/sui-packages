module 0xcb43d8ad8dc6e65ae0833f48992129c2c687dcd6f423f1284edaaaa94c58628a::jizz {
    struct JIZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIZZ>(arg0, 6, b"JIZZ", b"Jizz Doge", x"4265666f72652074686572652077617320446f67652c20746865726520776173204a495a5a20444f4745200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jizz_doge_logo_7d8534b46f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JIZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

