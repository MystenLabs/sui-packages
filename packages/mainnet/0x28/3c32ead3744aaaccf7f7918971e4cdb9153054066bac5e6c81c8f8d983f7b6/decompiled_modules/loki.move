module 0x283c32ead3744aaaccf7f7918971e4cdb9153054066bac5e6c81c8f8d983f7b6::loki {
    struct LOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOKI>(arg0, 9, b"LOKI", b"Loki", b"Loki Token ($LOKI) is a mischievously fun meme cryptocurrency inspired by the Norse God of Mischief. Loki represents playful chaos, unpredictability, and decentralized power. Whether you're a fan of Norse mythology or a crypto enthusiast,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e47479c5-c336-411b-8e26-ca2dfbcc1651.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

