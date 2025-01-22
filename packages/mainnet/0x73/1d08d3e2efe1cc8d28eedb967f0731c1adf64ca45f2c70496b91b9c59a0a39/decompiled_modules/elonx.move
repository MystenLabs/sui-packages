module 0x731d08d3e2efe1cc8d28eedb967f0731c1adf64ca45f2c70496b91b9c59a0a39::elonx {
    struct ELONX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONX>(arg0, 6, b"ELONX", b"D.O.G.E. X ", b"Department of Government Efficiency(DOGE) coin created by the community, we follow our leader Elon Musk. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737523606206.37")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELONX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

