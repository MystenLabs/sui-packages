module 0x19552b6fbbc5c00e7a604e53bd6cd8ce3df6b2c9e45ed4793c40dde104daf9cd::stmaxa {
    struct STMAXA has drop {
        dummy_field: bool,
    }

    fun init(arg0: STMAXA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STMAXA>(arg0, 9, b"STMAXA", b"Stmax", b"Stma----SSSSSSSSSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/78d91ea2-3d7d-48f0-b771-79887a3e4166.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STMAXA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STMAXA>>(v1);
    }

    // decompiled from Move bytecode v6
}

