module 0x796e4497f97185aec9266a476dbd46f0384a09add81ed2f1c904b83fa27e079d::hello {
    struct HELLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLO>(arg0, 9, b"hello1", b"hello", b"hello here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/958fe5e8-b99a-4ea4-a368-9fe198552ebe.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELLO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

