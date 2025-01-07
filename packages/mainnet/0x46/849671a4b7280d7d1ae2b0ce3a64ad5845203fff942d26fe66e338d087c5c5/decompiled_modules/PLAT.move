module 0x46849671a4b7280d7d1ae2b0ce3a64ad5845203fff942d26fe66e338d087c5c5::PLAT {
    struct PLAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLAT>(arg0, 2, b"Platypus", b"Platypus", b"A ferocious platypus in Sui Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s1.locimg.com/2024/10/14/2cc2ed2481767.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLAT>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PLAT>(&mut v2, 31551750000000000, @0x5d97713923cf40947b344aaafdc48f5d48681f46127d13974785ae43ea4fcbf2, arg1);
        0x2::coin::mint_and_transfer<PLAT>(&mut v2, 10517250000000000, @0x5d97713923cf40947b344aaafdc48f5d48681f46127d13974785ae43ea4fcbf2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLAT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

