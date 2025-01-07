module 0x38ed29a952dfd8009d55f095eaa41b69b5a41fab6ae91fbb8ee19f4745aba4f5::MPAD {
    struct MPAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MPAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MPAD>(arg0, 9, b"MPAD", b"MPAD", b"MPAD", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MPAD>>(v1);
        0x2::coin::mint_and_transfer<MPAD>(&mut v2, 226600000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MPAD>>(v2);
    }

    // decompiled from Move bytecode v6
}

