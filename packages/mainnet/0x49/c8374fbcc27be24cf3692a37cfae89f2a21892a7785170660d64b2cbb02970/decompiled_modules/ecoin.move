module 0x49c8374fbcc27be24cf3692a37cfae89f2a21892a7785170660d64b2cbb02970::ecoin {
    struct ECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECOIN>(arg0, 6, b"ECOIN", b"E coin", b"I feel the infinite power", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c_c_2_0719ff3d91.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ECOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

