module 0x3676e0e888ac441440aaf263a38b3c939f5a52f7bc7b1473c28ebab9dcd96e3c::skot {
    struct SKOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKOT>(arg0, 6, b"SKOT", b"Skoot", b"Alex Beckers Dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/alex_becker_dog_b01d789880.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

