module 0x8b449b4dc0f8c5f996734eaf23d36a5f6724e02e312a7e4af34bd0bb74de7b17::deagent_token {
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
        0x2::coin::mint_and_transfer<DEAGENT_TOKEN>(&mut v2, 800000000000000000, @0xcf24599b32607ffe849d75b8a6c21e0e49f011ad377989583adda053b26bcb77, arg1);
        0x2::coin::mint_and_transfer<DEAGENT_TOKEN>(&mut v2, 200000000000000000, @0xe04abe8fcf2c2b4272082dcd873510a373157f29e8bdadad956edcd46fc3165c, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DEAGENT_TOKEN>>(v2);
    }

    public entry fun join_coins(arg0: &mut 0x2::coin::Coin<DEAGENT_TOKEN>, arg1: 0x2::coin::Coin<DEAGENT_TOKEN>) {
        0x2::coin::join<DEAGENT_TOKEN>(arg0, arg1);
    }

    public entry fun split_coin(arg0: &mut 0x2::coin::Coin<DEAGENT_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DEAGENT_TOKEN>>(0x2::coin::split<DEAGENT_TOKEN>(arg0, arg1, arg3), arg2);
    }

    public entry fun transfer_coin(arg0: 0x2::coin::Coin<DEAGENT_TOKEN>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DEAGENT_TOKEN>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

