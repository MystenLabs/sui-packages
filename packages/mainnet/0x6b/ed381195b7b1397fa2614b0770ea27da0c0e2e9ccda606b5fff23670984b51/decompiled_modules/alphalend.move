module 0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::alphalend {
    struct AlphaLendPosition has store, key {
        id: 0x2::object::UID,
        position_cap: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap,
        owner: address,
    }

    public fun collect_reward<T0>(arg0: &mut 0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::config::Config, arg1: &0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::pool_registry::PoolRegistry, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &AlphaLendPosition, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::config::assert_not_paused(arg0);
        0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::pool_registry::assert_pool_enabled<T0>(arg1, 0x1::string::utf8(b"alphalend"));
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward<T0>(arg2, arg4, &arg3.position_cap, arg5, arg6);
        let v2 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg2, v1, arg5, arg6);
        0x2::coin::join<T0>(&mut v2, v0);
        let v3 = 0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::config::deduct_fee<T0>(arg0, 0x2::coin::balance_mut<T0>(&mut v2));
        if (v3 > 0) {
            0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::events::emit_protocol_fees_collected(0x1::string::utf8(b"alphalend"), 0x2::object::id<AlphaLendPosition>(arg3), v3, 0x2::clock::timestamp_ms(arg5));
        };
        v2
    }

    public fun collect_reward_and_deposit<T0>(arg0: &mut 0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::config::Config, arg1: &0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::pool_registry::PoolRegistry, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &AlphaLendPosition, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::config::assert_not_paused(arg0);
        0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::pool_registry::assert_pool_enabled<T0>(arg1, 0x1::string::utf8(b"alphalend"));
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward_and_deposit<T0>(arg2, arg4, &arg3.position_cap, arg5, arg6);
        let v2 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg2, v1, arg5, arg6);
        0x2::coin::join<T0>(&mut v2, v0);
        let v3 = 0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::config::deduct_fee<T0>(arg0, 0x2::coin::balance_mut<T0>(&mut v2));
        if (v3 > 0) {
            0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::events::emit_protocol_fees_collected(0x1::string::utf8(b"alphalend"), 0x2::object::id<AlphaLendPosition>(arg3), v3, 0x2::clock::timestamp_ms(arg5));
        };
        v2
    }

    public fun create_pool<T0>(arg0: &0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::config::AdminCap, arg1: &0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::config::Config, arg2: &mut 0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::pool_registry::PoolRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::config::assert_not_paused(arg1);
        0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::config::assert_version(arg1);
        0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::pool_registry::register_pool<T0>(arg0, arg2, 0x1::string::utf8(b"alphalend"));
        0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::events::emit_pool_created(0x1::string::utf8(b"alphalend"), 0x2::object::id_from_address(@0x0), 0x1::type_name::get<T0>());
    }

    public fun create_position(arg0: &0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::config::Config, arg1: &mut 0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::position_registry::PositionRegistry, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0x2::tx_context::TxContext) : AlphaLendPosition {
        0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::config::assert_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::create_position(arg2, arg3);
        let v2 = AlphaLendPosition{
            id           : 0x2::object::new(arg3),
            position_cap : v1,
            owner        : v0,
        };
        0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::events::emit_position_created(0x1::string::utf8(b"alphalend"), 0x2::object::id<AlphaLendPosition>(&v2), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&v1), v0);
        0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::position_registry::register_position(arg1, 0x1::string::utf8(b"alphalend"), v0, 0x2::object::id<AlphaLendPosition>(&v2));
        v2
    }

    public fun deposit<T0>(arg0: &0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::config::Config, arg1: &0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::pool_registry::PoolRegistry, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &AlphaLendPosition, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::config::assert_not_paused(arg0);
        0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::pool_registry::assert_pool_enabled<T0>(arg1, 0x1::string::utf8(b"alphalend"));
        let v0 = 0x2::coin::value<T0>(&arg5);
        assert!(v0 > 0, 400);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::add_collateral<T0>(arg2, &arg3.position_cap, arg4, arg5, arg6, arg7);
        0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::events::emit_deposited(0x1::string::utf8(b"alphalend"), 0x2::object::id<AlphaLendPosition>(arg3), 0x2::tx_context::sender(arg7), v0, 0x2::clock::timestamp_ms(arg6));
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

    public fun withdraw<T0>(arg0: &0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::config::Config, arg1: &0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::pool_registry::PoolRegistry, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &AlphaLendPosition, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::config::assert_not_paused(arg0);
        0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::pool_registry::assert_pool_enabled<T0>(arg1, 0x1::string::utf8(b"alphalend"));
        assert!(arg5 > 0, 400);
        let v0 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg2, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::remove_collateral<T0>(arg2, &arg3.position_cap, arg4, arg5, arg6), arg6, arg7);
        0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::events::emit_withdrawn(0x1::string::utf8(b"alphalend"), 0x2::object::id<AlphaLendPosition>(arg3), 0x2::tx_context::sender(arg7), 0x2::coin::value<T0>(&v0), 0, 0x2::clock::timestamp_ms(arg6));
        v0
    }

    public fun withdraw_sui(arg0: &0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::config::Config, arg1: &0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::pool_registry::PoolRegistry, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &AlphaLendPosition, arg4: u64, arg5: u64, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::config::assert_not_paused(arg0);
        0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::pool_registry::assert_pool_enabled<0x2::sui::SUI>(arg1, 0x1::string::utf8(b"alphalend"));
        assert!(arg5 > 0, 400);
        let v0 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg2, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::remove_collateral<0x2::sui::SUI>(arg2, &arg3.position_cap, arg4, arg5, arg7), arg6, arg7, arg8);
        0x6bed381195b7b1397fa2614b0770ea27da0c0e2e9ccda606b5fff23670984b51::events::emit_withdrawn(0x1::string::utf8(b"alphalend"), 0x2::object::id<AlphaLendPosition>(arg3), 0x2::tx_context::sender(arg8), 0x2::coin::value<0x2::sui::SUI>(&v0), 0, 0x2::clock::timestamp_ms(arg7));
        v0
    }

    public fun wrapper_id(arg0: &AlphaLendPosition) : 0x2::object::ID {
        0x2::object::id<AlphaLendPosition>(arg0)
    }

    // decompiled from Move bytecode v6
}

