module 0xfb0109e54336c39d6d6f4f9b014d3b9a32d59df3d05f1a8c94bfe6f2cbc8fb9::b_bit {
    struct B_BIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BIT>(arg0, 9, b"bBIT", b"bToken BIT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

