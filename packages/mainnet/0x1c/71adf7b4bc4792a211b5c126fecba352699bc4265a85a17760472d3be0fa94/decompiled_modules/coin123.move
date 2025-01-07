module 0x1c71adf7b4bc4792a211b5c126fecba352699bc4265a85a17760472d3be0fa94::coin123 {
    struct COIN123 has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN123, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<COIN123>(arg0, 9, b"123", b"123", b"", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<COIN123>(&mut v3, 111000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<COIN123>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<COIN123>>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN123>>(v2);
    }

    // decompiled from Move bytecode v6
}

