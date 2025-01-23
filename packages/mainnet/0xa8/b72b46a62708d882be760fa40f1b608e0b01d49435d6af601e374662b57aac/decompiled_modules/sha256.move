module 0xa8b72b46a62708d882be760fa40f1b608e0b01d49435d6af601e374662b57aac::sha256 {
    struct SHA256 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHA256, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHA256>(arg0, 6, b"SHA256", b"SHA-256 AI", b"SHA-256 initiating", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028680_a46b49aaa0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHA256>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHA256>>(v1);
    }

    // decompiled from Move bytecode v6
}

