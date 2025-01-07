module 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::dashboard {
    struct VimverseInfo has copy, drop {
        index: u64,
        vim_staking_balance: u64,
        next_reward: u64,
        rebase_left_time: u64,
        total_reserves: u64,
    }

    struct BondInfo has copy, drop {
        mv: u64,
        rfv: u64,
        pol: u64,
        price_in_usd: u64,
    }

    struct UserBondInfo has copy, drop {
        price_in_usd: u64,
        bond_price: u64,
        max_payout: u64,
        debt_ratio: u64,
        current_debt: u64,
        unclaim_payout: u64,
        claimable_payout: u64,
        payout: u64,
    }

    public fun query_bond_info<T0>(arg0: &0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::bond_depository44::Terms<T0>, arg1: &0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::treasury::DepoisitToken<T0>, arg2: &0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::TreasuryLock<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>, arg3: &0x2::clock::Clock) : BondInfo {
        let v0 = 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::treasury::deposit_balance<T0>(arg1);
        BondInfo{
            mv           : v0,
            rfv          : v0,
            pol          : 0,
            price_in_usd : 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::bond_depository44::bond_price_in_usd<T0>(arg0, arg1, arg2, arg3),
        }
    }

    public fun query_user_bond_info<T0>(arg0: address, arg1: u64, arg2: &0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::bond_depository44::BondDepository44<T0>, arg3: &0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::bond_depository44::Terms<T0>, arg4: &0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::treasury::DepoisitToken<T0>, arg5: &0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::TreasuryLock<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>, arg6: &0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::TreasuryCap<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>, arg7: &0x2::clock::Clock) : UserBondInfo {
        UserBondInfo{
            price_in_usd     : 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::bond_depository44::bond_price_in_usd<T0>(arg3, arg4, arg5, arg7),
            bond_price       : 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::bond_depository44::bond_price<T0>(arg3, arg5, arg7),
            max_payout       : 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::bond_depository44::max_payout<T0>(arg5, arg3),
            debt_ratio       : 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::bond_depository44::debt_ratio<T0>(arg3, arg5, arg7),
            current_debt     : 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::bond_depository44::current_debt<T0>(arg3, arg7),
            unclaim_payout   : 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::bond_depository44::unclaim_payout_for<T0>(arg0, arg2, arg6),
            claimable_payout : 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::bond_depository44::pending_payout_for<T0>(arg0, arg2, arg7, arg6),
            payout           : 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::bond_depository44::payout_for<T0>(arg1, arg3, arg5, arg7),
        }
    }

    public fun query_vimverse_info(arg0: &0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::TreasuryCap<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>, arg1: &0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::treasury::Treasury, arg2: &0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::staking::Staking, arg3: &0x2::clock::Clock) : VimverseInfo {
        let v0 = 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::staking::next_reward_time(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v2 = 0;
        if (v0 > v1) {
            v2 = v0 - v1;
        };
        VimverseInfo{
            index               : 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::index<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(arg0),
            vim_staking_balance : 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::staking::vim_staking_balance(arg2, arg0),
            next_reward         : 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::staking::next_reward(arg2),
            rebase_left_time    : v2,
            total_reserves      : 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::treasury::total_reserves(arg1),
        }
    }

    // decompiled from Move bytecode v6
}

