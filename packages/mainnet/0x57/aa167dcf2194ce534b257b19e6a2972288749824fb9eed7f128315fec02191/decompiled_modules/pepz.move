module 0x57aa167dcf2194ce534b257b19e6a2972288749824fb9eed7f128315fec02191::pepz {
    struct PEPZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPZ>(arg0, 9, b"PEPZ", b"PEPERONI", b"PEPERONI is a meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/85957274-3c4d-49ef-8ebf-4b707d5fa974.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

