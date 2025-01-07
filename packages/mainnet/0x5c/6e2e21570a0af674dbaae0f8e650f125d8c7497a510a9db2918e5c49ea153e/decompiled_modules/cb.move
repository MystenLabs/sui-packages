module 0x5c6e2e21570a0af674dbaae0f8e650f125d8c7497a510a9db2918e5c49ea153e::cb {
    struct CB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CB>(arg0, 9, b"CB", b"Cheeseball", b"Sui Cheeseball", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/3BeJ9zCgQhaqKMu2HgKJ79yQBChD1Pf3hPwRX44fpump.png?size=xl&key=03a118")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CB>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CB>>(v2, @0x4f77eb51e5f8f1832330de810998eee140eb328a4a48e95019934bda17b9b984);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CB>>(v1);
    }

    // decompiled from Move bytecode v6
}

