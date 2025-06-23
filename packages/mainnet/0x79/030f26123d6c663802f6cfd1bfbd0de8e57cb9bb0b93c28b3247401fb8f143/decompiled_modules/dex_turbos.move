module 0x79030f26123d6c663802f6cfd1bfbd0de8e57cb9bb0b93c28b3247401fb8f143::dex_turbos {
    public fun calculate_sqrt_price_limit_turbos(arg0: bool, arg1: u64) : u128 {
        if (arg0) {
            79226673515401279992447579055
        } else {
            79428396330099221080
        }
    }

    public(friend) fun call_turbos_swap_sui_to_usdc_external(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u128, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x79030f26123d6c663802f6cfd1bfbd0de8e57cb9bb0b93c28b3247401fb8f143::usdc::USDC> {
        abort 6002
    }

    public(friend) fun call_turbos_swap_usdc_to_sui_external(arg0: address, arg1: 0x2::coin::Coin<0x79030f26123d6c663802f6cfd1bfbd0de8e57cb9bb0b93c28b3247401fb8f143::usdc::USDC>, arg2: u64, arg3: u128, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        abort 6002
    }

    public fun swap_sui_to_usdc_turbos(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u128, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x79030f26123d6c663802f6cfd1bfbd0de8e57cb9bb0b93c28b3247401fb8f143::usdc::USDC> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 6001);
        let v0 = call_turbos_swap_sui_to_usdc_external(arg0, arg1, arg2, arg3, arg4, arg6);
        assert!(0x2::coin::value<0x79030f26123d6c663802f6cfd1bfbd0de8e57cb9bb0b93c28b3247401fb8f143::usdc::USDC>(&v0) >= arg2, 6002);
        v0
    }

    public fun swap_usdc_to_sui_turbos(arg0: address, arg1: 0x2::coin::Coin<0x79030f26123d6c663802f6cfd1bfbd0de8e57cb9bb0b93c28b3247401fb8f143::usdc::USDC>, arg2: u64, arg3: u128, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::value<0x79030f26123d6c663802f6cfd1bfbd0de8e57cb9bb0b93c28b3247401fb8f143::usdc::USDC>(&arg1) > 0, 6001);
        let v0 = call_turbos_swap_usdc_to_sui_external(arg0, arg1, arg2, arg3, arg4, arg6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v0) >= arg2, 6002);
        v0
    }

    // decompiled from Move bytecode v6
}

