module 0xc04f2f6f594b787222f4df715617484c2081642dffef5d2d71a59748a8793e7f::dollar {
    struct DOLLAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLLAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLLAR>(arg0, 9, b"DOLLAR", b"DOLLAR", b"DOLLAR on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShmxpeFXJhR_ShLwzCHUPRIOmuuJITaORkFA&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOLLAR>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLLAR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLLAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

