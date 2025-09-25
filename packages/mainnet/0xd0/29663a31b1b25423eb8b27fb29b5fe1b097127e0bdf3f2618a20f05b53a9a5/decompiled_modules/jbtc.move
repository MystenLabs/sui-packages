module 0xd029663a31b1b25423eb8b27fb29b5fe1b097127e0bdf3f2618a20f05b53a9a5::jbtc {
    struct JBTC has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<JBTC>, arg1: 0x2::coin::Coin<JBTC>) {
        0x2::coin::burn<JBTC>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<JBTC>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JBTC> {
        0x2::coin::mint<JBTC>(arg0, arg1, arg2)
    }

    fun init(arg0: JBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JBTC>(arg0, 6, b"JBTC", b"jBTC", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1758822401284YlWV.jpeg"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JBTC>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<JBTC>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JBTC> {
        assert!(0x2::coin::total_supply<JBTC>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<JBTC>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

