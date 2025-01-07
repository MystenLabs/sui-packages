module 0x3e5e6e29c2a5af8dda9b72f2f4e298bd8e2d84c4a99dc2ef2f90f426c38633df::oekdn {
    struct OEKDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OEKDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OEKDN>(arg0, 9, b"OEKDN", x"d0b3d0b2d0bbd0be", b"hendb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/231bb871-2e6a-4692-922e-0797b78de794.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OEKDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OEKDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

