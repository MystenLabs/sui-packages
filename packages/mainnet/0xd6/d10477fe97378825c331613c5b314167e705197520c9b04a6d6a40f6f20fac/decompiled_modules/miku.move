module 0xd6d10477fe97378825c331613c5b314167e705197520c9b04a6d6a40f6f20fac::miku {
    struct MIKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKU>(arg0, 9, b"Miku", b"Brazilian Miku", b"Brazilian Miku meme token on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/eKRmDZ42Tw73pgKoWzehYSU4kdjTQhx5w69dvEcpump.png?size=xl&key=e796b1")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MIKU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIKU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

