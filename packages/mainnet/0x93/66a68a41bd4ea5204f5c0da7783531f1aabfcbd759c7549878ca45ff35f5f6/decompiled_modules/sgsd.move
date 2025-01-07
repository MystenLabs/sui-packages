module 0x9366a68a41bd4ea5204f5c0da7783531f1aabfcbd759c7549878ca45ff35f5f6::sgsd {
    struct SGSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGSD>(arg0, 9, b"SGSD", b"W", b"HDFH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a2c56799-27a0-401f-98d8-eccc65cf9a6d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

