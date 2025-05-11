module 0x98c5f159c16d72bb798fd8a62943fd6d573651cb62b654b4b971195f6fc5933e::sunyun12 {
    struct SUNYUN12 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNYUN12, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNYUN12>(arg0, 8, b"SUNYUN12", b"SUNYUN12", b"this is SUNYUN12", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUNYUN12>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNYUN12>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

