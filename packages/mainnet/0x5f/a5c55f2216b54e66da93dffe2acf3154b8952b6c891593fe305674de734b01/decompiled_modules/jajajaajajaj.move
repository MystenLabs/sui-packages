module 0x5fa5c55f2216b54e66da93dffe2acf3154b8952b6c891593fe305674de734b01::jajajaajajaj {
    struct JAJAJAAJAJAJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAJAJAAJAJAJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAJAJAAJAJAJ>(arg0, 9, b"JAJAJAAJAJAJ", b"hoyapprendiacrearcryptossinagar", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JAJAJAAJAJAJ>(&mut v2, 221243423000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAJAJAAJAJAJ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAJAJAAJAJAJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

