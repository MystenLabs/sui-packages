module 0x211804168f4fe16d5f75b4dd8a7e47367cc1ca1b49dd968752bba1afe66c36da::hamster {
    struct HAMSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HAMSTER>(arg0, 6, b"HAMSTER", b"HAMSTER", b"SuiEmoji Hamster", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/hamster.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAMSTER>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMSTER>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

