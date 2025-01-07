module 0x1484fdb9febe67eeeedd5d835dc8f1ba26320aedc5bf5c8459f9368bfd4d9dca::apepe {
    struct APEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: APEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APEPE>(arg0, 9, b"APEPE", b"AquaPepe", b"AquaPepe is a meme token making waves on the Sui blockchain. Combining the iconic Pepe meme with aquatic themes, AquaPepe brings fun, community, and liquidity to DeFi. Ride the tide with AquaPepe and make a splash in the crypto world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1649100092379480089/I8333KgA.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<APEPE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APEPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

