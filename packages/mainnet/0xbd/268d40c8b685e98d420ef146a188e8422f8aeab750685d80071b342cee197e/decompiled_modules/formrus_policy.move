module 0xbd268d40c8b685e98d420ef146a188e8422f8aeab750685d80071b342cee197e::formrus_policy {
    struct AccessPolicy has key {
        id: 0x2::object::UID,
        forms: 0x2::table::Table<vector<u8>, FormAccess>,
    }

    struct FormAccess has store {
        creator: address,
        admins: 0x2::vec_set::VecSet<address>,
    }

    struct FormRegistered has copy, drop {
        form_id: vector<u8>,
        creator: address,
    }

    struct FormAdminAdded has copy, drop {
        form_id: vector<u8>,
        admin: address,
    }

    struct FormAdminRemoved has copy, drop {
        form_id: vector<u8>,
        admin: address,
    }

    public fun add_form_admin(arg0: &mut AccessPolicy, arg1: vector<u8>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<vector<u8>, FormAccess>(&arg0.forms, arg1), 2);
        let v0 = 0x2::table::borrow_mut<vector<u8>, FormAccess>(&mut arg0.forms, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.creator, 3);
        if (!0x2::vec_set::contains<address>(&v0.admins, &arg2)) {
            0x2::vec_set::insert<address>(&mut v0.admins, arg2);
            let v1 = FormAdminAdded{
                form_id : arg1,
                admin   : arg2,
            };
            0x2::event::emit<FormAdminAdded>(v1);
        };
    }

    public fun form_creator(arg0: &AccessPolicy, arg1: vector<u8>) : address {
        assert!(0x2::table::contains<vector<u8>, FormAccess>(&arg0.forms, arg1), 2);
        0x2::table::borrow<vector<u8>, FormAccess>(&arg0.forms, arg1).creator
    }

    public fun form_exists(arg0: &AccessPolicy, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, FormAccess>(&arg0.forms, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AccessPolicy{
            id    : 0x2::object::new(arg0),
            forms : 0x2::table::new<vector<u8>, FormAccess>(arg0),
        };
        0x2::transfer::share_object<AccessPolicy>(v0);
    }

    public fun is_form_admin(arg0: &AccessPolicy, arg1: vector<u8>, arg2: address) : bool {
        if (!0x2::table::contains<vector<u8>, FormAccess>(&arg0.forms, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<vector<u8>, FormAccess>(&arg0.forms, arg1);
        v0.creator == arg2 || 0x2::vec_set::contains<address>(&v0.admins, &arg2)
    }

    public fun register_form(arg0: &mut AccessPolicy, arg1: vector<u8>, arg2: vector<address>, arg3: &0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<vector<u8>, FormAccess>(&arg0.forms, arg1), 1);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v1, v0);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v2 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::vec_set::contains<address>(&v1, &v2)) {
                0x2::vec_set::insert<address>(&mut v1, v2);
            };
            let v3 = FormAdminAdded{
                form_id : arg1,
                admin   : v2,
            };
            0x2::event::emit<FormAdminAdded>(v3);
        };
        let v4 = FormAccess{
            creator : v0,
            admins  : v1,
        };
        0x2::table::add<vector<u8>, FormAccess>(&mut arg0.forms, arg1, v4);
        let v5 = FormRegistered{
            form_id : arg1,
            creator : v0,
        };
        0x2::event::emit<FormRegistered>(v5);
    }

    public fun remove_form_admin(arg0: &mut AccessPolicy, arg1: vector<u8>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<vector<u8>, FormAccess>(&arg0.forms, arg1), 2);
        let v0 = 0x2::table::borrow_mut<vector<u8>, FormAccess>(&mut arg0.forms, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.creator, 3);
        assert!(arg2 != v0.creator, 4);
        if (0x2::vec_set::contains<address>(&v0.admins, &arg2)) {
            0x2::vec_set::remove<address>(&mut v0.admins, &arg2);
            let v1 = FormAdminRemoved{
                form_id : arg1,
                admin   : arg2,
            };
            0x2::event::emit<FormAdminRemoved>(v1);
        };
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &AccessPolicy, arg2: &0x2::tx_context::TxContext) {
        assert!(is_form_admin(arg1, arg0, 0x2::tx_context::sender(arg2)), 5);
    }

    // decompiled from Move bytecode v6
}

