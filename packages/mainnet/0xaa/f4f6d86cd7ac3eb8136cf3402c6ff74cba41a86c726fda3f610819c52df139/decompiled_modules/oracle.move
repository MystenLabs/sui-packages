module 0xaaf4f6d86cd7ac3eb8136cf3402c6ff74cba41a86c726fda3f610819c52df139::oracle {
    public fun update_price<T0>(arg0: &mut 0x6987906fbf965e4ac549e774e22714cbab402fd934330702727e2efb1b2aa98e::x_oracle::XOracle, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg3: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg4: &0x467a24e385368f74bb525e24783ff33d692c0ed5c09d544ef85d583f823ba387::pyth_registry::PythRegistry, arg5: vector<u8>, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6987906fbf965e4ac549e774e22714cbab402fd934330702727e2efb1b2aa98e::x_oracle::price_update_request<T0>(arg0);
        0x467a24e385368f74bb525e24783ff33d692c0ed5c09d544ef85d583f823ba387::rule::set_price<T0>(&mut v0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::split<0x2::sui::SUI>(arg6, 1, arg8), arg7);
        0x6987906fbf965e4ac549e774e22714cbab402fd934330702727e2efb1b2aa98e::x_oracle::confirm_price_update_request<T0>(arg0, v0, arg7);
    }

    public fun update_usdc_sui_prices<T0>(arg0: &mut 0x6987906fbf965e4ac549e774e22714cbab402fd934330702727e2efb1b2aa98e::x_oracle::XOracle, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg3: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg4: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg5: &0x467a24e385368f74bb525e24783ff33d692c0ed5c09d544ef85d583f823ba387::pyth_registry::PythRegistry, arg6: vector<u8>, arg7: vector<u8>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg8;
        update_price<0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg5, arg6, v0, arg9, arg10);
        let v1 = &mut arg8;
        update_price<T0>(arg0, arg1, arg2, arg4, arg5, arg7, v1, arg9, arg10);
        0xaaf4f6d86cd7ac3eb8136cf3402c6ff74cba41a86c726fda3f610819c52df139::util::destory_or_send_to_sender<0x2::sui::SUI>(arg8, arg10);
    }

    // decompiled from Move bytecode v6
}

