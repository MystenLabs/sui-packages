module 0x66fff92559c99c37340298fb809b3c4c1d07d3b613f0e858d79cbe9c61ce3bf6::czx {
    struct CZX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CZX>(arg0, 9, b"CZX", b"DAS", b"CZcx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/89324a86-48ca-4c61-b8dc-98c3c23c3d21.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CZX>>(v1);
    }

    // decompiled from Move bytecode v6
}

