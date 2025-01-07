module 0x636d8db58bdeec3b77c7acf535775f3375832c34f82667079647aca28e1c40d::suimama {
    struct SUIMAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAMA>(arg0, 9, b"SUIMAMA", b"Suimaam", b"Just for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/381b96f7-f832-45d4-81f8-6e4d1b92b8ee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

