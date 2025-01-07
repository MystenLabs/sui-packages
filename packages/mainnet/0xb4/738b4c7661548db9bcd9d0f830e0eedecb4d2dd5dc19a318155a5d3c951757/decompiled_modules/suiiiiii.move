module 0xb4738b4c7661548db9bcd9d0f830e0eedecb4d2dd5dc19a318155a5d3c951757::suiiiiii {
    struct SUIIIIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIIIIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIIIIII>(arg0, 9, b"SUIIIIII", b"Suiiiiii", b"Hello", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIIIIII>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIIIIII>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIIIIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

