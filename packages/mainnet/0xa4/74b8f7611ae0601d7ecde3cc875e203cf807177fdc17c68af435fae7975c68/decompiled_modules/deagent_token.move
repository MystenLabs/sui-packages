module 0xa474b8f7611ae0601d7ecde3cc875e203cf807177fdc17c68af435fae7975c68::deagent_token {
    struct DEAGENT_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEAGENT_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEAGENT_TOKEN>(arg0, 9, b"AIA", b"DeAgentAI", b"AIA is the native utility and governance token of DeAgentAI, the leading decentralized AI Agent infrastructure platform. It is used to access AI services, stake for rewards, participate in governance, and unlock cross-chain utilities", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.deagent.ai/DA-AA.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEAGENT_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<DEAGENT_TOKEN>>(0x2::coin::mint<DEAGENT_TOKEN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DEAGENT_TOKEN>>(v2);
    }

    // decompiled from Move bytecode v6
}

