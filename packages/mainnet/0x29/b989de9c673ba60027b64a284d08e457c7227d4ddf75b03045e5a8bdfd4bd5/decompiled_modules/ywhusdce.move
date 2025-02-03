module 0x29b989de9c673ba60027b64a284d08e457c7227d4ddf75b03045e5a8bdfd4bd5::ywhusdce {
    struct YWHUSDCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YWHUSDCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YWHUSDCE>(arg0, 6, b"yUSDC", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YWHUSDCE>>(v1);
        0x2::transfer::public_transfer<0x29b989de9c673ba60027b64a284d08e457c7227d4ddf75b03045e5a8bdfd4bd5::vault::AdminCap<YWHUSDCE>>(0x29b989de9c673ba60027b64a284d08e457c7227d4ddf75b03045e5a8bdfd4bd5::vault::new<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, YWHUSDCE>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

