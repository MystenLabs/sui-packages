module 0x368538e5368b49fe7ede1a997d700e241a4f12e033ad9d9442979b4edb5857fc::md {
    struct MD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MD>(arg0, 9, b"MD", b"Moondeg", b"Moondegs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e7aacbb8-b26c-4888-b078-6879d05f945d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MD>>(v1);
    }

    // decompiled from Move bytecode v6
}

