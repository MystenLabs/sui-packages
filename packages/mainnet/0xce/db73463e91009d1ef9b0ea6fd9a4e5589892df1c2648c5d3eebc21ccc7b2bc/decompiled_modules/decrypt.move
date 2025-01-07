module 0xcedb73463e91009d1ef9b0ea6fd9a4e5589892df1c2648c5d3eebc21ccc7b2bc::decrypt {
    struct DECRYPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DECRYPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DECRYPT>(arg0, 9, b"DECRYPT", b"De cryp", b"Community token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4d3951eb-2c87-4e88-a5e6-31fc1761bfc6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DECRYPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DECRYPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

