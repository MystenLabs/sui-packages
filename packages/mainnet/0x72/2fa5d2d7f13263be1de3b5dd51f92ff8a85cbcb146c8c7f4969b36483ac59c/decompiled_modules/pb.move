module 0x722fa5d2d7f13263be1de3b5dd51f92ff8a85cbcb146c8c7f4969b36483ac59c::pb {
    struct PB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PB>(arg0, 9, b"PB", b"picbox", x"6e68c3a0206e676fe1baa169206769616f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/49303971-7ff2-4393-a9ac-6db053f6f733.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PB>>(v1);
    }

    // decompiled from Move bytecode v6
}

