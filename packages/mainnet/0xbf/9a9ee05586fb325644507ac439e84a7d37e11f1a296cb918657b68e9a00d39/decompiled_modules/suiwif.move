module 0xbf9a9ee05586fb325644507ac439e84a7d37e11f1a296cb918657b68e9a00d39::suiwif {
    struct SUIWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWIF>(arg0, 9, b"Suiwif", b"Suiba Wif Hat", b"Suiba Wif Hat $SUIWIF is here to take on the world with smiles and cuteness! His name is Suif, the first and only Suiba Inu on Sui chain and he comes Wif Hat. Let him take you on a journey you wont forget!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FSuif500x500_04f4da93fe.png&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIWIF>(&mut v2, 150000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWIF>>(v2, @0x3e5a78284e4680cb2230cc8de33b29ce19b79ec47c36cf28c8b1b2e3ec44e178);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

