module 0x50973441261a4f31727545dcec51d62c4650d0167057a306b83100073128f7b2::doggie {
    struct DOGGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGGIE>(arg0, 9, b"DOGGIE", b"Dog on sui", x"446f67206f6e207375692e2e2e2042756c6c697368f09f94a5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6719d0dd-3d69-4790-86e3-8b070b5dee45.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

