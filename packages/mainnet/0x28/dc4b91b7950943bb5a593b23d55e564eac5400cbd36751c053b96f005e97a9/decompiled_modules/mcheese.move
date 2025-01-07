module 0x28dc4b91b7950943bb5a593b23d55e564eac5400cbd36751c053b96f005e97a9::mcheese {
    struct MCHEESE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCHEESE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCHEESE>(arg0, 6, b"MCHEESE", b"Moon Cheese", b"Welcome to MoonCheese , the tastiest memecoin journey to the moon! Strap in for a galactic adventure of cheddary profits and brie-lliant opportunities. Let's curdle our doubts and crumble barriers. Join us now, and say CHEESE to a fun-filled profitable future!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016872_0b16b828ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCHEESE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCHEESE>>(v1);
    }

    // decompiled from Move bytecode v6
}

