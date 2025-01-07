module 0xeb8a2636d7823544df1a70cd15958cb2ae458816a4d09fe5d31e1984e21d24b8::BLUB {
    struct BLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUB>(arg0, 2, b"BLUBv2", b"BLUB2", b"A Dirty Fish in the Waters of the Sui Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/unfatm/imghoster/e4ae281a33a4c4e0858fd0412d1ecb4ac4af40fe/logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUB>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLUB>(&mut v2, 31551750000000000, @0x752f96f551fc538efaa7d269d177553d6bb9b442cfb1d23be081a9ba99dd2b59, arg1);
        0x2::coin::mint_and_transfer<BLUB>(&mut v2, 10517250000000000, @0x752f96f551fc538efaa7d269d177553d6bb9b442cfb1d23be081a9ba99dd2b59, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUB>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

