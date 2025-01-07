module 0x92ae29ad29e60053a1076ff9c55d1ad32539222a3c0e88624ad8e6f925e0d802::mrn {
    struct MRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRN>(arg0, 9, b"MRN", b"Mehran", b"For huntrs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/83b614a6-55be-4dbd-9b5b-6b443803f2f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRN>>(v1);
    }

    // decompiled from Move bytecode v6
}

