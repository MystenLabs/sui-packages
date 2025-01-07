module 0xb8742df0cbac3b39e39f0025aa14f91e64d84785ebe825a4f565c8a42307970d::bitobtc {
    struct BITOBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITOBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITOBTC>(arg0, 8, b"bitoBTC.sui", b"bito wrapped ckbtc", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://assets.coingecko.com/coins/images/33818/large/01_ckBTC_Token_HEX__4x.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITOBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITOBTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

