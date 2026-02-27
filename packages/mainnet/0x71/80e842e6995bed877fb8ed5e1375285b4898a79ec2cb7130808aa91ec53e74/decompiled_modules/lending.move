module 0x7180e842e6995bed877fb8ed5e1375285b4898a79ec2cb7130808aa91ec53e74::lending {
    struct DepositEvent has copy, drop {
        sender: address,
        amount: u64,
    }

    struct ClaimRewardEvent has copy, drop {
        receiver: address,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        receiver: address,
        amount: u64,
    }

    public fun claim_reward<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>, arg4: vector<0x1::ascii::String>, arg5: vector<address>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v1 = ClaimRewardEvent{
            receiver : 0x2::tx_context::sender(arg6),
            amount   : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<ClaimRewardEvent>(v1);
        v0
    }

    public fun deposit<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &mut 0x2::tx_context::TxContext) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::entry_deposit<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v0 = DepositEvent{
            sender : 0x2::tx_context::sender(arg8),
            amount : arg5,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public fun withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = WithdrawEvent{
            receiver : 0x2::tx_context::sender(arg9),
            amount   : arg5,
        };
        0x2::event::emit<WithdrawEvent>(v0);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_v2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    // decompiled from Move bytecode v6
}

