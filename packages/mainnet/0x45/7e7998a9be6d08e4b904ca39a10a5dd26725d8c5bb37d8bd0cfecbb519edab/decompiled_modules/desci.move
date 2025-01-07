module 0x457e7998a9be6d08e4b904ca39a10a5dd26725d8c5bb37d8bd0cfecbb519edab::desci {
    struct DESCI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DESCI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DESCI>(arg0, 9, b"DESCI", b"SUI Desci Agents", b"SUI Desci Agents is a layer revolutionizing longevity science by launching tokenized compounds, promoting them with AI agents, and implementing advanced liquidity mechanics inspired by Pump.fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/SUI_Desci_Agents_logo_a7a89cb634.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DESCI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<DESCI>>(0x2::coin::mint<DESCI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DESCI>>(v2);
    }

    // decompiled from Move bytecode v6
}

