module 0x7fe29180a775f310c65de0f80712ff3b509bb8b47e81f50bcd78c2a880cfe6de::oms {
    struct OMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMS>(arg0, 9, b"OMS", b"OMS", b"OMS", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OMS>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

