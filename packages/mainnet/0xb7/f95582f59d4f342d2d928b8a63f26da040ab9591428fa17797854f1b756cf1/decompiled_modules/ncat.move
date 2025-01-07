module 0xb7f95582f59d4f342d2d928b8a63f26da040ab9591428fa17797854f1b756cf1::ncat {
    struct NCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NCAT>(arg0, 9, b"NCAT", b"NERD CAT", b"NERD CAR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a1914dbe-0994-4e0c-8014-3ecc2ab573da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

