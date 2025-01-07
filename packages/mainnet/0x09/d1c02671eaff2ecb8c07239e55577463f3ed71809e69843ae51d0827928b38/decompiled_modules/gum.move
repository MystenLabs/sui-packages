module 0x9d1c02671eaff2ecb8c07239e55577463f3ed71809e69843ae51d0827928b38::gum {
    struct GUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUM>(arg0, 6, b"GUM", b"Gumball", b"\"Time to shine! Another gem for the collection, and I'm just getting started!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d8e56bf9_2655_4522_b48a_65ee0b88d13d_06ac7028c1_e82737e5fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

