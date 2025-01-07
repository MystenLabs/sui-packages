module 0xc291b66989130902dd7b9684dfbf77d4d8ef57118a8fadc2a77d48f9d11ece0b::bbb {
    struct BBB has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BBB>, arg1: 0x2::coin::Coin<BBB>) {
        assert!(false == false, 100);
        0x2::coin::burn<BBB>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BBB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (false == true && 0x2::balance::supply_value<BBB>(0x2::coin::supply<BBB>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<BBB>>(0x2::coin::mint<BBB>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBB>(arg0, 9, b"BBB", b"BBB", b"Big Bigger Biggest", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.arweave.net/lPZBu7uL1Ew5hkw0U8C3hp3RY5YKOhJUtbE8MSZ2sl0?ext=jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

