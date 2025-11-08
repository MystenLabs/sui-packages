module 0x6b6696f4d4e24bea51fa43987f2f09ab0521f6708ab8d98428bcdb248ede50c::Rock {
    struct ROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCK>(arg0, 9, b"STAR", b"Rock", b"rockstar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/G5KAPzSW0AAxhwy?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

