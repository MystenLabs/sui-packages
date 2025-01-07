module 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad {
    struct Launchpad has key {
        id: 0x2::object::UID,
        next_dao_to_launch: NextDaoToLaunch,
        last_launch_at_ms: u64,
        default_policies: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyConf>,
        recommended_policies: 0x2::table::Table<0x1::type_name::TypeName, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyConf>,
        recommended_policies_list: vector<0x1::type_name::TypeName>,
        conf: 0x2::bag::Bag,
    }

    struct NextDaoToLaunch has store {
        launch_in_progress: bool,
        estimated_total_liq_in_boat: u64,
        liquidity: 0x2::bag::Bag,
        shareholders: 0x2::vec_map::VecMap<address, ShareholderForNextDao>,
    }

    struct ShareholderForNextDao has drop, store {
        provided_liquidity: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        message_for_agent: 0x1::string::String,
    }

    struct LaunchClearance<phantom T0> {
        xyz_treasury_cap: 0x2::coin::TreasuryCap<T0>,
        xyz_coin_metadata: 0x2::coin::CoinMetadata<T0>,
        token_prices_in_boat: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        total_liq_in_boat_token: u64,
        liquidity: 0x2::bag::Bag,
        liq_swapped_to_boat: 0x2::balance::Balance<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Launchpad {
        let v0 = 0x2::bag::new(arg0);
        0x2::bag::add<0x1::ascii::String, u64>(&mut v0, 0x1::ascii::string(b"min_agents"), 3);
        0x2::bag::add<0x1::ascii::String, u64>(&mut v0, 0x1::ascii::string(b"min_agent_deposit_in_boat"), 5000000000);
        0x2::bag::add<0x1::ascii::String, u64>(&mut v0, 0x1::ascii::string(b"min_liquidity_per_launch_in_dao"), 15000000000);
        0x2::bag::add<0x1::ascii::String, u64>(&mut v0, 0x1::ascii::string(b"min_ms_since_last_launch"), 180000);
        0x2::bag::add<0x1::ascii::String, u64>(&mut v0, 0x1::ascii::string(b"max_agents"), 15);
        0x2::bag::add<0x1::ascii::String, u256>(&mut v0, 0x1::ascii::string(b"percentage_of_liquidity_exchanged_to_boat"), 10 * 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::utils::precision_scalar());
        0x2::bag::add<0x1::ascii::String, u64>(&mut v0, 0x1::ascii::string(b"max_shareholder_initial_message_length"), 1024);
        0x2::bag::add<0x1::ascii::String, u256>(&mut v0, 0x1::ascii::string(b"base_price_for_new_xyz_slash_boat_pool_scaled"), 1 * 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::utils::precision_scalar());
        let v1 = NextDaoToLaunch{
            launch_in_progress          : false,
            estimated_total_liq_in_boat : 0,
            liquidity                   : 0x2::bag::new(arg0),
            shareholders                : 0x2::vec_map::empty<address, ShareholderForNextDao>(),
        };
        let v2 = Launchpad{
            id                        : 0x2::object::new(arg0),
            next_dao_to_launch        : v1,
            last_launch_at_ms         : 0,
            default_policies          : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyConf>(),
            recommended_policies      : 0x2::table::new<0x1::type_name::TypeName, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyConf>(arg0),
            recommended_policies_list : 0x1::vector::empty<0x1::type_name::TypeName>(),
            conf                      : v0,
        };
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::event::emit_launchpad_created(0x2::object::id<Launchpad>(&v2), 0x2::object::id<0x2::bag::Bag>(&v2.conf), 0x2::object::id<0x2::bag::Bag>(&v2.next_dao_to_launch.liquidity), 0x2::object::id<0x2::table::Table<0x1::type_name::TypeName, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyConf>>(&v2.recommended_policies));
        v2
    }

    public(friend) fun share(arg0: Launchpad) {
        0x2::transfer::share_object<Launchpad>(arg0);
    }

    public fun add_default_policy(arg0: &mut Launchpad, arg1: &0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::admin::AdminCap, arg2: 0x1::type_name::TypeName, arg3: 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyConf) {
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::event::emit_default_policy_added(0x1::type_name::into_string(arg2), arg3);
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyConf>(&mut arg0.default_policies, arg2, arg3);
    }

    public fun add_liquidity_for_next_dao<T0>(arg0: &mut Launchpad, arg1: &0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOATPool, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg0.next_dao_to_launch.launch_in_progress, 9223373290985357315);
        assert!(*get_config<u64>(arg0, 0x1::ascii::string(b"max_agents")) > 0x2::vec_map::size<address, ShareholderForNextDao>(&arg0.next_dao_to_launch.shareholders), 9223373312460193795);
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::price_in_boat<T0>(arg1, v0);
        assert!(v1 >= *get_config<u64>(arg0, 0x1::ascii::string(b"min_agent_deposit_in_boat")), 9223373333935161349);
        arg0.next_dao_to_launch.estimated_total_liq_in_boat = arg0.next_dao_to_launch.estimated_total_liq_in_boat + v1;
        let v2 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.next_dao_to_launch.liquidity, v2)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.next_dao_to_launch.liquidity, v2, arg2);
        } else {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.next_dao_to_launch.liquidity, v2), arg2);
        };
        let v3 = 0x2::tx_context::sender(arg4);
        let v4 = &mut arg0.next_dao_to_launch.shareholders;
        if (!0x2::vec_map::contains<address, ShareholderForNextDao>(v4, &v3)) {
            let v5 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v5, v2, v0);
            let v6 = ShareholderForNextDao{
                provided_liquidity : v5,
                message_for_agent  : 0x1::string::utf8(b""),
            };
            0x2::vec_map::insert<address, ShareholderForNextDao>(v4, v3, v6);
        } else {
            let v7 = 0x2::vec_map::get_mut<address, ShareholderForNextDao>(v4, &v3);
            if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v7.provided_liquidity, &v2)) {
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v7.provided_liquidity, v2, v0);
            } else {
                let (_, v9) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut v7.provided_liquidity, &v2);
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v7.provided_liquidity, v2, v9 + v0);
            };
        };
        if (0x2::vec_map::size<address, ShareholderForNextDao>(&arg0.next_dao_to_launch.shareholders) >= *get_config<u64>(arg0, 0x1::ascii::string(b"min_agents"))) {
            if (0x2::clock::timestamp_ms(arg3) - arg0.last_launch_at_ms >= *get_config<u64>(arg0, 0x1::ascii::string(b"min_ms_since_last_launch"))) {
                if (arg0.next_dao_to_launch.estimated_total_liq_in_boat >= *get_config<u64>(arg0, 0x1::ascii::string(b"min_liquidity_per_launch_in_dao"))) {
                    0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::event::emit_next_dao_can_probably_be_launched();
                };
            };
        };
    }

    public fun begin_launch<T0>(arg0: &mut Launchpad, arg1: &0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::admin::AdminCap, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin::CoinMetadata<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : LaunchClearance<T0> {
        assert!(!arg0.next_dao_to_launch.launch_in_progress, 9223374167158685699);
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 9223374171453521921);
        assert!(0x2::vec_map::size<address, ShareholderForNextDao>(&arg0.next_dao_to_launch.shareholders) >= *get_config<u64>(arg0, 0x1::ascii::string(b"min_agents")), 9223374201518686215);
        assert!(0x2::clock::timestamp_ms(arg4) - arg0.last_launch_at_ms >= *get_config<u64>(arg0, 0x1::ascii::string(b"min_ms_since_last_launch")), 9223374218698686473);
        arg0.next_dao_to_launch.launch_in_progress = true;
        LaunchClearance<T0>{
            xyz_treasury_cap        : arg2,
            xyz_coin_metadata       : arg3,
            token_prices_in_boat    : 0x2::vec_map::empty<0x1::type_name::TypeName, u256>(),
            total_liq_in_boat_token : 0,
            liquidity               : 0x2::bag::new(arg5),
            liq_swapped_to_boat     : 0x2::balance::zero<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>(),
        }
    }

    public fun clone_default_policies(arg0: &Launchpad, arg1: &mut 0x2::tx_context::TxContext) : 0x2::table::Table<0x1::type_name::TypeName, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyConf> {
        let v0 = 0x2::table::new<0x1::type_name::TypeName, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyConf>(arg1);
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<0x1::type_name::TypeName, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyConf>(&arg0.default_policies)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyConf>(&arg0.default_policies, v1);
            0x2::table::add<0x1::type_name::TypeName, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyConf>(&mut v0, *v2, *v3);
            v1 = v1 + 1;
        };
        v0
    }

    public fun finalize_launch<T0>(arg0: &mut Launchpad, arg1: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOATPool, arg2: LaunchClearance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let LaunchClearance {
            xyz_treasury_cap        : v0,
            xyz_coin_metadata       : v1,
            token_prices_in_boat    : v2,
            total_liq_in_boat_token : v3,
            liquidity               : v4,
            liq_swapped_to_boat     : v5,
        } = arg2;
        let v6 = v4;
        let v7 = v2;
        let v8 = v0;
        assert!(0x2::bag::is_empty(&arg0.next_dao_to_launch.liquidity), 9223374613835939853);
        assert!(v3 >= *get_config<u64>(arg0, 0x1::ascii::string(b"min_liquidity_per_launch_in_dao")), 9223374622425350149);
        let v9 = 0x1::type_name::get<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&v6, v9)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>>(&mut v6, v9, v5);
        } else {
            0x2::balance::join<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>>(&mut v6, v9), v5);
        };
        let v10 = 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::bonding_curve::find_initial_mint_amount_of_x_to_compliment_y(*get_config<u256>(arg0, 0x1::ascii::string(b"base_price_for_new_xyz_slash_boat_pool_scaled")), v3);
        let v11 = 0x2::coin::mint_balance<T0>(&mut v8, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::bonding_curve::midpoint_u64(v10));
        let v12 = 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::bonding_curve::midpoint_u256(v10);
        let v13 = clone_default_policies(arg0, arg4);
        let v14 = 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::new<T0>(v8, v1, v10, v6, v13, arg3, arg4);
        let v15 = 0x1::string::utf8(b"The DAO is launching with these stats:");
        0x1::string::append_utf8(&mut v15, x"0a2d207468652044414f2773206f776e20746f6b656e20616464726573733a20");
        0x1::string::append_utf8(&mut v15, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x1::string::append_utf8(&mut v15, x"0a2d20616d6f756e74206f66207468617420746f6b656e206d696e74656420746f207368617265686f6c646572733a20");
        0x1::string::append(&mut v15, 0x1::u256::to_string(v12));
        0x1::string::append_utf8(&mut v15, x"0a2d206e756d626572206f66207368617265686f6c646572733a20");
        0x1::string::append(&mut v15, 0x1::u64::to_string(0x2::vec_map::size<address, ShareholderForNextDao>(&arg0.next_dao_to_launch.shareholders)));
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::log_as_package(&v14, v15);
        while (!0x2::vec_map::is_empty<address, ShareholderForNextDao>(&arg0.next_dao_to_launch.shareholders)) {
            let (v16, v17) = 0x2::vec_map::pop<address, ShareholderForNextDao>(&mut arg0.next_dao_to_launch.shareholders);
            let ShareholderForNextDao {
                provided_liquidity : v18,
                message_for_agent  : v19,
            } = v17;
            let v20 = if (0x2::vec_map::is_empty<address, ShareholderForNextDao>(&arg0.next_dao_to_launch.shareholders)) {
                0x2::balance::withdraw_all<T0>(&mut v11)
            } else {
                0x2::balance::split<T0>(&mut v11, how_many_xyz_should_shareholder_get((v3 as u256), &v7, v12, v18))
            };
            let v21 = v20;
            0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::add_agent_for_shareholder(&mut v14, v16, 0x2::balance::value<T0>(&v21), v19, arg4);
            let v22 = 0x1::string::utf8(b"Shareholder with address ");
            0x1::string::append(&mut v22, 0x2::address::to_string(v16));
            0x1::string::append_utf8(&mut v22, b" got this many DAO's native tokens: ");
            0x1::string::append(&mut v22, 0x1::u64::to_string(0x2::balance::value<T0>(&v21)));
            0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::log_as_package(&v14, v22);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v21, arg4), v16);
        };
        arg0.last_launch_at_ms = 0x2::clock::timestamp_ms(arg3);
        arg0.next_dao_to_launch.launch_in_progress = false;
        0x2::balance::destroy_zero<T0>(v11);
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::share(v14, arg3);
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::unlock_trading(arg1);
    }

    public fun get_config<T0: store>(arg0: &Launchpad, arg1: 0x1::ascii::String) : &T0 {
        0x2::bag::borrow<0x1::ascii::String, T0>(&arg0.conf, arg1)
    }

    public fun get_config_mut<T0: store>(arg0: &mut Launchpad, arg1: &0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::admin::AdminCap, arg2: 0x1::ascii::String) : &mut T0 {
        0x2::bag::borrow_mut<0x1::ascii::String, T0>(&mut arg0.conf, arg2)
    }

    public fun get_list_of_recommended_policies(arg0: &Launchpad) : &vector<0x1::type_name::TypeName> {
        &arg0.recommended_policies_list
    }

    public fun get_recommended_policy_conf(arg0: &Launchpad, arg1: 0x1::type_name::TypeName) : 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyConf {
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyConf>(&arg0.recommended_policies, arg1), 9223375081987899413);
        *0x2::table::borrow<0x1::type_name::TypeName, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyConf>(&arg0.recommended_policies, arg1)
    }

    fun how_many_xyz_should_shareholder_get(arg0: u256, arg1: &0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>, arg2: u256, arg3: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>) : u64 {
        let (v0, v1) = 0x2::vec_map::into_keys_values<0x1::type_name::TypeName, u64>(arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0;
        while (!0x1::vector::is_empty<0x1::type_name::TypeName>(&v3)) {
            let v5 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v3);
            let v6 = (0x1::vector::pop_back<u64>(&mut v2) as u256);
            if (v5 == 0x1::type_name::get<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>()) {
                v4 = v4 + v6 * 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::utils::precision_scalar();
                continue
            };
            v4 = v4 + *0x2::vec_map::get<0x1::type_name::TypeName, u256>(arg1, &v5) * v6;
        };
        let v7 = 0x1::u256::try_as_u64(v4 * arg2 / (arg0 as u256) * 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::utils::precision_scalar());
        if (0x1::option::is_some<u64>(&v7)) {
            return 0x1::option::destroy_some<u64>(v7)
        } else {
            0x1::option::destroy_none<u64>(v7);
            abort 9223375313915740175
        };
    }

    public fun launch_with_token<T0, T1>(arg0: &mut Launchpad, arg1: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOATPool, arg2: &mut LaunchClearance<T0>) {
        let v0 = 0x1::type_name::get<T1>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.next_dao_to_launch.liquidity, v0)) {
            return
        };
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.next_dao_to_launch.liquidity, v0);
        arg2.total_liq_in_boat_token = arg2.total_liq_in_boat_token + 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::price_in_boat<T1>(arg1, 0x2::balance::value<T1>(&v1));
        0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg2.token_prices_in_boat, v0, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::price_for_one_boat<T1>(arg1));
        if (v0 != 0x1::type_name::get<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>()) {
            0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::unlock_trading(arg1);
            let v2 = 0x1::u256::try_as_u64((0x2::balance::value<T1>(&v1) as u256) * *get_config<u256>(arg0, 0x1::ascii::string(b"percentage_of_liquidity_exchanged_to_boat")) / 100 * 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::utils::precision_scalar());
            if (0x1::option::is_some<u64>(&v2)) {
                let v3 = 0x2::balance::split<T1>(&mut v1, (0x1::option::destroy_some<u64>(v2) as u64));
                0x2::balance::join<T1>(&mut v1, v3);
                0x2::balance::join<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>(&mut arg2.liq_swapped_to_boat, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::buy_max_boat<T1>(arg1, &mut v3));
                0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::lock_trading(arg1);
            } else {
                0x1::option::destroy_none<u64>(v2);
                abort 9223374454922018827
            };
        };
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg2.liquidity, v0, v1);
    }

    public fun recommend_policy(arg0: &mut Launchpad, arg1: &0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::admin::AdminCap, arg2: 0x1::type_name::TypeName, arg3: 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyConf) {
        0x2::table::add<0x1::type_name::TypeName, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyConf>(&mut arg0.recommended_policies, arg2, arg3);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.recommended_policies_list, arg2);
    }

    public fun remove_default_policy(arg0: &mut Launchpad, arg1: &0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::admin::AdminCap, arg2: 0x1::type_name::TypeName) {
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::event::emit_default_policy_removed(0x1::type_name::into_string(arg2));
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyConf>(&mut arg0.default_policies, &arg2);
    }

    public fun remove_recommended_policy(arg0: &mut Launchpad, arg1: &0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::admin::AdminCap, arg2: 0x1::type_name::TypeName) {
        0x2::table::remove<0x1::type_name::TypeName, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::PolicyConf>(&mut arg0.recommended_policies, arg2);
        let (v0, v1) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.recommended_policies_list, &arg2);
        assert!(v0, 9223373969591369749);
        0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.recommended_policies_list, v1);
    }

    public fun set_agent_message_for_next_dao(arg0: &mut Launchpad, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        assert!(!arg0.next_dao_to_launch.launch_in_progress, 9223373170726273027);
        assert!(0x1::string::length(&arg1) <= *get_config<u64>(arg0, 0x1::ascii::string(b"max_shareholder_initial_message_length")), 9223373183612223507);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = &mut arg0.next_dao_to_launch.shareholders;
        if (!0x2::vec_map::contains<address, ShareholderForNextDao>(v1, &v0)) {
            abort 9223373209381896209
        };
        0x2::vec_map::get_mut<address, ShareholderForNextDao>(v1, &v0).message_for_agent = arg1;
    }

    public fun set_config<T0: drop + store>(arg0: &mut Launchpad, arg1: &0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::admin::AdminCap, arg2: 0x1::ascii::String, arg3: T0) {
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.conf, arg2)) {
            0x2::bag::remove<0x1::ascii::String, T0>(&mut arg0.conf, arg2);
        };
        0x2::bag::add<0x1::ascii::String, T0>(&mut arg0.conf, arg2, arg3);
    }

    public fun set_config_min_ms_since_last_launch(arg0: &mut Launchpad, arg1: &0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::admin::AdminCap, arg2: u64) {
        set_config<u64>(arg0, arg1, 0x1::ascii::string(b"min_ms_since_last_launch"), arg2);
    }

    public fun withdraw_liquidity_from_next_dao<T0>(arg0: &mut Launchpad, arg1: &0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOATPool, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(!arg0.next_dao_to_launch.launch_in_progress, 9223373634582740995);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = &mut arg0.next_dao_to_launch.shareholders;
        if (!0x2::vec_map::contains<address, ShareholderForNextDao>(v2, &v1)) {
            return 0x2::balance::zero<T0>()
        };
        let v3 = 0x2::vec_map::get_mut<address, ShareholderForNextDao>(v2, &v1);
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v3.provided_liquidity, &v0)) {
            return 0x2::balance::zero<T0>()
        };
        let (_, v5) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut v3.provided_liquidity, &v0);
        if (0x2::vec_map::is_empty<0x1::type_name::TypeName, u64>(&v3.provided_liquidity)) {
            let (_, _) = 0x2::vec_map::remove<address, ShareholderForNextDao>(v2, &v1);
        };
        let v8 = 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::price_in_boat<T0>(arg1, v5);
        if (arg0.next_dao_to_launch.estimated_total_liq_in_boat < v8) {
            arg0.next_dao_to_launch.estimated_total_liq_in_boat = 0;
        } else {
            arg0.next_dao_to_launch.estimated_total_liq_in_boat = arg0.next_dao_to_launch.estimated_total_liq_in_boat - v8;
        };
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.next_dao_to_launch.liquidity, v0), v5)
    }

    // decompiled from Move bytecode v6
}

