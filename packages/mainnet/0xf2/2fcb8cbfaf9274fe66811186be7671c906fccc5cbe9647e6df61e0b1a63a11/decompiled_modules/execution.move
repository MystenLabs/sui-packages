module 0xf22fcb8cbfaf9274fe66811186be7671c906fccc5cbe9647e6df61e0b1a63a11::execution {
    public fun maybe_x_to_y<T0>(arg0: &mut 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<T0>, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>, arg3: 0x1::option::Option<0x2::coin::Coin<T0>>, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg3)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg3);
            return 0x1::option::none<0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>>()
        };
        let v0 = 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest>();
        0x1::option::some<0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>>(0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::swap_in<T0>(arg0, arg1, arg2, 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg3), &v0, arg4))
    }

    public fun maybe_y_to_x<T0>(arg0: &mut 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<T0>, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>, arg3: 0x1::option::Option<0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>>, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1::option::is_none<0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>>(&arg3)) {
            0x1::option::destroy_none<0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>>(arg3);
            return 0x1::option::none<0x2::coin::Coin<T0>>()
        };
        let v0 = 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest>();
        0x1::option::some<0x2::coin::Coin<T0>>(0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::swap_out<T0>(arg0, arg1, arg2, 0x1::option::destroy_some<0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>>(arg3), &v0, arg4))
    }

    // decompiled from Move bytecode v7
}

