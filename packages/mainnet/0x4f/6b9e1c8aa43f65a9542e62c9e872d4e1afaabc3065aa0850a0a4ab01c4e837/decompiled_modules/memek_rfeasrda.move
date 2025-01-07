module 0x4f6b9e1c8aa43f65a9542e62c9e872d4e1afaabc3065aa0850a0a4ab01c4e837::memek_rfeasrda {
    struct MEMEK_RFEASRDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_RFEASRDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_RFEASRDA>(arg0, 6, b"MEMEKRFEASRDA", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_RFEASRDA>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_RFEASRDA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_RFEASRDA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

