module 0xfd153c09ab40ceff3734db73fcf5dd49bbb997bf31da18f8b5480c82aca0b4f5::SQUIRTLE {
    struct SQUIRTLE has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SQUIRTLE>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == @0x1b2b16f34c4104689a1be0090847a0893b38f22974eeecdef67933bbf41e1045 || 0x2::tx_context::sender(arg2) == @0x1b2b16f34c4104689a1be0090847a0893b38f22974eeecdef67933bbf41e1045, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<SQUIRTLE>>(arg0, arg1);
    }

    fun init(arg0: SQUIRTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIRTLE>(arg0, 9, b"SQUIRT", b"SQUIRTLE", b"SUI moves like water. Squirt is water. It's a perfect overlap: velocity, flexibility, power under pressure. $SQUIRT is a signal. A shell-shocked, shade-wearing surge toward a new frontier.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tan-hidden-shark-534.mypinata.cloud/ipfs/bafkreiafrovpkppkn2tlla5qp7fiblvh3dvmk6tzaha26yojqyzexawiny")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SQUIRTLE>>(0x2::coin::mint<SQUIRTLE>(&mut v2, 1000000000000000000, arg1), @0x1b2b16f34c4104689a1be0090847a0893b38f22974eeecdef67933bbf41e1045);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SQUIRTLE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUIRTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

