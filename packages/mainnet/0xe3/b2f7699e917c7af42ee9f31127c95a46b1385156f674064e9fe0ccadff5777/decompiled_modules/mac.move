module 0xe3b2f7699e917c7af42ee9f31127c95a46b1385156f674064e9fe0ccadff5777::mac {
    struct MAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAC>(arg0, 6, b"MAC", b"Mac&Cheese", x"57656c636f6d6520746f2061206368656573792070726f6a656374206469726563746c792066726f6d207468652063686565737920646570746873206f662074686520537569204e6574776f726b2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/665675_ff260d79e3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

