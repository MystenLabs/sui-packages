module 0x353ee6e39e854c2fba0f3085fa613d0a055d754daea67ad799eeb042f48721e5::config {
    struct GlobalConfigMap has key {
        id: 0x2::object::UID,
        power_configs: 0x2::table::Table<0x1::string::String, u64>,
        burn_configs: 0x2::table::Table<0x1::string::String, u64>,
        default_power_rate: u64,
        default_burn_percentage: u64,
        authorized_list: vector<address>,
    }

    struct PowerRateUpdated has copy, drop {
        coin_type: 0x1::string::String,
        old_rate: u64,
        new_rate: u64,
        operator: address,
        timestamp: u64,
    }

    struct BurnPercentageUpdated has copy, drop {
        coin_type: 0x1::string::String,
        old_percentage: u64,
        new_percentage: u64,
        operator: address,
        timestamp: u64,
    }

    struct BatchConfigUpdated has copy, drop {
        coin_types: vector<0x1::string::String>,
        power_rates: vector<u64>,
        burn_percentages: vector<u64>,
        operator: address,
        timestamp: u64,
    }

    struct AuthorizedAddressAdded has copy, drop {
        authorized_address: address,
        operator: address,
        timestamp: u64,
    }

    struct AuthorizedAddressRemoved has copy, drop {
        authorized_address: address,
        operator: address,
        timestamp: u64,
    }

    public(friend) fun add_authorized_address(arg0: &mut GlobalConfigMap, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::contains<address>(&arg0.authorized_list, &arg1), 204);
        0x1::vector::push_back<address>(&mut arg0.authorized_list, arg1);
        let v0 = AuthorizedAddressAdded{
            authorized_address : arg1,
            operator           : 0x2::tx_context::sender(arg3),
            timestamp          : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AuthorizedAddressAdded>(v0);
    }

    public fun calculate_burn_amount(arg0: &GlobalConfigMap, arg1: 0x1::string::String, arg2: u64) : u64 {
        arg2 * get_burn_percentage(arg0, arg1) / 100
    }

    public fun calculate_power(arg0: &GlobalConfigMap, arg1: 0x1::string::String, arg2: u64) : u64 {
        arg2 * get_power_rate(arg0, arg1) / 100
    }

    public fun calculate_stake_amount(arg0: &GlobalConfigMap, arg1: 0x1::string::String, arg2: u64) : u64 {
        arg2 - calculate_burn_amount(arg0, arg1, arg2)
    }

    fun check_permission(arg0: &GlobalConfigMap, arg1: &0x2::tx_context::TxContext) {
        assert!(is_authorized(arg0, 0x2::tx_context::sender(arg1)), 203);
    }

    public fun get_authorized_addresses(arg0: &GlobalConfigMap) : vector<address> {
        arg0.authorized_list
    }

    public fun get_burn_percentage(arg0: &GlobalConfigMap, arg1: 0x1::string::String) : u64 {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.burn_configs, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.burn_configs, arg1)
        } else {
            arg0.default_burn_percentage
        }
    }

    public fun get_coin_config(arg0: &GlobalConfigMap, arg1: 0x1::string::String) : (u64, u64) {
        (get_power_rate(arg0, arg1), get_burn_percentage(arg0, arg1))
    }

    public fun get_power_rate(arg0: &GlobalConfigMap, arg1: 0x1::string::String) : u64 {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.power_configs, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.power_configs, arg1)
        } else {
            arg0.default_power_rate
        }
    }

    public(friend) fun init_config(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<0x1::string::String, u64>(arg0);
        let v1 = 0x2::table::new<0x1::string::String, u64>(arg0);
        0x2::table::add<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"L"), 200);
        0x2::table::add<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"YUSDT"), 100);
        0x2::table::add<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"USDC"), 120);
        0x2::table::add<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"SUI"), 120);
        0x2::table::add<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"YY"), 100);
        0x2::table::add<0x1::string::String, u64>(&mut v1, 0x1::string::utf8(b"L"), 20);
        0x2::table::add<0x1::string::String, u64>(&mut v1, 0x1::string::utf8(b"YUSDT"), 30);
        0x2::table::add<0x1::string::String, u64>(&mut v1, 0x1::string::utf8(b"USDC"), 30);
        0x2::table::add<0x1::string::String, u64>(&mut v1, 0x1::string::utf8(b"SUI"), 30);
        0x2::table::add<0x1::string::String, u64>(&mut v1, 0x1::string::utf8(b"YY"), 30);
        let v2 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v2, 0x2::tx_context::sender(arg0));
        let v3 = GlobalConfigMap{
            id                      : 0x2::object::new(arg0),
            power_configs           : v0,
            burn_configs            : v1,
            default_power_rate      : 100,
            default_burn_percentage : 20,
            authorized_list         : v2,
        };
        0x2::transfer::share_object<GlobalConfigMap>(v3);
    }

    public fun is_authorized(arg0: &GlobalConfigMap, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.authorized_list, &arg1)
    }

    public(friend) fun remove_authorized_address(arg0: &mut GlobalConfigMap, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.authorized_list, &arg1);
        assert!(v0, 205);
        0x1::vector::remove<address>(&mut arg0.authorized_list, v1);
        let v2 = AuthorizedAddressRemoved{
            authorized_address : arg1,
            operator           : 0x2::tx_context::sender(arg3),
            timestamp          : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AuthorizedAddressRemoved>(v2);
    }

    public entry fun set_burn_percentage(arg0: &mut GlobalConfigMap, arg1: 0x1::string::String, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 100, 201);
        check_permission(arg0, arg4);
        let v0 = if (0x2::table::contains<0x1::string::String, u64>(&arg0.burn_configs, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.burn_configs, arg1)
        } else {
            0
        };
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.burn_configs, arg1)) {
            *0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg0.burn_configs, arg1) = arg2;
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg0.burn_configs, arg1, arg2);
        };
        let v1 = BurnPercentageUpdated{
            coin_type      : arg1,
            old_percentage : v0,
            new_percentage : arg2,
            operator       : 0x2::tx_context::sender(arg4),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<BurnPercentageUpdated>(v1);
    }

    public entry fun set_power_rate(arg0: &mut GlobalConfigMap, arg1: 0x1::string::String, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_permission(arg0, arg4);
        assert!(arg2 > 0 && arg2 <= 1000, 200);
        let v0 = if (0x2::table::contains<0x1::string::String, u64>(&arg0.power_configs, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.power_configs, arg1)
        } else {
            0
        };
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.power_configs, arg1)) {
            *0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg0.power_configs, arg1) = arg2;
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg0.power_configs, arg1, arg2);
        };
        let v1 = PowerRateUpdated{
            coin_type : arg1,
            old_rate  : v0,
            new_rate  : arg2,
            operator  : 0x2::tx_context::sender(arg4),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PowerRateUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}

