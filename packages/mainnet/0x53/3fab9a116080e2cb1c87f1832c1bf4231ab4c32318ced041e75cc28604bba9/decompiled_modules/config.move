module 0x533fab9a116080e2cb1c87f1832c1bf4231ab4c32318ced041e75cc28604bba9::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        acl: 0x533fab9a116080e2cb1c87f1832c1bf4231ab4c32318ced041e75cc28604bba9::acl::ACL,
        token_white_list: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        deletion_grace_period: u64,
        require_flash_loan_auth: bool,
        require_check_token_white_list: bool,
        package_version: u64,
    }

    struct InitFactoryEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
        global_config_id: 0x2::object::ID,
    }

    struct SetRolesEvent has copy, drop {
        member: address,
        roles: u128,
    }

    struct AddRoleEvent has copy, drop {
        member: address,
        role: u8,
    }

    struct RemoveRoleEvent has copy, drop {
        member: address,
        role: u8,
    }

    struct RemoveMemberEvent has copy, drop {
        member: address,
    }

    struct SetPackageVersion has copy, drop {
        new_version: u64,
        old_version: u64,
    }

    struct AddTokenEvent has copy, drop {
        token: 0x1::ascii::String,
        min_trade_amount: u64,
    }

    struct RemoveTokenEvent has copy, drop {
        token: 0x1::ascii::String,
    }

    struct SetConfigDeletionGracePeriod has copy, drop {
        deletion_grace_period: u64,
    }

    struct SetConfigRequireFlashLoanAuth has copy, drop {
        require_flash_loan_auth: bool,
    }

    struct SetConfigRequireCheckTokenWhiteList has copy, drop {
        require_check_token_white_list: bool,
    }

    struct UpdateMinTradeAmount has copy, drop {
        token: 0x1::ascii::String,
        min_trade_amount: u64,
    }

    public fun add_role(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u8) {
        checked_package_version(arg1);
        0x533fab9a116080e2cb1c87f1832c1bf4231ab4c32318ced041e75cc28604bba9::acl::add_role(&mut arg1.acl, arg2, arg3);
        let v0 = AddRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<AddRoleEvent>(v0);
    }

    public fun get_members(arg0: &GlobalConfig) : vector<0x533fab9a116080e2cb1c87f1832c1bf4231ab4c32318ced041e75cc28604bba9::acl::Member> {
        0x533fab9a116080e2cb1c87f1832c1bf4231ab4c32318ced041e75cc28604bba9::acl::get_members(&arg0.acl)
    }

    public fun remove_member(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        checked_package_version(arg1);
        0x533fab9a116080e2cb1c87f1832c1bf4231ab4c32318ced041e75cc28604bba9::acl::remove_member(&mut arg1.acl, arg2);
        let v0 = RemoveMemberEvent{member: arg2};
        0x2::event::emit<RemoveMemberEvent>(v0);
    }

    public fun remove_role(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u8) {
        checked_package_version(arg1);
        0x533fab9a116080e2cb1c87f1832c1bf4231ab4c32318ced041e75cc28604bba9::acl::remove_role(&mut arg1.acl, arg2, arg3);
        let v0 = RemoveRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<RemoveRoleEvent>(v0);
    }

    public fun set_roles(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u128) {
        checked_package_version(arg1);
        0x533fab9a116080e2cb1c87f1832c1bf4231ab4c32318ced041e75cc28604bba9::acl::set_roles(&mut arg1.acl, arg2, arg3);
        let v0 = SetRolesEvent{
            member : arg2,
            roles  : arg3,
        };
        0x2::event::emit<SetRolesEvent>(v0);
    }

    public fun add_into_token_list<T0>(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        checked_token_white_list_manager_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x1::type_name::get<T0>();
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.token_white_list, v0, arg1);
        let v1 = AddTokenEvent{
            token            : 0x1::type_name::into_string(v0),
            min_trade_amount : arg1,
        };
        0x2::event::emit<AddTokenEvent>(v1);
    }

    public fun check_token_and_min_trade_amount<T0>(arg0: &GlobalConfig, arg1: u64) : bool {
        if (!arg0.require_check_token_white_list) {
            true
        } else {
            let (v1, v2) = find_token_and_min_trade_amount<T0>(arg0);
            v1 && v2 <= arg1
        }
    }

    public fun checked_keeper(arg0: &GlobalConfig, arg1: address) {
        assert!(0x533fab9a116080e2cb1c87f1832c1bf4231ab4c32318ced041e75cc28604bba9::acl::has_role(&arg0.acl, arg1, 1), 2);
    }

    public fun checked_package_version(arg0: &GlobalConfig) {
        assert!(1 == arg0.package_version, 0);
    }

    public fun checked_pool_token_types<T0, T1>(arg0: &GlobalConfig) {
        if (arg0.require_check_token_white_list) {
            assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.token_white_list, 0x1::type_name::get<T0>()) && 0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.token_white_list, 0x1::type_name::get<T1>()), 3);
        };
    }

    public fun checked_token_white_list_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x533fab9a116080e2cb1c87f1832c1bf4231ab4c32318ced041e75cc28604bba9::acl::has_role(&arg0.acl, arg1, 0), 1);
    }

    fun find_token_and_min_trade_amount<T0>(arg0: &GlobalConfig) : (bool, u64) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.token_white_list, v0)) {
            return (false, 0)
        };
        (true, *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.token_white_list, v0))
    }

    public fun get_config_deletion_grace_period(arg0: &GlobalConfig) : u64 {
        arg0.deletion_grace_period
    }

    public fun get_config_require_check_token_white_list(arg0: &GlobalConfig) : bool {
        arg0.require_check_token_white_list
    }

    public fun get_config_require_flash_loan_auth(arg0: &GlobalConfig) : bool {
        arg0.require_flash_loan_auth
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id                             : 0x2::object::new(arg0),
            acl                            : 0x533fab9a116080e2cb1c87f1832c1bf4231ab4c32318ced041e75cc28604bba9::acl::new(arg0),
            token_white_list               : 0x2::table::new<0x1::type_name::TypeName, u64>(arg0),
            deletion_grace_period          : 2592000000,
            require_flash_loan_auth        : true,
            require_check_token_white_list : false,
            package_version                : 1,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = 0x2::tx_context::sender(arg0);
        let v3 = &mut v0;
        set_roles(&v1, v3, v2, 0 | 1 << 0 | 1 << 1);
        0x2::transfer::transfer<AdminCap>(v1, v2);
        0x2::transfer::share_object<GlobalConfig>(v0);
        let v4 = InitFactoryEvent{
            admin_cap_id     : 0x2::object::id<AdminCap>(&v1),
            global_config_id : 0x2::object::id<GlobalConfig>(&v0),
        };
        0x2::event::emit<InitFactoryEvent>(v4);
    }

    public fun package_version() : u64 {
        1
    }

    public fun remove_from_token_list<T0>(arg0: &mut GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        checked_token_white_list_manager_role(arg0, 0x2::tx_context::sender(arg1));
        let v0 = 0x1::type_name::get<T0>();
        0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.token_white_list, v0);
        let v1 = RemoveTokenEvent{token: 0x1::type_name::into_string(v0)};
        0x2::event::emit<RemoveTokenEvent>(v1);
    }

    public fun set_config_deletion_grace_period(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        checked_keeper(arg0, 0x2::tx_context::sender(arg2));
        arg0.deletion_grace_period = arg1;
        let v0 = SetConfigDeletionGracePeriod{deletion_grace_period: arg1};
        0x2::event::emit<SetConfigDeletionGracePeriod>(v0);
    }

    public fun set_config_require_check_token_white_list(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: bool) {
        checked_package_version(arg1);
        arg1.require_check_token_white_list = arg2;
        let v0 = SetConfigRequireCheckTokenWhiteList{require_check_token_white_list: arg2};
        0x2::event::emit<SetConfigRequireCheckTokenWhiteList>(v0);
    }

    public fun set_config_require_flash_loan_auth(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: bool) {
        checked_package_version(arg1);
        arg1.require_flash_loan_auth = arg2;
        let v0 = SetConfigRequireFlashLoanAuth{require_flash_loan_auth: arg2};
        0x2::event::emit<SetConfigRequireFlashLoanAuth>(v0);
    }

    public fun update_min_trade_amount<T0>(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        checked_package_version(arg1);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg1.token_white_list, v0)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg1.token_white_list, v0) = arg2;
            let v1 = UpdateMinTradeAmount{
                token            : 0x1::type_name::into_string(v0),
                min_trade_amount : arg2,
            };
            0x2::event::emit<UpdateMinTradeAmount>(v1);
        };
    }

    public fun update_package_version(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.package_version = arg2;
        let v0 = SetPackageVersion{
            new_version : arg2,
            old_version : arg1.package_version,
        };
        0x2::event::emit<SetPackageVersion>(v0);
    }

    // decompiled from Move bytecode v6
}

