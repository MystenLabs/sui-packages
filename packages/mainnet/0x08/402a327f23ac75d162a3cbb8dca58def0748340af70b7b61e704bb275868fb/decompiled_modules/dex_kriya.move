module 0x8402a327f23ac75d162a3cbb8dca58def0748340af70b7b61e704bb275868fb::dex_kriya {
    struct KriyaSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        method: vector<u8>,
        package: address,
        timestamp: u64,
    }

    fun call_kriya_external_swap(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v0) * 997000 / 1000000 * 1045000 / 1000000000 >= arg2, 5001);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(v0);
        0x2::balance::value<0x2::sui::SUI>(&v1);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>()
    }

    fun execute_kriya_amm_swap(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        assert!(arg2 * 997000 / 1000000 * 1045000 / 1000000000 >= arg3, 5001);
        0x2::balance::value<0x2::sui::SUI>(&arg0);
        call_kriya_external_swap(arg0, arg1, arg3, arg5)
    }

    public fun get_kriya_package() : address {
        0x8402a327f23ac75d162a3cbb8dca58def0748340af70b7b61e704bb275868fb::constants::kriya_package()
    }

    fun kriya_amm_execute_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        let v0 = execute_kriya_amm_swap(0x2::coin::into_balance<0x2::sui::SUI>(arg0), arg1, arg2, arg3, arg4, arg5);
        0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0, arg5)
    }

    public entry fun swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 5001);
        assert!(arg2 > 0, 5004);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(arg1 != @0x0, 5003);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(kriya_amm_execute_swap(arg0, arg1, v0, arg2, arg3, arg4), v1);
        let v2 = KriyaSwapExecuted{
            sender         : v1,
            amount_in      : v0,
            min_amount_out : arg2,
            pool_id        : arg1,
            method         : b"kriya_amm_swap",
            package        : 0x8402a327f23ac75d162a3cbb8dca58def0748340af70b7b61e704bb275868fb::constants::kriya_package(),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<KriyaSwapExecuted>(v2);
    }

    // decompiled from Move bytecode v6
}

