module 0xf97a7a2fc63bf4010f53499749965f39254dac9c823b33294b8d909c997b473d::binance100btcusdc {
    struct BINANCE100BTCUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BINANCE100BTCUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xb72175bb4d4587fe7f54a7bfd6b9f813cd30f323e8c18bbfc64b7f02118cf45b::oracle::create_oracle<BINANCE100BTCUSDC>(arg0, 0x1::string::utf8(b"Binance Spot BTC/USDC depth@100ms"), 0x1::ascii::string(b"BTCUSDC-Binance-100ms"), 0x1::string::utf8(b"Binance BTC/USDC spot price oracle with 100ms frequency"), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0xb72175bb4d4587fe7f54a7bfd6b9f813cd30f323e8c18bbfc64b7f02118cf45b::oracle::Oracle<BINANCE100BTCUSDC>>(v0, v2);
        0x2::transfer::public_transfer<0xb72175bb4d4587fe7f54a7bfd6b9f813cd30f323e8c18bbfc64b7f02118cf45b::oracle::OracleMetadata<BINANCE100BTCUSDC>>(v1, v2);
    }

    // decompiled from Move bytecode v6
}

