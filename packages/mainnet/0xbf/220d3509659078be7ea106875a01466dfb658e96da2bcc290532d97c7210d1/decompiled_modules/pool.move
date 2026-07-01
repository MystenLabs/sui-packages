module 0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::pool {
    struct POOL has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        sqrt_price_x64: u256,
        tick_index: u32,
        tick_spacing: u32,
        fee_bps: u64,
        liquidity_global: u128,
        fee_growth_global_a: u128,
        fee_growth_global_b: u128,
        reserve_a: 0x2::balance::Balance<T0>,
        reserve_b: 0x2::balance::Balance<T1>,
    }

    struct Position<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
        liquidity: u128,
        fee_growth_inside_last_a: u128,
        fee_growth_inside_last_b: u128,
        owed_a: u64,
        owed_b: u64,
    }

    struct TickInfo has copy, drop, store {
        liquidity_gross: u128,
        liquidity_net: u128,
        fee_growth_outside_a: u128,
        fee_growth_outside_b: u128,
        initialized: bool,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        fee_bps: u64,
        tick_spacing: u32,
        initial_sqrt_price_x64: u256,
    }

    struct SwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        a_to_b: bool,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        new_sqrt_price_x64: u256,
    }

    struct AddLiquidityEvent has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        sender: address,
        tick_lower: u32,
        tick_upper: u32,
        liquidity_delta: u128,
        amount_a: u64,
        amount_b: u64,
    }

    struct RemoveLiquidityEvent has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        sender: address,
        liquidity_delta: u128,
        amount_a: u64,
        amount_b: u64,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut Position<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = arg1.tick_lower;
        let v1 = arg1.tick_upper;
        let v2 = 0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::tick_math::get_sqrt_ratio_at_tick(v0);
        let v3 = 0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::tick_math::get_sqrt_ratio_at_tick(v1);
        let v4 = arg0.sqrt_price_x64;
        let v5 = 0x2::coin::value<T0>(&arg2);
        let v6 = 0x2::coin::value<T1>(&arg3);
        let v7 = 0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::tick_math::get_liquidity_for_amounts(v4, v2, v3, v5, v6);
        if (v7 == 0) {
            abort 4
        };
        let (v8, v9) = 0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::tick_math::get_amounts_for_liquidity(v4, v2, v3, v7);
        arg1.liquidity = arg1.liquidity + v7;
        arg1.fee_growth_inside_last_a = arg0.fee_growth_global_a;
        arg1.fee_growth_inside_last_b = arg0.fee_growth_global_b;
        let v10 = (v0 as u64);
        if (0x2::dynamic_field::exists_with_type<u64, TickInfo>(&arg0.id, v10)) {
            let v11 = 0x2::dynamic_field::remove<u64, TickInfo>(&mut arg0.id, v10);
            v11.liquidity_gross = v11.liquidity_gross + v7;
            v11.initialized = true;
            0x2::dynamic_field::add<u64, TickInfo>(&mut arg0.id, v10, v11);
        };
        let v12 = (v1 as u64);
        if (0x2::dynamic_field::exists_with_type<u64, TickInfo>(&arg0.id, v12)) {
            let v13 = 0x2::dynamic_field::remove<u64, TickInfo>(&mut arg0.id, v12);
            v13.liquidity_gross = v13.liquidity_gross + v7;
            v13.initialized = true;
            0x2::dynamic_field::add<u64, TickInfo>(&mut arg0.id, v12, v13);
        };
        arg0.liquidity_global = arg0.liquidity_global + v7;
        0x2::balance::join<T0>(&mut arg0.reserve_a, 0x2::coin::into_balance<T0>(arg2));
        0x2::balance::join<T1>(&mut arg0.reserve_b, 0x2::coin::into_balance<T1>(arg3));
        let v14 = AddLiquidityEvent{
            pool_id         : 0x2::object::uid_to_inner(&arg0.id),
            position_id     : 0x2::object::uid_to_inner(&arg1.id),
            sender          : 0x2::tx_context::sender(arg5),
            tick_lower      : v0,
            tick_upper      : v1,
            liquidity_delta : v7,
            amount_a        : v8,
            amount_b        : v9,
        };
        0x2::event::emit<AddLiquidityEvent>(v14);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_a, v5 - v8), arg5), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_b, v6 - v9), arg5))
    }

    public fun close_position<T0, T1>(arg0: Position<T0, T1>) {
        let Position {
            id                       : v0,
            pool_id                  : _,
            tick_lower               : _,
            tick_upper               : _,
            liquidity                : _,
            fee_growth_inside_last_a : _,
            fee_growth_inside_last_b : _,
            owed_a                   : _,
            owed_b                   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun collect_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut Position<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = arg1.owed_a;
        let v1 = arg1.owed_b;
        arg1.owed_a = 0;
        arg1.owed_b = 0;
        let v2 = if (v0 > 0) {
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_a, v0), arg3)
        } else {
            0x2::coin::zero<T0>(arg3)
        };
        let v3 = if (v1 > 0) {
            0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_b, v1), arg3)
        } else {
            0x2::coin::zero<T1>(arg3)
        };
        (v2, v3)
    }

    public fun create_pool<T0, T1>(arg0: &AdminCap, arg1: u256, arg2: u32, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        if (arg2 == 0) {
            abort 1
        };
        if (arg3 > 1000) {
            abort 0
        };
        if (arg1 < 4316055825262872218 || arg1 >= 7922644845311496243882047550464776895664) {
            abort 2
        };
        let v0 = 0x2::object::new(arg4);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = Pool<T0, T1>{
            id                  : v0,
            sqrt_price_x64      : arg1,
            tick_index          : 0,
            tick_spacing        : arg2,
            fee_bps             : arg3,
            liquidity_global    : 0,
            fee_growth_global_a : 0,
            fee_growth_global_b : 0,
            reserve_a           : 0x2::balance::zero<T0>(),
            reserve_b           : 0x2::balance::zero<T1>(),
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v2);
        let v3 = PoolCreated{
            pool_id                : v1,
            coin_type_a            : 0x1::type_name::get<T0>(),
            coin_type_b            : 0x1::type_name::get<T1>(),
            fee_bps                : arg3,
            tick_spacing           : arg2,
            initial_sqrt_price_x64 : arg1,
        };
        0x2::event::emit<PoolCreated>(v3);
        v1
    }

    fun decr_gross(arg0: u128, arg1: u128) : u128 {
        if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    public fun fee_bps<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.fee_bps
    }

    fun get_amount_out_a(arg0: u256, arg1: u256, arg2: u128) : u64 {
        let v0 = (arg2 as u256) * (arg1 - arg0) / 79228162514264337593543950336;
        if (v0 == 0) {
            0
        } else {
            ((v0 / 79228162514264337593543950336) as u64)
        }
    }

    fun get_amount_out_b(arg0: u256, arg1: u256, arg2: u128) : u64 {
        let v0 = arg0 * arg1 / 79228162514264337593543950336;
        if (v0 == 0) {
            0
        } else {
            (((arg2 as u256) * (arg0 - arg1) / 79228162514264337593543950336 * 340282366920938463463374607431768211456 / 79228162514264337593543950336 / v0) as u64)
        }
    }

    fun init(arg0: POOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<POOL>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(x"5375695377617020c2b720506f6f6c2041646d696e"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(x"41646d696e206361706162696c69747920666f7220746865205375695377617020706f6f6c206d6f64756c6520e2809420636f6e74726f6c7320706f6f6c206372656174696f6e2c2066656520746965722c20616e6420706f6f6c20706172616d65746572732e"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://swap.epinio.playunknown.com/icon.png"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://swap.epinio.playunknown.com"));
        let v6 = 0x2::display::new_with_fields<AdminCap>(&v1, v2, v4, arg1);
        0x2::display::update_version<AdminCap>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::display::Display<AdminCap>>(v6, v0);
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v7, v0);
    }

    public fun liquidity_global<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.liquidity_global
    }

    fun next_sqrt_price_from_input_a(arg0: u256, arg1: u256, arg2: u128, arg3: u64) : u256 {
        if (arg2 == 0) {
            abort 7
        };
        let v0 = (arg2 as u256) * arg0 / 79228162514264337593543950336 - (arg3 as u256) * arg1 / 79228162514264337593543950336;
        if (v0 == 0) {
            abort 7
        };
        let v1 = (arg2 as u256) * arg0 * arg1 / v0;
        if (v1 >= arg0) {
            abort 6
        };
        v1
    }

    fun next_sqrt_price_from_input_b(arg0: u256, arg1: u256, arg2: u128, arg3: u64) : u256 {
        if (arg2 == 0) {
            abort 7
        };
        let v0 = ((arg2 as u256) * arg0 / 79228162514264337593543950336 + (arg3 as u256) * arg0 / 79228162514264337593543950336) / (arg2 as u256);
        if (v0 >= arg1) {
            abort 6
        };
        if (v0 > 7922644845311496243882047550464776895664) {
            7922644845311496243882047550464776895664
        } else {
            v0
        }
    }

    public fun open_position<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u32, arg4: u32, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (Position<T0, T1>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (!0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::tick_math::i32_lt(arg3, arg4)) {
            abort 3
        };
        let v0 = 0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::tick_math::get_sqrt_ratio_at_tick(arg3);
        let v1 = 0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::tick_math::get_sqrt_ratio_at_tick(arg4);
        let v2 = arg0.sqrt_price_x64;
        let v3 = 0x2::coin::value<T0>(&arg1);
        let v4 = 0x2::coin::value<T1>(&arg2);
        let v5 = 0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::tick_math::get_liquidity_for_amounts(v2, v0, v1, v3, v4);
        if (v5 == 0) {
            abort 4
        };
        let (v6, v7) = 0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::tick_math::get_amounts_for_liquidity(v2, v0, v1, v5);
        let v8 = Position<T0, T1>{
            id                       : 0x2::object::new(arg6),
            pool_id                  : 0x2::object::uid_to_inner(&arg0.id),
            tick_lower               : arg3,
            tick_upper               : arg4,
            liquidity                : v5,
            fee_growth_inside_last_a : 0,
            fee_growth_inside_last_b : 0,
            owed_a                   : 0,
            owed_b                   : 0,
        };
        let v9 = (arg3 as u64);
        if (0x2::dynamic_field::exists_with_type<u64, TickInfo>(&arg0.id, v9)) {
            let v10 = 0x2::dynamic_field::remove<u64, TickInfo>(&mut arg0.id, v9);
            v10.liquidity_gross = v10.liquidity_gross + v5;
            v10.initialized = true;
            0x2::dynamic_field::add<u64, TickInfo>(&mut arg0.id, v9, v10);
        } else {
            let v11 = TickInfo{
                liquidity_gross      : v5,
                liquidity_net        : 0,
                fee_growth_outside_a : 0,
                fee_growth_outside_b : 0,
                initialized          : true,
            };
            0x2::dynamic_field::add<u64, TickInfo>(&mut arg0.id, v9, v11);
        };
        let v12 = (arg4 as u64);
        if (0x2::dynamic_field::exists_with_type<u64, TickInfo>(&arg0.id, v12)) {
            let v13 = 0x2::dynamic_field::remove<u64, TickInfo>(&mut arg0.id, v12);
            v13.liquidity_gross = v13.liquidity_gross + v5;
            v13.initialized = true;
            0x2::dynamic_field::add<u64, TickInfo>(&mut arg0.id, v12, v13);
        } else {
            let v14 = TickInfo{
                liquidity_gross      : v5,
                liquidity_net        : 0,
                fee_growth_outside_a : 0,
                fee_growth_outside_b : 0,
                initialized          : true,
            };
            0x2::dynamic_field::add<u64, TickInfo>(&mut arg0.id, v12, v14);
        };
        arg0.liquidity_global = arg0.liquidity_global + v5;
        0x2::balance::join<T0>(&mut arg0.reserve_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.reserve_b, 0x2::coin::into_balance<T1>(arg2));
        let v15 = AddLiquidityEvent{
            pool_id         : 0x2::object::uid_to_inner(&arg0.id),
            position_id     : 0x2::object::uid_to_inner(&v8.id),
            sender          : 0x2::tx_context::sender(arg6),
            tick_lower      : arg3,
            tick_upper      : arg4,
            liquidity_delta : v5,
            amount_a        : v6,
            amount_b        : v7,
        };
        0x2::event::emit<AddLiquidityEvent>(v15);
        v8.pool_id = 0x2::object::uid_to_inner(&arg0.id);
        (v8, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_a, v3 - v6), arg6), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_b, v4 - v7), arg6))
    }

    public fun pool_id<T0, T1>(arg0: &Pool<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun position_liquidity<T0, T1>(arg0: &Position<T0, T1>) : u128 {
        arg0.liquidity
    }

    public fun position_owed<T0, T1>(arg0: &Position<T0, T1>) : (u64, u64) {
        (arg0.owed_a, arg0.owed_b)
    }

    public fun position_pool_id<T0, T1>(arg0: &Position<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun position_ticks<T0, T1>(arg0: &Position<T0, T1>) : (u32, u32) {
        (arg0.tick_lower, arg0.tick_upper)
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut Position<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (arg1.liquidity == 0) {
            abort 8
        };
        let v0 = arg1.liquidity;
        let (v1, v2) = 0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::tick_math::get_amounts_for_liquidity(arg0.sqrt_price_x64, 0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::tick_math::get_sqrt_ratio_at_tick(arg1.tick_lower), 0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::tick_math::get_sqrt_ratio_at_tick(arg1.tick_upper), v0);
        let v3 = v2;
        let v4 = v1;
        let v5 = arg1.owed_a;
        let v6 = arg1.owed_b;
        if (v5 > 0) {
            v4 = v1 + v5;
        };
        if (v6 > 0) {
            v3 = v2 + v6;
        };
        arg1.owed_a = 0;
        arg1.owed_b = 0;
        let v7 = (arg1.tick_lower as u64);
        let v8 = (arg1.tick_upper as u64);
        if (0x2::dynamic_field::exists_with_type<u64, TickInfo>(&arg0.id, v7)) {
            let v9 = 0x2::dynamic_field::remove<u64, TickInfo>(&mut arg0.id, v7);
            v9.liquidity_gross = decr_gross(v9.liquidity_gross, v0);
            0x2::dynamic_field::add<u64, TickInfo>(&mut arg0.id, v7, v9);
        };
        if (0x2::dynamic_field::exists_with_type<u64, TickInfo>(&arg0.id, v8)) {
            let v10 = 0x2::dynamic_field::remove<u64, TickInfo>(&mut arg0.id, v8);
            v10.liquidity_gross = decr_gross(v10.liquidity_gross, v0);
            0x2::dynamic_field::add<u64, TickInfo>(&mut arg0.id, v8, v10);
        };
        if (arg0.liquidity_global >= v0) {
            arg0.liquidity_global = arg0.liquidity_global - v0;
        } else {
            arg0.liquidity_global = 0;
        };
        arg1.liquidity = 0;
        let v11 = if (v4 > 0) {
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_a, v4), arg3)
        } else {
            0x2::coin::zero<T0>(arg3)
        };
        let v12 = if (v3 > 0) {
            0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_b, v3), arg3)
        } else {
            0x2::coin::zero<T1>(arg3)
        };
        let v13 = RemoveLiquidityEvent{
            pool_id         : 0x2::object::uid_to_inner(&arg0.id),
            position_id     : 0x2::object::uid_to_inner(&arg1.id),
            sender          : 0x2::tx_context::sender(arg3),
            liquidity_delta : v0,
            amount_a        : v4,
            amount_b        : v3,
        };
        0x2::event::emit<RemoveLiquidityEvent>(v13);
        (v11, v12)
    }

    public fun reserve_a<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.reserve_a)
    }

    public fun reserve_b<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.reserve_b)
    }

    public fun sqrt_price<T0, T1>(arg0: &Pool<T0, T1>) : u256 {
        arg0.sqrt_price_x64
    }

    public fun swap_a_to_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u256, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        if (v0 == 0) {
            abort 4
        };
        let v1 = (((v0 as u128) * (arg0.fee_bps as u128) / 10000) as u64);
        let v2 = arg0.sqrt_price_x64;
        if (arg3 >= v2) {
            abort 6
        };
        if (arg3 < 4316055825262872218) {
            abort 2
        };
        let v3 = next_sqrt_price_from_input_a(v2, arg3, arg0.liquidity_global, v0 - v1);
        if (v3 > v2) {
            abort 6
        };
        let v4 = get_amount_out_b(v2, v3, arg0.liquidity_global);
        if (v4 < arg2) {
            abort 5
        };
        if (v1 > 0 && arg0.liquidity_global > 0) {
            let v5 = (v1 as u256) * 340282366920938463463374607431768211456 / (arg0.liquidity_global as u256);
            if (v5 > 340282366920938463463374607431768211455) {
                arg0.fee_growth_global_a = 340282366920938463463374607431768211455;
            } else {
                arg0.fee_growth_global_a = arg0.fee_growth_global_a + (v5 as u128);
            };
        };
        arg0.sqrt_price_x64 = v3;
        0x2::balance::join<T0>(&mut arg0.reserve_a, 0x2::coin::into_balance<T0>(arg1));
        let v6 = SwapEvent{
            pool_id            : 0x2::object::uid_to_inner(&arg0.id),
            sender             : 0x2::tx_context::sender(arg5),
            a_to_b             : true,
            amount_in          : v0,
            amount_out         : v4,
            fee_amount         : v1,
            new_sqrt_price_x64 : v3,
        };
        0x2::event::emit<SwapEvent>(v6);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_b, v4), arg5)
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u256, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        if (v0 == 0) {
            abort 4
        };
        let v1 = (((v0 as u128) * (arg0.fee_bps as u128) / 10000) as u64);
        let v2 = arg0.sqrt_price_x64;
        if (arg3 <= v2) {
            abort 6
        };
        if (arg3 >= 7922644845311496243882047550464776895664) {
            abort 2
        };
        let v3 = next_sqrt_price_from_input_b(v2, arg3, arg0.liquidity_global, v0 - v1);
        if (v3 <= v2) {
            abort 6
        };
        let v4 = get_amount_out_a(v2, v3, arg0.liquidity_global);
        if (v4 < arg2) {
            abort 5
        };
        if (v1 > 0 && arg0.liquidity_global > 0) {
            let v5 = (v1 as u256) * 340282366920938463463374607431768211456 / (arg0.liquidity_global as u256);
            if (v5 > 340282366920938463463374607431768211455) {
                arg0.fee_growth_global_b = 340282366920938463463374607431768211455;
            } else {
                arg0.fee_growth_global_b = arg0.fee_growth_global_b + (v5 as u128);
            };
        };
        arg0.sqrt_price_x64 = v3;
        0x2::balance::join<T1>(&mut arg0.reserve_b, 0x2::coin::into_balance<T1>(arg1));
        let v6 = SwapEvent{
            pool_id            : 0x2::object::uid_to_inner(&arg0.id),
            sender             : 0x2::tx_context::sender(arg5),
            a_to_b             : false,
            amount_in          : v0,
            amount_out         : v4,
            fee_amount         : v1,
            new_sqrt_price_x64 : v3,
        };
        0x2::event::emit<SwapEvent>(v6);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_a, v4), arg5)
    }

    public fun tick_spacing<T0, T1>(arg0: &Pool<T0, T1>) : u32 {
        arg0.tick_spacing
    }

    // decompiled from Move bytecode v7
}

