module 0x23b4a97cb587c85ab5c1a510897d9335e377fe8f94a7a360062c8054f68381d4::hot {
    struct HOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOT>(arg0, 9, b"HOT", b"Hot", b"hot is best token in the sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d499639e-3b2d-4b22-8714-0595a3dae5f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

