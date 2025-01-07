module 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::app {
    struct AdminCap has key {
        id: 0x2::object::UID,
        admin: address,
        whitelisted_addresses: 0x2::table::Table<address, bool>,
    }

    public entry fun add_whitelist(arg0: &mut AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        authenticate_admin(arg0, arg2);
        assert!(!0x2::table::contains<address, bool>(&arg0.whitelisted_addresses, arg1), 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::alreadyWhitelisted());
        0x2::table::add<address, bool>(&mut arg0.whitelisted_addresses, arg1, true);
    }

    fun authenticate(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::admin_access::AdminAccess {
        assert!(0x2::table::contains<address, bool>(&arg0.whitelisted_addresses, 0x2::tx_context::sender(arg1)), 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::unauthorized());
        0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::admin_access::mint()
    }

    fun authenticate_admin(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::unauthorized());
    }

    fun authenticate_pool<T0, T1>(arg0: &0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::PoolCap, arg1: &0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::Pool<T0, T1>) : 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::admin_access::AdminAccess {
        assert!(0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::get_pool_id(arg0) == 0x2::object::id<0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::Pool<T0, T1>>(arg1), 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::unauthorized());
        0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::admin_access::mint()
    }

    public entry fun claim_fees<T0, T1>(arg0: &mut 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::Pool<T0, T1>, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = authenticate(arg1, arg4);
        let (v1, v2) = 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::claim_fee<T0, T1>(arg0, arg2, arg3, &v0, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg4));
        0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::admin_access::burn(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<address, bool>(arg0);
        0x2::table::add<address, bool>(&mut v0, 0x2::tx_context::sender(arg0), true);
        let v1 = AdminCap{
            id                    : 0x2::object::new(arg0),
            admin                 : 0x2::tx_context::sender(arg0),
            whitelisted_addresses : v0,
        };
        0x2::transfer::share_object<AdminCap>(v1);
    }

    public entry fun remove_whitelisted_address_config(arg0: &mut AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        authenticate_admin(arg0, arg2);
        assert!(arg0.admin != arg1, 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::removeAdminNotAllowed());
        assert!(0x2::table::contains<address, bool>(&arg0.whitelisted_addresses, arg1), 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::alreadyWhitelisted());
        0x2::table::remove<address, bool>(&mut arg0.whitelisted_addresses, arg1);
    }

    public entry fun update_default_stable_fee(arg0: &mut 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::default_config::DefaultConfig, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = authenticate(arg1, arg5);
        0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::default_config::set_stable_fees(arg0, arg2, arg3, arg4, &v0);
        0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::admin_access::burn(v0);
    }

    public entry fun update_default_uc_fee(arg0: &mut 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::default_config::DefaultConfig, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = authenticate(arg1, arg7);
        0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::default_config::set_uc_fees(arg0, arg2, arg3, arg4, arg5, arg6, &v0);
        0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::admin_access::burn(v0);
    }

    public entry fun update_pool_fee<T0, T1>(arg0: &0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::PoolCap, arg1: &mut 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::Pool<T0, T1>, arg2: u64, arg3: &0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::default_config::DefaultConfig, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = authenticate_pool<T0, T1>(arg0, arg1);
        let (v1, v2) = 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::default_config::fee(arg3, 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::is_stable<T0, T1>(arg1), arg2);
        0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::pool::set_fee<T0, T1>(arg1, v1, v2, &v0);
        0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::admin_access::burn(v0);
    }

    // decompiled from Move bytecode v6
}

