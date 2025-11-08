module 0xea08eb69ae75b87d8b4b1dffc9c74d31f8fa046c586ad394838cce4ed7b563fe::Random {
    struct RANDOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: RANDOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RANDOM>(arg0, 9, b"RANDOM", b"Random", b"just a random coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/G5L7LjLXUAARgy8?format=jpg&name=small")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RANDOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RANDOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

