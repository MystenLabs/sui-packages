module 0x1fdbd01b576c4bbb8737e69ed4f182097fe4d13a6ba21556705dfbd27b686db3::forever {
    struct FOREVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOREVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOREVER>(arg0, 6, b"FOREVER", b"PERSIST", b"PERSIST FOREVER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752538199053.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOREVER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOREVER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

