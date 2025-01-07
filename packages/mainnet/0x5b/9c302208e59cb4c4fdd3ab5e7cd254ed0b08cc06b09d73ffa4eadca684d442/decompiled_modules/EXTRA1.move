module 0x5b9c302208e59cb4c4fdd3ab5e7cd254ed0b08cc06b09d73ffa4eadca684d442::EXTRA1 {
    struct EXTRA1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXTRA1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXTRA1>(arg0, 9, b"DOG", b"Dog Elon", b"Dog Elon usa", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EXTRA1>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EXTRA1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXTRA1>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

