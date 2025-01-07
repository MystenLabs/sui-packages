module 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::asset_manager {
    struct REGISTER_WITNESS has drop, store {
        dummy_field: bool,
    }

    struct WitnessCarrier has key {
        id: 0x2::object::UID,
        witness: REGISTER_WITNESS,
    }

    struct AssetManager<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        rate_limit: RateLimit<T0>,
    }

    struct Config has key {
        id: 0x2::object::UID,
        icon_asset_manager: 0x1::string::String,
        assets: 0x2::bag::Bag,
        version: u64,
        id_cap: 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::IDCap,
        xcall_manager_id: 0x2::object::ID,
        xcall_id: 0x2::object::ID,
    }

    struct RateLimit<phantom T0> has copy, store {
        period: u64,
        percentage: u64,
        last_update: u64,
        current_limit: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    entry fun execute_call<T0>(arg0: &mut Config, arg1: &0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::xcall_manager::Config, arg2: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: u128, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        enforce_version(arg0);
        let v0 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_call(arg2, get_idcap(arg0), arg5, arg6, arg7);
        let v1 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::execute_ticket::message(&v0);
        let v2 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::execute_ticket::protocols(&v0);
        let v3 = 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::deposit::get_method(&v1);
        let v4 = 0x1::type_name::get<T0>();
        assert!(0x1::string::from_ascii(*0x1::type_name::borrow_string(&v4)) == 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::deposit::get_token_type(&v1), 2);
        if (0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::xcall_manager::verify_protocols(arg1, &v2) && (v3 == b"WithdrawTo" || v3 == b"WithdrawNativeTo") && 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::execute_ticket::from(&v0) == 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::network_address::from_string(arg0.icon_asset_manager)) {
            let v5 = 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::withdraw_to::decode(&v1);
            let v6 = 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::withdraw_to::to(&v5);
            let v7 = get_asset_manager_mut<T0>(arg0);
            let v8 = &mut v7.balance;
            let v9 = &mut v7.rate_limit;
            withdraw<T0>(v8, v9, arg4, 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::balanced_utils::address_from_hex_string(&v6), 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::withdraw_to::amount(&v5), arg7);
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_call_result(arg2, v0, true, arg3, arg7);
        } else {
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_call_result(arg2, v0, false, arg3, arg7);
        };
    }

    entry fun execute_rollback<T0>(arg0: &mut Config, arg1: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        enforce_version(arg0);
        let v0 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_rollback(arg1, get_idcap(arg0), arg2, arg4);
        let v1 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_ticket::rollback(&v0);
        assert!(0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::deposit::get_method(&v1) == b"DepositRevert", 3);
        let v2 = 0x1::type_name::get<T0>();
        if (0x1::string::from_ascii(*0x1::type_name::borrow_string(&v2)) == 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::deposit::get_token_type(&v1)) {
            let v3 = get_asset_manager_mut<T0>(arg0);
            let v4 = &mut v3.balance;
            let v5 = &mut v3.rate_limit;
            let v6 = 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::deposit_revert::decode(&v1);
            withdraw<T0>(v4, v5, arg3, 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::deposit_revert::to(&v6), 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::deposit_revert::amount(&v6), arg4);
        };
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_rollback_result(arg1, v0, true);
    }

    fun calculate_limit<T0>(arg0: u64, arg1: &RateLimit<T0>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = arg1.period;
        if (v0 == 0) {
            return 0
        };
        let v1 = arg0 * arg1.percentage / 10000;
        let v2 = (0x2::clock::timestamp_ms(arg2) - arg1.last_update) / 1000;
        let v3 = if (v2 > v0) {
            v0
        } else {
            v2
        };
        let v4 = (arg0 - v1) * v3 / v0;
        if (arg1.current_limit < v4) {
            return v1
        };
        let v5 = arg1.current_limit - v4;
        if (v5 > v1) {
            v5
        } else {
            v1
        }
    }

    entry fun configure(arg0: &AdminCap, arg1: &0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::xcall_manager::Config, arg2: &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg3: WitnessCarrier, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::register_dapp<REGISTER_WITNESS>(arg2, get_witness(arg3), arg6);
        let v1 = Config{
            id                 : 0x2::object::new(arg6),
            icon_asset_manager : arg4,
            assets             : 0x2::bag::new(arg6),
            version            : arg5,
            id_cap             : v0,
            xcall_manager_id   : 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::xcall_manager::get_id(arg1),
            xcall_id           : 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_id_cap_xcall(&v0),
        };
        0x2::transfer::share_object<Config>(v1);
    }

    entry fun configure_rate_limit<T0>(arg0: &mut Config, arg1: &AdminCap, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64) {
        enforce_version(arg0);
        let v0 = get_asset_manager_mut<T0>(arg0);
        let v1 = &mut v0.rate_limit;
        v1.period = arg3;
        v1.percentage = arg4;
        v1.last_update = 0x2::clock::timestamp_ms(arg2);
        v1.current_limit = 0x2::balance::value<T0>(&v0.balance) * arg4 / 10000;
    }

    entry fun deposit<T0>(arg0: &mut Config, arg1: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg2: &0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::xcall_manager::Config, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<T0>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x1::option::Option<vector<u8>>, arg7: &mut 0x2::tx_context::TxContext) {
        enforce_version(arg0);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x1::string::utf8(b"");
        if (0x1::option::is_some<0x1::string::String>(&arg5)) {
            v1 = *0x1::option::borrow<0x1::string::String>(&arg5);
        };
        let v2 = get_asset_manager_mut<T0>(arg0);
        let v3 = 0x2::coin::value<T0>(&arg4);
        assert!(v3 > 0, 0);
        0x2::coin::put<T0>(&mut v2.balance, arg4);
        let v4 = 0x1::type_name::get<T0>();
        let v5 = 0x1::string::from_ascii(*0x1::type_name::borrow_string(&v4));
        let v6 = 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::deposit::wrap_deposit(v5, 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::balanced_utils::address_to_hex_string(&v0), v1, v3, 0x1::option::get_with_default<vector<u8>>(&arg6, b""));
        let v7 = 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::deposit_revert::wrap_deposit_revert(v5, v0, v3);
        let (v8, v9) = 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::xcall_manager::get_protocals(arg2);
        let v10 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::envelope::wrap_call_message_rollback(0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::deposit::encode(&v6, b"Deposit"), 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::deposit_revert::encode(&v7, b"DepositRevert"), v8, v9);
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::send_call(arg1, arg3, get_idcap(arg0), arg0.icon_asset_manager, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::envelope::encode(&v10), arg7);
    }

    fun enforce_version(arg0: &Config) {
        assert!(arg0.version == 4, 8);
    }

    entry fun execute_force_rollback(arg0: &Config, arg1: &AdminCap, arg2: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u128, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        enforce_version(arg0);
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_call_result(arg2, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_call(arg2, get_idcap(arg0), arg4, arg5, arg6), false, arg3, arg6);
    }

    fun get_asset_manager<T0>(arg0: &Config) : &AssetManager<T0> {
        let v0 = 0x1::type_name::get<T0>();
        0x2::bag::borrow<0x1::string::String, AssetManager<T0>>(&arg0.assets, 0x1::string::from_ascii(*0x1::type_name::borrow_string(&v0)))
    }

    fun get_asset_manager_mut<T0>(arg0: &mut Config) : &mut AssetManager<T0> {
        let v0 = 0x1::type_name::get<T0>();
        0x2::bag::borrow_mut<0x1::string::String, AssetManager<T0>>(&mut arg0.assets, 0x1::string::from_ascii(*0x1::type_name::borrow_string(&v0)))
    }

    public fun get_config_id(arg0: &Config) : 0x2::object::ID {
        enforce_version(arg0);
        0x2::object::uid_to_inner(&arg0.id)
    }

    entry fun get_execute_call_params(arg0: &Config) : (0x2::object::ID, 0x2::object::ID) {
        (get_xcall_manager_id(arg0), get_xcall_id(arg0))
    }

    entry fun get_execute_params(arg0: &Config, arg1: vector<u8>) : 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::balanced_utils::ExecuteParams {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, get_withdraw_token_type(arg1));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = get_config_id(arg0);
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_utils::id_to_hex_string(&v2));
        let v3 = get_xcall_manager_id(arg0);
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_utils::id_to_hex_string(&v3));
        let v4 = get_xcall_id(arg0);
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_utils::id_to_hex_string(&v4));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"coin"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"clock"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"request_id"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"data"));
        0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::balanced_utils::create_execute_params(v0, v1)
    }

    public(friend) fun get_idcap(arg0: &Config) : &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::IDCap {
        enforce_version(arg0);
        &arg0.id_cap
    }

    entry fun get_rollback_params(arg0: &Config, arg1: vector<u8>) : 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::balanced_utils::ExecuteParams {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, get_withdraw_token_type(arg1));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = get_config_id(arg0);
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_utils::id_to_hex_string(&v2));
        let v3 = get_xcall_id(arg0);
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_utils::id_to_hex_string(&v3));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"sn"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"clock"));
        0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::balanced_utils::create_execute_params(v0, v1)
    }

    public fun get_version(arg0: &mut Config) : u64 {
        arg0.version
    }

    public fun get_withdraw_limit<T0>(arg0: &Config, arg1: &RateLimit<T0>, arg2: &0x2::clock::Clock) : u64 {
        enforce_version(arg0);
        calculate_limit<T0>(0x2::balance::value<T0>(&get_asset_manager<T0>(arg0).balance), arg1, arg2)
    }

    public fun get_withdraw_token_type(arg0: vector<u8>) : 0x1::string::String {
        0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::deposit::get_token_type(&arg0)
    }

    fun get_witness(arg0: WitnessCarrier) : REGISTER_WITNESS {
        let WitnessCarrier {
            id      : v0,
            witness : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    public fun get_xcall_id(arg0: &Config) : 0x2::object::ID {
        enforce_version(arg0);
        arg0.xcall_id
    }

    public fun get_xcall_manager_id(arg0: &Config) : 0x2::object::ID {
        enforce_version(arg0);
        arg0.xcall_manager_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = REGISTER_WITNESS{dummy_field: false};
        let v2 = WitnessCarrier{
            id      : 0x2::object::new(arg0),
            witness : v1,
        };
        0x2::transfer::transfer<WitnessCarrier>(v2, 0x2::tx_context::sender(arg0));
    }

    entry fun migrate(arg0: &mut Config, arg1: &0x2::package::UpgradeCap) {
        let v0 = get_version(arg0);
        assert!(v0 < 4, 6);
        set_version(arg0, 4);
    }

    entry fun register_token<T0>(arg0: &mut Config, arg1: &AdminCap, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        enforce_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::string::from_ascii(*0x1::type_name::borrow_string(&v0));
        if (0x2::bag::contains<0x1::string::String>(&arg0.assets, v1)) {
            abort 7
        };
        let v2 = RateLimit<T0>{
            period        : arg3,
            percentage    : arg4,
            last_update   : 0x2::clock::timestamp_ms(arg2),
            current_limit : 0,
        };
        let v3 = AssetManager<T0>{
            id         : 0x2::object::new(arg5),
            balance    : 0x2::balance::zero<T0>(),
            rate_limit : v2,
        };
        assert!(10000 >= arg4, 9);
        0x2::bag::add<0x1::string::String, AssetManager<T0>>(&mut arg0.assets, v1, v3);
    }

    entry fun reset_limit<T0>(arg0: &mut Config, arg1: &AdminCap) {
        enforce_version(arg0);
        let v0 = get_asset_manager_mut<T0>(arg0);
        let v1 = &mut v0.rate_limit;
        v1.current_limit = 0x2::balance::value<T0>(&v0.balance) * v1.percentage / 10000;
    }

    entry fun set_icon_asset_manager(arg0: &mut Config, arg1: &AdminCap, arg2: 0x1::string::String) {
        enforce_version(arg0);
        arg0.icon_asset_manager = arg2;
    }

    fun set_version(arg0: &mut Config, arg1: u64) {
        arg0.version = arg1;
    }

    fun verify_withdraw<T0>(arg0: &0x2::balance::Balance<T0>, arg1: &mut RateLimit<T0>, arg2: &0x2::clock::Clock, arg3: u64) {
        let v0 = 0x2::balance::value<T0>(arg0);
        let v1 = calculate_limit<T0>(v0, arg1, arg2);
        assert!(v0 - arg3 >= v1, 4);
        arg1.current_limit = v1;
        arg1.last_update = 0x2::clock::timestamp_ms(arg2);
    }

    fun withdraw<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut RateLimit<T0>, arg2: &0x2::clock::Clock, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 0);
        verify_withdraw<T0>(arg0, arg1, arg2, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(arg0, arg4, arg5), arg3);
    }

    // decompiled from Move bytecode v6
}

