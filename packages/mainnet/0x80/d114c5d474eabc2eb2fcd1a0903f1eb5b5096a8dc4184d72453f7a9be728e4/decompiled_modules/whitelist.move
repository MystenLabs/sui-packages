module 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::whitelist {
    struct WhiteUserInfo has copy, drop, store {
        safe_purchased_amount: u64,
        safe_limit_amount: u64,
    }

    struct WhiteList has store, key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, WhiteUserInfo>,
        purchase_total: u64,
        hard_cap_total: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : WhiteList {
        WhiteList{
            id             : 0x2::object::new(arg0),
            users          : 0x2::table::new<address, WhiteUserInfo>(arg0),
            purchase_total : 0,
            hard_cap_total : 0,
        }
    }

    public(friend) fun add_user_to_whitelist(arg0: &mut WhiteList, arg1: address, arg2: u64) {
        assert!(!0x2::table::contains<address, WhiteUserInfo>(&mut arg0.users, arg1), 3);
        let v0 = WhiteUserInfo{
            safe_purchased_amount : 0,
            safe_limit_amount     : arg2,
        };
        0x2::table::add<address, WhiteUserInfo>(&mut arg0.users, arg1, v0);
    }

    public(friend) fun add_users_to_whitelist(arg0: &mut WhiteList, arg1: vector<address>, arg2: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = 0x1::vector::borrow<address>(&arg1, v0);
            if (!0x2::table::contains<address, WhiteUserInfo>(&mut arg0.users, *v1)) {
                let v2 = WhiteUserInfo{
                    safe_purchased_amount : 0,
                    safe_limit_amount     : arg2,
                };
                0x2::table::add<address, WhiteUserInfo>(&mut arg0.users, *v1, v2);
            };
            v0 = v0 + 1;
        };
    }

    public(friend) fun get_purchase_total(arg0: &WhiteList) : u64 {
        arg0.purchase_total
    }

    public(friend) fun get_whitelist_user_safe_purchased(arg0: &WhiteList, arg1: address) : u64 {
        if (0x2::table::contains<address, WhiteUserInfo>(&arg0.users, arg1)) {
            0x2::table::borrow<address, WhiteUserInfo>(&arg0.users, arg1).safe_purchased_amount
        } else {
            0
        }
    }

    public(friend) fun increse_white_list_purchase_total(arg0: &mut WhiteList, arg1: u64, arg2: address) {
        if (is_useful_white_list_member(arg0, arg2)) {
            let v0 = 0x2::table::borrow_mut<address, WhiteUserInfo>(&mut arg0.users, arg2);
            let v1 = arg0.hard_cap_total - arg0.purchase_total;
            let v2 = if (arg1 <= v1) {
                arg1
            } else {
                v1
            };
            arg0.purchase_total = arg0.purchase_total - v0.safe_purchased_amount;
            let v3 = if (v0.safe_purchased_amount + v2 <= v0.safe_limit_amount) {
                v0.safe_purchased_amount + v2
            } else {
                v0.safe_limit_amount
            };
            v0.safe_purchased_amount = v3;
            arg0.purchase_total = arg0.purchase_total + v0.safe_purchased_amount;
        };
    }

    public(friend) fun is_useful_white_list_member(arg0: &WhiteList, arg1: address) : bool {
        0x2::table::contains<address, WhiteUserInfo>(&arg0.users, arg1) && arg0.hard_cap_total > 0 && whitelist_user_safe_limit(arg0, arg1) > 0
    }

    public(friend) fun remove_user_from_whitelist(arg0: &mut WhiteList, arg1: address) {
        assert!(0x2::table::contains<address, WhiteUserInfo>(&mut arg0.users, arg1), 1);
        assert!(0x2::table::borrow<address, WhiteUserInfo>(&arg0.users, arg1).safe_purchased_amount == 0, 2);
        0x2::table::remove<address, WhiteUserInfo>(&mut arg0.users, arg1);
    }

    public(friend) fun update_hard_cap_total(arg0: &mut WhiteList, arg1: u64) {
        arg0.hard_cap_total = arg1;
    }

    public(friend) fun update_whitelist_user_safe_limit_amount(arg0: &mut WhiteList, arg1: address, arg2: u64) {
        assert!(0x2::table::contains<address, WhiteUserInfo>(&arg0.users, arg1), 1);
        0x2::table::borrow_mut<address, WhiteUserInfo>(&mut arg0.users, arg1).safe_limit_amount = arg2;
    }

    fun whitelist_user_safe_limit(arg0: &WhiteList, arg1: address) : u64 {
        0x2::table::borrow<address, WhiteUserInfo>(&arg0.users, arg1).safe_limit_amount
    }

    // decompiled from Move bytecode v6
}

