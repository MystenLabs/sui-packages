module 0x6e90787aafc3733916eb79e9f2c3a603c3235e2ee46b51cde427deac4e89fd8::agent {
    struct AGENT has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AGENT>, arg1: 0x2::coin::Coin<AGENT>) {
        assert!(false == false, 100);
        0x2::coin::burn<AGENT>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AGENT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (false == true && 0x2::balance::supply_value<AGENT>(0x2::coin::supply<AGENT>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<AGENT>>(0x2::coin::mint<AGENT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: AGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGENT>(arg0, 5, b"AGENT", b"Agent Coin", b"Agent's coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/9-3HAhP8jTuGt9Tu98_HzQ0-a9wFAk_DfPfgKUwO9CY")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

