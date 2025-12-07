module 0x99cc0e7834326ec6ac571421e9b8e042e9eb63062771c77ac592bd194180b5da::deagent_token {
    struct DEAGENT_TOKEN has drop {
        dummy_field: bool,
    }

    public fun get_coin_value(arg0: &0x2::coin::Coin<DEAGENT_TOKEN>) : u64 {
        0x2::coin::value<DEAGENT_TOKEN>(arg0)
    }

    fun init(arg0: DEAGENT_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEAGENT_TOKEN>(arg0, 9, b"AIA", b"DeAgentAI", b"AIA is the native utility and governance token of DeAgentAI, the leading decentralized AI Agent infrastructure platform. It is used to access AI services, stake for rewards, participate in governance, and unlock cross-chain utilities.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.deagent.ai/DA-AA.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEAGENT_TOKEN>>(v1);
        0x2::coin::mint_and_transfer<DEAGENT_TOKEN>(&mut v2, 800000000000000000, @0x53a0f5cb5bb98d20c04e5ebcd334bd062c5b1a54a24514c9adeda9938960584d, arg1);
        0x2::coin::mint_and_transfer<DEAGENT_TOKEN>(&mut v2, 200000000000000000, @0xff139cc24837e475ad6209e88561e394812dcb99f06d1674b5b01bc4570e5030, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DEAGENT_TOKEN>>(v2);
    }

    public fun join_coins(arg0: &mut 0x2::coin::Coin<DEAGENT_TOKEN>, arg1: 0x2::coin::Coin<DEAGENT_TOKEN>) {
        0x2::coin::join<DEAGENT_TOKEN>(arg0, arg1);
    }

    public fun split_coin(arg0: &mut 0x2::coin::Coin<DEAGENT_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DEAGENT_TOKEN>>(0x2::coin::split<DEAGENT_TOKEN>(arg0, arg1, arg3), arg2);
    }

    public fun transfer_coin(arg0: 0x2::coin::Coin<DEAGENT_TOKEN>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DEAGENT_TOKEN>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

