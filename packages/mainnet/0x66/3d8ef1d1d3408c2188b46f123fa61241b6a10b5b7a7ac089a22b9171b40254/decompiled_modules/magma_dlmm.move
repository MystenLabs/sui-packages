module 0x663d8ef1d1d3408c2188b46f123fa61241b6a10b5b7a7ac089a22b9171b40254::magma_dlmm {
    struct MagmaSwapEvent has copy, drop, store {
        pool: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        partner_id: 0x2::object::ID,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    fun swap<T0, T1>(arg0: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig, arg1: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg2: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::partner::Partner, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: bool, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (arg7) {
            assert!(0x2::coin::value<T1>(&arg4) == 0, 9223372346092421119);
        } else {
            assert!(0x2::coin::value<T0>(&arg3) == 0, 9223372354682355711);
        };
        let (v0, v1, v2) = if (0x2::object::id_address<0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::partner::Partner>(arg2) == @0xe42e8c358149738b6f020696a78d911342e8334b1ec369097a96e5a49f7ef996) {
            0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::swap<T0, T1>(arg1, arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
        } else {
            0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::swap_with_partner<T0, T1>(arg1, arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
        };
        let v3 = v2;
        let v4 = MagmaSwapEvent{
            pool         : 0x2::object::id<0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>>(arg1),
            amount_in    : arg5,
            amount_out   : 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::amounts_out(&v3),
            a2b          : arg7,
            by_amount_in : true,
            partner_id   : 0x2::object::id<0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::partner::Partner>(arg2),
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<MagmaSwapEvent>(v4);
        (0x2::coin::from_balance<T0>(v0, arg10), 0x2::coin::from_balance<T1>(v1, arg10))
    }

    public fun swap_a2b<T0, T1>(arg0: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig, arg1: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg2: &mut 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::partner::Partner, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::zero<T1>(arg5);
        let v1 = 0x2::tx_context::sender(arg5);
        let (v2, v3) = swap<T0, T1>(arg0, arg1, arg2, arg3, v0, 0x2::coin::value<T0>(&arg3), 1, true, v1, arg4, arg5);
        0x2::coin::destroy_zero<T0>(v2);
        v3
    }

    public fun swap_b2a<T0, T1>(arg0: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig, arg1: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg2: &mut 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::partner::Partner, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg5);
        let v1 = 0x2::tx_context::sender(arg5);
        let (v2, v3) = swap<T0, T1>(arg0, arg1, arg2, v0, arg3, 0x2::coin::value<T1>(&arg3), 1, false, v1, arg4, arg5);
        0x2::coin::destroy_zero<T1>(v3);
        v2
    }

    // decompiled from Move bytecode v6
}

