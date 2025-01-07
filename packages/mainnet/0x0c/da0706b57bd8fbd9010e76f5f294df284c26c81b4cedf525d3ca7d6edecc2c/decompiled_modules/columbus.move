module 0xcda0706b57bd8fbd9010e76f5f294df284c26c81b4cedf525d3ca7d6edecc2c::columbus {
    struct COLUMBUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: COLUMBUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COLUMBUS>(arg0, 6, b"Columbus", b"Squirrelopher ", b"Peanut made the ultimate sacrifice to save our republic. Squirrelopher Columbus ventured into brave new lands to found a country where all people are free to Hodl.  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732161737407.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COLUMBUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COLUMBUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

