module 0xc81b3b825f4f2d1343c70a91d06a9f02c249c3d2ace05edf1835847a9456424f::bn {
    struct BN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BN>(arg0, 6, b"BN", b"Bijiewang Network", b"The credit token used internally in 528btc.com", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BN>>(v1);
    }

    // decompiled from Move bytecode v6
}

