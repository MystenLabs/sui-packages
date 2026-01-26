module 0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::limit_order_config {
    struct LIMIT_ORDER_CONFIG has drop {
        dummy_field: bool,
    }

    struct LimitOrderConfig has store, key {
        id: 0x2::object::UID,
        token_white_list: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        deletion_grace_period: u64,
        require_flash_loan_auth: bool,
        require_check_token_white_list: bool,
    }

    struct AddTokenEvent has copy, drop {
        token: 0x1::ascii::String,
        min_trade_amount: u64,
    }

    struct RemoveTokenEvent has copy, drop {
        token: 0x1::ascii::String,
    }

    struct SetDeletionGracePeriodEvent has copy, drop {
        deletion_grace_period: u64,
    }

    struct SetRequireFlashLoanAuthEvent has copy, drop {
        require_flash_loan_auth: bool,
    }

    struct SetRequireCheckTokenWhiteListEvent has copy, drop {
        require_check_token_white_list: bool,
    }

    struct UpdateMinTradeAmountEvent has copy, drop {
        token: 0x1::ascii::String,
        min_trade_amount: u64,
    }

    public fun add_into_token_list<T0>(arg0: &0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::BaseConfig, arg1: &mut LimitOrderConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::checked_package_version(arg0);
        checked_token_white_list_manager_role(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x1::type_name::get<T0>();
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg1.token_white_list, v0, arg2);
        let v1 = AddTokenEvent{
            token            : 0x1::type_name::into_string(v0),
            min_trade_amount : arg2,
        };
        0x2::event::emit<AddTokenEvent>(v1);
    }

    public fun check_token_and_min_trade_amount<T0>(arg0: &LimitOrderConfig, arg1: u64) : bool {
        if (!arg0.require_check_token_white_list) {
            return true
        };
        let (v0, v1) = find_token_and_min_trade_amount<T0>(arg0);
        v0 && v1 <= arg1
    }

    public fun checked_keeper(arg0: &0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::BaseConfig, arg1: address) {
        assert!(0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::has_role(arg0, arg1, 1), 2);
    }

    public fun checked_pool_token_types<T0, T1>(arg0: &LimitOrderConfig) {
        if (arg0.require_check_token_white_list) {
            assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.token_white_list, 0x1::type_name::get<T0>()) && 0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.token_white_list, 0x1::type_name::get<T1>()), 3);
        };
    }

    public fun checked_token_white_list_manager_role(arg0: &0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::BaseConfig, arg1: address) {
        assert!(0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::has_role(arg0, arg1, 0), 1);
    }

    fun find_token_and_min_trade_amount<T0>(arg0: &LimitOrderConfig) : (bool, u64) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.token_white_list, v0)) {
            return (false, 0)
        };
        (true, *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.token_white_list, v0))
    }

    public fun get_deletion_grace_period(arg0: &LimitOrderConfig) : u64 {
        arg0.deletion_grace_period
    }

    public fun get_require_check_token_white_list(arg0: &LimitOrderConfig) : bool {
        arg0.require_check_token_white_list
    }

    public fun get_require_flash_loan_auth(arg0: &LimitOrderConfig) : bool {
        arg0.require_flash_loan_auth
    }

    fun init(arg0: LIMIT_ORDER_CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LimitOrderConfig{
            id                             : 0x2::object::new(arg1),
            token_white_list               : 0x2::table::new<0x1::type_name::TypeName, u64>(arg1),
            deletion_grace_period          : 2592000000,
            require_flash_loan_auth        : true,
            require_check_token_white_list : false,
        };
        0x2::transfer::share_object<LimitOrderConfig>(v0);
    }

    public fun remove_from_token_list<T0>(arg0: &0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::BaseConfig, arg1: &mut LimitOrderConfig, arg2: &0x2::tx_context::TxContext) {
        0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::checked_package_version(arg0);
        checked_token_white_list_manager_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x1::type_name::get<T0>();
        0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg1.token_white_list, v0);
        let v1 = RemoveTokenEvent{token: 0x1::type_name::into_string(v0)};
        0x2::event::emit<RemoveTokenEvent>(v1);
    }

    public fun set_deletion_grace_period(arg0: &0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::BaseConfig, arg1: &mut LimitOrderConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::checked_package_version(arg0);
        checked_keeper(arg0, 0x2::tx_context::sender(arg3));
        arg1.deletion_grace_period = arg2;
        let v0 = SetDeletionGracePeriodEvent{deletion_grace_period: arg2};
        0x2::event::emit<SetDeletionGracePeriodEvent>(v0);
    }

    public fun set_require_check_token_white_list(arg0: &0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::BaseConfig, arg1: &0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::AdminCap, arg2: &mut LimitOrderConfig, arg3: bool) {
        0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::checked_package_version(arg0);
        arg2.require_check_token_white_list = arg3;
        let v0 = SetRequireCheckTokenWhiteListEvent{require_check_token_white_list: arg3};
        0x2::event::emit<SetRequireCheckTokenWhiteListEvent>(v0);
    }

    public fun set_require_flash_loan_auth(arg0: &0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::BaseConfig, arg1: &0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::AdminCap, arg2: &mut LimitOrderConfig, arg3: bool) {
        0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::checked_package_version(arg0);
        arg2.require_flash_loan_auth = arg3;
        let v0 = SetRequireFlashLoanAuthEvent{require_flash_loan_auth: arg3};
        0x2::event::emit<SetRequireFlashLoanAuthEvent>(v0);
    }

    public fun update_min_trade_amount<T0>(arg0: &0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::BaseConfig, arg1: &0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::AdminCap, arg2: &mut LimitOrderConfig, arg3: u64) {
        0x1ffaf092ba4c8b863a637738ce1a7a6cb6b12fa8cddf1dcfe6137b30a8ee9e8c::base_config::checked_package_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg2.token_white_list, v0)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg2.token_white_list, v0) = arg3;
            let v1 = UpdateMinTradeAmountEvent{
                token            : 0x1::type_name::into_string(v0),
                min_trade_amount : arg3,
            };
            0x2::event::emit<UpdateMinTradeAmountEvent>(v1);
        };
    }

    // decompiled from Move bytecode v6
}

