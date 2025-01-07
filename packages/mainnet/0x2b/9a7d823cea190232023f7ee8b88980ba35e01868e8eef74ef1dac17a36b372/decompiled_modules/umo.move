module 0x2b9a7d823cea190232023f7ee8b88980ba35e01868e8eef74ef1dac17a36b372::umo {
    struct UMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: UMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UMO>(arg0, 6, b"UMO", b"SUMO", x"53554d4f20776173206372656174656420746f2070726f74656374206d656d6520746f6b656e7320d0b2d0bed18220d0bed0bfd0b8d181d0b0d0bdd0b8d0b5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731415609962.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UMO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UMO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

