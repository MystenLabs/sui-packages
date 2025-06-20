module 0x8402a327f23ac75d162a3cbb8dca58def0748340af70b7b61e704bb275868fb::dex_deepbook {
    struct DeepBookSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        method: vector<u8>,
        package: address,
        timestamp: u64,
    }

    fun calculate_usdc_output_from_sui(arg0: u64, arg1: address) : u64 {
        let v0 = arg0 * 180 / 100;
        (v0 - v0 * 5 / 10000) / 1000
    }

    public fun call_deepbook_v3_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg0);
        0x2::balance::value<0x2::sui::SUI>(&v0);
        let v1 = execute_deepbook_v3_market_order(v0, arg1, arg2, arg3, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v1, arg5), arg4);
    }

    fun create_usdc_balance_from_swap(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1))
    }

    fun deepbook_v3_execute_market_order(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg5);
        call_deepbook_v3_swap(v0, arg1, arg2, arg3, arg4, arg5);
    }

    fun execute_deepbook_v3_market_order(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0);
        0x2::balance::destroy_zero<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0, v0));
        0x2::balance::destroy_zero<0x2::sui::SUI>(arg0);
        create_usdc_balance_from_swap(calculate_usdc_output_from_sui(v0, arg1), arg4)
    }

    public fun get_deepbook_package() : address {
        0x8402a327f23ac75d162a3cbb8dca58def0748340af70b7b61e704bb275868fb::constants::deepbook_package()
    }

    public entry fun swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 6001);
        assert!(arg2 > 0, 6004);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(arg1 != @0x0, 6003);
        deepbook_v3_execute_market_order(0x2::coin::into_balance<0x2::sui::SUI>(arg0), arg1, arg2, arg3, v1, arg4);
        let v2 = DeepBookSwapExecuted{
            sender         : v1,
            amount_in      : v0,
            min_amount_out : arg2,
            pool_id        : arg1,
            method         : b"deepbook_clob_swap",
            package        : 0x8402a327f23ac75d162a3cbb8dca58def0748340af70b7b61e704bb275868fb::constants::deepbook_package(),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DeepBookSwapExecuted>(v2);
    }

    // decompiled from Move bytecode v6
}

