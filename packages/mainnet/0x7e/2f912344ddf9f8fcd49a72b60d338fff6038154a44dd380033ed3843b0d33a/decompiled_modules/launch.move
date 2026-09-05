module 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::launch {
    struct Launch<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        locker_id: 0x2::object::ID,
        fee_config_id: 0x2::object::ID,
        metadata_cap: 0x2::coin_registry::MetadataCap<T0>,
        supply: u64,
        sqrt_price: u128,
    }

    public fun set_description<T0>(arg0: &0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::config::AdminCap, arg1: &Launch<T0>, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: 0x1::string::String) {
        0x2::coin_registry::set_description<T0>(arg2, &arg1.metadata_cap, arg3);
        emit_metadata_snapshot<T0>(arg1, arg2);
    }

    public fun set_icon_url<T0>(arg0: &0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::config::AdminCap, arg1: &Launch<T0>, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: 0x1::string::String) {
        0x2::coin_registry::set_icon_url<T0>(arg2, &arg1.metadata_cap, arg3);
        emit_metadata_snapshot<T0>(arg1, arg2);
    }

    public fun set_name<T0>(arg0: &0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::config::AdminCap, arg1: &Launch<T0>, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: 0x1::string::String) {
        0x2::coin_registry::set_name<T0>(arg2, &arg1.metadata_cap, arg3);
        emit_metadata_snapshot<T0>(arg1, arg2);
    }

    public fun creator<T0>(arg0: &Launch<T0>) : address {
        arg0.creator
    }

    public fun deploy_lp<T0, T1>(arg0: &mut 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::config::Config, arg1: 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::pending::PendingLaunch<T0>, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: 0x2::coin::Coin<T1>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: 0x99ad8d11a4d4886e2af7f22be2f63526a4a880835b51f5957a7dda73bee74ca7::distributor::TokenSidePolicy, arg8: address, arg9: &0x99ad8d11a4d4886e2af7f22be2f63526a4a880835b51f5957a7dda73bee74ca7::distributor::DistributorConfig, arg10: &mut 0x2::tx_context::TxContext) {
        0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::config::assert_not_paused(arg0);
        0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::pending::assert_can_launch<T0>(&arg1, 0x2::tx_context::sender(arg10));
        assert!(0x2::coin_registry::decimals<T0>(arg2) == 9, 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::errors::invalid_decimals());
        let v0 = 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::config::starting_sqrt_price(arg0);
        let v1 = 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::pending::creator<T0>(&arg1);
        let (v2, v3) = extract_caps<T0>(arg1);
        let v4 = v2;
        let v5 = 0x2::coin_registry::symbol<T0>(arg2);
        let v6 = 0x2::coin_registry::symbol<T0>(arg2);
        let v7 = *0x1::string::as_bytes(&v6);
        0x1::vector::append<u8>(&mut v7, b"-SUI");
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::create_pool_and_get_object<T0, 0x2::sui::SUI, T1>(arg3, arg4, v7, b"", *0x1::string::as_bytes(&v5), 9, b"", b"SUI", 9, b"", 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::config::tick_spacing(), 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::config::pool_fee_rate(), v0, 0x2::coin::into_balance<T1>(arg5), arg10);
        let v9 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, 0x2::sui::SUI>(arg4, &mut v8, 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::config::tick_lower(arg0), 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::config::tick_upper(), arg10);
        let (v10, _, v12, v13) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, 0x2::sui::SUI>(arg3, arg4, &mut v8, &mut v9, 0x2::coin::mint_balance<T0>(&mut v4, 1000000000000000000), 0x2::balance::zero<0x2::sui::SUI>(), 1000000000000000000, true);
        let v14 = v12;
        assert!(v10 + 0x2::balance::value<T0>(&v14) == 1000000000000000000, 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::errors::leftover_tokens());
        0x2::balance::destroy_zero<0x2::sui::SUI>(v13);
        if (0x2::balance::value<T0>(&v14) > 0) {
            0x2::coin::burn<T0>(&mut v4, 0x2::coin::from_balance<T0>(v14, arg10));
        } else {
            0x2::balance::destroy_zero<T0>(v14);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg6) > 0) {
            let (v15, v16) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, 0x2::sui::SUI>(arg3, arg4, &mut v8, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<0x2::sui::SUI>(arg6), false, true, 0x2::coin::value<0x2::sui::SUI>(&arg6), 0, 79226673515401279992447579055);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v15, arg10), v1);
            send_balance<0x2::sui::SUI>(v16, v1, arg10);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg6);
        };
        let v17 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(&v8);
        let v18 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v9);
        0x2::coin_registry::make_supply_burn_only<T0>(arg2, v4);
        let v19 = 0x9b21d97979345362266d80f30acee2e739a025d803d54d56948e287aab46c3f5::locker::lock_position<T0, 0x2::sui::SUI>(&v8, v9, arg10);
        let v20 = 0x9b21d97979345362266d80f30acee2e739a025d803d54d56948e287aab46c3f5::locker::locker_id(&v19);
        let v21 = 0x99ad8d11a4d4886e2af7f22be2f63526a4a880835b51f5957a7dda73bee74ca7::distributor::share_launch_config<T0>(0x99ad8d11a4d4886e2af7f22be2f63526a4a880835b51f5957a7dda73bee74ca7::distributor::new_launch_config<T0>(arg9, 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::config::borrow_launcher_cap(arg0), v19, arg8, arg7, arg10));
        0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::config::clear_open_slot(arg0, v1);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::share_pool_object<T0, 0x2::sui::SUI>(v8);
        let v22 = Launch<T0>{
            id            : 0x2::object::new(arg10),
            creator       : v1,
            pool_id       : v17,
            position_id   : v18,
            locker_id     : v20,
            fee_config_id : v21,
            metadata_cap  : v3,
            supply        : v10,
            sqrt_price    : v0,
        };
        0x2::transfer::share_object<Launch<T0>>(v22);
        0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::events::emit_launched(v1, v17, v18, v20, v21, arg8, 0x99ad8d11a4d4886e2af7f22be2f63526a4a880835b51f5957a7dda73bee74ca7::distributor::default_quote_protocol_fee_bps(arg9), arg7, v10, v0);
    }

    fun emit_metadata_snapshot<T0>(arg0: &Launch<T0>, arg1: &0x2::coin_registry::Currency<T0>) {
        0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::events::emit_metadata_updated(0x2::object::id<Launch<T0>>(arg0), arg0.creator, 0x2::coin_registry::name<T0>(arg1), 0x2::coin_registry::description<T0>(arg1), 0x2::coin_registry::icon_url<T0>(arg1));
    }

    fun extract_caps<T0>(arg0: 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::pending::PendingLaunch<T0>) : (0x2::coin::TreasuryCap<T0>, 0x2::coin_registry::MetadataCap<T0>) {
        let (v0, v1, _) = 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::pending::take_caps<T0>(arg0);
        (v0, v1)
    }

    public fun fee_config_id<T0>(arg0: &Launch<T0>) : 0x2::object::ID {
        arg0.fee_config_id
    }

    public fun locker_id<T0>(arg0: &Launch<T0>) : 0x2::object::ID {
        arg0.locker_id
    }

    public fun pool_id<T0>(arg0: &Launch<T0>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun position_id<T0>(arg0: &Launch<T0>) : 0x2::object::ID {
        arg0.position_id
    }

    fun send_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        };
    }

    public fun sqrt_price<T0>(arg0: &Launch<T0>) : u128 {
        arg0.sqrt_price
    }

    public fun supply<T0>(arg0: &Launch<T0>) : u64 {
        arg0.supply
    }

    // decompiled from Move bytecode v7
}

