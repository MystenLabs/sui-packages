module 0x520f2bbc17d9de742fb0a8990b80852c820484621258e2202f668ffe1f2424aa::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let (v1, v2) = 0x2::coin::create_currency<COIN>(arg0, v0, b"LADYS", b"Milady", b"Milady", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Fvx0FtAaEAARGBp?format=jpg&name=900x900f")), arg1);
        let v3 = v1;
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<COIN>(&mut v3, 10000000 * 0x2::math::pow(10, v0), v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v3, v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

