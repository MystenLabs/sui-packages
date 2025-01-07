module 0xceb250581aa4efbae8f69b08a0f8c5e50fac2b216a98a94fcf413b195f44ca2::fuck {
    struct FUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCK>(arg0, 1, b"FUCK", b"FUCK", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FUCK>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

