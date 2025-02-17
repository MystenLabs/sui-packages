module 0x73cfd0703fa65ce89b5928a1497b5de3db5648659eed7e3feabba58db0fd3ea0::b_btc {
    struct B_BTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BTC>(arg0, 9, b"bwBTC", b"bToken wBTC", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

