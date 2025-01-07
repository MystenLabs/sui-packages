module 0x33f9ab25a4a33842f1cc5c70bcdb74fa88958b16101877011040fa2abda85fbf::shim {
    struct SHIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIM>(arg0, 9, b"SHIM", b"ShibaMoon", b"ShibaMoon - To the moon. SHIM will always be by your side on your meme adventures", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f0d2a5f-1e82-481e-baaf-e8f4605054da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

