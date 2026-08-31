module 0x1cc0fbebb1e1dc890c29863e7e639152c02cb3e6f119ba5b2b3bf83679bce819::vahvx2_073575a7e93ca1d4 {
    struct VAHVX2_073575A7E93CA1D4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAHVX2_073575A7E93CA1D4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAHVX2_073575A7E93CA1D4>(arg0, 0, b"VAHVX2", b"Signed Launch 14k HAHVX2", b"14k graduation threshold verification token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAHVX2_073575A7E93CA1D4>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<VAHVX2_073575A7E93CA1D4>>(0x2::coin::mint<VAHVX2_073575A7E93CA1D4>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAHVX2_073575A7E93CA1D4>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

