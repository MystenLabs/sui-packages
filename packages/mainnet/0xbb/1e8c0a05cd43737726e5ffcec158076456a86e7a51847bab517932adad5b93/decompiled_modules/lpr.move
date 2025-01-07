module 0xbb1e8c0a05cd43737726e5ffcec158076456a86e7a51847bab517932adad5b93::lpr {
    struct LPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LPR>(arg0, 9, b"LPR", b"Little PR", b"Little Prince token LPR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/03118713-b775-453d-92b5-8f3c421917d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LPR>>(v1);
    }

    // decompiled from Move bytecode v6
}

