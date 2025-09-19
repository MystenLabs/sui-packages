module 0x96a78e1346ee266279a8e00500c26bb610b665643c5808b3c393b824e3513201::odc {
    struct ODC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODC>(arg0, 6, b"ODC", b"OBE CAT", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ODC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

