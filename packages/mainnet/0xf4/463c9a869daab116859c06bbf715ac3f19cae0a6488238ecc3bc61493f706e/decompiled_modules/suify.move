module 0xf4463c9a869daab116859c06bbf715ac3f19cae0a6488238ecc3bc61493f706e::suify {
    struct SUIFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFY>(arg0, 6, b"SUIFY", b"Suify Cat", b"This Cat doesnt meow, it $SUIFY .It fxxk Sol everyday.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_5a42f24efb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

