module 0x2cadf4d7d2e0cb53393f281d111efed7f41697d4e07942bd5fa7a6a5c5d0cb0d::uss {
    struct USS has drop {
        dummy_field: bool,
    }

    fun init(arg0: USS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USS>(arg0, 6, b"USS", b"UFO SHARK SUI", b"UFO SHARK ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b8399d70a73d36c3aaeb829385a62711_d1acd052d0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USS>>(v1);
    }

    // decompiled from Move bytecode v6
}

