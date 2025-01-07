module 0x247e1b261453d90be6da0331a64ad9b433adebfff2ceefe462e9db5c65359c67::sugo {
    struct SUGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUGO>(arg0, 6, b"SUGO", b"Super Angry Goku", b"then something just snapped", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4e24d6ccf7e2f8b2a44c23f3888c288c_fbdc47160f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

