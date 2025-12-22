module 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::service {
    struct PositionRegistry has key {
        id: 0x2::object::UID,
        positions: 0x2::table::Table<address, 0x2::table::Table<0x2::object::ID, 0x2::object::ID>>,
    }

    entry fun finalize<T0>(arg0: &mut 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::Campaign<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::finalize<T0>(arg0, v0);
        0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::events::emit_campaign_finalized(0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::id<T0>(arg0), 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::status<T0>(arg0), 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::raised<T0>(arg0), 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::goal<T0>(arg0), v0);
    }

    entry fun withdraw_funds<T0>(arg0: &mut 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::Campaign<T0>, arg1: &0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::platform::PlatformConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::withdraw_funds<T0>(arg0, v0);
        let v2 = 0x2::balance::value<T0>(&v1);
        let v3 = v2 * 500 / 10000;
        let v4 = 0x2::coin::from_balance<T0>(v1, arg3);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v4, v3, arg3), 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::platform::treasury(arg1));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, v0);
        0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::events::emit_funds_withdrawn(0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::id<T0>(arg0), v0, v2 - v3, 0x2::clock::timestamp_ms(arg2));
    }

    entry fun contribute<T0>(arg0: &mut 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::Campaign<T0>, arg1: &mut PositionRegistry, arg2: &0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::platform::PlatformConfig, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::is_active<T0>(arg0), 4);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 < 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::deadline_ms<T0>(arg0), 5);
        let v1 = 0x2::coin::value<T0>(&arg3);
        assert!(v1 > 0, 6);
        0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::check_min_contribution<T0>(arg0, v1);
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::id<T0>(arg0);
        if (!0x2::table::contains<address, 0x2::table::Table<0x2::object::ID, 0x2::object::ID>>(&arg1.positions, v2)) {
            0x2::table::add<address, 0x2::table::Table<0x2::object::ID, 0x2::object::ID>>(&mut arg1.positions, v2, 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg5));
        };
        let v4 = 0x2::table::borrow_mut<address, 0x2::table::Table<0x2::object::ID, 0x2::object::ID>>(&mut arg1.positions, v2);
        let v5 = !0x2::table::contains<0x2::object::ID, 0x2::object::ID>(v4, v3);
        assert!(v5, 8);
        0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::add_contribution<T0>(arg0, 0x2::coin::into_balance<T0>(arg3), v5);
        let v6 = 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::new<T0>(v3, v2, v1, 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::nft_image_url<T0>(arg0), v0, arg5);
        let v7 = 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::id<T0>(&v6);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(v4, v3, v7);
        0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::transfer<T0>(v6, v2);
        0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::events::emit_donor_position_created(v7, v3, v2, v1, v0);
        0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::events::emit_contribution_made(v3, v2, v1, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>())), v0);
    }

    entry fun contribute_more<T0>(arg0: &mut 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::Campaign<T0>, arg1: &mut 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::DonorPosition<T0>, arg2: &0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::platform::PlatformConfig, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::is_active<T0>(arg0), 4);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 < 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::deadline_ms<T0>(arg0), 5);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::id<T0>(arg0);
        0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::verify_ownership<T0>(arg1, v1);
        0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::verify_campaign<T0>(arg1, v2);
        let v3 = 0x2::coin::value<T0>(&arg3);
        assert!(v3 > 0, 6);
        0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::check_min_contribution<T0>(arg0, v3);
        0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::add_contribution<T0>(arg0, 0x2::coin::into_balance<T0>(arg3), false);
        0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::increase_amount<T0>(arg1, v3, v0);
        0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::events::emit_donor_position_updated(0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::id<T0>(arg1), v2, v1, v3, v0);
        0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::events::emit_contribution_made(v2, v1, v3, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>())), v0);
    }

    entry fun create_campaign<T0>(arg0: &0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::platform::PlatformConfig, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: 0x1::option::Option<u64>, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::platform::is_coin_allowed<T0>(arg0), 3);
        assert!(0x2::coin::value<T0>(&arg1) >= 1000000000, 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::platform::treasury(arg0));
        assert!(0x1::vector::length<u8>(&arg5) <= 2048, 9);
        assert!(0x1::vector::length<u8>(&arg6) <= 2048, 9);
        assert!(arg2 >= 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::platform::min_goal(arg0) && arg2 <= 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::platform::max_goal(arg0), 1);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        assert!(arg3 > v0, 2);
        let v1 = arg3 - v0;
        assert!(v1 >= 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::platform::min_duration_ms(arg0) && v1 <= 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::platform::max_duration_ms(arg0), 2);
        let v2 = 0x2::tx_context::sender(arg8);
        let v3 = 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::new<T0>(v2, arg2, arg3, arg4, arg5, arg6, arg8);
        0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::share<T0>(v3);
        0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::events::emit_campaign_created(0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::id<T0>(&v3), v2, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>())), arg2, arg3, arg5, v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PositionRegistry{
            id        : 0x2::object::new(arg0),
            positions : 0x2::table::new<address, 0x2::table::Table<0x2::object::ID, 0x2::object::ID>>(arg0),
        };
        0x2::transfer::share_object<PositionRegistry>(v0);
    }

    entry fun refund<T0>(arg0: &mut 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::Campaign<T0>, arg1: &mut 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::DonorPosition<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::verify_ownership<T0>(arg1, v0);
        0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::verify_campaign<T0>(arg1, 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::id<T0>(arg0));
        0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::verify_not_refunded<T0>(arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::amount_total<T0>(arg1);
        0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::mark_refunded<T0>(arg1, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::process_refund<T0>(arg0, v2), arg3), v0);
        0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::events::emit_refund_claimed(0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign::id<T0>(arg0), v0, v2, v1);
    }

    // decompiled from Move bytecode v6
}

