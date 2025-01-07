module 0x1eb4be008e694e8866aa6f4441aa252b3b56b11820dd70026840e16c0d0437a7::suibean {
    struct SUIBEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBEAN>(arg0, 9, b"SUIBEAN", b"Sui Bean", b"https://telegra.ph/SUI-BEAN-10-05", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://purple-neat-mole-319.mypinata.cloud/ipfs/QmR9bnvqfSb1Hsw95Ajcr4DTEAu1ba2MeepLYy8X8KLLC4")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBEAN>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBEAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

