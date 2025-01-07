module 0x6b734226277f7d19ae0471c90d166679162390c81134b55097fac22dc180f351::soda {
    struct SODA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SODA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SODA>(arg0, 6, b"Soda", b"Sui Soda", b"$Soda Ready to Drink", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730986233242.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SODA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SODA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

