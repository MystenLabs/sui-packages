module 0x73f95910df447b5f67f0109970230a7fef7ff7378a06abd8d26efffefdfe73f9::dsss {
    struct DSSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSSS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DSSS>(arg0, 6, b"DSSS", b"DDDD", b"dawedqwdaw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.daosui.fun/uploads/krillin_2_e5df32e1f6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DSSS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSSS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

