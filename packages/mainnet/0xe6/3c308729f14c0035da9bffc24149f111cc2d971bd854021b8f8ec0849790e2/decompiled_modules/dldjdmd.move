module 0xe63c308729f14c0035da9bffc24149f111cc2d971bd854021b8f8ec0849790e2::dldjdmd {
    struct DLDJDMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DLDJDMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DLDJDMD>(arg0, 9, b"DLDJDMD", b"Prkdkdm", b"Fldjfmfm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b4bb2cac-3f88-4176-8e64-ce3022068a37.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DLDJDMD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DLDJDMD>>(v1);
    }

    // decompiled from Move bytecode v6
}

