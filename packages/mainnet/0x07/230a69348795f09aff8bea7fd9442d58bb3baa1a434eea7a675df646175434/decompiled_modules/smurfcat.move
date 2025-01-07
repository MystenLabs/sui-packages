module 0x7230a69348795f09aff8bea7fd9442d58bb3baa1a434eea7a675df646175434::smurfcat {
    struct SMURFCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMURFCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMURFCAT>(arg0, 6, b"SMURFCAT", b"Real Smurf Cat", b"Real Smurf Cat is the mythical guardian of the hidden blue forest, watching over its magical creatures.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asd2131232zxcc23_44cdbcc4e9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMURFCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMURFCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

