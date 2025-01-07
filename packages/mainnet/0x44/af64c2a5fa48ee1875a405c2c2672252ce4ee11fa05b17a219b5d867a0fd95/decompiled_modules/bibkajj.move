module 0x44af64c2a5fa48ee1875a405c2c2672252ce4ee11fa05b17a219b5d867a0fd95::bibkajj {
    struct BIBKAJJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIBKAJJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIBKAJJ>(arg0, 9, b"BIBKAJJ", b"Bibka", b"Bibka can bip hip", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0ea3c457-9269-487d-8ec3-ae5d2db50d6f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIBKAJJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIBKAJJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

