module 0x2ce83ffee3d179d15f2271d9bdc45a48454dfd759fb685d0e2a0691c2d943d9c::jumpcat {
    struct JUMPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUMPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUMPCAT>(arg0, 6, b"JUMPCAT", b"Jump Cat", b"Jumping into sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Japanese_Bobtail_white_0a4acd850c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUMPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUMPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

