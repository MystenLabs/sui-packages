module 0xb7353ba5f7797f8290a5cafb3bc890eca04f73e67874573b36b90575b505ab88::peter {
    struct PETER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PETER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PETER>(arg0, 9, b"PETER", b"Peter Griffin", b"Peter embodies the true Degen mentality: he lives for risk, embraces chaos, and always delivers the best memes!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x8c2a59732b1ddb1ef57eb1986c1a397fabd40e6c.png?size=xl&key=4b62f7")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PETER>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PETER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PETER>>(v1);
    }

    // decompiled from Move bytecode v6
}

