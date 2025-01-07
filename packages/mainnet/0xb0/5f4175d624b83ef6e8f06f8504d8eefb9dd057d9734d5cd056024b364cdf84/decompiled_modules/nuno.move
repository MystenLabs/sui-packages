module 0xb05f4175d624b83ef6e8f06f8504d8eefb9dd057d9734d5cd056024b364cdf84::nuno {
    struct NUNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUNO>(arg0, 9, b"NUNO", b"Nunu", b"Huhi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cd1efb63-ef3b-4594-80cb-5a16c1a53a9c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUNO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NUNO>>(v1);
    }

    // decompiled from Move bytecode v6
}

