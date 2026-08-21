module 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::oracle_deepbook {
    public fun submit<T0, T1>(arg0: &mut 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::oracle::PriceOracle<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock) {
        assert!(0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::oracle::deepbook_pool_id<T0, T1>(arg0) == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::oracle_mismatch());
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg1, arg2);
        assert!(v0 > 0, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::oracle_bad_source());
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::oracle::submit<T0, T1>(arg0, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::oracle::source_deepbook_mid(), v0, 0x2::clock::timestamp_ms(arg2));
    }

    // decompiled from Move bytecode v7
}

