module 0x939b85fbb5b2ecee4a960d044d7e70f49dd73db5c31e372dc3970c71f2b98192::nwl {
    struct NWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NWL>(arg0, 9, b"NWL", b"Now world", x"57656c636f6d6520746f206e6f7720776f726c6420f09f8c8ee29c85", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b4b67606-c1fb-4791-bfbe-10b32d307dd1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NWL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NWL>>(v1);
    }

    // decompiled from Move bytecode v6
}

