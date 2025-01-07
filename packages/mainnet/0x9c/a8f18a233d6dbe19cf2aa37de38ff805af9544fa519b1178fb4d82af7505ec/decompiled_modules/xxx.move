module 0x9ca8f18a233d6dbe19cf2aa37de38ff805af9544fa519b1178fb4d82af7505ec::xxx {
    struct XXX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XXX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XXX>(arg0, 6, b"XXX", b"xxx", b"x", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wall_Background_c9f49deca6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XXX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XXX>>(v1);
    }

    // decompiled from Move bytecode v6
}

