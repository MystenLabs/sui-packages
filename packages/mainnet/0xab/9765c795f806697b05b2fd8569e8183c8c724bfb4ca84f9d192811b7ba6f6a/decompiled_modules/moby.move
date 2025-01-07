module 0xab9765c795f806697b05b2fd8569e8183c8c724bfb4ca84f9d192811b7ba6f6a::moby {
    struct MOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOBY>(arg0, 9, b"MOBY", b"MOBY", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmdkd7BseX4di7mWYks2KshMmnq6iJFPh1pZbqivBS5kGV")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOBY>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOBY>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOBY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

