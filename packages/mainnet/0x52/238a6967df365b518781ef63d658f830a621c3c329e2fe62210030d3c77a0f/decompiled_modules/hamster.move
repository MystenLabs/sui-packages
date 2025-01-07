module 0x52238a6967df365b518781ef63d658f830a621c3c329e2fe62210030d3c77a0f::hamster {
    struct HAMSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMSTER>(arg0, 9, b"HAMSTER", b"bongcute", b"Cute hamster bongbong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe01ec14-0294-41f7-87c3-397a7cb04485.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMSTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAMSTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

