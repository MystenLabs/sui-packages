module 0xfecf09c1c75eec491bd51bb7060cbe5875a2391e07d39b59c181285d66ac301a::pineapple {
    struct PINEAPPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINEAPPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINEAPPLE>(arg0, 9, b"PINEAPPLE", b"Pinpeapple", b"JUST A PINEAPPLE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/BkvnWerVaa6NYvPAdeX5kBsGhCRjDnUUutAa5KbUvJwJ.png?size=xl&key=664e3b")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PINEAPPLE>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINEAPPLE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINEAPPLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

