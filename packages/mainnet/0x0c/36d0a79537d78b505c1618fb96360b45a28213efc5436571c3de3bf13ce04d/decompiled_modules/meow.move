module 0xc36d0a79537d78b505c1618fb96360b45a28213efc5436571c3de3bf13ce04d::meow {
    struct MEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOW>(arg0, 6, b"MEOW", b"GARY", b"Meoooooooooooow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_8d59aa61b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

