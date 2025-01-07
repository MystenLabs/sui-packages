module 0x6e3194f28355a019e42aad0dbf3d8df06d6da00adf0a4cc3ddf8628c3e7b6f9c::moby {
    struct MOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOBY>(arg0, 9, b"MOBY", b"MOBY", b"MOBY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmdkd7BseX4di7mWYks2KshMmnq6iJFPh1pZbqivBS5kGV")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOBY>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOBY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOBY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

