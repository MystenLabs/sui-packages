module 0x5a17860f640823ff8e9f6be6f429563f68f74de80aa08b502a2f467e8c73e392::capi {
    struct CAPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPI>(arg0, 9, b"CAPI", b"CAPI", b"CAPI", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CAPI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

