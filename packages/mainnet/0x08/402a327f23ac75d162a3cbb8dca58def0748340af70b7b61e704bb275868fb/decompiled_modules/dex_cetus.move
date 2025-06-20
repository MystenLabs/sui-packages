module 0x8402a327f23ac75d162a3cbb8dca58def0748340af70b7b61e704bb275868fb::dex_cetus {
    struct CetusSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        method: vector<u8>,
        package: address,
        timestamp: u64,
    }

    fun cetus_clmm_swap_call(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::coin::value<0x2::sui::SUI>(&arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg4);
    }

    public fun get_cetus_package() : address {
        0x8402a327f23ac75d162a3cbb8dca58def0748340af70b7b61e704bb275868fb::constants::cetus_package()
    }

    public fun is_cetus_operational() : bool {
        true
    }

    public entry fun swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 9001);
        assert!(arg2 > 0, 9005);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(arg1 != @0x0, 9003);
        cetus_clmm_swap_call(arg0, 0x8402a327f23ac75d162a3cbb8dca58def0748340af70b7b61e704bb275868fb::constants::cetus_sui_usdc_pool(), arg2, arg3, v1, arg4);
        let v2 = CetusSwapExecuted{
            sender         : v1,
            amount_in      : v0,
            min_amount_out : arg2,
            pool_id        : arg1,
            method         : b"cetus_amm_swap",
            package        : 0x8402a327f23ac75d162a3cbb8dca58def0748340af70b7b61e704bb275868fb::constants::cetus_package(),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CetusSwapExecuted>(v2);
    }

    // decompiled from Move bytecode v6
}

