module 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin {
    struct JACKSON_LIQUIDITY_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JACKSON_LIQUIDITY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JACKSON_LIQUIDITY_COIN>(arg0, 6, b"JacksonLP", b"Jackson Liquidity Provider Token", b"JacksonLP is the liquidity provider token of Jackson.io on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/bafkreicn2t2ryh7f2nbpior3v6v6isr2c35ejzz2figro7wupimcxnr3aq"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JACKSON_LIQUIDITY_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACKSON_LIQUIDITY_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

