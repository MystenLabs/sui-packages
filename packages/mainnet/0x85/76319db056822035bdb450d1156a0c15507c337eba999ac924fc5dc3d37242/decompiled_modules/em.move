module 0x8576319db056822035bdb450d1156a0c15507c337eba999ac924fc5dc3d37242::em {
    struct EM has drop {
        dummy_field: bool,
    }

    fun init(arg0: EM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EM>(arg0, 9, b"EM", b"Elon musk", x"456c6f6e206d75736b20636f696e20f09faa99205465736c61", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/206f9979-e053-4fb5-9d0a-8fc25b96547f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EM>>(v1);
    }

    // decompiled from Move bytecode v6
}

