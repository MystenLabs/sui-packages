module 0x11db0ed44a0122788cefc18d37f0daf721f10396397d1d02eced04d8ac2d0099::dolphinagent {
    struct DOLPHINAGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPHINAGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPHINAGENT>(arg0, 6, b"DOLPHINAGENT", b"$DolphinAgent", b"Dolphin Agent is the TOP AI Agent of the SUI Network. Scanning the depths of blockchain, it delivers sharp insights, precise data, and market intelligence in real time...Fueled by us, it powers staking, launchpads, and NFTsdriving innovation across the ecosystem..The tide is risingjoin the pod and ride the wave...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052838_2d111b9851.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPHINAGENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLPHINAGENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

