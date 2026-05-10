module 0xe3a85e700c2bea075ca74288628ee28bfc48d90e80d9720fdee40e8f5ec9a310::mock_pool {
    struct MOCK_USDC has drop {
        dummy_field: bool,
    }

    struct MOCK_SUI has drop {
        dummy_field: bool,
    }

    struct MockPool has key {
        id: 0x2::object::UID,
        current_tick: u32,
        reserve_a: 0x2::balance::Balance<MOCK_USDC>,
        reserve_b: 0x2::balance::Balance<MOCK_SUI>,
        total_liquidity: u128,
    }

    struct MockPosition has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
        liquidity: u128,
        deposited_a: u64,
        deposited_b: u64,
    }

    public fun close_position(arg0: &mut MockPool, arg1: MockPosition, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<MOCK_USDC>, 0x2::coin::Coin<MOCK_SUI>) {
        let MockPosition {
            id          : v0,
            pool_id     : v1,
            tick_lower  : _,
            tick_upper  : _,
            liquidity   : v4,
            deposited_a : v5,
            deposited_b : v6,
        } = arg1;
        assert!(v1 == 0x2::object::id<MockPool>(arg0), 101);
        0x2::object::delete(v0);
        assert!(0x2::balance::value<MOCK_USDC>(&arg0.reserve_a) >= v5, 100);
        assert!(0x2::balance::value<MOCK_SUI>(&arg0.reserve_b) >= v6, 100);
        arg0.total_liquidity = arg0.total_liquidity - v4;
        (0x2::coin::take<MOCK_USDC>(&mut arg0.reserve_a, v5, arg2), 0x2::coin::take<MOCK_SUI>(&mut arg0.reserve_b, v6, arg2))
    }

    public fun current_tick(arg0: &MockPool) : u32 {
        arg0.current_tick
    }

    public fun init_pool(arg0: u32, arg1: &mut 0x2::tx_context::TxContext) : MockPool {
        MockPool{
            id              : 0x2::object::new(arg1),
            current_tick    : arg0,
            reserve_a       : 0x2::balance::zero<MOCK_USDC>(),
            reserve_b       : 0x2::balance::zero<MOCK_SUI>(),
            total_liquidity : 0,
        }
    }

    public fun open_position(arg0: &mut MockPool, arg1: u32, arg2: u32, arg3: 0x2::coin::Coin<MOCK_USDC>, arg4: 0x2::coin::Coin<MOCK_SUI>, arg5: &mut 0x2::tx_context::TxContext) : MockPosition {
        let v0 = 0x2::coin::value<MOCK_USDC>(&arg3);
        let v1 = 0x2::coin::value<MOCK_SUI>(&arg4);
        let v2 = (v0 as u128) + (v1 as u128);
        0x2::coin::put<MOCK_USDC>(&mut arg0.reserve_a, arg3);
        0x2::coin::put<MOCK_SUI>(&mut arg0.reserve_b, arg4);
        arg0.total_liquidity = arg0.total_liquidity + v2;
        MockPosition{
            id          : 0x2::object::new(arg5),
            pool_id     : 0x2::object::id<MockPool>(arg0),
            tick_lower  : arg1,
            tick_upper  : arg2,
            liquidity   : v2,
            deposited_a : v0,
            deposited_b : v1,
        }
    }

    public fun position_liquidity(arg0: &MockPosition) : u128 {
        arg0.liquidity
    }

    public fun position_pool_id(arg0: &MockPosition) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun position_tick_lower(arg0: &MockPosition) : u32 {
        arg0.tick_lower
    }

    public fun position_tick_upper(arg0: &MockPosition) : u32 {
        arg0.tick_upper
    }

    public fun reserve_a(arg0: &MockPool) : u64 {
        0x2::balance::value<MOCK_USDC>(&arg0.reserve_a)
    }

    public fun reserve_b(arg0: &MockPool) : u64 {
        0x2::balance::value<MOCK_SUI>(&arg0.reserve_b)
    }

    public fun share_pool(arg0: MockPool) {
        0x2::transfer::share_object<MockPool>(arg0);
    }

    public fun swap_a2b(arg0: &mut MockPool, arg1: 0x2::coin::Coin<MOCK_USDC>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MOCK_SUI> {
        let v0 = 0x2::coin::value<MOCK_USDC>(&arg1);
        0x2::coin::put<MOCK_USDC>(&mut arg0.reserve_a, arg1);
        assert!(0x2::balance::value<MOCK_SUI>(&arg0.reserve_b) >= v0, 100);
        0x2::coin::take<MOCK_SUI>(&mut arg0.reserve_b, v0, arg2)
    }

    public fun swap_b2a(arg0: &mut MockPool, arg1: 0x2::coin::Coin<MOCK_SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MOCK_USDC> {
        let v0 = 0x2::coin::value<MOCK_SUI>(&arg1);
        0x2::coin::put<MOCK_SUI>(&mut arg0.reserve_b, arg1);
        assert!(0x2::balance::value<MOCK_USDC>(&arg0.reserve_a) >= v0, 100);
        0x2::coin::take<MOCK_USDC>(&mut arg0.reserve_a, v0, arg2)
    }

    public fun total_liquidity(arg0: &MockPool) : u128 {
        arg0.total_liquidity
    }

    // decompiled from Move bytecode v7
}

