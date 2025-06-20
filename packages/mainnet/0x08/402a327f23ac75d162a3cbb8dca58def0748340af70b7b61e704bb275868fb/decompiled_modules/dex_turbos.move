module 0x8402a327f23ac75d162a3cbb8dca58def0748340af70b7b61e704bb275868fb::dex_turbos {
    struct TurbosSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        fee_tier: u64,
        method: vector<u8>,
        package: address,
        timestamp: u64,
    }

    fun calculate_turbos_swap_output(arg0: u64, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        arg0 * 700000 / 1000000 * 1050000 / 1000000000
    }

    public fun get_turbos_package() : address {
        0x8402a327f23ac75d162a3cbb8dca58def0748340af70b7b61e704bb275868fb::constants::turbos_package()
    }

    public entry fun swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 8001);
        assert!(arg2 > 0, 8004);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(arg1 != @0x0, 8003);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(turbos_external_swap_sui_to_usdc(arg0, arg1, arg2, arg3, arg4), v1);
        let v2 = TurbosSwapExecuted{
            sender         : v1,
            amount_in      : v0,
            min_amount_out : arg2,
            pool_id        : arg1,
            fee_tier       : 3000,
            method         : b"turbos_clmm_swap",
            package        : 0x8402a327f23ac75d162a3cbb8dca58def0748340af70b7b61e704bb275868fb::constants::turbos_package(),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TurbosSwapExecuted>(v2);
    }

    fun turbos_external_swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        assert!(calculate_turbos_swap_output(0x2::coin::value<0x2::sui::SUI>(&arg0), arg1, arg3) >= arg2, 8001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg4));
        0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), arg4)
    }

    // decompiled from Move bytecode v6
}

