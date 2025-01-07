module 0x2f19c46043649a40df0e36867d5366e949560f2f655f11978de41b8a0280ef2f::dth {
    struct DTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTH>(arg0, 9, b"DTH", b"death", b"Continue even after death", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dde0bc44-88a9-4284-acef-705e8c7602d9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

