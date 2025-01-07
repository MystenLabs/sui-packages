module 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::swap {
    struct RyuSwap has key {
        id: 0x2::object::UID,
    }

    struct LiquidityPool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        coin_x_reserve: 0x2::balance::Balance<T0>,
        coin_y_reserve: 0x2::balance::Balance<T1>,
        lsp_supply: 0x2::balance::Supply<LPCoin<T0, T1>>,
        last_block_timestamp: u64,
        last_price_x_cumulative: u128,
        last_price_y_cumulative: u128,
        locked: bool,
        fee: u64,
        dao_fee: u64,
    }

    struct LPCoin<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct PoolCreatedEvent<phantom T0, phantom T1> has copy, drop {
        creator: address,
    }

    struct LiquidityAddedEvent<phantom T0, phantom T1> has copy, drop {
        added_x_val: u64,
        added_y_val: u64,
        lp_tokens_received: u64,
    }

    struct LiquidityRemovedEvent<phantom T0, phantom T1> has copy, drop {
        returned_x_val: u64,
        returned_y_val: u64,
        lp_tokens_burned: u64,
    }

    struct SwapEvent<phantom T0, phantom T1> has copy, drop {
        x_in: u64,
        x_out: u64,
        y_in: u64,
        y_out: u64,
    }

    struct FlashloanEvent<phantom T0, phantom T1> has copy, drop {
        x_in: u64,
        x_out: u64,
        y_in: u64,
        y_out: u64,
    }

    struct OracleUpdatedEvent<phantom T0, phantom T1> has copy, drop {
        last_price_x_cumulative: u128,
        last_price_y_cumulative: u128,
    }

    struct UpdateFeeEvent<phantom T0, phantom T1> has copy, drop {
        new_fee: u64,
    }

    struct UpdateDAOFeeEvent<phantom T0, phantom T1> has copy, drop {
        new_fee: u64,
    }

    public fun swap<T0, T1>(arg0: &mut RyuSwap, arg1: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::dao_fee::DaoFeeInfo, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::coin_helper::is_sorted<T0, T1>(), 1000);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, LiquidityPool<T0, T1>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<LPCoin<T0, T1>>()));
        assert!(!v0.locked, 1011);
        let v1 = 0x2::coin::value<T0>(&arg3);
        let v2 = 0x2::coin::value<T1>(&arg5);
        assert!(v1 > 0 || v2 > 0, 1004);
        let v3 = 0x2::balance::value<T0>(&v0.coin_x_reserve);
        let v4 = 0x2::balance::value<T1>(&v0.coin_y_reserve);
        0x2::coin::put<T0>(&mut v0.coin_x_reserve, arg3);
        0x2::coin::put<T1>(&mut v0.coin_y_reserve, arg5);
        let v5 = 0x2::coin::take<T0>(&mut v0.coin_x_reserve, arg4, arg7);
        let v6 = 0x2::coin::take<T1>(&mut v0.coin_y_reserve, arg6, arg7);
        let (v7, v8) = new_reserves_after_fees_scaled(0x2::balance::value<T0>(&v0.coin_x_reserve), 0x2::balance::value<T1>(&v0.coin_y_reserve), v1, v2, v0.fee);
        assert_lp_value_is_increased((v3 as u128), (v4 as u128), (v7 as u128), (v8 as u128));
        split_fee_to_dao<T0, T1>(v0, arg1, v1, v2);
        update_oracle<T0, T1>(v0, arg2, v3, v4);
        let v9 = SwapEvent<T0, T1>{
            x_in  : v1,
            x_out : arg4,
            y_in  : v2,
            y_out : arg6,
        };
        0x2::event::emit<SwapEvent<T0, T1>>(v9);
        (v5, v6)
    }

    public entry fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x3ec31c14f6739ff7da81c7f10912cbdea340319c95b30cd52b55e8e697655472, 1009);
        let v0 = RyuSwap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<RyuSwap>(v0);
        0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::dao_fee::initialize(arg0);
        0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::config::initialize(arg0);
    }

    public fun register<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut RyuSwap, arg4: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::dao_fee::DaoFeeInfo, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LPCoin<T0, T1>> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::coin::value<T1>(&arg1);
        assert!(0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::coin_helper::is_sorted<T0, T1>(), 1000);
        assert!(!0x2::dynamic_field::exists_<0x1::ascii::String>(&mut arg3.id, 0x1::type_name::into_string(0x1::type_name::get<LPCoin<T0, T1>>())), 1009);
        assert!(v0 > 0 && v1 > 0, 0);
        assert!(v0 < 1844674407370955 && v1 < 1844674407370955, 4);
        let v2 = LPCoin<T0, T1>{dummy_field: false};
        let v3 = 0x2::balance::create_supply<LPCoin<T0, T1>>(v2);
        let v4 = LiquidityPool<T0, T1>{
            id                      : 0x2::object::new(arg5),
            coin_x_reserve          : 0x2::coin::into_balance<T0>(arg0),
            coin_y_reserve          : 0x2::coin::into_balance<T1>(arg1),
            lsp_supply              : v3,
            last_block_timestamp    : 0,
            last_price_x_cumulative : 0,
            last_price_y_cumulative : 0,
            locked                  : false,
            fee                     : 30,
            dao_fee                 : 33,
        };
        let v5 = &mut v4;
        update_oracle<T0, T1>(v5, arg2, v0, v1);
        0x2::dynamic_object_field::add<0x1::ascii::String, LiquidityPool<T0, T1>>(&mut arg3.id, 0x1::type_name::into_string(0x1::type_name::get<LPCoin<T0, T1>>()), v4);
        0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::dao_fee::register<T0, T1>(arg4);
        let v6 = PoolCreatedEvent<T0, T1>{creator: 0x2::tx_context::sender(arg5)};
        0x2::event::emit<PoolCreatedEvent<T0, T1>>(v6);
        0x2::coin::from_balance<LPCoin<T0, T1>>(0x2::balance::increase_supply<LPCoin<T0, T1>>(&mut v3, 0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::math::sqrt(0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::math::mul_to_u128(v0, v1))), arg5)
    }

    fun assert_lp_value_is_increased(arg0: u128, arg1: u128, arg2: u128, arg3: u128) {
        let v0 = 0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::u256::mul(0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::u256::from_u128(arg0 * arg1), 0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::u256::from_u64(10000 * 10000));
        let v1 = 0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::u256::mul(0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::u256::from_u128(arg2), 0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::u256::from_u128(arg3));
        assert!(0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::u256::compare(&v1, &v0) == 2, 1005);
    }

    public fun assert_no_emergency() {
    }

    public fun burn<T0, T1>(arg0: &mut RyuSwap, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<LPCoin<T0, T1>>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::coin_helper::is_sorted<T0, T1>(), 1000);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, LiquidityPool<T0, T1>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<LPCoin<T0, T1>>()));
        assert!(!v0.locked, 1011);
        let v1 = 0x2::coin::value<LPCoin<T0, T1>>(&arg2);
        let v2 = 0x2::balance::supply_value<LPCoin<T0, T1>>(&v0.lsp_supply);
        let v3 = 0x2::balance::value<T0>(&v0.coin_x_reserve);
        let v4 = 0x2::balance::value<T1>(&v0.coin_y_reserve);
        let v5 = 0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::math::mul_div_u128((v1 as u128), (v3 as u128), (v2 as u128));
        let v6 = 0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::math::mul_div_u128((v1 as u128), (v4 as u128), (v2 as u128));
        assert!(v5 > 0 && v6 > 0, 1006);
        update_oracle<T0, T1>(v0, arg1, v3, v4);
        0x2::balance::decrease_supply<LPCoin<T0, T1>>(&mut v0.lsp_supply, 0x2::coin::into_balance<LPCoin<T0, T1>>(arg2));
        let v7 = LiquidityRemovedEvent<T0, T1>{
            returned_x_val   : v5,
            returned_y_val   : v6,
            lp_tokens_burned : v1,
        };
        0x2::event::emit<LiquidityRemovedEvent<T0, T1>>(v7);
        (0x2::coin::take<T0>(&mut v0.coin_x_reserve, v5, arg3), 0x2::coin::take<T1>(&mut v0.coin_y_reserve, v6, arg3))
    }

    public fun get_cumulative_prices<T0, T1>(arg0: &mut RyuSwap) : (u128, u128, u64) {
        assert_no_emergency();
        assert!(0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::coin_helper::is_sorted<T0, T1>(), 1000);
        assert!(0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::coin_helper::is_sorted<T0, T1>(), 1000);
        let v0 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, LiquidityPool<T0, T1>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<LPCoin<T0, T1>>()));
        (v0.last_price_x_cumulative, v0.last_price_y_cumulative, v0.last_block_timestamp)
    }

    public fun get_dao_fee<T0, T1>(arg0: &mut RyuSwap) : u64 {
        assert!(0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::coin_helper::is_sorted<T0, T1>(), 1000);
        0x2::dynamic_object_field::borrow<0x1::ascii::String, LiquidityPool<T0, T1>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<LPCoin<T0, T1>>())).dao_fee
    }

    public fun get_dao_fees_config<T0, T1>(arg0: &mut RyuSwap) : (u64, u64) {
        (get_dao_fee<T0, T1>(arg0), 100)
    }

    public fun get_fee<T0, T1>(arg0: &mut RyuSwap) : u64 {
        assert!(0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::coin_helper::is_sorted<T0, T1>(), 1000);
        0x2::dynamic_object_field::borrow<0x1::ascii::String, LiquidityPool<T0, T1>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<LPCoin<T0, T1>>())).fee
    }

    public fun get_fees_config<T0, T1>(arg0: &mut RyuSwap) : (u64, u64) {
        (get_fee<T0, T1>(arg0), 10000)
    }

    public fun get_lp_total<T0, T1>(arg0: &LiquidityPool<T0, T1>) : u64 {
        0x2::balance::supply_value<LPCoin<T0, T1>>(&arg0.lsp_supply)
    }

    public fun get_reserves_size<T0, T1>(arg0: &mut RyuSwap) : (u64, u64) {
        assert_no_emergency();
        assert!(0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::coin_helper::is_sorted<T0, T1>(), 1000);
        let v0 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, LiquidityPool<T0, T1>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<LPCoin<T0, T1>>()));
        (0x2::balance::value<T0>(&v0.coin_x_reserve), 0x2::balance::value<T1>(&v0.coin_y_reserve))
    }

    public fun is_pool_exists<T0, T1>(arg0: &mut RyuSwap) : bool {
        assert!(0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::coin_helper::is_sorted<T0, T1>(), 1000);
        0x2::dynamic_object_field::exists_<0x1::ascii::String>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<LPCoin<T0, T1>>()))
    }

    public fun is_pool_locked<T0, T1>(arg0: &LiquidityPool<T0, T1>) : bool {
        arg0.locked
    }

    public fun mint<T0, T1>(arg0: &mut RyuSwap, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LPCoin<T0, T1>> {
        assert!(0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::coin_helper::is_sorted<T0, T1>(), 1000);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, LiquidityPool<T0, T1>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<LPCoin<T0, T1>>()));
        assert!(!v0.locked, 1011);
        let v1 = 0x2::balance::supply_value<LPCoin<T0, T1>>(&v0.lsp_supply);
        let v2 = 0x2::balance::value<T0>(&v0.coin_x_reserve);
        let v3 = 0x2::balance::value<T1>(&v0.coin_y_reserve);
        let v4 = 0x2::coin::into_balance<T0>(arg2);
        let v5 = 0x2::coin::into_balance<T1>(arg3);
        let v6 = 0x2::balance::value<T0>(&v4);
        let v7 = 0x2::balance::value<T1>(&v5);
        let v8 = 0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::math::mul_div_u128((v6 as u128), (v1 as u128), (v2 as u128));
        let v9 = 0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::math::mul_div_u128((v7 as u128), (v1 as u128), (v3 as u128));
        let v10 = if (v8 < v9) {
            v8
        } else {
            v9
        };
        assert!(v10 > 0, 1003);
        0x2::balance::join<T0>(&mut v0.coin_x_reserve, v4);
        0x2::balance::join<T1>(&mut v0.coin_y_reserve, v5);
        let v11 = 0x2::balance::increase_supply<LPCoin<T0, T1>>(&mut v0.lsp_supply, v10);
        update_oracle<T0, T1>(v0, arg1, v2, v3);
        let v12 = LiquidityAddedEvent<T0, T1>{
            added_x_val        : v6,
            added_y_val        : v7,
            lp_tokens_received : v10,
        };
        0x2::event::emit<LiquidityAddedEvent<T0, T1>>(v12);
        0x2::coin::from_balance<LPCoin<T0, T1>>(v11, arg4)
    }

    fun new_reserves_after_fees_scaled(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u128, u128) {
        (0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::math::mul_to_u128(arg0, 10000) - 0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::math::mul_to_u128(arg2, arg4), 0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::math::mul_to_u128(arg1, 10000) - 0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::math::mul_to_u128(arg3, arg4))
    }

    public entry fun set_dao_fee<T0, T1>(arg0: &mut RyuSwap, arg1: &mut LiquidityPool<T0, T1>, arg2: &0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::config::Config, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::coin_helper::is_sorted<T0, T1>(), 1000);
        assert!(0x2::dynamic_field::exists_<0x1::ascii::String>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<LPCoin<T0, T1>>())), 1007);
        assert!(!arg1.locked, 1011);
        assert!(0x2::tx_context::sender(arg4) == 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::config::get_fee_admin(arg2), 1012);
        0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::config::assert_valid_dao_fee(arg3);
        arg1.dao_fee = arg3;
        let v0 = UpdateDAOFeeEvent<T0, T1>{new_fee: arg3};
        0x2::event::emit<UpdateDAOFeeEvent<T0, T1>>(v0);
    }

    public entry fun set_fee<T0, T1>(arg0: &mut RyuSwap, arg1: &mut LiquidityPool<T0, T1>, arg2: &0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::config::Config, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::coin_helper::is_sorted<T0, T1>(), 1000);
        assert!(0x2::dynamic_field::exists_<0x1::ascii::String>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<LPCoin<T0, T1>>())), 1007);
        assert!(!arg1.locked, 1011);
        assert!(0x2::tx_context::sender(arg4) == 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::config::get_fee_admin(arg2), 1012);
        0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::config::assert_valid_fee(arg3);
        arg1.fee = arg3;
        let v0 = UpdateFeeEvent<T0, T1>{new_fee: arg3};
        0x2::event::emit<UpdateFeeEvent<T0, T1>>(v0);
    }

    fun split_fee_to_dao<T0, T1>(arg0: &mut LiquidityPool<T0, T1>, arg1: &mut 0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::dao_fee::DaoFeeInfo, arg2: u64, arg3: u64) {
        let v0 = arg0.fee;
        let v1 = arg0.dao_fee;
        let v2 = if (v0 * v1 % 100 != 0) {
            v0 * v1 / 100 + 1
        } else {
            v0 * v1 / 100
        };
        0xd842eddc81c64fb889aa1676068176f41b577b20c2d143c7b718f2ad1ebd56b2::dao_fee::deposit<T0, T1>(arg1, 0x2::balance::split<T0>(&mut arg0.coin_x_reserve, 0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::math::mul_div(arg2, v2, 10000)), 0x2::balance::split<T1>(&mut arg0.coin_y_reserve, 0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::math::mul_div(arg3, v2, 10000)));
    }

    fun update_oracle<T0, T1>(arg0: &mut LiquidityPool<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = ((v0 - arg0.last_block_timestamp) as u128);
        if (v1 > 0 && arg2 != 0 && arg3 != 0) {
            arg0.last_price_x_cumulative = 0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::math::overflow_add(arg0.last_price_x_cumulative, 0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::uq64x64::to_u128(0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::uq64x64::fraction(arg3, arg2)) * v1);
            arg0.last_price_y_cumulative = 0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::math::overflow_add(arg0.last_price_y_cumulative, 0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::uq64x64::to_u128(0x169518d7d80b7817ee834a6e19eaeeb518d37a56c843edc34f1b5b82b4871494::uq64x64::fraction(arg2, arg3)) * v1);
            let v2 = OracleUpdatedEvent<T0, T1>{
                last_price_x_cumulative : arg0.last_price_x_cumulative,
                last_price_y_cumulative : arg0.last_price_y_cumulative,
            };
            0x2::event::emit<OracleUpdatedEvent<T0, T1>>(v2);
        };
        arg0.last_block_timestamp = v0;
    }

    // decompiled from Move bytecode v6
}

