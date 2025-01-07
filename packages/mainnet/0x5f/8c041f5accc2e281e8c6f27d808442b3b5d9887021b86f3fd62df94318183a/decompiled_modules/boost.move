module 0x5f8c041f5accc2e281e8c6f27d808442b3b5d9887021b86f3fd62df94318183a::boost {
    struct BOOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOST>(arg0, 9, b"BOOST", b"BOOST", b"BOOST", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOOST>(&mut v2, 9999999000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOST>>(v1);
    }

    // decompiled from Move bytecode v6
}

