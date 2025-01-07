module 0xd259a0916452dff53e52ff45eedea5307aee355f8bb44c4c5db7f4c54d38b5f0::account_graph {
    struct AccountGraph<phantom T0: copy + drop + store, phantom T1: copy + drop + store> has store, key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        max_out_degree: 0x1::option::Option<u32>,
        relationships: 0x2::table::Table<address, 0x2::vec_set::VecSet<address>>,
        account_props: 0x2::table::Table<address, T0>,
        relationship_props: 0x2::table::Table<RelationshipKey, T1>,
    }

    struct EmptyProp has copy, drop, store {
        dummy_field: bool,
    }

    struct RelationshipKey has copy, drop, store {
        source: address,
        target: address,
    }

    struct GraphCreated has copy, drop {
        graph_id: 0x2::object::ID,
    }

    struct RelationshipAdded has copy, drop {
        graph_id: 0x2::object::ID,
        source: address,
        target: address,
    }

    struct RelationshipRemoved has copy, drop {
        graph_id: 0x2::object::ID,
        source: address,
        target: address,
    }

    struct AccountPropsSet<T0: copy> has copy, drop {
        graph_id: 0x2::object::ID,
        node: address,
        props: T0,
    }

    struct AccountPropsUnset<T0: copy> has copy, drop {
        graph_id: 0x2::object::ID,
        node: address,
        props: T0,
    }

    struct RelationshipPropsSet<T0: copy> has copy, drop {
        graph_id: 0x2::object::ID,
        source: address,
        target: address,
        props: T0,
    }

    struct RelationshipPropsUnset<T0: copy> has copy, drop {
        graph_id: 0x2::object::ID,
        source: address,
        target: address,
        props: T0,
    }

    fun new<T0: copy + drop + store, T1: copy + drop + store>(arg0: 0x1::string::String, arg1: 0x1::option::Option<u32>, arg2: &mut 0x2::tx_context::TxContext) : AccountGraph<T0, T1> {
        let v0 = if (0x1::option::is_none<u32>(&arg1)) {
            true
        } else {
            let v1 = 0;
            !0x1::option::contains<u32>(&arg1, &v1)
        };
        assert!(v0, 1);
        AccountGraph<T0, T1>{
            id                 : 0x2::object::new(arg2),
            description        : arg0,
            max_out_degree     : arg1,
            relationships      : 0x2::table::new<address, 0x2::vec_set::VecSet<address>>(arg2),
            account_props      : 0x2::table::new<address, T0>(arg2),
            relationship_props : 0x2::table::new<RelationshipKey, T1>(arg2),
        }
    }

    public fun add_relationship<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut AccountGraph<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = &mut arg0.relationships;
        if (0x2::table::contains<address, 0x2::vec_set::VecSet<address>>(v1, v0)) {
            let v2 = 0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<address>>(v1, v0);
            assert!(0x1::option::is_none<u32>(&arg0.max_out_degree) || 0x2::vec_set::size<address>(v2) < (*0x1::option::borrow<u32>(&arg0.max_out_degree) as u64), 0);
            0x2::vec_set::insert<address>(v2, arg1);
        } else {
            0x2::table::add<address, 0x2::vec_set::VecSet<address>>(v1, v0, 0x2::vec_set::singleton<address>(arg1));
        };
        let v3 = RelationshipAdded{
            graph_id : 0x2::object::id<AccountGraph<T0, T1>>(arg0),
            source   : v0,
            target   : arg1,
        };
        0x2::event::emit<RelationshipAdded>(v3);
    }

    public fun clear_relationships<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut AccountGraph<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::vec_map::VecMap<address, 0x1::option::Option<T1>> {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = &mut arg0.relationships;
        let v2 = 0x2::vec_map::empty<address, 0x1::option::Option<T1>>();
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<address>>(v1, v0)) {
            return v2
        };
        let v3 = 0x2::table::remove<address, 0x2::vec_set::VecSet<address>>(v1, v0);
        let v4 = 0x2::vec_set::keys<address>(&v3);
        let v5 = 0x2::object::id<AccountGraph<T0, T1>>(arg0);
        let v6 = 0;
        while (v6 < 0x1::vector::length<address>(v4)) {
            let v7 = *0x1::vector::borrow<address>(v4, v6);
            0x2::vec_map::insert<address, 0x1::option::Option<T1>>(&mut v2, v7, unset_relationship_props<T0, T1>(arg0, v7, arg1));
            let v8 = RelationshipRemoved{
                graph_id : v5,
                source   : v0,
                target   : v7,
            };
            0x2::event::emit<RelationshipRemoved>(v8);
            v6 = v6 + 1;
        };
        v2
    }

    public fun create<T0: copy + drop + store, T1: copy + drop + store>(arg0: 0x1::string::String, arg1: 0x1::option::Option<u32>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = new<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::share_object<AccountGraph<T0, T1>>(v0);
        let v1 = GraphCreated{graph_id: 0x2::object::id<AccountGraph<T0, T1>>(&v0)};
        0x2::event::emit<GraphCreated>(v1);
    }

    fun relationship_exists<T0: copy + drop + store, T1: copy + drop + store>(arg0: &AccountGraph<T0, T1>, arg1: address, arg2: address) : bool {
        0x2::table::contains<address, 0x2::vec_set::VecSet<address>>(&arg0.relationships, arg1) && 0x2::vec_set::contains<address>(0x2::table::borrow<address, 0x2::vec_set::VecSet<address>>(&arg0.relationships, arg1), &arg2)
    }

    public fun remove_relationship<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut AccountGraph<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : (address, 0x1::option::Option<T1>) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<address>>(&mut arg0.relationships, v0);
        0x2::vec_set::remove<address>(v1, &arg1);
        if (0x2::vec_set::size<address>(v1) == 0) {
            0x2::table::remove<address, 0x2::vec_set::VecSet<address>>(&mut arg0.relationships, v0);
        };
        let v2 = unset_relationship_props<T0, T1>(arg0, arg1, arg2);
        let v3 = RelationshipRemoved{
            graph_id : 0x2::object::id<AccountGraph<T0, T1>>(arg0),
            source   : v0,
            target   : arg1,
        };
        0x2::event::emit<RelationshipRemoved>(v3);
        (arg1, v2)
    }

    public fun set_account_props<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut AccountGraph<T0, T1>, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = &mut arg0.account_props;
        let v2 = if (0x2::table::contains<address, T0>(v1, v0)) {
            let v3 = 0x2::table::borrow_mut<address, T0>(v1, v0);
            *v3 = arg1;
            0x1::option::some<T0>(*v3)
        } else {
            0x2::table::add<address, T0>(v1, v0, arg1);
            0x1::option::none<T0>()
        };
        let v4 = AccountPropsSet<T0>{
            graph_id : 0x2::object::id<AccountGraph<T0, T1>>(arg0),
            node     : v0,
            props    : arg1,
        };
        0x2::event::emit<AccountPropsSet<T0>>(v4);
        v2
    }

    public fun set_relationship_props<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut AccountGraph<T0, T1>, arg1: address, arg2: T1, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<T1> {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(relationship_exists<T0, T1>(arg0, v0, arg1), 2);
        let v1 = &mut arg0.relationship_props;
        let v2 = RelationshipKey{
            source : v0,
            target : arg1,
        };
        let v3 = if (0x2::table::contains<RelationshipKey, T1>(v1, v2)) {
            let v4 = 0x2::table::borrow_mut<RelationshipKey, T1>(v1, v2);
            *v4 = arg2;
            0x1::option::some<T1>(*v4)
        } else {
            0x2::table::add<RelationshipKey, T1>(v1, v2, arg2);
            0x1::option::none<T1>()
        };
        let v5 = RelationshipPropsSet<T1>{
            graph_id : 0x2::object::id<AccountGraph<T0, T1>>(arg0),
            source   : v0,
            target   : arg1,
            props    : arg2,
        };
        0x2::event::emit<RelationshipPropsSet<T1>>(v5);
        v3
    }

    public fun unset_account_props<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut AccountGraph<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<T0> {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = &mut arg0.account_props;
        if (0x2::table::contains<address, T0>(v1, v0)) {
            let v3 = 0x2::table::remove<address, T0>(v1, v0);
            let v4 = AccountPropsUnset<T0>{
                graph_id : 0x2::object::id<AccountGraph<T0, T1>>(arg0),
                node     : v0,
                props    : v3,
            };
            0x2::event::emit<AccountPropsUnset<T0>>(v4);
            0x1::option::some<T0>(v3)
        } else {
            0x1::option::none<T0>()
        }
    }

    public fun unset_relationship_props<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut AccountGraph<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<T1> {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = &mut arg0.relationship_props;
        let v2 = RelationshipKey{
            source : v0,
            target : arg1,
        };
        if (0x2::table::contains<RelationshipKey, T1>(v1, v2)) {
            let v4 = 0x2::table::remove<RelationshipKey, T1>(v1, v2);
            let v5 = RelationshipPropsUnset<T1>{
                graph_id : 0x2::object::id<AccountGraph<T0, T1>>(arg0),
                source   : v0,
                target   : arg1,
                props    : v4,
            };
            0x2::event::emit<RelationshipPropsUnset<T1>>(v5);
            0x1::option::some<T1>(v4)
        } else {
            0x1::option::none<T1>()
        }
    }

    // decompiled from Move bytecode v6
}

