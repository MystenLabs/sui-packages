module 0xfbaabd0d6eddeb67bdbf64712d4641a326da2426a1c7afecd08128570de8c529::TEST123 {
    struct TEST123 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEST123>, arg1: 0x2::coin::Coin<TEST123>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<TEST123>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST123>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST123>>(0x2::coin::mint<TEST123>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<TEST123>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TEST123>>(arg0);
    }

    fun init(arg0: TEST123, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST123>(arg0, 9, b"TEST123", b"SUI Faucet33", b"Testing coin creator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.dictionary.com/e/wp-content/uploads/2018/03/asdfmovie-300x300.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST123>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST123>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

