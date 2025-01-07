module 0xf08c74c920d2e2f25727255e0c407a94a3f7521cbbd7cea66da19fb1938a3af6::bio {
    struct BIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIO>(arg0, 9, b"BIO", b"Yogurt", b"microbiological fertilizers for soil and plants", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0b0d19c5-8b4d-4d94-a0b2-49063ef15609.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

