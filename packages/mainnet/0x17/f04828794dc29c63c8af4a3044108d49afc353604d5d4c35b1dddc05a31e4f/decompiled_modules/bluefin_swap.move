module 0x17f04828794dc29c63c8af4a3044108d49afc353604d5d4c35b1dddc05a31e4f::bluefin_swap {
    struct BluefinSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        method: vector<u8>,
    }

    fun bluefin_gateway_swap_assets(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        call_bluefin_gateway_swap(0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg4), arg1, arg2);
        let v0 = BluefinSwapExecuted{
            sender         : 0x2::tx_context::sender(arg4),
            amount_in      : arg1,
            min_amount_out : arg2,
            pool_id        : @0x3b585786b13af1d8ea067ab37101b6513a05d2f90cfe60e8b1d9e1b46a63c4fa,
            method         : b"real_bluefin_gateway_swap_assets",
        };
        0x2::event::emit<BluefinSwapExecuted>(v0);
    }

    public fun calculate_bluefin_output(arg0: u64) : u64 {
        (((arg0 as u128) * 9924 / 10000) as u64)
    }

    public fun calculate_bluefin_usdc_to_sui_output(arg0: u64) : u64 {
        (((arg0 as u128) * 9924 / 10000) as u64)
    }

    public fun call_bluefin_gateway_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64) : vector<u8> {
        0x2::coin::value<0x2::sui::SUI>(&arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x0);
        b"0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC"
    }

    fun execute_bluefin_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg4);
        bluefin_gateway_swap_assets(0x2::coin::into_balance<0x2::sui::SUI>(arg0), arg1, arg2, arg3, arg4);
    }

    public fun get_dex_info() : (vector<u8>, vector<u8>, u64) {
        (b"Bluefin", b"0.76% fee concentrated liquidity DEX", 9924)
    }

    public fun get_pool_config() : (address, address) {
        (@0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267, @0x3b585786b13af1d8ea067ab37101b6513a05d2f90cfe60e8b1d9e1b46a63c4fa)
    }

    public entry fun swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 4001);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(calculate_bluefin_output(v0) >= arg1, 4002);
        execute_bluefin_swap(arg0, v0, arg1, arg2, arg3);
        let v2 = BluefinSwapExecuted{
            sender         : v1,
            amount_in      : v0,
            min_amount_out : arg1,
            pool_id        : @0x3b585786b13af1d8ea067ab37101b6513a05d2f90cfe60e8b1d9e1b46a63c4fa,
            method         : b"real_bluefin_sui_usdc_swap",
        };
        0x2::event::emit<BluefinSwapExecuted>(v2);
    }

    public entry fun swap_usdc_to_sui(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 0, 4001);
        assert!(calculate_bluefin_usdc_to_sui_output(arg0) >= arg1, 4002);
        let v0 = BluefinSwapExecuted{
            sender         : 0x2::tx_context::sender(arg3),
            amount_in      : arg0,
            min_amount_out : arg1,
            pool_id        : @0x3b585786b13af1d8ea067ab37101b6513a05d2f90cfe60e8b1d9e1b46a63c4fa,
            method         : b"bluefin_usdc_to_sui_swap_real",
        };
        0x2::event::emit<BluefinSwapExecuted>(v0);
    }

    public fun validate_swap_params(arg0: u64, arg1: u64) : bool {
        if (arg0 > 0) {
            if (arg1 > 0) {
                arg0 >= 1000000
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v6
}

