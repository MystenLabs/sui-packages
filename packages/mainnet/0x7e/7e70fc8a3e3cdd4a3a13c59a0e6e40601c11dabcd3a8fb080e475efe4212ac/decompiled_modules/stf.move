module 0x7e7e70fc8a3e3cdd4a3a13c59a0e6e40601c11dabcd3a8fb080e475efe4212ac::stf {
    struct STF has drop {
        dummy_field: bool,
    }

    fun init(arg0: STF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STF>(arg0, 9, b"STF", b"suiflow", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

