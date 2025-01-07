module 0x54b3228fc1271eb054dbbd5f1301f5d41ff5e6a594759fb7712e3946268616d7::mooner {
    struct MOONER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONER>(arg0, 6, b"MOONER", b"MOON.DAY", x"536f6d657468696e67204855474520697320636f6d696e6720746f204465466920f09f9a80f09f8c91", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730972150625.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOONER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

