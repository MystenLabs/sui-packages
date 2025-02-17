module 0x2cfb99d84ab873e5f6eb72f88668301e041913434571d7efd3f1e0b21fbd6705::fit {
    struct FIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIT>(arg0, 6, b"FIT", b"OFFICIAL RAY LEWIS", b"OFFICIAL RAY LEWIS COIN $FIT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Af2_E_Zs_Kt8h_O5q_Yf4_fb6d57e70c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

