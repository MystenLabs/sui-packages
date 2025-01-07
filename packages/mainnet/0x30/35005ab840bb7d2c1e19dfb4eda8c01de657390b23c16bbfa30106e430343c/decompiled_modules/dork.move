module 0x3035005ab840bb7d2c1e19dfb4eda8c01de657390b23c16bbfa30106e430343c::dork {
    struct DORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORK>(arg0, 6, b"DORK", b"Dork", b"Youre poor. Youre unimportant. Men do not fear you. Stop being a dork, and buy $DORK.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_23f64ffcb4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

