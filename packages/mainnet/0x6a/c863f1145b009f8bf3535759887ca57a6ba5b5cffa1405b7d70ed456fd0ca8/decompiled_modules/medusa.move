module 0x6ac863f1145b009f8bf3535759887ca57a6ba5b5cffa1405b7d70ed456fd0ca8::medusa {
    struct MEDUSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEDUSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEDUSA>(arg0, 6, b"MEDUSA", b"MEDUSA ON SUI", b"Probably nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000085230_a8ad9b53ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEDUSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEDUSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

