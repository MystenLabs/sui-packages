module 0x70c28d82d722cd878dbe6301a445fc7366bdf95bc5921625026d27e9a91d53bb::cetus_clmm_usdc_forwarder {
    struct Position has key {
        id: 0x2::object::UID,
        record: PositionRecord,
        cetus_position: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
    }

    struct PositionRecord has store {
        owner: address,
        payout_destination: address,
        pool_id: 0x2::object::ID,
        cetus_position_id: 0x2::object::ID,
        principal_micros: u64,
        measured_liquidity: u128,
        tick_lower: u32,
        tick_upper: u32,
        closed: bool,
    }

    struct Deposited has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        pool_id: 0x2::object::ID,
        cetus_position_id: 0x2::object::ID,
        principal_micros: u64,
        measured_liquidity: u128,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct WithdrawnInKind has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        payout_destination: address,
        pool_id: 0x2::object::ID,
        cetus_position_id: 0x2::object::ID,
        principal_micros: u64,
        primary_amount: u64,
        secondary_amount: u64,
        residual_nft_transferred: bool,
        emergency: bool,
    }

    public fun pool_id(arg0: &Position) : 0x2::object::ID {
        arg0.record.pool_id
    }

    fun assert_config(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig) {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg0) == 0x2::object::id_from_address(@0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f), 15);
    }

    fun assert_deposit_authority<T0>(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::YieldRouter, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>) {
        assert!(0x2::object::id_address<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig>(arg0) == @0xdcd2e53c6ebc03cea47bcfc656337f03bf64cf1069bb92419bb67f4969603bba, 1);
        assert!(0x2::object::id_address<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::YieldRouter>(arg1) == @0xa0722a3dd74837d9daa4a82c2ffd7ed4c1b6013d57a362a42cb5a6c9c004db6f, 2);
        assert!(!0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::is_paused(arg1), 3);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::canonical_adapter_registry_v2_id(arg0) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2>(arg2)), 4);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::assert_active_v2_on_chain(arg2, b"sui-cetus-clmm-usdc", b"sui");
        assert_config(arg3);
        assert_pool<T0>(arg4);
    }

    fun assert_exit_authority<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg1: &Position, arg2: &0x2::tx_context::TxContext) {
        assert_recorded_owner(arg1, 0x2::tx_context::sender(arg2));
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg0) == arg1.record.pool_id, 5);
        assert!(0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg0) == @0x51e883ba7c0b566a26cbc8a94cd33eb0abd418a77cc1e60ad22fd9b1f29cd2ab, 5);
    }

    fun assert_nonzero_owner(arg0: address) {
        assert!(arg0 != @0x0, 10);
    }

    fun assert_nonzero_principal(arg0: u64) {
        assert!(arg0 > 0, 9);
    }

    fun assert_pool<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>) {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg0) == 0x2::object::id_from_address(@0x51e883ba7c0b566a26cbc8a94cd33eb0abd418a77cc1e60ad22fd9b1f29cd2ab), 5);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, 0x2::sui::SUI>(arg0) == 500, 12);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, 0x2::sui::SUI>(arg0) == 10, 13);
        assert!(!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_pause<T0, 0x2::sui::SUI>(arg0), 14);
    }

    fun assert_recorded_owner(arg0: &Position, arg1: address) {
        assert!(arg1 == arg0.record.owner, 6);
        assert!(!arg0.record.closed, 7);
    }

    fun assert_usdc<T0>() {
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())) == b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC", 11);
    }

    public fun canonical_pool() : address {
        @0x51e883ba7c0b566a26cbc8a94cd33eb0abd418a77cc1e60ad22fd9b1f29cd2ab
    }

    public fun cetus_position_id(arg0: &Position) : 0x2::object::ID {
        arg0.record.cetus_position_id
    }

    public fun closed(arg0: &Position) : bool {
        arg0.record.closed
    }

    public fun deposit_usdc<T0>(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::YieldRouter, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        deposit_usdc_for_owner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg6, arg7);
    }

    public fun deposit_usdc_for_owner<T0>(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::YieldRouter, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: 0x2::coin::Coin<T0>, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_deposit_authority<T0>(arg0, arg1, arg2, arg3, arg4);
        assert_usdc<T0>();
        assert_nonzero_owner(arg6);
        let v0 = 0x2::coin::value<T0>(&arg5);
        assert_nonzero_principal(v0);
        let (v1, v2) = one_sided_usdc_ticks<T0>(arg4);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, 0x2::sui::SUI>(arg3, arg4, v1, v2, arg8);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, 0x2::sui::SUI>(arg3, arg4, &mut v3, v0, true, arg7);
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, 0x2::sui::SUI>(&v4);
        assert!(v5 == v0 && v6 == 0, 16);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, 0x2::sui::SUI>(arg3, arg4, 0x2::coin::into_balance<T0>(arg5), 0x2::balance::zero<0x2::sui::SUI>(), v4);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v3);
        assert!(v7 > 0, 17);
        let v8 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg4);
        let v9 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v3);
        let v10 = PositionRecord{
            owner              : arg6,
            payout_destination : arg6,
            pool_id            : v8,
            cetus_position_id  : v9,
            principal_micros   : v0,
            measured_liquidity : v7,
            tick_lower         : v1,
            tick_upper         : v2,
            closed             : false,
        };
        let v11 = Position{
            id             : 0x2::object::new(arg8),
            record         : v10,
            cetus_position : 0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v3),
        };
        let v12 = Deposited{
            position_id        : 0x2::object::id<Position>(&v11),
            owner              : arg6,
            pool_id            : v8,
            cetus_position_id  : v9,
            principal_micros   : v0,
            measured_liquidity : v7,
            tick_lower         : v1,
            tick_upper         : v2,
        };
        0x2::event::emit<Deposited>(v12);
        0x2::transfer::transfer<Position>(v11, arg6);
    }

    public fun emergency_exit(arg0: &mut Position, arg1: &mut 0x2::tx_context::TxContext) {
        assert_recorded_owner(arg0, 0x2::tx_context::sender(arg1));
        assert!(0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.cetus_position), 19);
        let v0 = arg0.record.owner;
        arg0.record.closed = true;
        arg0.record.measured_liquidity = 0;
        let v1 = WithdrawnInKind{
            position_id              : 0x2::object::id<Position>(arg0),
            owner                    : v0,
            payout_destination       : arg0.record.payout_destination,
            pool_id                  : arg0.record.pool_id,
            cetus_position_id        : arg0.record.cetus_position_id,
            principal_micros         : arg0.record.principal_micros,
            primary_amount           : 0,
            secondary_amount         : 0,
            residual_nft_transferred : true,
            emergency                : true,
        };
        0x2::event::emit<WithdrawnInKind>(v1);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.cetus_position), v0);
    }

    public fun measured_liquidity(arg0: &Position) : u128 {
        arg0.record.measured_liquidity
    }

    fun one_sided_usdc_ticks<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>) : (u32, u32) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, 0x2::sui::SUI>(arg0);
        assert!(!0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(v0), 16);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v0);
        let v2 = 10;
        let v3 = v1 / v2 * v2 + v2;
        assert!(v1 < v3, 16);
        (v3, v3 + 500)
    }

    public fun owner(arg0: &Position) : address {
        arg0.record.owner
    }

    public fun payout_destination(arg0: &Position) : address {
        arg0.record.payout_destination
    }

    public fun principal_micros(arg0: &Position) : u64 {
        arg0.record.principal_micros
    }

    public fun registry_adapter_key() : vector<u8> {
        b"sui-cetus-clmm-usdc"
    }

    public fun reviewed_tick_spacing() : u32 {
        10
    }

    public fun reviewed_tick_width() : u32 {
        500
    }

    public fun tick_lower(arg0: &Position) : u32 {
        arg0.record.tick_lower
    }

    public fun tick_upper(arg0: &Position) : u32 {
        arg0.record.tick_upper
    }

    public fun withdraw_all_in_kind<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut Position, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert_usdc<T0>();
        assert_config(arg0);
        assert_pool<T0>(arg1);
        assert_exit_authority<T0>(arg1, arg2, arg6);
        let v0 = 0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg2.cetus_position);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0) == arg2.record.cetus_position_id, 8);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0) == arg2.record.measured_liquidity, 8);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v0) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg1), 5);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, 0x2::sui::SUI>(arg0, arg1, &mut v0, arg2.record.measured_liquidity, arg3);
        let v3 = v2;
        let v4 = v1;
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, 0x2::sui::SUI>(arg0, arg1, &v0, false);
        0x2::balance::join<T0>(&mut v4, v5);
        0x2::balance::join<0x2::sui::SUI>(&mut v3, v6);
        let v7 = 0x2::balance::value<T0>(&v4);
        let v8 = 0x2::balance::value<0x2::sui::SUI>(&v3);
        assert!(v7 >= arg4 && v8 >= arg5, 18);
        let v9 = arg2.record.payout_destination;
        let v10 = arg2.record.owner;
        arg2.record.closed = true;
        arg2.record.measured_liquidity = 0;
        let v11 = WithdrawnInKind{
            position_id              : 0x2::object::id<Position>(arg2),
            owner                    : v10,
            payout_destination       : v9,
            pool_id                  : arg2.record.pool_id,
            cetus_position_id        : arg2.record.cetus_position_id,
            principal_micros         : arg2.record.principal_micros,
            primary_amount           : v7,
            secondary_amount         : v8,
            residual_nft_transferred : true,
            emergency                : false,
        };
        0x2::event::emit<WithdrawnInKind>(v11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg6), v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg6), v9);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v0, v10);
    }

    // decompiled from Move bytecode v7
}

