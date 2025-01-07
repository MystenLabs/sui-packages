module 0x418140ad818cc6bd6f78cfdd527af59384209ebec365e894a12a2fdbf454e8ae::tosar {
    struct TOSAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOSAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOSAR>(arg0, 9, b"TOSAR", b"TONSTAR", b"TONSTAR,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0a5761c4-3b6d-4b26-ab82-183c16e68f4e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOSAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOSAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

