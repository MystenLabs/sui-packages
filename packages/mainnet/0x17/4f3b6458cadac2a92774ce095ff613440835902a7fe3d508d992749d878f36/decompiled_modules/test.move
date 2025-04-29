module 0x174f3b6458cadac2a92774ce095ff613440835902a7fe3d508d992749d878f36::test {
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
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 0, b"TEST", b"Token Test", b"Some test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.arweave.net/R55sIJH0VDOk1P2fJmLhcMPOucPujWpjKqANBlIKvZ0?ext=jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

