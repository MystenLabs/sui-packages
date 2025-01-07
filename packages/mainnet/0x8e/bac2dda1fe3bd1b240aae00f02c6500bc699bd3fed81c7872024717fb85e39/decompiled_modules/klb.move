module 0x8ebac2dda1fe3bd1b240aae00f02c6500bc699bd3fed81c7872024717fb85e39::klb {
    struct KLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KLB>(arg0, 6, b"KLB", b"Kyller boy", b"Hhhhggfdyff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000033874_d9fb326d60.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KLB>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KLB>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

