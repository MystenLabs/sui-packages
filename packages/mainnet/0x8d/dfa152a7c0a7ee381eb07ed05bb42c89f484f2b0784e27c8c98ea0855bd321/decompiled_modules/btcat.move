module 0x8ddfa152a7c0a7ee381eb07ed05bb42c89f484f2b0784e27c8c98ea0855bd321::btcat {
    struct BTCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCAT>(arg0, 8, b"BTCAT", b"BitCat", b"The first ever cat to appear on any Blockchain was on the 28/9/2014, over 10 years ago.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BTCAT>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

