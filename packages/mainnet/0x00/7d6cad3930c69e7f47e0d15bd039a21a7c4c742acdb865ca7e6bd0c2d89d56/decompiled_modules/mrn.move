module 0x7d6cad3930c69e7f47e0d15bd039a21a7c4c742acdb865ca7e6bd0c2d89d56::mrn {
    struct MRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRN>(arg0, 9, b"MRN", b"Mehran", b"For huntrs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c2a6d865-4732-4ffd-a0f3-96f045b0639e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRN>>(v1);
    }

    // decompiled from Move bytecode v6
}

