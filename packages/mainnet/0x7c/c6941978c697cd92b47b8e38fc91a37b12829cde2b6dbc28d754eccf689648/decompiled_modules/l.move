module 0x7cc6941978c697cd92b47b8e38fc91a37b12829cde2b6dbc28d754eccf689648::l {
    fun extract_vaa(arg0: &vector<u8>) : vector<u8> {
        let v0 = 7 + (*0x1::vector::borrow<u8>(arg0, 6) as u64) + 1;
        let v1 = b"";
        let v2 = 0;
        while (v2 < (*0x1::vector::borrow<u8>(arg0, v0) as u64) << 8 | (*0x1::vector::borrow<u8>(arg0, v0 + 1) as u64)) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg0, v0 + 2 + v2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun pv(arg0: &0x2::clock::Clock, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>) : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo> {
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, extract_vaa(&arg3), arg0), arg0)
    }

    // decompiled from Move bytecode v7
}

