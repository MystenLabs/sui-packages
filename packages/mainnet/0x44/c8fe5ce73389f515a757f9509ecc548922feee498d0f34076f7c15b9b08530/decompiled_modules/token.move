module 0x44c8fe5ce73389f515a757f9509ecc548922feee498d0f34076f7c15b9b08530::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TOKEN>(arg0, 6, 0x1::string::utf8(b"REG"), 0x1::string::utf8(b"Regulated test coin"), 0x1::string::utf8(b""), 0x1::string::utf8(b""), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TOKEN>>(0x2::coin_registry::make_regulated<TOKEN>(&mut v2, true, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TOKEN>>(0x2::coin_registry::finalize<TOKEN>(v2, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

