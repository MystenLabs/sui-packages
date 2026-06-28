module 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority {
    struct ADMIN {
        dummy_field: bool,
    }

    struct ASSISTANT {
        dummy_field: bool,
    }

    struct SingletonKey<phantom T0, phantom T1> has copy, drop, store {
        dummy_field: bool,
    }

    struct MultitonKey<phantom T0, phantom T1> has copy, drop, store {
        dummy_field: bool,
    }

    struct AuthorityCapKey<phantom T0, phantom T1> has copy, drop, store {
        dummy_field: bool,
    }

    struct AuthorityCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    public fun exists<T0, T1>(arg0: &0x2::object::UID) : bool {
        let v0 = AuthorityCapKey<T0, T1>{dummy_field: false};
        0x2::derived_object::exists<AuthorityCapKey<T0, T1>>(arg0, v0)
    }

    public fun new<T0: drop, T1: drop>(arg0: &mut 0x2::object::UID, arg1: &T0, arg2: &T1, arg3: 0x2::object::ID) : AuthorityCap<T0, T1> {
        let v0 = SingletonKey<T0, T1>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<SingletonKey<T0, T1>>(arg0, v0), 13835059176268627969);
        let v1 = MultitonKey<T0, T1>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<MultitonKey<T0, T1>>(arg0, v1), 13835903618379022343);
        let v2 = SingletonKey<T0, T1>{dummy_field: false};
        0x2::dynamic_field::add<SingletonKey<T0, T1>, bool>(arg0, v2, true);
        let v3 = AuthorityCapKey<T0, T1>{dummy_field: false};
        AuthorityCap<T0, T1>{
            id  : 0x2::derived_object::claim<AuthorityCapKey<T0, T1>>(arg0, v3),
            for : arg3,
        }
    }

    public fun assert_is_admin<T0>() {
        assert!(0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<ADMIN>(), 13835340591115927555);
    }

    public fun assert_is_admin_or_assistant<T0>() {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v0 == 0x1::type_name::with_defining_ids<ADMIN>() || v0 == 0x1::type_name::with_defining_ids<ASSISTANT>(), 13835340561051156483);
    }

    public fun borrow_mut_id<T0, T1>(arg0: &mut AuthorityCap<T0, T1>, arg1: 0x1::internal::Permit<T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun destroy<T0, T1>(arg0: AuthorityCap<T0, T1>, arg1: 0x1::internal::Permit<T0>) {
        let AuthorityCap {
            id  : v0,
            for : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun for<T0, T1>(arg0: &AuthorityCap<T0, T1>) : 0x2::object::ID {
        arg0.for
    }

    public fun is_multiton<T0, T1>(arg0: &0x2::object::UID) : bool {
        let v0 = MultitonKey<T0, T1>{dummy_field: false};
        0x2::dynamic_field::exists<MultitonKey<T0, T1>>(arg0, v0)
    }

    public fun is_singleton<T0, T1>(arg0: &0x2::object::UID) : bool {
        let v0 = SingletonKey<T0, T1>{dummy_field: false};
        0x2::dynamic_field::exists<SingletonKey<T0, T1>>(arg0, v0)
    }

    public fun new_admin_cap<T0: drop>(arg0: &mut 0x2::object::UID, arg1: &T0, arg2: 0x2::object::ID) : AuthorityCap<T0, ADMIN> {
        let v0 = SingletonKey<T0, ADMIN>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<SingletonKey<T0, ADMIN>>(arg0, v0), 13835059176268627969);
        let v1 = MultitonKey<T0, ADMIN>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<MultitonKey<T0, ADMIN>>(arg0, v1), 13835903618379022343);
        let v2 = SingletonKey<T0, ADMIN>{dummy_field: false};
        0x2::dynamic_field::add<SingletonKey<T0, ADMIN>, bool>(arg0, v2, true);
        let v3 = AuthorityCapKey<T0, ADMIN>{dummy_field: false};
        AuthorityCap<T0, ADMIN>{
            id  : 0x2::derived_object::claim<AuthorityCapKey<T0, ADMIN>>(arg0, v3),
            for : arg2,
        }
    }

    public fun new_assistant_cap<T0: drop>(arg0: &mut 0x2::object::UID, arg1: &T0, arg2: 0x2::object::ID) : AuthorityCap<T0, ASSISTANT> {
        let v0 = SingletonKey<T0, ASSISTANT>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<SingletonKey<T0, ASSISTANT>>(arg0, v0), 13835059176268627969);
        let v1 = MultitonKey<T0, ASSISTANT>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<MultitonKey<T0, ASSISTANT>>(arg0, v1), 13835903618379022343);
        let v2 = SingletonKey<T0, ASSISTANT>{dummy_field: false};
        0x2::dynamic_field::add<SingletonKey<T0, ASSISTANT>, bool>(arg0, v2, true);
        let v3 = AuthorityCapKey<T0, ASSISTANT>{dummy_field: false};
        AuthorityCap<T0, ASSISTANT>{
            id  : 0x2::derived_object::claim<AuthorityCapKey<T0, ASSISTANT>>(arg0, v3),
            for : arg2,
        }
    }

    public fun new_multiton<T0: drop, T1: drop>(arg0: &mut 0x2::object::UID, arg1: &T0, arg2: &T1, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : AuthorityCap<T0, T1> {
        let v0 = SingletonKey<T0, T1>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<SingletonKey<T0, T1>>(arg0, v0), 13835622220711591941);
        let v1 = MultitonKey<T0, T1>{dummy_field: false};
        if (!0x2::dynamic_field::exists<MultitonKey<T0, T1>>(arg0, v1)) {
            0x2::dynamic_field::add<MultitonKey<T0, T1>, bool>(arg0, v1, true);
        };
        AuthorityCap<T0, T1>{
            id  : 0x2::object::new(arg4),
            for : arg3,
        }
    }

    public fun new_multiton_admin_cap<T0: drop>(arg0: &mut 0x2::object::UID, arg1: &T0, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : AuthorityCap<T0, ADMIN> {
        let v0 = SingletonKey<T0, ADMIN>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<SingletonKey<T0, ADMIN>>(arg0, v0), 13835622220711591941);
        let v1 = MultitonKey<T0, ADMIN>{dummy_field: false};
        if (!0x2::dynamic_field::exists<MultitonKey<T0, ADMIN>>(arg0, v1)) {
            0x2::dynamic_field::add<MultitonKey<T0, ADMIN>, bool>(arg0, v1, true);
        };
        AuthorityCap<T0, ADMIN>{
            id  : 0x2::object::new(arg3),
            for : arg2,
        }
    }

    public fun new_multiton_assistant_cap<T0: drop>(arg0: &mut 0x2::object::UID, arg1: &T0, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : AuthorityCap<T0, ASSISTANT> {
        let v0 = SingletonKey<T0, ASSISTANT>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<SingletonKey<T0, ASSISTANT>>(arg0, v0), 13835622220711591941);
        let v1 = MultitonKey<T0, ASSISTANT>{dummy_field: false};
        if (!0x2::dynamic_field::exists<MultitonKey<T0, ASSISTANT>>(arg0, v1)) {
            0x2::dynamic_field::add<MultitonKey<T0, ASSISTANT>, bool>(arg0, v1, true);
        };
        AuthorityCap<T0, ASSISTANT>{
            id  : 0x2::object::new(arg3),
            for : arg2,
        }
    }

    public fun receive<T0, T1, T2: store + key>(arg0: &mut AuthorityCap<T0, T1>, arg1: 0x2::transfer::Receiving<T2>) : T2 {
        0x2::transfer::public_receive<T2>(&mut arg0.id, arg1)
    }

    // decompiled from Move bytecode v7
}

