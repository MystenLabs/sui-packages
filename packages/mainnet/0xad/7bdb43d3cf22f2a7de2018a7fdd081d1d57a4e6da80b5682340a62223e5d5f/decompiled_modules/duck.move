module 0xad7bdb43d3cf22f2a7de2018a7fdd081d1d57a4e6da80b5682340a62223e5d5f::duck {
    struct DUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCK>(arg0, 9, b"DUCK", b"DUCK", b"Duck one of the meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://png.pngtree.com/png-clipart/20201208/original/pngtree-duck-vector-text-effect-with-transparent-background-png-image_5546099.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DUCK>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

