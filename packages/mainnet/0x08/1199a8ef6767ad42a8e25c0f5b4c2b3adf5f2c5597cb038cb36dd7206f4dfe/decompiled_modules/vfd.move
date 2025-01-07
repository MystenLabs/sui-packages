module 0x81199a8ef6767ad42a8e25c0f5b4c2b3adf5f2c5597cb038cb36dd7206f4dfe::vfd {
    struct VFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: VFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VFD>(arg0, 9, b"VFD", b"V", b"X", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a25cea06-7728-49b3-8621-d9451b62e517.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

