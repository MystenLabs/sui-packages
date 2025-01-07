module 0xa1e14491a7ae52e4c3c03777fc2d6926f2295ab1d15ecd7394ed1c4c9deef525::mcdonalddd {
    struct MCDONALDDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCDONALDDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCDONALDDD>(arg0, 9, b"MCDONALDDD", b"MCDONALDDD", b"wakkkkakaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MCDONALDDD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCDONALDDD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCDONALDDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

