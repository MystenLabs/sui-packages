module 0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::manager {
    struct State<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<T0>,
        balance: 0x2::balance::Balance<T1>,
    }

    public fun mint<T0, T1>(arg0: &mut State<T0, T1>, arg1: &0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::amm::Market<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::yield_object::YieldObject<T1>) {
        if (0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::amm::is_expired<T0, T1>(arg1, arg4)) {
            abort 1
        };
        let v0 = 0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::utils::sy_to_asset(0x2::coin::value<T1>(&arg2), arg3);
        0x2::coin::put<T1>(&mut arg0.balance, arg2);
        (0x2::coin::mint<T0>(&mut arg0.treasury, v0, arg5), 0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::yield_object::mint<T1>(v0, arg3, arg5))
    }

    public fun claim_interest<T0, T1>(arg0: &mut State<T0, T1>, arg1: &0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::amm::Market<T0, T1>, arg2: &mut 0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::yield_object::YieldObject<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::amm::is_expired<T0, T1>(arg1, arg3)) {
            abort 1
        };
        0x2::coin::take<T1>(&mut arg0.balance, 0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::yield_object::claim<T1>(arg2), arg4)
    }

    public fun earn_interest<T0, T1>(arg0: &0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::amm::Market<T0, T1>, arg1: &mut 0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::yield_object::YieldObject<T1>, arg2: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::amm::is_expired<T0, T1>(arg0, arg3)) {
            abort 1
        };
        0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::yield_object::earn<T1>(arg1, arg2);
    }

    public fun new_state<T0, T1>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : State<T0, T1> {
        State<T0, T1>{
            id       : 0x2::object::new(arg1),
            treasury : arg0,
            balance  : 0x2::balance::zero<T1>(),
        }
    }

    public fun redeem_after_maturity<T0, T1>(arg0: &mut State<T0, T1>, arg1: &0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::amm::Market<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (!0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::amm::is_expired<T0, T1>(arg1, arg4)) {
            abort 3
        };
        0x2::coin::burn<T0>(&mut arg0.treasury, arg2);
        0x2::coin::take<T1>(&mut arg0.balance, 0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::utils::asset_to_sy(0x2::coin::value<T0>(&arg2), arg3), arg5)
    }

    public fun redeem_before_maturity<T0, T1>(arg0: &mut State<T0, T1>, arg1: &0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::amm::Market<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::yield_object::YieldObject<T1>, arg4: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::amm::is_expired<T0, T1>(arg1, arg5)) {
            abort 5
        };
        let v0 = 0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::yield_object::get_amount<T1>(&arg3);
        assert!(0x2::coin::value<T0>(&arg2) == v0, 0);
        0x2::coin::burn<T0>(&mut arg0.treasury, arg2);
        0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::yield_object::delete<T1>(arg3);
        0x2::coin::take<T1>(&mut arg0.balance, 0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::utils::asset_to_sy(v0, arg4), arg6)
    }

    // decompiled from Move bytecode v6
}

