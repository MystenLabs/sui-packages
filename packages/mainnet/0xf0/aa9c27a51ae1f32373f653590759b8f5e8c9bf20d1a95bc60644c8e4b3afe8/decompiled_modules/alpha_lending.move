module 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::alpha_lending {
    struct LendingProtocol has key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun borrow<T0>(arg0: &mut LendingProtocol, arg1: &0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::position::PositionCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::market::LiquidityPromise<T0> {
        abort 0
    }

    public fun add_collateral<T0>(arg0: &mut LendingProtocol, arg1: &0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::position::PositionCap, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun collect_reward<T0>(arg0: &mut LendingProtocol, arg1: u64, arg2: &0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::position::PositionCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::market::LiquidityPromise<T0>) {
        abort 0
    }

    public fun collect_reward_and_deposit<T0>(arg0: &mut LendingProtocol, arg1: u64, arg2: &0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::position::PositionCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::market::LiquidityPromise<T0>) {
        abort 0
    }

    public fun collect_staking_rewards(arg0: &mut LendingProtocol, arg1: &AdminCap, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun create_position(arg0: &mut LendingProtocol, arg1: &mut 0x2::tx_context::TxContext) : 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::position::PositionCap {
        abort 0
    }

    public fun fulfill_promise<T0>(arg0: &mut LendingProtocol, arg1: 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::market::LiquidityPromise<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 0
    }

    public fun fulfill_promise_SUI(arg0: &mut LendingProtocol, arg1: 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::market::LiquidityPromise<0x2::sui::SUI>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        abort 0
    }

    public fun get_claimable_rewards(arg0: &mut LendingProtocol, arg1: &0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::position::PositionCap, arg2: &0x2::clock::Clock) : vector<0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::rewards::ClaimableReward> {
        abort 0
    }

    public fun get_collateral_amount(arg0: &mut LendingProtocol, arg1: u64, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : u64 {
        abort 0
    }

    public fun remove_collateral<T0>(arg0: &mut LendingProtocol, arg1: &0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::position::PositionCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::market::LiquidityPromise<T0> {
        abort 0
    }

    public fun repay<T0>(arg0: &mut LendingProtocol, arg1: &0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::position::PositionCap, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

