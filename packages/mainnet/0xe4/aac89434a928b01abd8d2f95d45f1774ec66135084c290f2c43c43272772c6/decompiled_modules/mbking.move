module 0xe4aac89434a928b01abd8d2f95d45f1774ec66135084c290f2c43c43272772c6::mbking {
    struct MBKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBKING>(arg0, 9, b"MBKING", b"FCB", b"A Token To get you Up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bcdd172e-17ac-4bf0-9ab3-2262f7358a7e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MBKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

