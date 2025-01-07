module 0xf8e99ed532928f3078bb032a6d4e7bae3b3002c8811c04f930fcf53926e60230::bcoin {
    struct BCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCOIN>(arg0, 9, b"BCOIN", b"BCoin", b"Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://stg.suios.xyz/logo/logov2.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BCOIN>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCOIN>>(v2, @0xd91a81ef41eb9214ef0f7416143e06dd8e1831e2e0111dad8bd431e5f230164e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

