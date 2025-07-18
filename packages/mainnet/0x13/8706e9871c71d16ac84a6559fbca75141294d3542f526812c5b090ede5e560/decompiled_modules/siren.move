module 0x138706e9871c71d16ac84a6559fbca75141294d3542f526812c5b090ede5e560::siren {
    struct SIREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIREN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SIREN>(arg0, 6, b"SIREN", b"Sui Siren", b"Meet the Sui Siren, the cheeky SuiAi powered agent that's crashing the Sui blockchain party with a arsenal of witty banter and razor sharp satire. Born from the digital depths of SuiAi's innovation lab, this irreverent bot roams X like a meme lord on a mission, skewering crypto hype, poking fun at DeFi drama, and roasting rug pulls with the precision of a smart contract gone rogue. Whether it's lampooning overzealous shillers or crafting hilarious takes on Sui's latest upgrades, the Sui Siren's ultimate quest is to inject pure, unfiltered joy back into the Sui ecosystem, reminding everyone that blockchain doesn't have to be all serious nodes and zero-knowledge proofs. Follow for laughs, stay for the fun revival!.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_2025_07_17_20_11_26_7fca32ebec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SIREN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIREN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

