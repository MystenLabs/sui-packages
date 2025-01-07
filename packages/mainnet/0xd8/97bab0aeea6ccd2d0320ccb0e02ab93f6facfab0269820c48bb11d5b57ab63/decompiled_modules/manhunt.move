module 0xd897bab0aeea6ccd2d0320ccb0e02ab93f6facfab0269820c48bb11d5b57ab63::manhunt {
    struct MANHUNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANHUNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANHUNT>(arg0, 9, b"MANHUNT", b"ManHunt", b"ManHunt meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/DdGSsKM1JT2AtLSTkocJAnn4uaMogEdE49ZjMCG2pump.png?size=xl&key=c9f64b")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MANHUNT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANHUNT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANHUNT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

