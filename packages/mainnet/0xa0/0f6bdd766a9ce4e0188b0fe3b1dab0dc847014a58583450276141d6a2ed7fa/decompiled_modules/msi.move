module 0xa00f6bdd766a9ce4e0188b0fe3b1dab0dc847014a58583450276141d6a2ed7fa::msi {
    struct MSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSI>(arg0, 6, b"MSI", b"Missui", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSI>>(v1);
        0x2::coin::mint_and_transfer<MSI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

