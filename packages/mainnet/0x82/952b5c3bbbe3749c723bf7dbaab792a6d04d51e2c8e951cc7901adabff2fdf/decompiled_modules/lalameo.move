module 0x82952b5c3bbbe3749c723bf7dbaab792a6d04d51e2c8e951cc7901adabff2fdf::lalameo {
    struct LALAMEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LALAMEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LALAMEO>(arg0, 9, b"LALAMEO", b"lalameo", b"lalameopump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9b80f0d4-cbd0-44ab-a5f9-d95d83ea80a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LALAMEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LALAMEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

