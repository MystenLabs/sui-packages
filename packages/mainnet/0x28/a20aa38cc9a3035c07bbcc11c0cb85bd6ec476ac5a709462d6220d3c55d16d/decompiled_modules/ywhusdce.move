module 0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::ywhusdce {
    struct YWHUSDCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YWHUSDCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YWHUSDCE>(arg0, 6, b"yUSDC", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YWHUSDCE>>(v1);
        0x2::transfer::public_transfer<0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::vault::AdminCap<YWHUSDCE>>(0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::vault::new<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, YWHUSDCE>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

