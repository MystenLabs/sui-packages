module 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::cap_revocation {
    struct CapRevocationRegistry has key {
        id: 0x2::object::UID,
        revoked: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct CapRevoked has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct CapUnrevoked has copy, drop {
        cap_id: 0x2::object::ID,
    }

    public fun assert_not_revoked(arg0: &CapRevocationRegistry, arg1: 0x2::object::ID) {
        assert!(!is_revoked(arg0, arg1), 1100);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CapRevocationRegistry{
            id      : 0x2::object::new(arg0),
            revoked : 0x2::table::new<0x2::object::ID, bool>(arg0),
        };
        0x2::transfer::share_object<CapRevocationRegistry>(v0);
    }

    public fun is_revoked(arg0: &CapRevocationRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.revoked, arg1)
    }

    public fun revoke(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut CapRevocationRegistry, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::verify_authority_only(arg0, arg3);
        if (!0x2::table::contains<0x2::object::ID, bool>(&arg1.revoked, arg2)) {
            0x2::table::add<0x2::object::ID, bool>(&mut arg1.revoked, arg2, true);
            let v0 = CapRevoked{cap_id: arg2};
            0x2::event::emit<CapRevoked>(v0);
        };
    }

    public fun unrevoke(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut CapRevocationRegistry, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::version_check(arg0);
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::verify(arg0, arg3);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg1.revoked, arg2)) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg1.revoked, arg2);
            let v0 = CapUnrevoked{cap_id: arg2};
            0x2::event::emit<CapUnrevoked>(v0);
        };
    }

    // decompiled from Move bytecode v7
}

