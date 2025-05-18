module 0x701bdd6856ce761e196b906ebf059371635acef99b6543f67061b430cf368191::suiora {
    struct SUIORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIORA>(arg0, 6, b"SUIORA", b"Zeraora Pokecombat", b"s", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihxvums5iu2yyzpw2hkns5232zxnps7iferdmus7bdgd3ylskjzvy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIORA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIORA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

