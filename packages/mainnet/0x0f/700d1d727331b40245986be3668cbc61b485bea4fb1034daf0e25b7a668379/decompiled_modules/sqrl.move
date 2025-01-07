module 0xf700d1d727331b40245986be3668cbc61b485bea4fb1034daf0e25b7a668379::sqrl {
    struct SQRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQRL>(arg0, 6, b"SQRL", b"Squarel", b"Square Squirrel (SQRL) : More pointless memecoin in a nutshell. We are going nuts!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732043738800.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQRL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQRL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

