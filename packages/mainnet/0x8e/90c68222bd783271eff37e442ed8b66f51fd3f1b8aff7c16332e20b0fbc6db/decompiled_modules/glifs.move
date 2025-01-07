module 0x8e90c68222bd783271eff37e442ed8b66f51fd3f1b8aff7c16332e20b0fbc6db::glifs {
    struct GLIFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLIFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLIFS>(arg0, 9, b"GLIFS", b"Glifs", b"Someone Updated It Before Us", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/GmTH6V13rHVXeNdmDfh7VQeS2Lj9YWRKT5XjDEA2pump.png?size=lg&key=c10ab6")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GLIFS>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLIFS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLIFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

