module 0xd625c41a570e054debc9a39e6b76fba8a88c0388ce27a2d50fcbd7665bc56a81::blue {
    struct BLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BLUE>(arg0, 9, b"BLUE", b"BlueFood Token", b"The world's first sustainable Marine Aquaculture Token (Token). To promote sustainable blue food development and maintain marine Aquaculture resources.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://gateway.irys.xyz/KuTIVGn1Xb1wveRHRbfJzGPclApzZTO7Mtb5bh1-R7U"))), true, arg1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUE>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BLUE>>(v1, v3);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUE>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}

