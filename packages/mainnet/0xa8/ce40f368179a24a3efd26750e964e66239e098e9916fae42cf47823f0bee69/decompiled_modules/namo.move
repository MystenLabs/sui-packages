module 0xa8ce40f368179a24a3efd26750e964e66239e098e9916fae42cf47823f0bee69::namo {
    struct NAMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAMO>(arg0, 9, b"NAMO", b"Modi Meme", b"Support Modo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f61ded54-dd98-427a-ac80-0dc968ee6a1e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

