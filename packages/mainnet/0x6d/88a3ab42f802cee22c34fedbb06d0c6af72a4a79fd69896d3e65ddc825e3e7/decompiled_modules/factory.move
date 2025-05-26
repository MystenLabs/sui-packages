module 0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::factory {
    struct YourStableFactory has drop {
        dummy_field: bool,
    }

    struct Factory<phantom T0> has store, key {
        id: 0x2::object::UID,
        underlying_balance: 0x2::balance::Balance<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>,
        basic_supply: 0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::limited_supply::LimitedSupply,
        extension_supplies: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::limited_supply::LimitedSupply>,
    }

    struct FactoryCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    public fun burn<T0, T1>(arg0: &mut Factory<T1>, arg1: &mut 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::Vault<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>) : (0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::WithdrawTicket<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>, 0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::redemption_queue::RedeemRequest<T0, YourStableFactory>) {
        let v0 = 0x2::coin::value<T1>(&arg3);
        let v1 = borrow_cap_mut<T1>(arg0);
        0x2::coin::burn<T1>(v1, arg3);
        0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::limited_supply::decrease(&mut arg0.basic_supply, v0);
        let v2 = 0x2::balance::value<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(&arg0.underlying_balance) - 0x2::balance::value<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(&arg0.underlying_balance);
        let v3 = YourStableFactory{dummy_field: false};
        0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::event::emit_burn_your_stable_event<T1>(0x2::object::id<Factory<T1>>(arg0), 0x1::type_name::get<T0>(), v0, from_underlying_amount(arg1, arg2, v2), v2, basic_supply<T1>(arg0), 0x2::balance::value<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(&arg0.underlying_balance));
        (0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::withdraw_t_amt<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(arg1, v0, &mut arg0.underlying_balance, arg2), 0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::redemption_queue::request<T0, YourStableFactory>(v3, v0))
    }

    public fun mint<T0, T1>(arg0: &mut Factory<T1>, arg1: &mut 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::Vault<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::charge_reservoir<T0>(arg2, 0x2::coin::into_balance<T0>(arg4));
        let v1 = 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v0);
        let v2 = 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::deposit<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(arg1, v0, arg3);
        0x2::balance::join<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(&mut arg0.underlying_balance, v2);
        0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::limited_supply::increase(&mut arg0.basic_supply, v1);
        0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::event::emit_mint_your_stable_event<T1>(0x2::object::id<Factory<T1>>(arg0), 0x1::type_name::get<T0>(), 0x2::coin::value<T0>(&arg4), v1, 0x2::balance::value<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(&v2), basic_supply<T1>(arg0), 0x2::balance::value<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(&arg0.underlying_balance));
        0x2::coin::mint<T1>(borrow_cap_mut<T1>(arg0), v1, arg5)
    }

    public fun total_supply<T0>(arg0: &Factory<T0>) : u64 {
        0x2::coin::total_supply<T0>(borrow_cap<T0>(arg0))
    }

    public fun new<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &0x2::coin::CoinMetadata<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (Factory<T0>, FactoryCap<T0>) {
        if (0x2::coin::get_decimals<T0>(arg1) != underlying_decimals()) {
            err_mismatched_decimals();
        };
        let v0 = 0x2::object::new(arg3);
        0x2::dynamic_object_field::add<0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::cap_key::CapKey, 0x2::coin::TreasuryCap<T0>>(&mut v0, 0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::cap_key::cap_key(), arg0);
        let v1 = Factory<T0>{
            id                 : v0,
            underlying_balance : 0x2::balance::zero<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(),
            basic_supply       : 0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::limited_supply::new(arg2),
            extension_supplies : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::limited_supply::LimitedSupply>(),
        };
        let v2 = FactoryCap<T0>{id: 0x2::object::new(arg3)};
        0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::event::emit_new_factory_event<T0>(0x2::object::id<Factory<T0>>(&v1), 0x2::object::id<FactoryCap<T0>>(&v2), 0x1::type_name::get<T0>(), arg2);
        (v1, v2)
    }

    public fun basic_supply<T0>(arg0: &Factory<T0>) : u64 {
        0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::limited_supply::supply(&arg0.basic_supply)
    }

    fun borrow_cap<T0>(arg0: &Factory<T0>) : &0x2::coin::TreasuryCap<T0> {
        0x2::dynamic_object_field::borrow<0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::cap_key::CapKey, 0x2::coin::TreasuryCap<T0>>(&arg0.id, 0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::cap_key::cap_key())
    }

    fun borrow_cap_mut<T0>(arg0: &mut Factory<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        0x2::dynamic_object_field::borrow_mut<0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::cap_key::CapKey, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, 0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::cap_key::cap_key())
    }

    public fun claim_reward<T0>(arg0: &FactoryCap<T0>, arg1: &mut Factory<T0>, arg2: &0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::Vault<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK> {
        let v0 = 0x2::balance::value<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(&arg1.underlying_balance) - underlying_reserve<T0>(arg1, arg2, arg3);
        0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::event::emit_claim_reward_event<T0>(0x2::object::id<Factory<T0>>(arg1), v0);
        0x2::coin::from_balance<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(0x2::balance::split<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(&mut arg1.underlying_balance, v0), arg4)
    }

    fun err_mismatched_decimals() {
        abort 0
    }

    public fun extension_supplies<T0>(arg0: &Factory<T0>) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::limited_supply::LimitedSupply> {
        &arg0.extension_supplies
    }

    public fun from_underlying_amount(arg0: &0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::Vault<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>, arg1: &0x2::clock::Clock, arg2: u64) : u64 {
        0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::utils::mul_div(arg2, 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::total_available_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(arg0, arg1), 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::total_yt_supply<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(arg0))
    }

    public fun get_rewards_amount<T0>(arg0: &mut Factory<T0>, arg1: &0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::Vault<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>, arg2: &0x2::clock::Clock) : u64 {
        0x2::balance::value<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(&arg0.underlying_balance) - underlying_reserve<T0>(arg0, arg1, arg2)
    }

    public fun get_rewards_value<T0>(arg0: &mut Factory<T0>, arg1: &0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::Vault<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = get_rewards_amount<T0>(arg0, arg1, arg2);
        if (v0 == 0 || 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::total_yt_supply<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(arg1) == 0) {
            return 0
        };
        0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::utils::mul_div(v0, 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::total_available_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(arg1, arg2), 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::total_yt_supply<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(arg1))
    }

    public fun set_basic_limit<T0>(arg0: &FactoryCap<T0>, arg1: &mut Factory<T0>, arg2: u64) {
        0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::limited_supply::set_limit(&mut arg1.basic_supply, arg2);
    }

    public fun set_extension_limit<T0, T1: drop>(arg0: &FactoryCap<T0>, arg1: &mut Factory<T0>, arg2: u64) {
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::limited_supply::LimitedSupply>(&arg1.extension_supplies, &v0)) {
            0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::limited_supply::set_limit(0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::limited_supply::LimitedSupply>(&mut arg1.extension_supplies, &v0), arg2);
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, 0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::limited_supply::LimitedSupply>(&mut arg1.extension_supplies, v0, 0x6d88a3ab42f802cee22c34fedbb06d0c6af72a4a79fd69896d3e65ddc825e3e7::limited_supply::new(arg2));
        };
    }

    public fun to_underlying_amount(arg0: &0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::Vault<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>, arg1: &0x2::clock::Clock, arg2: u64) : u64 {
        let v0 = 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::total_available_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(arg0, arg1);
        if (v0 == 0) {
            return 0
        };
        0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::utils::mul_div_round_up(arg2, 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::total_yt_supply<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(arg0), v0)
    }

    public fun underlying_balance<T0>(arg0: &Factory<T0>) : u64 {
        0x2::balance::value<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(&arg0.underlying_balance)
    }

    public fun underlying_decimals() : u8 {
        9
    }

    public fun underlying_reserve<T0>(arg0: &Factory<T0>, arg1: &0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::Vault<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>, arg2: &0x2::clock::Clock) : u64 {
        to_underlying_amount(arg1, arg2, basic_supply<T0>(arg0))
    }

    public fun update_metadata<T0>(arg0: &FactoryCap<T0>, arg1: &Factory<T0>, arg2: &mut 0x2::coin::CoinMetadata<T0>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::ascii::String>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x1::option::Option<0x1::ascii::String>) {
        let v0 = borrow_cap<T0>(arg1);
        if (0x1::option::is_some<0x1::string::String>(&arg3)) {
            0x2::coin::update_name<T0>(v0, arg2, 0x1::option::destroy_some<0x1::string::String>(arg3));
        } else {
            0x1::option::destroy_none<0x1::string::String>(arg3);
        };
        if (0x1::option::is_some<0x1::ascii::String>(&arg4)) {
            0x2::coin::update_symbol<T0>(v0, arg2, 0x1::option::destroy_some<0x1::ascii::String>(arg4));
        } else {
            0x1::option::destroy_none<0x1::ascii::String>(arg4);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg5)) {
            0x2::coin::update_description<T0>(v0, arg2, 0x1::option::destroy_some<0x1::string::String>(arg5));
        } else {
            0x1::option::destroy_none<0x1::string::String>(arg5);
        };
        if (0x1::option::is_some<0x1::ascii::String>(&arg6)) {
            0x2::coin::update_icon_url<T0>(v0, arg2, 0x1::option::destroy_some<0x1::ascii::String>(arg6));
        } else {
            0x1::option::destroy_none<0x1::ascii::String>(arg6);
        };
    }

    // decompiled from Move bytecode v6
}

