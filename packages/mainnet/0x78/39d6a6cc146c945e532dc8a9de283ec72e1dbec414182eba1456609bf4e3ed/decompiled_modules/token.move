module 0x7839d6a6cc146c945e532dc8a9de283ec72e1dbec414182eba1456609bf4e3ed::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TOKEN>(arg0, 6, 0x1::string::utf8(b"AMPBSK"), 0x1::string::utf8(b"Amped basket staging"), 0x1::string::utf8(b"Test coin of the Amped basket staging package. Not a product."), 0x1::string::utf8(b"https://popular.fun/template.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TOKEN>>(0x2::coin_registry::finalize<TOKEN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

