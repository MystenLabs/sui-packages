module 0xabceca5e130fb3baef280f9fec0558943c189be37f11d9d18ec3ca4fdd8f27c5::jawir {
    struct JAWIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAWIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAWIR>(arg0, 9, b"JAWIR", b"Jawirerr", b"buat nuyul", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3559f098-2cf9-457b-b67e-e90282f5e3a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAWIR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAWIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

