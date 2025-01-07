module 0xe4b8537be6fbb74f5b9e95ea2c085978c39c485372e45bc05b7e8b620725139d::moe {
    struct MOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOE>(arg0, 9, b"MOE", b"MOE", b"MOE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWH44odXYncPqnsg8Lgcfzp2Xeb4eQgfmauqSeG5XEytf")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

