module 0xe0bcd4314c70f62e83e7777ad077eea5e2bbbddafca224d0ee8a344fe998b4ea::sruto {
    struct SRUTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRUTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRUTO>(arg0, 6, b"SRUTO", b"Suiruto", b"Suiruto is stealthy, unstoppable, and taking over the Sui Network. Driven by community power", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012397_fe254789d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRUTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRUTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

