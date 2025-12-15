module 0xa978fab7c608c1a76426606772356196637a23ecb7d4eff8404373af8a135731::router {
    struct OrderRecord has copy, drop {
        order_id: u64,
        decimal: u8,
        out_amount: u64,
    }

    struct CommissionRecord has copy, drop {
        commission_amount: u64,
        referral_address: address,
    }

    struct HopRecord has copy, drop {
        out_amount: u64,
    }

    public fun alphafi_swap_a2b_with_return<T0: drop>(arg0: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        let v0 = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::mint<T0>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::coin::value<T0>(&v0);
        let v2 = HopRecord{out_amount: v1};
        0x2::event::emit<HopRecord>(v2);
        (v0, v1)
    }

    public fun alphafi_swap_b2a_with_return<T0: drop>(arg0: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, u64) {
        let v0 = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::redeem<T0>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        let v2 = HopRecord{out_amount: v1};
        0x2::event::emit<HopRecord>(v2);
        (v0, v1)
    }

    fun destroy_or_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun finalize<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: address, arg4: address, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 6);
        assert!(arg2 == 0 || arg2 > 0 && arg3 != @0x0, 5);
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = if (arg4 != @0x0) {
            arg4
        } else {
            0x2::tx_context::sender(arg7)
        };
        if (v0 < arg1) {
            abort 1
        };
        if (arg2 > 0) {
            let v2 = &mut arg0;
            let (v3, _) = split_with_percentage_for_commission<T0>(v2, arg2, arg3, arg7);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v1);
            destroy_or_transfer<T0>(arg0, arg7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, v1);
        };
        let v5 = OrderRecord{
            order_id   : arg5,
            decimal    : arg6,
            out_amount : v0,
        };
        0x2::event::emit<OrderRecord>(v5);
    }

    public fun haedal_swap_a2b_with_return(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, u64) {
        let v0 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::request_stake_coin(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v0);
        let v2 = HopRecord{out_amount: v1};
        0x2::event::emit<HopRecord>(v2);
        (v0, v1)
    }

    public fun haedal_swap_b2a_with_return(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, u64) {
        let v0 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::request_unstake_instant_coin(arg0, arg1, arg2, arg3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        let v2 = HopRecord{out_amount: v1};
        0x2::event::emit<HopRecord>(v2);
        (v0, v1)
    }

    public fun scallop_swap_exact_swap_a2b_with_return<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T1, T0>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let v0 = 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::mint_s_coin<T1, T0>(arg2, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg0, arg1, arg3, arg4, arg5), arg5);
        let v1 = 0x2::coin::value<T1>(&v0);
        let v2 = HopRecord{out_amount: v1};
        0x2::event::emit<HopRecord>(v2);
        (v0, v1)
    }

    public fun scallop_swap_exact_swap_b2a_with_return<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T1>(arg0, arg1, 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::burn_s_coin<T0, T1>(arg2, arg3, arg5), arg4, arg5);
        let v1 = 0x2::coin::value<T1>(&v0);
        let v2 = HopRecord{out_amount: v1};
        0x2::event::emit<HopRecord>(v2);
        (v0, v1)
    }

    public fun split_with_percentage<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64, 0x2::coin::Coin<T0>, u64) {
        assert!(arg1 <= 10000, 2);
        let v0 = 0x2::coin::value<T0>(arg0);
        let v1 = (((v0 as u128) * (arg1 as u128) / (10000 as u128)) as u64);
        (0x2::coin::split<T0>(arg0, v1, arg2), v1, 0x2::coin::split<T0>(arg0, v0 - v1, arg2), v0 - v1)
    }

    public fun split_with_percentage_for_commission<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        assert!(arg1 <= 300, 3);
        assert!(arg1 == 0 || arg1 > 0 && arg2 != @0x0, 5);
        let (v0, v1, v2, v3) = split_with_percentage<T0>(arg0, arg1, arg3);
        if (v1 == 0) {
            0x2::coin::destroy_zero<T0>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg2);
            let v4 = CommissionRecord{
                commission_amount : v1,
                referral_address  : arg2,
            };
            0x2::event::emit<CommissionRecord>(v4);
        };
        (v2, v3)
    }

    // decompiled from Move bytecode v6
}

