module 0x45f7c2738204fea5f9c28627b120970463cf6b463d6d07f3b773166d5d3961ca::account_cap_store {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct AccountCapStore<phantom T0> has store, key {
        id: 0x2::object::UID,
        account_cap_table: 0x2::table::Table<address, 0x2::object::ID>,
    }

    public fun admin_set(arg0: &mut AccountCapStore<0xdee9::custodian::AccountCap>, arg1: address, arg2: 0x2::object::ID, arg3: &AdminCap) {
        admin_set_(arg0, arg1, arg2, arg3);
    }

    fun admin_set_(arg0: &mut AccountCapStore<0xdee9::custodian::AccountCap>, arg1: address, arg2: 0x2::object::ID, arg3: &AdminCap) {
        if (exists_(arg0, arg1)) {
            0x2::table::borrow_mut<address, 0x2::object::ID>(&mut arg0.account_cap_table, arg1);
        } else {
            0x2::table::add<address, 0x2::object::ID>(&mut arg0.account_cap_table, arg1, arg2);
        };
    }

    public fun entry_exists(arg0: &AccountCapStore<0xdee9::custodian::AccountCap>, arg1: address) : bool {
        exists_(arg0, arg1)
    }

    fun exists_(arg0: &AccountCapStore<0xdee9::custodian::AccountCap>, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.account_cap_table, arg1)
    }

    public fun get(arg0: &AccountCapStore<0xdee9::custodian::AccountCap>, arg1: address) : 0x2::object::ID {
        get_(arg0, arg1)
    }

    fun get_(arg0: &AccountCapStore<0xdee9::custodian::AccountCap>, arg1: address) : 0x2::object::ID {
        assert!(exists_(arg0, arg1), 0);
        *0x2::table::borrow<address, 0x2::object::ID>(&arg0.account_cap_table, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = AccountCapStore<0xdee9::custodian::AccountCap>{
            id                : 0x2::object::new(arg0),
            account_cap_table : 0x2::table::new<address, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<AccountCapStore<0xdee9::custodian::AccountCap>>(v1);
    }

    public fun set(arg0: &mut AccountCapStore<0xdee9::custodian::AccountCap>, arg1: &0xdee9::custodian::AccountCap, arg2: &mut 0x2::tx_context::TxContext) {
        set_(arg0, arg1, arg2);
    }

    fun set_(arg0: &mut AccountCapStore<0xdee9::custodian::AccountCap>, arg1: &0xdee9::custodian::AccountCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::table::contains<address, 0x2::object::ID>(&arg0.account_cap_table, v0);
        if (exists_(arg0, v0)) {
            0x2::table::borrow_mut<address, 0x2::object::ID>(&mut arg0.account_cap_table, v0);
        } else {
            0x2::table::add<address, 0x2::object::ID>(&mut arg0.account_cap_table, v0, 0x2::object::id<0xdee9::custodian::AccountCap>(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

