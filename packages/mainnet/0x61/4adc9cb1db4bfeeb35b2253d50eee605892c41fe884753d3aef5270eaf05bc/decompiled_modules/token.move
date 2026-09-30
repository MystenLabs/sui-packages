module 0x614adc9cb1db4bfeeb35b2253d50eee605892c41fe884753d3aef5270eaf05bc::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TOKEN>(arg0, 6, 0x1::string::utf8(b"AMPSOL"), 0x1::string::utf8(b"Amped test SOL 20x"), 0x1::string::utf8(b"Test coin for the Amped defend_margin check. Not a product."), 0x1::string::utf8(b"https://popular.fun/template.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TOKEN>>(0x2::coin_registry::finalize<TOKEN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

