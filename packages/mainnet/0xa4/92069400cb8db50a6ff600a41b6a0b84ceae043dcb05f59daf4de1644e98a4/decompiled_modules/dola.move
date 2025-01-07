module 0xa492069400cb8db50a6ff600a41b6a0b84ceae043dcb05f59daf4de1644e98a4::dola {
    struct DOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOLA>(arg0, 6, b"DOLA", b"Dolphin Agent", b"Dolphin Agent: A Tier 1 AI-powered radar built on the SUI Network, leading the way in blockchain intelligence. Dolphin Agent provides real-time insights, accurate data, and market intelligence to keep users ahead of the curve..Driving innovation, Dolphin Agent offers tools like staking, launchpad, and NFT integration, all powered by $DOLA as its core utility token..Join the pod and stay ahead in the fast-moving crypto ocean....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/27_12_5_nho_hon_1_MB_01_afec78f0c4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOLA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

