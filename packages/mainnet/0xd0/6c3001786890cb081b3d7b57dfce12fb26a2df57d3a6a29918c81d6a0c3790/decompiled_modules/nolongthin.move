module 0xd06c3001786890cb081b3d7b57dfce12fb26a2df57d3a6a29918c81d6a0c3790::nolongthin {
    struct NOLONGTHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOLONGTHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOLONGTHIN>(arg0, 9, b"NOLONGTHIN", b"Zube", x"546f20746865206d6f6f6e20f09f8c9df09f8c922c2057616b616e646120666f726576657220f09f8c8af09f8c80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/61d206bc-0b60-478d-89d9-6247324c8f2a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOLONGTHIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOLONGTHIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

