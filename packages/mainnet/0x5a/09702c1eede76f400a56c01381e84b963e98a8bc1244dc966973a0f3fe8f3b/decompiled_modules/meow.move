module 0x5a09702c1eede76f400a56c01381e84b963e98a8bc1244dc966973a0f3fe8f3b::meow {
    struct MEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOW>(arg0, 9, b"MEOW", b"Meow", b"Meow Sui Mascot Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1814192025715261442/wCi39RmY_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEOW>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOW>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

