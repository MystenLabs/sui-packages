module 0x640389c0f53bd675444a36164b217bfeaf62f7539e30389c2673bdb2e8d53fce::meow {
    struct MEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOW>(arg0, 6, b"MEOW", b"Zeek Coin", x"5768696c65206e6f7420666f726d616c6c79207265636f676e697a65642c2073796d626f6c697a6573205a65656b2c20746865206d6173636f74206f66205375692e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zeek_head_d3490f7d36.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

