module 0xbc8fc491364d1bafe6602a2c0ff0a60ee7c5fe776d0e5849363c7c35d30197db::pressing {
    struct PressingKey has copy, drop, store {
        pos0: u16,
    }

    struct PressingAdminCapKey has copy, drop, store {
        dummy_field: bool,
    }

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

    struct PressingCreatedEvent has copy, drop {
        pressing_id: address,
        release_id: address,
        pressing_admin_cap_id: address,
        release_admin_cap_id: address,
        edition: u16,
        supply: u32,
        max_supply: u32,
        distributors: vector<0x1::ascii::String>,
    }

    struct RecordPurchasedEvent<phantom T0: drop, phantom T1> has copy, drop {
        record_id: address,
        release_id: address,
        pressing_id: address,
        edition: u16,
        number: u32,
        purchase_price: u64,
        purchased_by: address,
        purchased_timestamp_ms: u64,
        supply_before: u32,
        supply_delta: u32,
        supply_after: u32,
        max_supply: u32,
    }

    struct PressingDistributorAuthorizedEvent<phantom T0: drop> has copy, drop {
        pressing_id: address,
        release_id: address,
        edition: u16,
        pressing_admin_cap_id: address,
        authorized_before: bool,
        authorized_after: bool,
        distributor_count_before: u64,
        distributor_count_after: u64,
    }

    struct PressingDistributorRevokedEvent<phantom T0: drop> has copy, drop {
        pressing_id: address,
        release_id: address,
        edition: u16,
        pressing_admin_cap_id: address,
        authorized_before: bool,
        authorized_after: bool,
        distributor_count_before: u64,
        distributor_count_after: u64,
    }

    public fun derive_address(arg0: 0x2::object::ID, arg1: u16) : address {
        let v0 = PressingKey{pos0: arg1};
        0x2::derived_object::derive_address<PressingKey>(arg0, v0)
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
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.distributors, &v0)) {
            let v1 = 0x2::object::uid_to_inner(&arg0.id);
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.distributors, v0);
            let v2 = PressingDistributorAuthorizedEvent<T0>{
                pressing_id              : 0x2::object::id_to_address(&v1),
                release_id               : 0x2::object::id_to_address(&arg0.release_id),
                edition                  : arg0.edition,
                pressing_admin_cap_id    : 0x2::object::id_address<PressingAdminCap>(arg1),
                authorized_before        : false,
                authorized_after         : true,
                distributor_count_before : 0x2::vec_set::length<0x1::type_name::TypeName>(&arg0.distributors),
                distributor_count_after  : 0x2::vec_set::length<0x1::type_name::TypeName>(&arg0.distributors),
            };
            0x2::event::emit<PressingDistributorAuthorizedEvent<T0>>(v2);
        };
    }

    public fun derive_admin_cap_address(arg0: 0x2::object::ID) : address {
        let v0 = PressingAdminCapKey{dummy_field: false};
        0x2::derived_object::derive_address<PressingAdminCapKey>(arg0, v0)
    }

    fun distributor_names(arg0: &Pressing) : vector<0x1::ascii::String> {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.distributors);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, 0x1::type_name::into_string(*0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2)));
            v2 = v2 + 1;
        };
        v0
    }

    public fun distributors(arg0: &Pressing) : &vector<0x1::type_name::TypeName> {
        0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.distributors)
    }

    public fun edition(arg0: &Pressing) : u16 {
        arg0.edition
    }

    public fun is_distributor_authorized<T0: drop>(arg0: &Pressing) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.distributors, &v0)
    }

    public fun max_supply(arg0: &Pressing) : u32 {
        arg0.max_supply
    }

    public fun mint<T0: drop, T1>(arg0: &mut Pressing, arg1: T0, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xbc8fc491364d1bafe6602a2c0ff0a60ee7c5fe776d0e5849363c7c35d30197db::record::Record {
        assert!(is_distributor_authorized<T0>(arg0), 3);
        assert!(arg2 > 0, 5);
        assert!(arg0.supply < arg0.max_supply, 4);
        arg0.supply = arg0.supply + 1;
        let v0 = 0xbc8fc491364d1bafe6602a2c0ff0a60ee7c5fe776d0e5849363c7c35d30197db::record::new<T1>(&mut arg0.id, arg0.release_id, arg0.edition, arg0.supply, arg2, arg3, arg4);
        let v1 = 0x2::object::id<0xbc8fc491364d1bafe6602a2c0ff0a60ee7c5fe776d0e5849363c7c35d30197db::record::Record>(&v0);
        let v2 = 0xbc8fc491364d1bafe6602a2c0ff0a60ee7c5fe776d0e5849363c7c35d30197db::record::release_id(&v0);
        let v3 = 0xbc8fc491364d1bafe6602a2c0ff0a60ee7c5fe776d0e5849363c7c35d30197db::record::pressing_id(&v0);
        let v4 = RecordPurchasedEvent<T0, T1>{
            record_id              : 0x2::object::id_to_address(&v1),
            release_id             : 0x2::object::id_to_address(&v2),
            pressing_id            : 0x2::object::id_to_address(&v3),
            edition                : 0xbc8fc491364d1bafe6602a2c0ff0a60ee7c5fe776d0e5849363c7c35d30197db::record::edition(&v0),
            number                 : 0xbc8fc491364d1bafe6602a2c0ff0a60ee7c5fe776d0e5849363c7c35d30197db::record::number(&v0),
            purchase_price         : 0xbc8fc491364d1bafe6602a2c0ff0a60ee7c5fe776d0e5849363c7c35d30197db::record::purchase_price(&v0),
            purchased_by           : 0xbc8fc491364d1bafe6602a2c0ff0a60ee7c5fe776d0e5849363c7c35d30197db::record::purchased_by(&v0),
            purchased_timestamp_ms : 0xbc8fc491364d1bafe6602a2c0ff0a60ee7c5fe776d0e5849363c7c35d30197db::record::purchased_timestamp_ms(&v0),
            supply_before          : arg0.supply,
            supply_delta           : 1,
            supply_after           : arg0.supply,
            max_supply             : arg0.max_supply,
        };
        0x2::event::emit<RecordPurchasedEvent<T0, T1>>(v4);
        v0
    }

    public fun new(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap, arg2: u16, arg3: u32) : (Pressing, PressingAdminCap) {
        assert!(arg2 > 0, 1);
        assert!(arg3 > 0, 2);
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release>(arg0);
        let v1 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid_mut(arg0, arg1);
        if (arg2 > 1) {
            let v2 = PressingKey{pos0: arg2 - 1};
            assert!(0x2::derived_object::exists<PressingKey>(v1, v2), 6);
        };
        let v3 = PressingKey{pos0: arg2};
        let v4 = 0x2::derived_object::claim<PressingKey>(v1, v3);
        let v5 = 0x2::object::uid_to_inner(&v4);
        let v6 = PressingAdminCapKey{dummy_field: false};
        let v7 = PressingAdminCap{
            id          : 0x2::derived_object::claim<PressingAdminCapKey>(&mut v4, v6),
            pressing_id : v5,
        };
        let v8 = Pressing{
            id           : v4,
            release_id   : v0,
            edition      : arg2,
            supply       : 0,
            max_supply   : arg3,
            distributors : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v9 = PressingCreatedEvent{
            pressing_id           : 0x2::object::id_to_address(&v5),
            release_id            : 0x2::object::id_to_address(&v0),
            pressing_admin_cap_id : 0x2::object::id_address<PressingAdminCap>(&v7),
            release_admin_cap_id  : 0x2::object::id_address<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap>(arg1),
            edition               : v8.edition,
            supply                : v8.supply,
            max_supply            : v8.max_supply,
            distributors          : distributor_names(&v8),
        };
        0x2::event::emit<PressingCreatedEvent>(v9);
        (v8, v7)
    }

    public fun pressing_id(arg0: &PressingAdminCap) : 0x2::object::ID {
        arg0.pressing_id
    }

    public fun release_id(arg0: &Pressing) : 0x2::object::ID {
        arg0.release_id
    }

    public fun revoke_distributor<T0: drop>(arg0: &mut Pressing, arg1: &PressingAdminCap) {
        authorize(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.distributors, &v0)) {
            let v1 = 0x2::object::uid_to_inner(&arg0.id);
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.distributors, &v0);
            let v2 = PressingDistributorRevokedEvent<T0>{
                pressing_id              : 0x2::object::id_to_address(&v1),
                release_id               : 0x2::object::id_to_address(&arg0.release_id),
                edition                  : arg0.edition,
                pressing_admin_cap_id    : 0x2::object::id_address<PressingAdminCap>(arg1),
                authorized_before        : true,
                authorized_after         : false,
                distributor_count_before : 0x2::vec_set::length<0x1::type_name::TypeName>(&arg0.distributors),
                distributor_count_after  : 0x2::vec_set::length<0x1::type_name::TypeName>(&arg0.distributors),
            };
            0x2::event::emit<PressingDistributorRevokedEvent<T0>>(v2);
        };
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

