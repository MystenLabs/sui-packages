module 0xc128adeac567b68c4f6a79cc53bbdec5e7123b69aa4b88d77d9aba8ec3a68cfe::mrn {
    struct MRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRN>(arg0, 9, b"MRN", b"MIREN", b"Beautiful Token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/65962c8c-820f-4298-b8c1-6b12992cfee9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRN>>(v1);
    }

    // decompiled from Move bytecode v6
}

