module 0x51acb30953cb9bf10f092397afd2de34d968c21bc0857b30e8cb7b22d7aa90f1::social_layer_config {
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
        config_manager: address,
    }

    struct ConfigManagerCap has store, key {
        id: 0x2::object::UID,
        config_manager: address,
    }

    public fun assert_address_is_config_manager(arg0: &ConfigManagerCap, arg1: &Config, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.config_manager == 0x2::tx_context::sender(arg2), 6);
        assert!(arg1.config_manager == 0x2::tx_context::sender(arg2), 6);
    }

    public fun assert_bio_length_is_valid(arg0: &Config, arg1: &0x1::string::String) {
        assert!(0x1::string::length(arg1) >= arg0.bio_min_length, 5);
        assert!(0x1::string::length(arg1) <= arg0.bio_max_length, 4);
    }

    public fun assert_display_name_length_is_valid(arg0: &Config, arg1: &0x1::string::String) {
        assert!(0x1::string::length(arg1) >= arg0.display_name_min_length, 3);
        assert!(0x1::string::length(arg1) <= arg0.display_name_max_length, 2);
    }

    public fun assert_interacting_with_most_up_to_date_package(arg0: &Config) {
        assert!(arg0.version == 1, 0);
    }

    public fun assign_config_manager(arg0: &0x51acb30953cb9bf10f092397afd2de34d968c21bc0857b30e8cb7b22d7aa90f1::app::AdminCap, arg1: &mut Config, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_interacting_with_most_up_to_date_package(arg1);
        arg1.config_manager = arg2;
        let v0 = ConfigManagerCap{
            id             : 0x2::object::new(arg3),
            config_manager : arg2,
        };
        0x2::transfer::transfer<ConfigManagerCap>(v0, arg2);
    }

    public(friend) fun create_config(arg0: &SOCIAL_LAYER_CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<SOCIAL_LAYER_CONFIG>(arg0), 1);
        let v0 = Config{
            id                      : 0x2::object::new(arg1),
            version                 : 1,
            display_name_min_length : 0x51acb30953cb9bf10f092397afd2de34d968c21bc0857b30e8cb7b22d7aa90f1::social_layer_constants::display_name_min_length(),
            display_name_max_length : 0x51acb30953cb9bf10f092397afd2de34d968c21bc0857b30e8cb7b22d7aa90f1::social_layer_constants::display_name_max_length(),
            bio_min_length          : 0x51acb30953cb9bf10f092397afd2de34d968c21bc0857b30e8cb7b22d7aa90f1::social_layer_constants::bio_min_length(),
            bio_max_length          : 0x51acb30953cb9bf10f092397afd2de34d968c21bc0857b30e8cb7b22d7aa90f1::social_layer_constants::bio_max_length(),
            config_manager          : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    fun init(arg0: SOCIAL_LAYER_CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        create_config(&arg0, arg1);
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

    // decompiled from Move bytecode v6
}

