module 0x1fc14553fdbc6f103dfb2a0167366c45b1db59bc1f77a48faf0a30176b2ff13c::nuts {
    struct NUTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUTS>(arg0, 6, b"NUTS", b"SUI NUTS", b"u gotta have some balls to make it, the bold the based, the ballsy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031132_b80d5b1892.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

