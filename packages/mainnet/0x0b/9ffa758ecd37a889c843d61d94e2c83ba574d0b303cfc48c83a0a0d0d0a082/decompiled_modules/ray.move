module 0xb9ffa758ecd37a889c843d61d94e2c83ba574d0b303cfc48c83a0a0d0d0a082::ray {
    struct RAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAY>(arg0, 6, b"RAY", b"Ray moon boy", b"Ray the Moon Boy is more than just a memehe's a movement. Ray is a relatable degen on a mission to moon, creating a fun, rewarding experience for community members around the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000086653_146a29c61a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

