module 0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin {
    struct OracleAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PriceAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ReferenceAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CapRegistry has key {
        id: 0x2::object::UID,
        current_price_admin_cap_id: 0x2::object::ID,
        current_reference_admin_cap_id: 0x2::object::ID,
    }

    struct PriceAdminCapRevoked has copy, drop {
        old_cap_id: 0x2::object::ID,
        new_cap_id: 0x2::object::ID,
        new_owner: address,
    }

    struct ReferenceAdminCapRevoked has copy, drop {
        old_cap_id: 0x2::object::ID,
        new_cap_id: 0x2::object::ID,
        new_owner: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = OracleAdminCap{id: 0x2::object::new(arg0)};
        let v2 = PriceAdminCap{id: 0x2::object::new(arg0)};
        let v3 = ReferenceAdminCap{id: 0x2::object::new(arg0)};
        let v4 = CapRegistry{
            id                             : 0x2::object::new(arg0),
            current_price_admin_cap_id     : 0x2::object::id<PriceAdminCap>(&v2),
            current_reference_admin_cap_id : 0x2::object::id<ReferenceAdminCap>(&v3),
        };
        0x2::transfer::transfer<OracleAdminCap>(v1, v0);
        0x2::transfer::transfer<PriceAdminCap>(v2, v0);
        0x2::transfer::transfer<ReferenceAdminCap>(v3, v0);
        0x2::transfer::share_object<CapRegistry>(v4);
    }

    public fun is_current_price_admin_cap(arg0: &CapRegistry, arg1: 0x2::object::ID) : bool {
        arg0.current_price_admin_cap_id == arg1
    }

    public fun is_current_reference_admin_cap(arg0: &CapRegistry, arg1: 0x2::object::ID) : bool {
        arg0.current_reference_admin_cap_id == arg1
    }

    public fun revoke_and_reissue_price_admin_cap(arg0: &OracleAdminCap, arg1: &mut CapRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceAdminCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::id<PriceAdminCap>(&v0);
        arg1.current_price_admin_cap_id = v1;
        0x2::transfer::transfer<PriceAdminCap>(v0, arg2);
        let v2 = PriceAdminCapRevoked{
            old_cap_id : arg1.current_price_admin_cap_id,
            new_cap_id : v1,
            new_owner  : arg2,
        };
        0x2::event::emit<PriceAdminCapRevoked>(v2);
    }

    public fun revoke_and_reissue_reference_admin_cap(arg0: &OracleAdminCap, arg1: &mut CapRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ReferenceAdminCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::id<ReferenceAdminCap>(&v0);
        arg1.current_reference_admin_cap_id = v1;
        0x2::transfer::transfer<ReferenceAdminCap>(v0, arg2);
        let v2 = ReferenceAdminCapRevoked{
            old_cap_id : arg1.current_reference_admin_cap_id,
            new_cap_id : v1,
            new_owner  : arg2,
        };
        0x2::event::emit<ReferenceAdminCapRevoked>(v2);
    }

    // decompiled from Move bytecode v7
}

