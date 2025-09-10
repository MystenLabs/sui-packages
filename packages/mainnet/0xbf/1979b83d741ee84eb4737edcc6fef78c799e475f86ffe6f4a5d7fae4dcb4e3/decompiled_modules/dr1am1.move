module 0xbf1979b83d741ee84eb4737edcc6fef78c799e475f86ffe6f4a5d7fae4dcb4e3::dr1am1 {
    struct DR1AM1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DR1AM1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DR1AM1>(arg0, 8, b"DR1AM1", b"DR1AM1", b"this is dr1am1coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DR1AM1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DR1AM1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

