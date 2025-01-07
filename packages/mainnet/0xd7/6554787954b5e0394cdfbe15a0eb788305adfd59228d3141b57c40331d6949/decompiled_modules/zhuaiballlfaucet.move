module 0xd76554787954b5e0394cdfbe15a0eb788305adfd59228d3141b57c40331d6949::zhuaiballlfaucet {
    struct ZHUAIBALLLFAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZHUAIBALLLFAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZHUAIBALLLFAUCET>(arg0, 18, b"ZBF", b"Zbf", b"ZBF is zhuaiballl's faucet", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZHUAIBALLLFAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ZHUAIBALLLFAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

