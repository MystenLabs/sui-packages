module 0x3852eac04a1464de57a0f65ecac7e41919c70d7fc92100e2e658b2119f41f785::purr {
    struct PURR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURR>(arg0, 6, b"PURR", b"SUIPURR", b"I'm purring hard", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIPURR_67fc6d1fd5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PURR>>(v1);
    }

    // decompiled from Move bytecode v6
}

