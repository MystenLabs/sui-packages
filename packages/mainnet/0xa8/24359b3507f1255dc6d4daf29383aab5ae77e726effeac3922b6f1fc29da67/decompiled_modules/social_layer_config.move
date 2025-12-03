module 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config {
    struct SOCIAL_LAYER_CONFIG has drop {
        dummy_field: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        display_name_min_length: u64,
        display_name_max_length: u64,
        bio_min_length: u64,
        bio_max_length: u64,
        allowed_wallet_keys: vector<0x1::string::String>,
        allowed_social_platforms: vector<0x1::string::String>,
        config_manager: address,
    }

    struct ConfigManagerCap has store, key {
        id: 0x2::object::UID,
        config_manager: address,
    }

    public fun add_allowed_social_platform(arg0: &ConfigManagerCap, arg1: &mut Config, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert_address_is_config_manager(arg0, arg1, arg3);
        assert!(!0x1::vector::contains<0x1::string::String>(&arg1.allowed_social_platforms, &arg2), 11);
        0x1::vector::push_back<0x1::string::String>(&mut arg1.allowed_social_platforms, arg2);
    }

    public fun add_allowed_wallet_key(arg0: &ConfigManagerCap, arg1: &mut Config, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert_address_is_config_manager(arg0, arg1, arg3);
        assert!(!0x1::vector::contains<0x1::string::String>(&arg1.allowed_wallet_keys, &arg2), 9);
        0x1::vector::push_back<0x1::string::String>(&mut arg1.allowed_wallet_keys, arg2);
    }

    public fun allowed_social_platforms(arg0: &Config) : &vector<0x1::string::String> {
        &arg0.allowed_social_platforms
    }

    public fun allowed_wallet_keys(arg0: &Config) : &vector<0x1::string::String> {
        &arg0.allowed_wallet_keys
    }

    public fun assert_address_is_config_manager(arg0: &ConfigManagerCap, arg1: &Config, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.config_manager == 0x2::tx_context::sender(arg2), 6);
        assert!(arg1.config_manager == 0x2::tx_context::sender(arg2), 6);
    }

    public fun assert_bio_length_is_valid(arg0: &Config, arg1: &0x1::string::String) {
        assert!(0x1::string::length(arg1) >= arg0.bio_min_length, 5);
        assert!(0x1::string::length(arg1) <= arg0.bio_max_length, 4);
    }

    public fun assert_display_name_is_valid(arg0: &Config, arg1: &0x1::string::String) {
        assert_display_name_length_is_valid(arg0, arg1);
        let v0 = 0x1::string::as_bytes(arg1);
        let v1 = 0;
        let v2 = 0x1::string::length(arg1);
        while (v1 < v2) {
            let v3 = *0x1::vector::borrow<u8>(v0, v1);
            let v4 = if (97 <= v3 && v3 <= 122) {
                true
            } else if (48 <= v3 && v3 <= 57) {
                true
            } else if (v3 == 45) {
                if (v1 != 0) {
                    v1 != v2 - 1
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v4, 7);
            v1 = v1 + 1;
        };
    }

    public fun assert_display_name_length_is_valid(arg0: &Config, arg1: &0x1::string::String) {
        assert!(0x1::string::length(arg1) >= arg0.display_name_min_length, 3);
        assert!(0x1::string::length(arg1) <= arg0.display_name_max_length, 2);
    }

    public fun assert_interacting_with_most_up_to_date_package(arg0: &Config) {
        assert!(arg0.version == 1, 0);
    }

    public fun assert_social_platform_is_allowed(arg0: &Config, arg1: &0x1::string::String) {
        assert!(0x1::vector::contains<0x1::string::String>(&arg0.allowed_social_platforms, arg1), 10);
    }

    public fun assert_wallet_key_is_allowed(arg0: &Config, arg1: &0x1::string::String) {
        assert!(0x1::vector::contains<0x1::string::String>(&arg0.allowed_wallet_keys, arg1), 8);
    }

    public fun assign_config_manager(arg0: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::app::AdminCap, arg1: &mut Config, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_interacting_with_most_up_to_date_package(arg1);
        arg1.config_manager = arg2;
        let v0 = ConfigManagerCap{
            id             : 0x2::object::new(arg3),
            config_manager : arg2,
        };
        0x2::transfer::transfer<ConfigManagerCap>(v0, arg2);
    }

    public fun bio_max_length(arg0: &Config) : u64 {
        arg0.bio_max_length
    }

    public fun bio_min_length(arg0: &Config) : u64 {
        arg0.bio_min_length
    }

    public fun config_manager(arg0: &Config) : address {
        arg0.config_manager
    }

    public fun create_config(arg0: &SOCIAL_LAYER_CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<SOCIAL_LAYER_CONFIG>(arg0), 1);
        let v0 = Config{
            id                       : 0x2::object::new(arg1),
            version                  : 1,
            display_name_min_length  : 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_constants::display_name_min_length(),
            display_name_max_length  : 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_constants::display_name_max_length(),
            bio_min_length           : 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_constants::bio_min_length(),
            bio_max_length           : 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_constants::bio_max_length(),
            allowed_wallet_keys      : 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_constants::allowed_wallet_keys(),
            allowed_social_platforms : 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_constants::allowed_social_platforms(),
            config_manager           : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun display_name_max_length(arg0: &Config) : u64 {
        arg0.display_name_max_length
    }

    public fun display_name_min_length(arg0: &Config) : u64 {
        arg0.display_name_min_length
    }

    fun init(arg0: SOCIAL_LAYER_CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        create_config(&arg0, arg1);
    }

    public fun migrate_config(arg0: &ConfigManagerCap, arg1: &mut Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_address_is_config_manager(arg0, arg1, arg3);
        assert!(arg2 > arg1.version, 13);
        assert!(arg2 <= 1, 12);
        assert!(arg1.version == 1 && arg2 == 2, 12);
        arg1.version = 2;
    }

    public fun remove_allowed_social_platform(arg0: &ConfigManagerCap, arg1: &mut Config, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : bool {
        assert_address_is_config_manager(arg0, arg1, arg3);
        let v0 = &mut arg1.allowed_social_platforms;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(v0)) {
            if (*0x1::vector::borrow<0x1::string::String>(v0, v1) == arg2) {
                0x1::vector::swap_remove<0x1::string::String>(v0, v1);
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun remove_allowed_wallet_key(arg0: &ConfigManagerCap, arg1: &mut Config, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : bool {
        assert_address_is_config_manager(arg0, arg1, arg3);
        let v0 = &mut arg1.allowed_wallet_keys;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(v0)) {
            if (*0x1::vector::borrow<0x1::string::String>(v0, v1) == arg2) {
                0x1::vector::swap_remove<0x1::string::String>(v0, v1);
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun set_allowed_social_platforms(arg0: &ConfigManagerCap, arg1: &mut Config, arg2: vector<0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_address_is_config_manager(arg0, arg1, arg3);
        arg1.allowed_social_platforms = arg2;
    }

    public fun set_allowed_wallet_keys(arg0: &ConfigManagerCap, arg1: &mut Config, arg2: vector<0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_address_is_config_manager(arg0, arg1, arg3);
        arg1.allowed_wallet_keys = arg2;
    }

    public fun set_bio_max_length(arg0: &ConfigManagerCap, arg1: &mut Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_address_is_config_manager(arg0, arg1, arg3);
        arg1.bio_max_length = arg2;
    }

    public fun set_bio_min_length(arg0: &ConfigManagerCap, arg1: &mut Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_address_is_config_manager(arg0, arg1, arg3);
        arg1.bio_min_length = arg2;
    }

    public fun set_display_name_max_length(arg0: &ConfigManagerCap, arg1: &mut Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_address_is_config_manager(arg0, arg1, arg3);
        arg1.display_name_max_length = arg2;
    }

    public fun set_display_name_min_length(arg0: &ConfigManagerCap, arg1: &mut Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_address_is_config_manager(arg0, arg1, arg3);
        arg1.display_name_min_length = arg2;
    }

    public fun update_config_to_latest_version(arg0: &ConfigManagerCap, arg1: &mut Config, arg2: &mut 0x2::tx_context::TxContext) {
        migrate_config(arg0, arg1, 1, arg2);
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

