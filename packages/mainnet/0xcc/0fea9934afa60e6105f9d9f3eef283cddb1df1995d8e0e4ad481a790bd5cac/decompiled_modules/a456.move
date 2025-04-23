module 0xcc0fea9934afa60e6105f9d9f3eef283cddb1df1995d8e0e4ad481a790bd5cac::a456 {
    struct A456 has drop {
        dummy_field: bool,
    }

    fun init(arg0: A456, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A456>(arg0, 6, b"A456", b"123", b"789", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigrao6akxk3wg66dd4z6b7jc3rfi5jj3d4oopr465subsgadhlxfu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A456>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<A456>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

