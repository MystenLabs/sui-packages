module 0x4592095daef921f9229c7a35f56ed4a363fea5e34d82edb01e1cc744499754fd::hihehihe {
    struct HIHEHIHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIHEHIHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIHEHIHE>(arg0, 9, b"HIHEHIHE", b"Bap", b"Andk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/877bda2c-950c-4a67-865b-3f11e5c994c3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIHEHIHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIHEHIHE>>(v1);
    }

    // decompiled from Move bytecode v6
}

