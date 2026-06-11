module 0x9e848ea883920e811375462830380a1895cc82a8ee15ad44d4445573dc0e30e7::osail_13jan2028 {
    struct OSAIL_13JAN2028 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL_13JAN2028, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL_13JAN2028>(arg0, 6, b"oSAIL-13Jan2028", b"oSAIL-13Jan2028", b"Full Sail option token, expiration 13 Jan 2028 00:00:00 UTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL_13JAN2028>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL_13JAN2028>>(v1);
    }

    // decompiled from Move bytecode v7
}

