module 0xbf0f92b5a9faf1956d2ef0e47378799f102961dad783b8cb0e220d6612ffd5d1::suibag {
    struct SUIBAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBAG>(arg0, 9, b"SUIBAG", b"$BAG", b"TG: https://t.me/SuiBag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/pdNLMq3/logo-cropped.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBAG>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBAG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

