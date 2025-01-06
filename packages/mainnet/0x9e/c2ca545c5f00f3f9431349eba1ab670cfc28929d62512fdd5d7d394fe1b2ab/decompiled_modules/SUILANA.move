module 0x9ec2ca545c5f00f3f9431349eba1ab670cfc28929d62512fdd5d7d394fe1b2ab::SUILANA {
    struct SUILANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILANA>(arg0, 6, b"SUILANA", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUILANA>>(v1);
        0x2::coin::mint_and_transfer<SUILANA>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILANA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

