module 0x7c14b034ce1b7537146d7ce5ca74cb448dc43fce88b8506f4199a4f5494256cb::hamburger {
    struct HAMBURGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMBURGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMBURGER>(arg0, 6, b"Hamburger", b"hamburger", b"Is that what Trump said about hamburgers? Are you in?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012746_d200d4f655.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMBURGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMBURGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

