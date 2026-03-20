module 0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::alphalend {
    struct AlphaLendPosition has store, key {
        id: 0x2::object::UID,
        position_cap: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap,
        tokens_deposited: 0x2::table::Table<u64, u64>,
        owner: address,
    }

    public fun collect_reward<T0>(arg0: &mut 0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::config::Config, arg1: &0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::pool_registry::PoolRegistry, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &AlphaLendPosition, arg4: u64, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::config::assert_not_paused(arg0);
        0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::pool_registry::assert_pool_enabled<T0>(arg1, 0x1::string::utf8(b"alphalend"), 0x1::option::some<0x1::string::String>(0x1::u64::to_string(arg4)));
        let v0 = 0x2::bag::new(arg7);
        let v1 = if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            let (v2, v3) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward<0x2::sui::SUI>(arg2, arg4, &arg3.position_cap, arg6, arg7);
            let v4 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg2, v3, arg5, arg6, arg7);
            0x2::coin::join<0x2::sui::SUI>(&mut v4, v2);
            0x2::bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<0x2::sui::SUI>>(&mut v0, 0x1::type_name::with_defining_ids<0x2::sui::SUI>(), v4);
            0x2::coin::value<0x2::sui::SUI>(&v4)
        } else {
            let (v5, v6) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward<T0>(arg2, arg4, &arg3.position_cap, arg6, arg7);
            let v7 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg2, v6, arg6, arg7);
            0x2::coin::join<T0>(&mut v7, v5);
            0x2::bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut v0, 0x1::type_name::with_defining_ids<T0>(), v7);
            0x2::coin::value<T0>(&v7)
        };
        let v8 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut v0, 0x1::type_name::with_defining_ids<T0>());
        0x2::bag::destroy_empty(v0);
        let v9 = 0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::config::deduct_fee_on_yield<T0>(arg0, 0x2::coin::balance_mut<T0>(&mut v8), v1);
        if (v9 > 0) {
            0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::events::emit_protocol_fees_collected(0x1::string::utf8(b"alphalend"), 0x2::object::id<AlphaLendPosition>(arg3), v9, 0x2::clock::timestamp_ms(arg6));
        };
        v8
    }

    public fun collect_reward_and_deposit<T0>(arg0: &mut 0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::config::Config, arg1: &0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::pool_registry::PoolRegistry, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &AlphaLendPosition, arg4: u64, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::config::assert_not_paused(arg0);
        0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::pool_registry::assert_pool_enabled<T0>(arg1, 0x1::string::utf8(b"alphalend"), 0x1::option::some<0x1::string::String>(0x1::u64::to_string(arg4)));
        let v0 = 0x2::bag::new(arg7);
        let v1 = if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            let (v2, v3) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward_and_deposit<0x2::sui::SUI>(arg2, arg4, &arg3.position_cap, arg6, arg7);
            let v4 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg2, v3, arg5, arg6, arg7);
            0x2::coin::join<0x2::sui::SUI>(&mut v4, v2);
            0x2::bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<0x2::sui::SUI>>(&mut v0, 0x1::type_name::with_defining_ids<0x2::sui::SUI>(), v4);
            0x2::coin::value<0x2::sui::SUI>(&v4)
        } else {
            let (v5, v6) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward_and_deposit<T0>(arg2, arg4, &arg3.position_cap, arg6, arg7);
            let v7 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg2, v6, arg6, arg7);
            0x2::coin::join<T0>(&mut v7, v5);
            0x2::bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut v0, 0x1::type_name::with_defining_ids<T0>(), v7);
            0x2::coin::value<T0>(&v7)
        };
        let v8 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut v0, 0x1::type_name::with_defining_ids<T0>());
        0x2::bag::destroy_empty(v0);
        let v9 = 0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::config::deduct_fee_on_yield<T0>(arg0, 0x2::coin::balance_mut<T0>(&mut v8), v1);
        if (v9 > 0) {
            0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::events::emit_protocol_fees_collected(0x1::string::utf8(b"alphalend"), 0x2::object::id<AlphaLendPosition>(arg3), v9, 0x2::clock::timestamp_ms(arg6));
        };
        v8
    }

    public fun create_pool<T0>(arg0: &0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::config::AdminCap, arg1: &0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::config::Config, arg2: &mut 0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::pool_registry::PoolRegistry, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::config::assert_not_paused(arg1);
        0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::config::assert_version(arg1);
        0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::pool_registry::register_pool<T0>(arg0, arg2, 0x1::string::utf8(b"alphalend"), 0x1::option::some<0x1::string::String>(0x1::u64::to_string(arg3)));
        0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::events::emit_pool_created(0x1::string::utf8(b"alphalend"), 0x1::option::some<0x1::string::String>(0x1::u64::to_string(arg3)), 0x1::type_name::with_defining_ids<T0>());
    }

    public fun create_position(arg0: &0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::config::Config, arg1: &mut 0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::position_registry::PositionRegistry, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0x2::tx_context::TxContext) : AlphaLendPosition {
        0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::config::assert_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::create_position(arg2, arg3);
        let v2 = AlphaLendPosition{
            id               : 0x2::object::new(arg3),
            position_cap     : v1,
            tokens_deposited : 0x2::table::new<u64, u64>(arg3),
            owner            : v0,
        };
        0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::events::emit_position_created(0x1::string::utf8(b"alphalend"), 0x2::object::id<AlphaLendPosition>(&v2), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&v1), v0);
        0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::position_registry::register_position(arg1, 0x1::string::utf8(b"alphalend"), v0, 0x2::object::id<AlphaLendPosition>(&v2));
        v2
    }

    public fun deposit<T0>(arg0: &0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::config::Config, arg1: &0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::pool_registry::PoolRegistry, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut AlphaLendPosition, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::config::assert_not_paused(arg0);
        0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::pool_registry::assert_pool_enabled<T0>(arg1, 0x1::string::utf8(b"alphalend"), 0x1::option::some<0x1::string::String>(0x1::u64::to_string(arg4)));
        let v0 = 0x2::coin::value<T0>(&arg5);
        assert!(v0 > 0, 400);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::add_collateral<T0>(arg2, &arg3.position_cap, arg4, arg5, arg6, arg7);
        if (!0x2::table::contains<u64, u64>(&arg3.tokens_deposited, arg4)) {
            0x2::table::add<u64, u64>(&mut arg3.tokens_deposited, arg4, v0);
        } else {
            let v1 = 0x2::table::borrow_mut<u64, u64>(&mut arg3.tokens_deposited, arg4);
            *v1 = *v1 + v0;
        };
        0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::events::emit_deposited(0x1::string::utf8(b"alphalend"), 0x1::option::some<0x1::string::String>(0x1::u64::to_string(arg4)), 0x2::tx_context::sender(arg7), v0, 0x2::clock::timestamp_ms(arg6));
    }

    public fun get_claimable_rewards(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: &AlphaLendPosition, arg2: &0x2::clock::Clock) : vector<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::ClaimableReward> {
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_claimable_rewards(arg0, &arg1.position_cap, arg2)
    }

    public fun get_collateral_amount(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: &AlphaLendPosition, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_collateral_amount(arg0, arg2, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&arg1.position_cap), arg3)
    }

    public fun position_id(arg0: &AlphaLendPosition) : 0x2::object::ID {
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&arg0.position_cap)
    }

    public fun position_owner(arg0: &AlphaLendPosition) : address {
        arg0.owner
    }

    public fun withdraw<T0>(arg0: &mut 0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::config::Config, arg1: &0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::pool_registry::PoolRegistry, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut AlphaLendPosition, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::config::assert_not_paused(arg0);
        0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::pool_registry::assert_pool_enabled<T0>(arg1, 0x1::string::utf8(b"alphalend"), 0x1::option::some<0x1::string::String>(0x1::u64::to_string(arg4)));
        assert!(arg5 > 0, 400);
        let v0 = 0x2::bag::new(arg9);
        let v1 = 0x2::table::borrow_mut<u64, u64>(&mut arg3.tokens_deposited, arg4);
        let v2 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_collateral_amount(arg2, arg4, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&arg3.position_cap), arg8);
        assert!(v2 >= arg5, 401);
        let v3 = (((*v1 as u128) * (arg5 as u128) / (v2 as u128)) as u64);
        let v4 = if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            let v5 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg2, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::remove_collateral<0x2::sui::SUI>(arg2, &arg3.position_cap, arg4, arg5, arg8), arg7, arg8, arg9);
            0x2::bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<0x2::sui::SUI>>(&mut v0, 0x1::type_name::with_defining_ids<0x2::sui::SUI>(), v5);
            0x2::coin::value<0x2::sui::SUI>(&v5)
        } else {
            let v6 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg2, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::remove_collateral<T0>(arg2, &arg3.position_cap, arg4, arg5, arg8), arg8, arg9);
            0x2::bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut v0, 0x1::type_name::with_defining_ids<T0>(), v6);
            0x2::coin::value<T0>(&v6)
        };
        let v7 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut v0, 0x1::type_name::with_defining_ids<T0>());
        0x2::bag::destroy_empty(v0);
        let v8 = if (v4 > v3) {
            v4 - v3
        } else {
            0
        };
        let v9 = 0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::config::deduct_fee_on_yield<T0>(arg0, 0x2::coin::balance_mut<T0>(&mut v7), v8);
        assert!(arg5 - v9 >= arg6, 402);
        *v1 = *v1 - v3;
        if (*v1 == 0) {
            0x2::table::remove<u64, u64>(&mut arg3.tokens_deposited, arg4);
        };
        if (v9 > 0) {
            0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::events::emit_protocol_fees_collected(0x1::string::utf8(b"alphalend"), 0x2::object::id<AlphaLendPosition>(arg3), v9, 0x2::clock::timestamp_ms(arg8));
        };
        0x3a5009b69ec01786f03e3ad50c15fd6a7bf023d7d41f82efdb50615dc1605292::events::emit_withdrawn(0x1::string::utf8(b"alphalend"), 0x1::option::some<0x1::string::String>(0x1::u64::to_string(arg4)), 0x2::tx_context::sender(arg9), v4, 0, 0x2::clock::timestamp_ms(arg8));
        v7
    }

    public fun wrapper_id(arg0: &AlphaLendPosition) : 0x2::object::ID {
        0x2::object::id<AlphaLendPosition>(arg0)
    }

    // decompiled from Move bytecode v6
}

