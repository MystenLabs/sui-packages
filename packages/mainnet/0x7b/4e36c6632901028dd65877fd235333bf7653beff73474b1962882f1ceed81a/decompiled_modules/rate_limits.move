module 0x7b4e36c6632901028dd65877fd235333bf7653beff73474b1962882f1ceed81a::rate_limits {
    struct RATE_LIMITS has drop {
        dummy_field: bool,
    }

    struct RateLimitConfig has copy, drop, store {
        rate_per_second: u128,
        last_updated: u64,
        available: u128,
        max_available: u128,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        version: u64,
        latest_package_id: 0x1::string::String,
        asset_manager: 0x1::string::String,
        paused: bool,
        hub_admin: vector<u8>,
        hub_manager: vector<u8>,
        hub_chain_id: u256,
        hub_signers: vector<vector<u8>>,
        publisher: 0x2::package::Publisher,
        token_configs: 0x2::table::Table<0x1::string::String, RateLimitConfig>,
        executed_messages: 0x2::table::Table<u64, bool>,
    }

    struct Params has drop {
        type_args: vector<0x1::string::String>,
        args: vector<0x1::string::String>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun get_hub_admin(arg0: &Config) : vector<u8> {
        arg0.hub_admin
    }

    public fun get_hub_signers(arg0: &Config) : vector<vector<u8>> {
        arg0.hub_signers
    }

    fun compute_available(arg0: &RateLimitConfig, arg1: u64) : u128 {
        0x1::u128::min(arg0.available + ((((arg1 - arg0.last_updated) as u128) * arg0.rate_per_second) as u128), arg0.max_available)
    }

    entry fun configure(arg0: &mut Config, arg1: u256, arg2: vector<u8>, arg3: 0x1::string::String, arg4: vector<u8>, arg5: &AdminCap) {
        arg0.asset_manager = arg3;
        arg0.hub_admin = arg4;
        arg0.hub_manager = arg2;
        arg0.hub_chain_id = arg1;
    }

    fun decode_and_verify_payload(arg0: &mut Config, arg1: vector<u8>, arg2: &0x2::clock::Clock) : (0x7b4e36c6632901028dd65877fd235333bf7653beff73474b1962882f1ceed81a::actions::Actions, vector<u8>) {
        let v0 = 0x7b4e36c6632901028dd65877fd235333bf7653beff73474b1962882f1ceed81a::payload::decode(&arg1);
        let v1 = 0x7b4e36c6632901028dd65877fd235333bf7653beff73474b1962882f1ceed81a::payload::get_message(&v0);
        assert!(0x7b4e36c6632901028dd65877fd235333bf7653beff73474b1962882f1ceed81a::message::has_expired(&v1, arg2) == false, 6);
        assert!(0x2::table::contains<u64, bool>(&arg0.executed_messages, 0x7b4e36c6632901028dd65877fd235333bf7653beff73474b1962882f1ceed81a::message::get_deadline(&v1)), 10);
        0x2::table::add<u64, bool>(&mut arg0.executed_messages, 0x7b4e36c6632901028dd65877fd235333bf7653beff73474b1962882f1ceed81a::message::get_deadline(&v1), true);
        (0x7b4e36c6632901028dd65877fd235333bf7653beff73474b1962882f1ceed81a::message::get_actions(&v1), 0x7b4e36c6632901028dd65877fd235333bf7653beff73474b1962882f1ceed81a::payload::recover_signer(&v0))
    }

    public(friend) fun enforce_version(arg0: &Config, arg1: u64) {
        assert!(arg0.version == arg1, 7);
    }

    public fun get_asset_manager(arg0: &Config) : 0x1::string::String {
        arg0.asset_manager
    }

    public fun get_available<T0>(arg0: &Config, arg1: &0x2::clock::Clock) : u128 {
        let v0 = get_type_string<T0>();
        if (!0x2::table::contains<0x1::string::String, RateLimitConfig>(&arg0.token_configs, v0)) {
            return 0
        };
        compute_available(0x2::table::borrow<0x1::string::String, RateLimitConfig>(&arg0.token_configs, v0), timestamp_s(arg1))
    }

    public fun get_hub_manager(arg0: &Config) : vector<u8> {
        arg0.hub_manager
    }

    public fun get_rate_limit_configs<T0>(arg0: &Config) : RateLimitConfig {
        *0x2::table::borrow<0x1::string::String, RateLimitConfig>(&arg0.token_configs, get_type_string<T0>())
    }

    entry fun get_recv_message_args(arg0: &Config, arg1: vector<u8>) : Params {
        enforce_version(arg0, 1);
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, id_to_hex_string(0x2::object::uid_as_inner(&arg0.id)));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"connection"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"src_chain_id"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"src_address"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"conn_sn"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"payload"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"signatures"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"clock"));
        Params{
            type_args : 0x1::vector::empty<0x1::string::String>(),
            args      : v0,
        }
    }

    public fun get_type_string<T0>() : 0x1::string::String {
        to_hex_string(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    public fun id_to_hex_string(arg0: &0x2::object::ID) : 0x1::string::String {
        to_hex_string(0x1::string::utf8(0x2::hex::encode(0x2::object::id_to_bytes(arg0))))
    }

    fun init(arg0: RATE_LIMITS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<RATE_LIMITS>(arg0, arg1);
        let v1 = Config{
            id                : 0x2::object::new(arg1),
            version           : 1,
            latest_package_id : 0x1::string::from_ascii(*0x2::package::published_package(&v0)),
            asset_manager     : 0x1::string::utf8(b""),
            paused            : false,
            hub_admin         : 0x1::vector::empty<u8>(),
            hub_manager       : 0x1::vector::empty<u8>(),
            hub_chain_id      : 146,
            hub_signers       : 0x1::vector::empty<vector<u8>>(),
            publisher         : v0,
            token_configs     : 0x2::table::new<0x1::string::String, RateLimitConfig>(arg1),
            executed_messages : 0x2::table::new<u64, bool>(arg1),
        };
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_share_object<Config>(v1);
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    fun is_authorized(arg0: &Config, arg1: vector<u8>) : bool {
        if (arg1 == arg0.hub_admin) {
            return true
        };
        0x1::vector::contains<vector<u8>>(&arg0.hub_signers, &arg1)
    }

    entry fun migrate(arg0: &mut Config, arg1: 0x1::string::String, arg2: &0x2::package::UpgradeCap) {
        assert!(arg0.version < 1, 8);
        arg0.version = 1;
        arg0.latest_package_id = arg1;
    }

    entry fun pause(arg0: &mut Config, arg1: &AdminCap) {
        arg0.paused = true;
    }

    entry fun pause_s(arg0: &mut Config, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        let (v0, v1) = decode_and_verify_payload(arg0, arg1, arg2);
        let v2 = v0;
        assert!(0x7b4e36c6632901028dd65877fd235333bf7653beff73474b1962882f1ceed81a::actions::is_pause(&v2), 4);
        assert!(is_authorized(arg0, v1), 5);
        arg0.paused = true;
    }

    fun process_message(arg0: &mut Config, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        let (v0, v1) = decode_and_verify_payload(arg0, arg1, arg2);
        let v2 = v0;
        if (0x7b4e36c6632901028dd65877fd235333bf7653beff73474b1962882f1ceed81a::actions::is_set_hub_admin(&v2)) {
            assert!(v1 == arg0.hub_admin, 5);
            arg0.hub_admin = 0x7b4e36c6632901028dd65877fd235333bf7653beff73474b1962882f1ceed81a::actions::get_hub_admin(&v2);
        } else if (0x7b4e36c6632901028dd65877fd235333bf7653beff73474b1962882f1ceed81a::actions::is_set_hub_signers(&v2)) {
            assert!(v1 == arg0.hub_admin, 5);
            arg0.hub_signers = 0x7b4e36c6632901028dd65877fd235333bf7653beff73474b1962882f1ceed81a::actions::get_hub_signers(&v2);
        } else if (0x7b4e36c6632901028dd65877fd235333bf7653beff73474b1962882f1ceed81a::actions::is_set_rate_limit(&v2)) {
            assert!(is_authorized(arg0, v1), 5);
            let (v3, v4, v5) = 0x7b4e36c6632901028dd65877fd235333bf7653beff73474b1962882f1ceed81a::actions::get_rate_limit(&v2);
            set_rate_limit_inner(arg0, v4, v5, timestamp_s(arg2), v3);
        } else if (0x7b4e36c6632901028dd65877fd235333bf7653beff73474b1962882f1ceed81a::actions::is_reset_rate_limit(&v2)) {
            assert!(is_authorized(arg0, v1), 5);
            reset_rate_limit(arg0, 0x7b4e36c6632901028dd65877fd235333bf7653beff73474b1962882f1ceed81a::actions::get_reset_token(&v2), timestamp_s(arg2));
        } else {
            assert!(0x7b4e36c6632901028dd65877fd235333bf7653beff73474b1962882f1ceed81a::actions::is_pause(&v2), 4);
            assert!(is_authorized(arg0, v1), 5);
            arg0.paused = true;
        };
    }

    public fun recv_message(arg0: &mut Config, arg1: &mut 0xf3b1e696a66d02cb776dc15aae73c68bc8f03adcb6ba0ec7f6332d9d90a6a3d2::connectionv3::State, arg2: u256, arg3: vector<u8>, arg4: u256, arg5: vector<u8>, arg6: vector<vector<u8>>, arg7: &0x2::clock::Clock) {
        assert!(arg2 == arg0.hub_chain_id, 2);
        assert!(0x2::hash::keccak256(&arg3) == 0x2::hash::keccak256(&arg0.hub_manager), 3);
        0xf3b1e696a66d02cb776dc15aae73c68bc8f03adcb6ba0ec7f6332d9d90a6a3d2::connectionv3::verify_message(arg1, 0x2::object::id<Config>(arg0), &arg0.publisher, arg2, arg3, arg4, arg5, arg6);
        process_message(arg0, arg5, arg7);
    }

    fun reset_rate_limit(arg0: &mut Config, arg1: vector<u8>, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<0x1::string::String, RateLimitConfig>(&mut arg0.token_configs, 0x1::string::utf8(arg1));
        v0.last_updated = arg2;
        v0.available = 0;
    }

    entry fun set_asset_manager(arg0: &mut Config, arg1: 0x1::string::String, arg2: &AdminCap) {
        arg0.asset_manager = arg1;
    }

    fun set_rate_limit_inner(arg0: &mut Config, arg1: u128, arg2: u128, arg3: u64, arg4: vector<u8>) {
        assert!(arg1 > 0, 12);
        let v0 = 0x1::string::utf8(arg4);
        if (0x2::table::contains<0x1::string::String, RateLimitConfig>(&arg0.token_configs, v0)) {
            let v1 = 0x2::table::borrow_mut<0x1::string::String, RateLimitConfig>(&mut arg0.token_configs, v0);
            v1.available = compute_available(v1, arg3);
            v1.rate_per_second = arg1;
            v1.max_available = arg2;
            v1.last_updated = arg3;
        } else {
            let v2 = RateLimitConfig{
                rate_per_second : arg1,
                last_updated    : arg3,
                available       : arg2,
                max_available   : arg2,
            };
            0x2::table::add<0x1::string::String, RateLimitConfig>(&mut arg0.token_configs, v0, v2);
        };
    }

    fun timestamp_s(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun to_hex_string(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, arg0);
        v0
    }

    entry fun unpause(arg0: &mut Config, arg1: &AdminCap) {
        arg0.paused = false;
    }

    public fun verify_withdraw<T0>(arg0: &mut Config, arg1: &0x2::package::Publisher, arg2: &0x2::clock::Clock, arg3: u128) {
        assert!(to_hex_string(0x1::string::from_ascii(*0x2::package::published_package(arg1))) == arg0.asset_manager, 0);
        assert!(arg0.paused == false, 9);
        assert!(arg3 > 0, 11);
        let v0 = timestamp_s(arg2);
        let v1 = get_type_string<T0>();
        if (!0x2::table::contains<0x1::string::String, RateLimitConfig>(&arg0.token_configs, v1)) {
            return
        };
        let v2 = 0x2::table::borrow_mut<0x1::string::String, RateLimitConfig>(&mut arg0.token_configs, v1);
        let v3 = compute_available(v2, v0);
        v2.last_updated = v0;
        assert!(v3 >= arg3, 1);
        v2.available = v3 - arg3;
    }

    // decompiled from Move bytecode v6
}

