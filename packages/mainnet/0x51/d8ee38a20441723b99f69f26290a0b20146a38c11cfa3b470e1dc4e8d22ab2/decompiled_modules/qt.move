module 0x51d8ee38a20441723b99f69f26290a0b20146a38c11cfa3b470e1dc4e8d22ab2::qt {
    struct QT has drop {
        dummy_field: bool,
    }

    fun init(arg0: QT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QT>(arg0, 9, b"QT", b"QT meme", b"My first project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/97f5f6f4-5ad0-410d-9606-4732cc4de2b9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QT>>(v1);
    }

    // decompiled from Move bytecode v6
}

