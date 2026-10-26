module 0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company {
    struct Company has key {
        id: 0x2::object::UID,
        admins: vector<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>,
        leads: vector<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>,
        members: vector<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>,
        viewers: vector<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>,
    }

    public fun add_admin(arg0: &mut Company, arg1: 0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert!(!is_admin(arg0, 0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::member_address(&arg1)), 1);
        let v0 = take_previous_role(arg0, arg1);
        0x1::vector::push_back<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>(&mut arg0.admins, v0);
    }

    public fun add_lead(arg0: &mut Company, arg1: 0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert!(!is_lead(arg0, 0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::member_address(&arg1)), 4);
        let v0 = take_previous_role(arg0, arg1);
        0x1::vector::push_back<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>(&mut arg0.leads, v0);
    }

    public fun add_member(arg0: &mut Company, arg1: 0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member, arg2: &0x2::tx_context::TxContext) {
        assert_admin_or_lead(arg0, arg2);
        assert!(!is_member(arg0, 0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::member_address(&arg1)), 6);
        if (is_admin(arg0, 0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::member_address(&arg1)) || is_lead(arg0, 0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::member_address(&arg1))) {
            assert_admin(arg0, arg2);
        };
        let v0 = take_previous_role(arg0, arg1);
        0x1::vector::push_back<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>(&mut arg0.members, v0);
    }

    public fun add_viewer(arg0: &mut Company, arg1: 0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert!(!is_viewer(arg0, 0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::member_address(&arg1)), 10);
        let v0 = take_previous_role(arg0, arg1);
        0x1::vector::push_back<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>(&mut arg0.viewers, v0);
    }

    public fun admins(arg0: &Company) : &vector<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member> {
        &arg0.admins
    }

    public fun assert_admin(arg0: &Company, arg1: &0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg1)), 0);
    }

    public fun assert_admin_or_lead(arg0: &Company, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(is_admin(arg0, v0) || is_lead(arg0, v0), 8);
    }

    public fun assert_company_member(arg0: &Company, arg1: address) {
        assert!(!is_viewer(arg0, arg1), 12);
        let v0 = if (is_member(arg0, arg1)) {
            true
        } else if (is_lead(arg0, arg1)) {
            true
        } else {
            is_admin(arg0, arg1)
        };
        assert!(v0, 7);
    }

    fun find_address(arg0: &vector<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>, arg1: address) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>(arg0)) {
            if (0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::member_address(0x1::vector::borrow<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>(arg0, v0)) == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>();
        0x1::vector::push_back<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>(&mut v0, 0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::new(0x1::string::utf8(b"DEPLOYER"), 0x2::tx_context::sender(arg0)));
        let v1 = Company{
            id      : 0x2::object::new(arg0),
            admins  : v0,
            leads   : 0x1::vector::empty<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>(),
            members : 0x1::vector::empty<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>(),
            viewers : 0x1::vector::empty<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>(),
        };
        0x2::transfer::share_object<Company>(v1);
    }

    public fun is_admin(arg0: &Company, arg1: address) : bool {
        let (v0, _) = find_address(&arg0.admins, arg1);
        v0
    }

    public fun is_lead(arg0: &Company, arg1: address) : bool {
        let (v0, _) = find_address(&arg0.leads, arg1);
        v0
    }

    public fun is_member(arg0: &Company, arg1: address) : bool {
        let (v0, _) = find_address(&arg0.members, arg1);
        v0
    }

    public fun is_viewer(arg0: &Company, arg1: address) : bool {
        let (v0, _) = find_address(&arg0.viewers, arg1);
        v0
    }

    public fun leads(arg0: &Company) : &vector<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member> {
        &arg0.leads
    }

    public fun members(arg0: &Company) : &vector<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member> {
        &arg0.members
    }

    public fun remove_admin(arg0: &mut Company, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        let (v0, v1) = find_address(&arg0.admins, arg1);
        assert!(v0, 2);
        assert!(0x1::vector::length<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>(&arg0.admins) > 1, 3);
        0x1::vector::remove<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>(&mut arg0.admins, v1);
    }

    public fun remove_lead(arg0: &mut Company, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        let (v0, v1) = find_address(&arg0.leads, arg1);
        assert!(v0, 5);
        0x1::vector::remove<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>(&mut arg0.leads, v1);
    }

    public fun remove_member(arg0: &mut Company, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        let (v0, v1) = find_address(&arg0.members, arg1);
        assert!(v0, 7);
        0x1::vector::remove<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>(&mut arg0.members, v1);
    }

    public fun remove_viewer(arg0: &mut Company, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        let (v0, v1) = find_address(&arg0.viewers, arg1);
        assert!(v0, 11);
        0x1::vector::remove<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>(&mut arg0.viewers, v1);
    }

    fun take_previous_role(arg0: &mut Company, arg1: 0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member) : 0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member {
        let v0 = 0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::member_address(&arg1);
        let (v1, v2) = find_address(&arg0.admins, v0);
        if (v1) {
            assert!(0x1::vector::length<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>(&arg0.admins) > 1, 3);
            return 0x1::vector::remove<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>(&mut arg0.admins, v2)
        };
        let (v3, v4) = find_address(&arg0.leads, v0);
        if (v3) {
            return 0x1::vector::remove<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>(&mut arg0.leads, v4)
        };
        let (v5, v6) = find_address(&arg0.members, v0);
        if (v5) {
            return 0x1::vector::remove<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>(&mut arg0.members, v6)
        };
        let (v7, v8) = find_address(&arg0.viewers, v0);
        if (v7) {
            return 0x1::vector::remove<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>(&mut arg0.viewers, v8)
        };
        arg1
    }

    public(friend) fun uid_mut(arg0: &mut Company) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun update_member_name(arg0: &mut Company, arg1: address, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = if (is_admin(arg0, v0)) {
            true
        } else if (is_lead(arg0, v0)) {
            true
        } else {
            v0 == arg1
        };
        assert!(v1, 9);
        let v2 = if (is_admin(arg0, arg1)) {
            true
        } else if (is_lead(arg0, arg1)) {
            true
        } else if (is_member(arg0, arg1)) {
            true
        } else {
            is_viewer(arg0, arg1)
        };
        assert!(v2, 7);
        let v3 = &mut arg0.admins;
        update_role_name(v3, arg1, arg2);
        let v4 = &mut arg0.leads;
        update_role_name(v4, arg1, arg2);
        let v5 = &mut arg0.members;
        update_role_name(v5, arg1, arg2);
        let v6 = &mut arg0.viewers;
        update_role_name(v6, arg1, arg2);
    }

    public fun update_member_url(arg0: &mut Company, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let (v1, v2) = find_address(&arg0.admins, v0);
        if (v1) {
            0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::update_url(0x1::vector::borrow_mut<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>(&mut arg0.admins, v2), arg1, arg2);
            return
        };
        let (v3, v4) = find_address(&arg0.leads, v0);
        if (v3) {
            0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::update_url(0x1::vector::borrow_mut<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>(&mut arg0.leads, v4), arg1, arg2);
            return
        };
        let (v5, v6) = find_address(&arg0.members, v0);
        if (v5) {
            0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::update_url(0x1::vector::borrow_mut<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>(&mut arg0.members, v6), arg1, arg2);
            return
        };
        let (v7, v8) = find_address(&arg0.viewers, v0);
        assert!(v7, 7);
        0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::update_url(0x1::vector::borrow_mut<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>(&mut arg0.viewers, v8), arg1, arg2);
    }

    fun update_role_name(arg0: &mut vector<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>, arg1: address, arg2: 0x1::string::String) {
        let (v0, v1) = find_address(arg0, arg1);
        if (v0) {
            0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::set_name(0x1::vector::borrow_mut<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member>(arg0, v1), arg2);
        };
    }

    public fun viewers(arg0: &Company) : &vector<0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member::Member> {
        &arg0.viewers
    }

    // decompiled from Move bytecode v7
}

