module 0x80cb17db97b41e6bf991bf703c751216ae8a63c5de3eec31840481c66ec58f9d::aia {
    struct AIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIA>(arg0, 9, b"AIA", b"DeAgentAI", b"AIA is the native utility and governance token of DeAgentAI, the leading decentralized AI Agent infrastructure platform. It is used to access AI services, stake for rewards, participate in governance, and unlock cross-chain utilities", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.deagent.ai/DA-AA.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<AIA>>(0x2::coin::mint<AIA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AIA>>(v2);
    }

    // decompiled from Move bytecode v6
}

