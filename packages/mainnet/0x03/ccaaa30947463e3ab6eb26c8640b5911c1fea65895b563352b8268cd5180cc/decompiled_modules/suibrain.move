module 0x3ccaaa30947463e3ab6eb26c8640b5911c1fea65895b563352b8268cd5180cc::suibrain {
    struct SUIBRAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBRAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBRAIN>(arg0, 6, b"SUIBRAIN", b"BIG BRAIN OF SUI", b"SUIBRAIN is the token for those who think big and play smart on Sui. Flex your mental muscles and join the Sui's masterminds with SUIBRAIN where brainpower leads to gains!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIBRAIN_f5b085d493.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBRAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBRAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

