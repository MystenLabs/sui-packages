module 0xaeae84272751fe0223cc85d989296b475881ffbfdaaf37ce03b2c371ea6f83f9::o {
    struct O has drop {
        dummy_field: bool,
    }

    fun init(arg0: O, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<O>(arg0, 6, b"O", b"dont buy by SuiAI", b"oo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000000704_2d7dd2991c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<O>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<O>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

