module 0xd841af6de5a627ebfba810eb067f7b75057f360d96b066e49e9b8261118a712f::slt {
    struct SLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLT>(arg0, 9, b"SLT", b"salt", x"f09faaa3f09faaa3f09faaa3f09faaa3f09faaa3f09faaa3616e6f74686572206f6e652061626f7574207361746c636f696e0a537072696e6b6c6520736f6d6520666c61766f72206f6e20796f757220696e766573746d656e747320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f887fe41-a929-406d-a0bc-b68c78a27fc0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

