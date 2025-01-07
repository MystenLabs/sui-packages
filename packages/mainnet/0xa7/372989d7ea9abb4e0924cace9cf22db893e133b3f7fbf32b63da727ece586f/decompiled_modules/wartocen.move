module 0xa7372989d7ea9abb4e0924cace9cf22db893e133b3f7fbf32b63da727ece586f::wartocen {
    struct WARTOCEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARTOCEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARTOCEN>(arg0, 9, b"WARTOCEN", b"WAR", b"Token of WAR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/abb9be25-8602-4061-9c64-64ca8d11101b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARTOCEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WARTOCEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

