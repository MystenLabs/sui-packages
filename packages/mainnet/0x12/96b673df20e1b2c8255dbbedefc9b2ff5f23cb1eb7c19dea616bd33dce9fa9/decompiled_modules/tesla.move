module 0x1296b673df20e1b2c8255dbbedefc9b2ff5f23cb1eb7c19dea616bd33dce9fa9::tesla {
    struct TESLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESLA>(arg0, 9, b"TESLA", b"Tesla", b"The best token! ;)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/87a650c9-58c2-46df-be2d-a5866a3b7220.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

