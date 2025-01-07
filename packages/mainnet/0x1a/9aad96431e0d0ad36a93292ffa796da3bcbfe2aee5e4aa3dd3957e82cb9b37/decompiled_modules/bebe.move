module 0x1a9aad96431e0d0ad36a93292ffa796da3bcbfe2aee5e4aa3dd3957e82cb9b37::bebe {
    struct BEBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEBE>(arg0, 9, b"BEBE", b"Baby En", b"Crypto for fomo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5c6bac17-77d0-412e-8db4-6ac0cb7f07a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

