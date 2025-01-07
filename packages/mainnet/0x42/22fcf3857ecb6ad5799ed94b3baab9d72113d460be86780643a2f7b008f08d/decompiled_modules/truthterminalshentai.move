module 0x4222fcf3857ecb6ad5799ed94b3baab9d72113d460be86780643a2f7b008f08d::truthterminalshentai {
    struct TRUTHTERMINALSHENTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUTHTERMINALSHENTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUTHTERMINALSHENTAI>(arg0, 6, b"TruthTerminalsHentai", b"HentAI", b"HentAI on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hent_Al_d9b10d9a04.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUTHTERMINALSHENTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUTHTERMINALSHENTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

