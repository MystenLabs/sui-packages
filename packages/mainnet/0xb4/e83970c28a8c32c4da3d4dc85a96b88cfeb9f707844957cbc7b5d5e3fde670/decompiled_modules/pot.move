module 0xb4e83970c28a8c32c4da3d4dc85a96b88cfeb9f707844957cbc7b5d5e3fde670::pot {
    struct POT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POT>(arg0, 9, b"POT", b"the pot", x"496e7370697265642062792074686520776f726c64206f6620706f74746572790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3224d4c4-aa2c-48b8-a5f9-e6fd8f295223.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POT>>(v1);
    }

    // decompiled from Move bytecode v6
}

