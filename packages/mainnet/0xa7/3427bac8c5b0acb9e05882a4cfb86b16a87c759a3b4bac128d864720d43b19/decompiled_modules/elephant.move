module 0xa73427bac8c5b0acb9e05882a4cfb86b16a87c759a3b4bac128d864720d43b19::elephant {
    struct ELEPHANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELEPHANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELEPHANT>(arg0, 9, b"ELEPHANT", b"BEC", b"Baby Elephant Coin is a unique heavy and strong coin that has the stamina to maintain and retain it's unique characteristic nature and ever dynamic block chain echo system and market fluctuations", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1ee44089-38ba-4b85-8c9e-9a62669d00db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELEPHANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELEPHANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

