module 0xd3c8d0bc7dbf5d1a61efb7e353b26606d0f4583a5e2f3455e6574f21931ba7ae::suipnut {
    struct SUIPNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPNUT>(arg0, 6, b"SuiPNUT", b"Peanut the squirrel ", b"ELON: \"I don't know man, just get out there and go vote for Peanut.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730961056082.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPNUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPNUT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

