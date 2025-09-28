module 0xb77c5df0d1ce9d4513069e657e4beca98350ed3d5b9e296696d31412487336fc::cetus_position {
    struct CetusPosition has store, key {
        id: 0x2::object::UID,
        pool_id: address,
        tick_lower: u32,
        tick_upper: u32,
        liquidity_amount_a: u64,
        liquidity_amount_b: u64,
        owner: address,
        created_at: u64,
        is_active: bool,
    }

    struct PositionCreated has copy, drop {
        position_id: address,
        pool_id: address,
        tick_lower: u32,
        tick_upper: u32,
        amount_a: u64,
        amount_b: u64,
        owner: address,
    }

    struct PositionClosed has copy, drop {
        position_id: address,
        pool_id: address,
        withdrawn_amount_a: u64,
        withdrawn_amount_b: u64,
        owner: address,
    }

    struct NewRange has copy, drop, store {
        tick_lower: u32,
        tick_upper: u32,
    }

    struct PositionRebalanced has copy, drop {
        position_id: address,
        old_tick_lower: u32,
        old_tick_upper: u32,
        new_tick_lower: u32,
        new_tick_upper: u32,
        owner: address,
    }

    public fun calculate_buy_the_dip_range(arg0: u32, arg1: u32, arg2: u32, arg3: u32) : NewRange {
        let v0 = (arg0 as u64) * (arg1 as u64) / 10000;
        let v1 = if (arg0 > (v0 as u32)) {
            arg0 - (v0 as u32)
        } else {
            0
        };
        let v2 = arg2 / 2;
        let v3 = if (v1 > v2) {
            v1 - v2
        } else {
            0
        };
        NewRange{
            tick_lower : v3 / arg3 * arg3,
            tick_upper : (v1 + v2) / arg3 * arg3,
        }
    }

    public fun close_position<T0, T1>(arg0: CetusPosition, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let CetusPosition {
            id                 : v1,
            pool_id            : v2,
            tick_lower         : _,
            tick_upper         : _,
            liquidity_amount_a : v5,
            liquidity_amount_b : v6,
            owner              : v7,
            created_at         : _,
            is_active          : _,
        } = arg0;
        let v10 = v1;
        assert!(v7 == v0, 0);
        let v11 = PositionClosed{
            position_id        : 0x2::object::uid_to_address(&v10),
            pool_id            : v2,
            withdrawn_amount_a : v5,
            withdrawn_amount_b : v6,
            owner              : v0,
        };
        0x2::event::emit<PositionClosed>(v11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v5, arg3), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg2, v6, arg3), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, v0);
        0x2::object::delete(v10);
    }

    public fun create_position<T0, T1>(arg0: address, arg1: u32, arg2: u32, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::coin::value<T0>(&arg3);
        let v2 = 0x2::coin::value<T1>(&arg4);
        let v3 = CetusPosition{
            id                 : 0x2::object::new(arg6),
            pool_id            : arg0,
            tick_lower         : arg1,
            tick_upper         : arg2,
            liquidity_amount_a : v1,
            liquidity_amount_b : v2,
            owner              : v0,
            created_at         : 0x2::clock::timestamp_ms(arg5),
            is_active          : true,
        };
        let v4 = PositionCreated{
            position_id : 0x2::object::uid_to_address(&v3.id),
            pool_id     : arg0,
            tick_lower  : arg1,
            tick_upper  : arg2,
            amount_a    : v1,
            amount_b    : v2,
            owner       : v0,
        };
        0x2::event::emit<PositionCreated>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg4, v0);
        0x2::transfer::transfer<CetusPosition>(v3, v0);
    }

    public fun destroy_position(arg0: CetusPosition, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let CetusPosition {
            id                 : v1,
            pool_id            : v2,
            tick_lower         : _,
            tick_upper         : _,
            liquidity_amount_a : v5,
            liquidity_amount_b : v6,
            owner              : v7,
            created_at         : _,
            is_active          : _,
        } = arg0;
        let v10 = v1;
        assert!(v7 == v0, 0);
        let v11 = PositionClosed{
            position_id        : 0x2::object::uid_to_address(&v10),
            pool_id            : v2,
            withdrawn_amount_a : v5,
            withdrawn_amount_b : v6,
            owner              : v0,
        };
        0x2::event::emit<PositionClosed>(v11);
        0x2::object::delete(v10);
    }

    public fun get_position_info(arg0: &CetusPosition) : (address, u32, u32, u64, u64, bool) {
        (arg0.pool_id, arg0.tick_lower, arg0.tick_upper, arg0.liquidity_amount_a, arg0.liquidity_amount_b, arg0.is_active)
    }

    public fun rebalance_position(arg0: &mut CetusPosition, arg1: u32, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.owner == v0, 101);
        arg0.tick_lower = arg1;
        arg0.tick_upper = arg2;
        let v1 = PositionRebalanced{
            position_id    : 0x2::object::uid_to_address(&arg0.id),
            old_tick_lower : arg0.tick_lower,
            old_tick_upper : arg0.tick_upper,
            new_tick_lower : arg1,
            new_tick_upper : arg2,
            owner          : v0,
        };
        0x2::event::emit<PositionRebalanced>(v1);
    }

    public entry fun rebalance_position_entry(arg0: &mut CetusPosition, arg1: u32, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) {
        rebalance_position(arg0, arg1, arg2, arg3);
    }

    public fun should_rebalance(arg0: u32, arg1: u32, arg2: &NewRange) : bool {
        arg0 != arg2.tick_lower || arg1 != arg2.tick_upper
    }

    public fun update_position(arg0: &mut CetusPosition, arg1: u32, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 0);
        arg0.tick_lower = arg1;
        arg0.tick_upper = arg2;
    }

    // decompiled from Move bytecode v6
}

