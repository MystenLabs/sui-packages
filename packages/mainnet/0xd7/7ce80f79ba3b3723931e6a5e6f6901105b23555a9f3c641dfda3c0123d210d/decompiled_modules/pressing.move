module 0xd77ce80f79ba3b3723931e6a5e6f6901105b23555a9f3c641dfda3c0123d210d::pressing {
    struct Pressing has key {
        id: 0x2::object::UID,
        release_id: 0x2::object::ID,
        edition: u16,
        supply: u32,
        max_supply: u32,
        distributors: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct PressingAdminCap has store, key {
        id: 0x2::object::UID,
        pressing_id: 0x2::object::ID,
    }

    struct PressingKey has copy, drop, store {
        pos0: u16,
    }

    struct PressingAdminCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PressingCreatedEvent has copy, drop {
        pressing_id: 0x2::object::ID,
        pressing_admin_cap_id: 0x2::object::ID,
        release_id: 0x2::object::ID,
        edition: u16,
        max_supply: u32,
    }

    struct PressingDistributorAuthorizedEvent<phantom T0> has copy, drop {
        pressing_id: 0x2::object::ID,
    }

    struct PressingDistributorRevokedEvent<phantom T0> has copy, drop {
        pressing_id: 0x2::object::ID,
    }

    public fun derive_address(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg1: u16) : address {
        let v0 = PressingKey{pos0: arg1};
        0x2::derived_object::derive_address<PressingKey>(0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release>(arg0), v0)
    }

    public fun uid_mut(arg0: &mut Pressing, arg1: &PressingAdminCap) : &mut 0x2::object::UID {
        authorize(arg0, arg1);
        &mut arg0.id
    }

    fun authorize(arg0: &Pressing, arg1: &PressingAdminCap) {
        assert!(arg1.pressing_id == 0x2::object::uid_to_inner(&arg0.id), 0);
    }

    public fun authorize_distributor<T0: drop>(arg0: &mut Pressing, arg1: &PressingAdminCap) {
        authorize(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.distributors, &v0), 6);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.distributors, v0);
        let v1 = PressingDistributorAuthorizedEvent<T0>{pressing_id: arg1.pressing_id};
        0x2::event::emit<PressingDistributorAuthorizedEvent<T0>>(v1);
    }

    public fun derive_admin_cap_address(arg0: &Pressing) : address {
        let v0 = PressingAdminCapKey{dummy_field: false};
        0x2::derived_object::derive_address<PressingAdminCapKey>(0x2::object::uid_to_inner(&arg0.id), v0)
    }

    public fun distributors(arg0: &Pressing) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.distributors
    }

    public fun edition(arg0: &Pressing) : u16 {
        arg0.edition
    }

    public fun is_distributor_authorized<T0: drop>(arg0: &Pressing) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.distributors, &v0)
    }

    public(friend) fun issue_number<T0: drop>(arg0: &mut Pressing) : u32 {
        assert!(is_distributor_authorized<T0>(arg0), 3);
        assert!(arg0.supply < arg0.max_supply, 4);
        arg0.supply = arg0.supply + 1;
        arg0.supply
    }

    public fun max_supply(arg0: &Pressing) : u32 {
        arg0.max_supply
    }

    public fun new(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::ReleaseAdminCap, arg2: u16, arg3: u32) : (Pressing, PressingAdminCap) {
        assert!(arg2 > 0, 1);
        assert!(arg3 > 0, 2);
        let v0 = 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release>(arg0);
        let v1 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::uid_mut(arg0, arg1);
        let v2 = if (arg2 == 1) {
            true
        } else {
            let v3 = PressingKey{pos0: arg2 - 1};
            0x2::derived_object::exists<PressingKey>(v1, v3)
        };
        assert!(v2, 5);
        let v4 = PressingKey{pos0: arg2};
        let v5 = 0x2::derived_object::claim<PressingKey>(v1, v4);
        let v6 = 0x2::object::uid_to_inner(&v5);
        let v7 = PressingAdminCapKey{dummy_field: false};
        let v8 = PressingAdminCap{
            id          : 0x2::derived_object::claim<PressingAdminCapKey>(&mut v5, v7),
            pressing_id : v6,
        };
        let v9 = PressingCreatedEvent{
            pressing_id           : v6,
            pressing_admin_cap_id : 0x2::object::id<PressingAdminCap>(&v8),
            release_id            : v0,
            edition               : arg2,
            max_supply            : arg3,
        };
        0x2::event::emit<PressingCreatedEvent>(v9);
        let v10 = Pressing{
            id           : v5,
            release_id   : v0,
            edition      : arg2,
            supply       : 0,
            max_supply   : arg3,
            distributors : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        (v10, v8)
    }

    public(friend) fun package_uid_mut(arg0: &mut Pressing) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun pressing_admin_cap_pressing_id(arg0: &PressingAdminCap) : 0x2::object::ID {
        arg0.pressing_id
    }

    public fun release_id(arg0: &Pressing) : 0x2::object::ID {
        arg0.release_id
    }

    public fun revoke_distributor<T0: drop>(arg0: &mut Pressing, arg1: &PressingAdminCap) {
        authorize(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.distributors, &v0), 3);
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.distributors, &v0);
        let v1 = PressingDistributorRevokedEvent<T0>{pressing_id: arg1.pressing_id};
        0x2::event::emit<PressingDistributorRevokedEvent<T0>>(v1);
    }

    public fun share(arg0: Pressing) {
        0x2::transfer::share_object<Pressing>(arg0);
    }

    public fun supply(arg0: &Pressing) : u32 {
        arg0.supply
    }

    public fun uid(arg0: &Pressing) : &0x2::object::UID {
        &arg0.id
    }

    // decompiled from Move bytecode v7
}

