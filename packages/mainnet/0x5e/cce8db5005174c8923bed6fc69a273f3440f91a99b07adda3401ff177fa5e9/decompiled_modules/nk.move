module 0x5ecce8db5005174c8923bed6fc69a273f3440f91a99b07adda3401ff177fa5e9::nk {
    struct NK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NK>(arg0, 9, b"NK", b"Nike", b"Sport is live", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NK>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NK>>(v1);
    }

    // decompiled from Move bytecode v6
}

