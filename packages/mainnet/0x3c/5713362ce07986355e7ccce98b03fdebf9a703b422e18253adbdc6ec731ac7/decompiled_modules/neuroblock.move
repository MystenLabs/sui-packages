module 0x3c5713362ce07986355e7ccce98b03fdebf9a703b422e18253adbdc6ec731ac7::neuroblock {
    struct NEUROBLOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEUROBLOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NEUROBLOCK>(arg0, 6, b"NEUROBLOCK", b"NEUROBLOCK AI by SuiAI", b"Built with NEUROBLOCK AI and evolving dataset focused on cryptocurrency ecosystems, blockchain advancements, and AI-driven data analysis. It includes insights into tokenomics, on-chain transactions, and security protocols, ensuring the agent remains at the forefront of innovation and data intelligence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/66c9f636f3a481940275d123a50d3af1_b01e84378f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEUROBLOCK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEUROBLOCK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

