module 0xf75dc1e2db1dc10a97db2ff46385a815173cedb3c61a28793f9fe444f5385bad::pludd {
    struct PLUDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUDD>(arg0, 9, b"Pludd", b"plud", b"this coin will be a trading market as an asset for the future plud currency which will have services and loans that are paid off and automated by artificial intelligence and agentic workflows", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lh3.googleusercontent.com/gg/ACM6BIsGjcrH4Kzr5QvDuXJmId8SyCLiOTrz1RjyKHX6Mk62o9ZzQlgaIaZ8CqF69O82rChe1acz8Y3xbTc0J8LnPIU0ABEyEmLsF4vclWestbl0-Dm5RGs6qwWLc8zP2L-p5zL3-E2mTIDQRnbCAY1oA4QqxxSoi2F2MfPexTjge7Afmfxx1GM")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PLUDD>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUDD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

