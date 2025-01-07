module 0x89fd553aeeeb5e16d9f423f04fb6ffa1bbd463c447c789b6f43c615283c155e0::hybob {
    struct HYBOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYBOB>(arg0, 6, b"HYBOB", b"Hydro-Bob", b"Just a family guy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1085_bc64aa82c9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYBOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HYBOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

