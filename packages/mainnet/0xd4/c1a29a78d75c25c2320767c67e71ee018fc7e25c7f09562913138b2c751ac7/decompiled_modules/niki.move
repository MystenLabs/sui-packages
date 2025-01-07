module 0xd4c1a29a78d75c25c2320767c67e71ee018fc7e25c7f09562913138b2c751ac7::niki {
    struct NIKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIKI>(arg0, 9, b"NIKI", b"Niki cat", b"Nikicat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7f1d2f63-416c-489a-99b5-cdc57c8d447a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

