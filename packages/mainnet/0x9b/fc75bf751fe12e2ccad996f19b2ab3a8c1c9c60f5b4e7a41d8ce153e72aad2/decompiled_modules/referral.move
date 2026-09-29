module 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::referral {
    struct ReferralAdminCap has key {
        id: 0x2::object::UID,
    }

    struct ReferralRegistry has key {
        id: 0x2::object::UID,
        user_to_code: 0x2::table::Table<address, 0x1::string::String>,
        code_to_user: 0x2::table::Table<0x1::string::String, address>,
        user_roles: 0x2::table::Table<address, u8>,
        user_referrer: 0x2::table::Table<address, address>,
    }

    struct CodeRegistered has copy, drop {
        user: address,
        code: 0x1::string::String,
    }

    struct RoleUpdated has copy, drop {
        user: address,
        role: u8,
    }

    struct ReferrerSet has copy, drop {
        user: address,
        referrer: address,
    }

    public(friend) fun add_referrer(arg0: &mut ReferralRegistry, arg1: address, arg2: 0x1::string::String) : address {
        assert!(0x2::table::contains<0x1::string::String, address>(&arg0.code_to_user, arg2), 7);
        let v0 = *0x2::table::borrow<0x1::string::String, address>(&arg0.code_to_user, arg2);
        assert!(v0 != arg1, 6);
        assert!(!0x2::table::contains<address, address>(&arg0.user_referrer, arg1), 8);
        0x2::table::add<address, address>(&mut arg0.user_referrer, arg1, v0);
        let v1 = ReferrerSet{
            user     : arg1,
            referrer : v0,
        };
        0x2::event::emit<ReferrerSet>(v1);
        v0
    }

    entry fun add_users_to_role(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut ReferralRegistry, arg2: vector<address>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_admin(arg0, arg4);
        assert!(arg3 <= 2, 9);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (0x2::table::contains<address, u8>(&arg1.user_roles, v1)) {
                *0x2::table::borrow_mut<address, u8>(&mut arg1.user_roles, v1) = arg3;
            } else {
                0x2::table::add<address, u8>(&mut arg1.user_roles, v1, arg3);
            };
            let v2 = RoleUpdated{
                user : v1,
                role : arg3,
            };
            0x2::event::emit<RoleUpdated>(v2);
            v0 = v0 + 1;
        };
    }

    entry fun add_users_with_specific_roles(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut ReferralRegistry, arg2: vector<address>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_admin(arg0, arg4);
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 == 0x1::vector::length<u8>(&arg3), 5);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v1);
            let v3 = *0x1::vector::borrow<u8>(&arg3, v1);
            if (0x2::table::contains<address, u8>(&arg1.user_roles, v2)) {
                *0x2::table::borrow_mut<address, u8>(&mut arg1.user_roles, v2) = v3;
            } else {
                0x2::table::add<address, u8>(&mut arg1.user_roles, v2, v3);
            };
            let v4 = RoleUpdated{
                user : v2,
                role : v3,
            };
            0x2::event::emit<RoleUpdated>(v4);
            v1 = v1 + 1;
        };
    }

    fun create_hash_code(arg0: address, arg1: u64) : 0x1::string::String {
        let v0 = 0x2::bcs::to_bytes<address>(&arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        let v1 = 0x2::hash::blake2b256(&v0);
        let v2 = b"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        let v3 = b"";
        let v4 = 0;
        while (v4 < 6) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&v2, (*0x1::vector::borrow<u8>(&v1, v4) as u64) % 62));
            v4 = v4 + 1;
        };
        0x1::string::utf8(v3)
    }

    public fun generate_ref_code(arg0: &mut ReferralRegistry, arg1: 0x1::option::Option<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) : (bool, 0x1::option::Option<address>) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x2::table::contains<address, 0x1::string::String>(&arg0.user_to_code, v0)) {
            return (false, 0x1::option::none<address>())
        };
        let v1 = 0;
        let v2 = v1;
        let v3 = create_hash_code(v0, v1);
        while (0x2::table::contains<0x1::string::String, address>(&arg0.code_to_user, v3)) {
            v2 = v2 + 1;
            v3 = create_hash_code(v0, v2);
        };
        if (!0x2::table::contains<address, u8>(&arg0.user_roles, v0)) {
            0x2::table::add<address, u8>(&mut arg0.user_roles, v0, 2);
            let v4 = RoleUpdated{
                user : v0,
                role : 2,
            };
            0x2::event::emit<RoleUpdated>(v4);
        };
        0x2::table::add<address, 0x1::string::String>(&mut arg0.user_to_code, v0, v3);
        0x2::table::add<0x1::string::String, address>(&mut arg0.code_to_user, v3, v0);
        let v5 = CodeRegistered{
            user : v0,
            code : v3,
        };
        0x2::event::emit<CodeRegistered>(v5);
        let v6 = 0x1::option::none<address>();
        if (0x1::option::is_some<0x1::string::String>(&arg1)) {
            let v7 = 0x1::option::destroy_some<0x1::string::String>(arg1);
            if (0x2::table::contains<0x1::string::String, address>(&arg0.code_to_user, v7)) {
                let v8 = *0x2::table::borrow<0x1::string::String, address>(&arg0.code_to_user, v7);
                if (v8 != v0) {
                    v6 = 0x1::option::some<address>(v8);
                    if (!0x2::table::contains<address, address>(&arg0.user_referrer, v0)) {
                        0x2::table::add<address, address>(&mut arg0.user_referrer, v0, v8);
                        let v9 = ReferrerSet{
                            user     : v0,
                            referrer : v8,
                        };
                        0x2::event::emit<ReferrerSet>(v9);
                    };
                };
            };
        };
        (true, v6)
    }

    public fun get_referrer(arg0: &ReferralRegistry, arg1: address) : 0x1::option::Option<address> {
        if (0x2::table::contains<address, address>(&arg0.user_referrer, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<address, address>(&arg0.user_referrer, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun get_user_by_code(arg0: &ReferralRegistry, arg1: 0x1::string::String) : 0x1::option::Option<address> {
        if (0x2::table::contains<0x1::string::String, address>(&arg0.code_to_user, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<0x1::string::String, address>(&arg0.code_to_user, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun get_user_code(arg0: &ReferralRegistry, arg1: address) : 0x1::option::Option<0x1::string::String> {
        if (0x2::table::contains<address, 0x1::string::String>(&arg0.user_to_code, arg1)) {
            0x1::option::some<0x1::string::String>(*0x2::table::borrow<address, 0x1::string::String>(&arg0.user_to_code, arg1))
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    public fun get_user_role(arg0: &ReferralRegistry, arg1: address) : u8 {
        if (0x2::table::contains<address, u8>(&arg0.user_roles, arg1)) {
            *0x2::table::borrow<address, u8>(&arg0.user_roles, arg1)
        } else {
            2
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ReferralAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ReferralAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = ReferralRegistry{
            id            : 0x2::object::new(arg0),
            user_to_code  : 0x2::table::new<address, 0x1::string::String>(arg0),
            code_to_user  : 0x2::table::new<0x1::string::String, address>(arg0),
            user_roles    : 0x2::table::new<address, u8>(arg0),
            user_referrer : 0x2::table::new<address, address>(arg0),
        };
        0x2::transfer::share_object<ReferralRegistry>(v1);
    }

    public fun is_valid_code(arg0: &ReferralRegistry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, address>(&arg0.code_to_user, arg1)
    }

    // decompiled from Move bytecode v7
}

