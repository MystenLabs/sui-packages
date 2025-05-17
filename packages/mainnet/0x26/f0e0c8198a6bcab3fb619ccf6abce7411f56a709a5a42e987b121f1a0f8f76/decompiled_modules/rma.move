module 0x26f0e0c8198a6bcab3fb619ccf6abce7411f56a709a5a42e987b121f1a0f8f76::rma {
    struct RMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RMA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RMA>(arg0, 6, b"RMA", b"Rami coin", b"I am just a hamster", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/32_DI_Cm_W_400x400_aeb0e3b001.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RMA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RMA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

