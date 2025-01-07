module 0xacb85d00b7e56a8fe5d8537f98ecb2e3ea127787d84ad33563d2b7017e443b7a::pay {
    struct PAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAY>(arg0, 6, b"Sui PAY", b"PAY", b"Sui Pay Utility Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAY>>(v1);
        0x2::coin::mint_and_transfer<PAY>(&mut v2, 1000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAY>>(v2, 0x2::tx_context::sender(arg1));
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PAY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<PAY>(arg0) + arg1 <= 200000000 * 1000000, 0);
        0x2::coin::mint_and_transfer<PAY>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

