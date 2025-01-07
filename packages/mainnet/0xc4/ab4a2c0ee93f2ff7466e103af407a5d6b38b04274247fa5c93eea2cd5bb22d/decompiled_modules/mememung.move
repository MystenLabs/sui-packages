module 0xc4ab4a2c0ee93f2ff7466e103af407a5d6b38b04274247fa5c93eea2cd5bb22d::mememung {
    struct MEMEMUNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEMUNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEMUNG>(arg0, 9, b"MEMEMUNG", b"Mungoi", b"Jxjxjxjjx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7f769704-a835-455c-9aff-0df665fd1139.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEMUNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEMUNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

