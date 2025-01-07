module 0x6410c2638bea2605beb05b1dab8159cac23737a0c03026200cfa3e1e7b582901::catme {
    struct CATME has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATME>(arg0, 9, b"CATME", b"Cat meme", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/51bb9a64-cecc-4082-b9a9-e2f50ed6f93d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATME>>(v1);
    }

    // decompiled from Move bytecode v6
}

