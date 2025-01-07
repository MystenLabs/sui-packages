module 0x4d02afd41a9f57abac1e8c9d5686b86626507b38c06505d73f8309c71e457276::mbash {
    struct MBASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBASH>(arg0, 9, b"MBASH", b"Bashkan", b"Bashtoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c5cbc769-731f-4b8c-88b3-813e12369223.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MBASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

