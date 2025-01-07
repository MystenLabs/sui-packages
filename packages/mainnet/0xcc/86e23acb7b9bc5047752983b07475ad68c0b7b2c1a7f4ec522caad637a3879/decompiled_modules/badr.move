module 0xcc86e23acb7b9bc5047752983b07475ad68c0b7b2c1a7f4ec522caad637a3879::badr {
    struct BADR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADR>(arg0, 6, b"Badr", b"RugPullFaggot", b"Best farming dev ever deserves his own token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241017_160147_a3238bc43c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BADR>>(v1);
    }

    // decompiled from Move bytecode v6
}

