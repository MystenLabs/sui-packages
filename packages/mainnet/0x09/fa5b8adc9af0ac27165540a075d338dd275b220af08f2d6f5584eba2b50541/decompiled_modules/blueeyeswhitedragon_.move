module 0x9fa5b8adc9af0ac27165540a075d338dd275b220af08f2d6f5584eba2b50541::blueeyeswhitedragon_ {
    struct BLUEEYESWHITEDRAGON_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEEYESWHITEDRAGON_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEEYESWHITEDRAGON_>(arg0, 9, b"BlueEyesWhiteDragon", b"Blue Eyes White Dragon", b"Blue-Eyes White Dragon CTO - Be part of this new hype -", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLUEEYESWHITEDRAGON_>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEEYESWHITEDRAGON_>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEEYESWHITEDRAGON_>>(v1);
    }

    // decompiled from Move bytecode v6
}

