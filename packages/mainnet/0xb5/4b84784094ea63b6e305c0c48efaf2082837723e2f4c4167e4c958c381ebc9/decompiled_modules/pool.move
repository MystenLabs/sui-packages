module 0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::pool {
    struct IronBankPool has key {
        id: 0x2::object::UID,
        inner: 0x2::versioned::Versioned,
    }

    struct PoolInner has store {
        allowed_versions: 0x2::vec_set::VecSet<u64>,
        principal_vault: 0x2::balance::Balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>,
        reward_vault: 0x2::balance::Balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>,
        entities: 0x2::table::Table<0x1::type_name::TypeName, Entity>,
        active_entities: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct Entity has drop, store {
        principal: u64,
        unclaimed_rewards: u64,
    }

    public fun active_entity_count(arg0: &IronBankPool) : u64 {
        0x2::vec_set::length<0x1::type_name::TypeName>(&load_inner(arg0).active_entities)
    }

    public fun claim_rewards<T0: drop>(arg0: &mut IronBankPool, arg1: &0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::registry::IronBankRegistry, arg2: T0, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI> {
        0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::registry::assert_entity_registered<T0>(arg1);
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = load_inner_mut(arg0);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Entity>(&v1.entities, v2), 13906835364049584133);
        let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Entity>(&mut v1.entities, v2);
        let v4 = v3.unclaimed_rewards;
        assert!(v4 > 0, 13906835381229715465);
        v3.unclaimed_rewards = 0;
        0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::events::emit_rewards_claimed(v0, v2, v4, 0x2::clock::timestamp_ms(arg3));
        0x2::coin::from_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(0x2::balance::split<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v1.reward_vault, v4), arg4)
    }

    fun create_entity(arg0: &mut PoolInner, arg1: 0x1::type_name::TypeName) {
        if (!0x2::table::contains<0x1::type_name::TypeName, Entity>(&arg0.entities, arg1)) {
            let v0 = Entity{
                principal         : 0,
                unclaimed_rewards : 0,
            };
            0x2::table::add<0x1::type_name::TypeName, Entity>(&mut arg0.entities, arg1, v0);
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.active_entities, arg1);
        };
    }

    public fun deposit_entity_rewards<T0: drop>(arg0: &mut IronBankPool, arg1: &0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::registry::IronBankRegistry, arg2: 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::registry::assert_entity_enabled<T0>(arg1);
        let v0 = 0x2::coin::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg2);
        assert!(v0 > 0, 13906835196545597441);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = load_inner_mut(arg0);
        let v3 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Entity>(&v2.entities, v3), 13906835230905597957);
        let v4 = 0x2::table::borrow<0x1::type_name::TypeName, Entity>(&v2.entities, v3).principal;
        assert!(v4 > 0, 13906835239495663623);
        0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::registry::assert_reward_within_ratio(arg1, v0, v4);
        0x2::balance::join<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v2.reward_vault, 0x2::coin::into_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(arg2));
        let v5 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Entity>(&mut v2.entities, v3);
        v5.unclaimed_rewards = v5.unclaimed_rewards + v0;
        0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::events::emit_entity_rewards_deposited(v1, v3, 0x2::tx_context::sender(arg4), v0, 0x2::clock::timestamp_ms(arg3));
    }

    public fun deposit_rewards(arg0: &mut IronBankPool, arg1: &0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::registry::IronBankRegistry, arg2: 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg2);
        assert!(v0 > 0, 13906834986092199937);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = load_inner_mut(arg0);
        let v3 = *0x2::vec_set::keys<0x1::type_name::TypeName>(&v2.active_entities);
        let v4 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v5 = 0;
        let v6 = &v3;
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x1::type_name::TypeName>(v6)) {
            let v8 = 0x1::vector::borrow<0x1::type_name::TypeName>(v6, v7);
            if (0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::registry::is_entity_enabled_by_typename(arg1, *v8)) {
                let v9 = 0x2::table::borrow<0x1::type_name::TypeName, Entity>(&v2.entities, *v8).principal;
                if (v9 > 0) {
                    0x1::vector::push_back<0x1::type_name::TypeName>(&mut v4, *v8);
                    v5 = v5 + v9;
                };
            };
            v7 = v7 + 1;
        };
        assert!(v5 > 0, 13906835067696971783);
        0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::registry::assert_reward_within_ratio(arg1, v0, v5);
        0x2::balance::join<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v2.reward_vault, 0x2::coin::into_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(arg2));
        let v10 = &v4;
        let v11 = 0;
        while (v11 < 0x1::vector::length<0x1::type_name::TypeName>(v10)) {
            let v12 = 0x1::vector::borrow<0x1::type_name::TypeName>(v10, v11);
            let v13 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Entity>(&mut v2.entities, *v12);
            let v14 = 0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::math::mul_div(v0, v13.principal, v5);
            v13.unclaimed_rewards = v13.unclaimed_rewards + v14;
            0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::events::emit_entity_rewards_deposited(v1, *v12, 0x2::tx_context::sender(arg4), v14, 0x2::clock::timestamp_ms(arg3));
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

    public fun entity_supply<T0: drop>(arg0: &mut IronBankPool, arg1: &0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::registry::IronBankRegistry, arg2: T0, arg3: 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>, arg4: &0x2::clock::Clock) {
        0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::registry::assert_entity_enabled<T0>(arg1);
        let v0 = 0x2::coin::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg3);
        assert!(v0 > 0, 13906834706919325697);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = load_inner_mut(arg0);
        let v3 = 0x1::type_name::with_defining_ids<T0>();
        create_entity(v2, v3);
        let v4 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Entity>(&mut v2.entities, v3);
        let v5 = v4.principal + v0;
        0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::registry::assert_within_max_deposit<T0>(arg1, v5);
        v4.principal = v5;
        0x2::balance::join<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v2.principal_vault, 0x2::coin::into_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(arg3));
        0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::events::emit_entity_supplied(v1, v3, v0, v5, 0x2::clock::timestamp_ms(arg4));
    }

    public fun entity_unclaimed_rewards<T0: drop>(arg0: &IronBankPool) : u64 {
        let v0 = load_inner(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, Entity>(&v0.entities, v1)) {
            0x2::table::borrow<0x1::type_name::TypeName, Entity>(&v0.entities, v1).unclaimed_rewards
        } else {
            0
        }
    }

    public fun entity_withdraw<T0: drop>(arg0: &mut IronBankPool, arg1: &0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::registry::IronBankRegistry, arg2: T0, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI> {
        0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::registry::assert_entity_registered<T0>(arg1);
        assert!(arg3 > 0, 13906834840063311873);
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = load_inner_mut(arg0);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Entity>(&v1.entities, v2), 13906834865833377797);
        let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Entity>(&mut v1.entities, v2);
        assert!(v3.principal >= arg3, 13906834878718148611);
        let v4 = v3.principal - arg3;
        v3.principal = v4;
        0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::events::emit_entity_withdrawn(v0, v2, arg3, v4, 0x2::clock::timestamp_ms(arg4));
        0x2::coin::from_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(0x2::balance::split<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut v1.principal_vault, arg3), arg5)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::constants::current_version();
        let v1 = PoolInner{
            allowed_versions : 0x2::vec_set::singleton<u64>(v0),
            principal_vault  : 0x2::balance::zero<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(),
            reward_vault     : 0x2::balance::zero<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(),
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
        let v1 = 0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::constants::current_version();
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &v1), 13906835548733571083);
        v0
    }

    public(friend) fun load_inner_mut(arg0: &mut IronBankPool) : &mut PoolInner {
        let v0 = 0x2::versioned::load_value_mut<PoolInner>(&mut arg0.inner);
        let v1 = 0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::constants::current_version();
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &v1), 13906835578798342155);
        v0
    }

    public fun reward_vault_balance(arg0: &IronBankPool) : u64 {
        0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&load_inner(arg0).reward_vault)
    }

    public fun total_principal(arg0: &IronBankPool) : u64 {
        0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&load_inner(arg0).principal_vault)
    }

    public fun update_allowed_versions(arg0: &mut IronBankPool, arg1: &0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::registry::IronBankRegistry) {
        0x2::versioned::load_value_mut<PoolInner>(&mut arg0.inner).allowed_versions = 0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::registry::allowed_versions(arg1);
    }

    // decompiled from Move bytecode v7
}

