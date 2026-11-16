module 0x5e69f67610c74b25a4b75ea160e5721d5b440c025b6dce222450c7b9c96dc9d3::grpctxir {
    struct GRPCTXIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRPCTXIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRPCTXIR>(arg0, 6, b"GRPCTXIR", b"gRPC rail test", b"Binderoo rail test, no value", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRPCTXIR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRPCTXIR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

