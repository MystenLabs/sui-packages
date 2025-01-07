module 0xc2ec9e799f6e4d0d2a5eeea745c2589b44cb7b47089420b1f2cbf72034039dd9::cewe {
    struct CEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEWE>(arg0, 9, b"CEWE", b"Maskgirl", b"Mysterious girl is very beautiful ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3ebd5b5f-520d-45ab-ab92-313d0e9fd924.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

