module 0x320be6f9e292f88d21e8e2b39290708f4be6d21cb099382319669fbc698be89c::moby {
    struct MOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOBY>(arg0, 6, b"MOBY", b"Moby Dick", x"546865206c617267657374207768616c65206b6e6f776e20746f206d616e6b696e642e20497427732074696d6520746f20736574207361696c21210a0a4d6f6279204469636b20697320616c72656164792077616974696e6720696e207468652064657074687320746f2065617420616c6c207468652064697021210a0a204d6f6279204469636b2077696c6c206265207375636365737366756c206f6e2073756920636861696e21210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000019237_cf1d586297.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

