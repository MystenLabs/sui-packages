module 0x8b355c20ef82dbe6e628a3e0ccb6b36f1b668f3a47c3647fc21407b06d732416::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TOKEN>(arg0, 9, 0x1::string::utf8(b"token"), 0x1::string::utf8(b"token"), 0x1::string::utf8(b"hi"), 0x1::string::utf8(b"https://placehold.co/400"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TOKEN>>(0x2::coin_registry::finalize<TOKEN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

