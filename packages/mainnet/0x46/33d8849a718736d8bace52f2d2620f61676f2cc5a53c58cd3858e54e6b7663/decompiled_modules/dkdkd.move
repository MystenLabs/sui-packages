module 0x4633d8849a718736d8bace52f2d2620f61676f2cc5a53c58cd3858e54e6b7663::dkdkd {
    struct DKDKD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DKDKD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DKDKD>(arg0, 9, b"DKDKD", b"Sisksk", b"Didol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9826171b-aa1f-4087-b6b1-7c0d8ab09718.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DKDKD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DKDKD>>(v1);
    }

    // decompiled from Move bytecode v6
}

