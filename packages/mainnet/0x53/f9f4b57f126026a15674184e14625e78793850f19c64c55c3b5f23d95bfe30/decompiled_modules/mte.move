module 0x53f9f4b57f126026a15674184e14625e78793850f19c64c55c3b5f23d95bfe30::mte {
    struct MTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTE>(arg0, 9, b"MTE", b"MinEmirate", x"4d696e6920456d69726174657320746f206d6f6f6e20f09f8c9d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6fcdc41b-5df3-48d0-9fc4-92c610e4c97f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

