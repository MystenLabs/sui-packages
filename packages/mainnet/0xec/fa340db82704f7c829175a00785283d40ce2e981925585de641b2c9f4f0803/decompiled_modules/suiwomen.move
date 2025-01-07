module 0xecfa340db82704f7c829175a00785283d40ce2e981925585de641b2c9f4f0803::suiwomen {
    struct SUIWOMEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWOMEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWOMEN>(arg0, 6, b"SUIWOMEN", b"Sui-Women", x"57686f2072756e2074686520776f726c643f202e2e2e20576f6d656e210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_women_483cf9973c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWOMEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWOMEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

