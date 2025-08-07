module 0xc4def77adb9ac33a80b438fbfdd091b58127b97ff99575c5af90e8d004a28959::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEST>, arg1: 0x2::coin::Coin<TEST>) {
        assert!(false == false, 100);
        0x2::coin::burn<TEST>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (false == true && 0x2::balance::supply_value<TEST>(0x2::coin::supply<TEST>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST>>(0x2::coin::mint<TEST>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 9, b"TEST", b"Test Coin", b"Test Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.arweave.net/UhPH4mEgViAEb0npPGslDvF-USghu6A3qkZVIrM1HxM?ext=jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

