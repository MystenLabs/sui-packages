module 0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::pool {
    struct IronBankPool has key {
        id: 0x2::object::UID,
        inner: 0x2::versioned::Versioned,
    }

    struct PoolInner has store {
        allowed_versions: 0x2::vec_set::VecSet<u64>,
        principal_vault: 0x2::balance::Balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>,
        incentive_vault: 0x2::balance::Balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>,
        entities: 0x2::table::Table<0x1::type_name::TypeName, Entity>,
        active_entities: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct Entity has drop, store {
        principal: u64,
        unclaimed_incentives: u64,
    }

    public fun active_entity_count(arg0: &IronBankPool) : u64 {
        0x2::vec_set::length<0x1::type_name::TypeName>(&load_inner(arg0).active_entities)
    }

    public fun claim_incentives<T0: drop>(arg0: &mut IronBankPool, arg1: &0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::registry::IronBankRegistry, arg2: T0, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI> {
        0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::registry::assert_entity_registered<T0>(arg1);
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = load_inner_mut(arg0);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Entity>(&v1.entities, v2), 13906835346869714949);
        let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Entity>(&mut v1.entities, v2);
        let v4 = v3.unclaimed_incentives;
        assert!(v4 > 0, 13906835364049846281);
        v3.unclaimed_incentives = 0;
        0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::events::emit_incentives_claimed(v0, v2, v4, 0x2::clock::timestamp_ms(arg3));
        0x2::coin::from_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(0x2::balance::split<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v1.incentive_vault, v4), arg4)
    }

    fun create_entity(arg0: &mut PoolInner, arg1: 0x1::type_name::TypeName) {
        if (!0x2::table::contains<0x1::type_name::TypeName, Entity>(&arg0.entities, arg1)) {
            let v0 = Entity{
                principal            : 0,
                unclaimed_incentives : 0,
            };
            0x2::table::add<0x1::type_name::TypeName, Entity>(&mut arg0.entities, arg1, v0);
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.active_entities, arg1);
        };
    }

    public fun deposit_entity_incentives<T0: drop>(arg0: &mut IronBankPool, arg1: &0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::registry::IronBankAdminCap, arg2: &0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::registry::IronBankRegistry, arg3: 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>, arg4: &0x2::clock::Clock) {
        0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::registry::assert_entity_enabled<T0>(arg2);
        let v0 = 0x2::coin::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg3);
        assert!(v0 > 0, 13906835183660695553);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = load_inner_mut(arg0);
        let v3 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Entity>(&v2.entities, v3), 13906835213725728773);
        let v4 = 0x2::table::borrow<0x1::type_name::TypeName, Entity>(&v2.entities, v3).principal;
        assert!(v4 > 0, 13906835222315794439);
        0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::registry::assert_incentive_within_ratio(arg2, v0, v4);
        0x2::balance::join<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v2.incentive_vault, 0x2::coin::into_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(arg3));
        let v5 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Entity>(&mut v2.entities, v3);
        v5.unclaimed_incentives = v5.unclaimed_incentives + v0;
        0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::events::emit_entity_incentives_deposited(v1, v3, v0, 0x2::clock::timestamp_ms(arg4));
    }

    public fun deposit_incentives(arg0: &mut IronBankPool, arg1: &0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::registry::IronBankAdminCap, arg2: &0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::registry::IronBankRegistry, arg3: 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>, arg4: &0x2::clock::Clock) {
        let v0 = 0x2::coin::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg3);
        assert!(v0 > 0, 13906834981797232641);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = load_inner_mut(arg0);
        let v3 = *0x2::vec_set::keys<0x1::type_name::TypeName>(&v2.active_entities);
        let v4 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v5 = 0;
        let v6 = &v3;
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x1::type_name::TypeName>(v6)) {
            let v8 = 0x1::vector::borrow<0x1::type_name::TypeName>(v6, v7);
            if (0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::registry::is_entity_enabled_by_typename(arg2, *v8)) {
                let v9 = 0x2::table::borrow<0x1::type_name::TypeName, Entity>(&v2.entities, *v8).principal;
                if (v9 > 0) {
                    0x1::vector::push_back<0x1::type_name::TypeName>(&mut v4, *v8);
                    v5 = v5 + v9;
                };
            };
            v7 = v7 + 1;
        };
        assert!(v5 > 0, 13906835059107037191);
        0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::registry::assert_incentive_within_ratio(arg2, v0, v5);
        0x2::balance::join<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v2.incentive_vault, 0x2::coin::into_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(arg3));
        let v10 = &v4;
        let v11 = 0;
        while (v11 < 0x1::vector::length<0x1::type_name::TypeName>(v10)) {
            let v12 = 0x1::vector::borrow<0x1::type_name::TypeName>(v10, v11);
            let v13 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Entity>(&mut v2.entities, *v12);
            let v14 = 0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::math::mul_div(v0, v13.principal, v5);
            v13.unclaimed_incentives = v13.unclaimed_incentives + v14;
            0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::events::emit_entity_incentives_deposited(v1, *v12, v14, 0x2::clock::timestamp_ms(arg4));
            v11 = v11 + 1;
        };
    }

    public fun entity_principal<T0: drop>(arg0: &IronBankPool) : u64 {
        let v0 = load_inner(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, Entity>(&v0.entities, v1)) {
            0x2::table::borrow<0x1::type_name::TypeName, Entity>(&v0.entities, v1).principal
        } else {
            0
        }
    }

    public fun entity_supply<T0: drop>(arg0: &mut IronBankPool, arg1: &0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::registry::IronBankRegistry, arg2: T0, arg3: 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>, arg4: &0x2::clock::Clock) {
        0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::registry::assert_entity_enabled<T0>(arg1);
        let v0 = 0x2::coin::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg3);
        assert!(v0 > 0, 13906834706919325697);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = load_inner_mut(arg0);
        let v3 = 0x1::type_name::with_defining_ids<T0>();
        create_entity(v2, v3);
        let v4 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Entity>(&mut v2.entities, v3);
        let v5 = v4.principal + v0;
        0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::registry::assert_within_max_deposit<T0>(arg1, v5);
        v4.principal = v5;
        0x2::balance::join<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v2.principal_vault, 0x2::coin::into_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(arg3));
        0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::events::emit_entity_supplied(v1, v3, v0, v5, 0x2::clock::timestamp_ms(arg4));
    }

    public fun entity_unclaimed_incentives<T0: drop>(arg0: &IronBankPool) : u64 {
        let v0 = load_inner(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, Entity>(&v0.entities, v1)) {
            0x2::table::borrow<0x1::type_name::TypeName, Entity>(&v0.entities, v1).unclaimed_incentives
        } else {
            0
        }
    }

    public fun entity_withdraw<T0: drop>(arg0: &mut IronBankPool, arg1: &0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::registry::IronBankRegistry, arg2: T0, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI> {
        0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::registry::assert_entity_registered<T0>(arg1);
        assert!(arg3 > 0, 13906834840063311873);
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = load_inner_mut(arg0);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Entity>(&v1.entities, v2), 13906834865833377797);
        let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Entity>(&mut v1.entities, v2);
        assert!(v3.principal >= arg3, 13906834878718148611);
        let v4 = v3.principal - arg3;
        v3.principal = v4;
        0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::events::emit_entity_withdrawn(v0, v2, arg3, v4, 0x2::clock::timestamp_ms(arg4));
        0x2::coin::from_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(0x2::balance::split<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v1.principal_vault, arg3), arg5)
    }

    public fun incentive_vault_balance(arg0: &IronBankPool) : u64 {
        0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&load_inner(arg0).incentive_vault)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::constants::current_version();
        let v1 = PoolInner{
            allowed_versions : 0x2::vec_set::singleton<u64>(v0),
            principal_vault  : 0x2::balance::zero<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(),
            incentive_vault  : 0x2::balance::zero<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(),
            entities         : 0x2::table::new<0x1::type_name::TypeName, Entity>(arg0),
            active_entities  : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v2 = IronBankPool{
            id    : 0x2::object::new(arg0),
            inner : 0x2::versioned::create<PoolInner>(v0, v1, arg0),
        };
        0x2::transfer::share_object<IronBankPool>(v2);
    }

    public(friend) fun load_inner(arg0: &IronBankPool) : &PoolInner {
        let v0 = 0x2::versioned::load_value<PoolInner>(&arg0.inner);
        let v1 = 0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::constants::current_version();
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &v1), 13906835531553701899);
        v0
    }

    public(friend) fun load_inner_mut(arg0: &mut IronBankPool) : &mut PoolInner {
        let v0 = 0x2::versioned::load_value_mut<PoolInner>(&mut arg0.inner);
        let v1 = 0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::constants::current_version();
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &v1), 13906835561618472971);
        v0
    }

    public fun total_principal(arg0: &IronBankPool) : u64 {
        0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&load_inner(arg0).principal_vault)
    }

    public fun update_allowed_versions(arg0: &mut IronBankPool, arg1: &0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::registry::IronBankRegistry) {
        0x2::versioned::load_value_mut<PoolInner>(&mut arg0.inner).allowed_versions = 0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::registry::allowed_versions(arg1);
    }

    // decompiled from Move bytecode v7
}

