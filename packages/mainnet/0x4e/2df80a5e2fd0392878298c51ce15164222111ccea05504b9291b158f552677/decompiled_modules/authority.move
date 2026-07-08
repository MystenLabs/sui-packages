module 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority {
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

    struct AuthorizedAuthorityCapKey<phantom T0, phantom T1> has copy, drop, store {
        cap_id: 0x2::object::ID,
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
        assert!(!0x2::dynamic_field::exists<SingletonKey<T0, T1>>(arg0, v0), 0);
        let v1 = MultitonKey<T0, T1>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<MultitonKey<T0, T1>>(arg0, v1), 3);
        let v2 = SingletonKey<T0, T1>{dummy_field: false};
        0x2::dynamic_field::add<SingletonKey<T0, T1>, bool>(arg0, v2, true);
        let v3 = AuthorityCapKey<T0, T1>{dummy_field: false};
        AuthorityCap<T0, T1>{
            id  : 0x2::derived_object::claim<AuthorityCapKey<T0, T1>>(arg0, v3),
            for : arg3,
        }
    }

    public fun assert_is_admin<T0>() {
        assert!(0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<ADMIN>(), 1);
    }

    public fun assert_is_admin_or_assistant<T0>() {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v0 == 0x1::type_name::with_defining_ids<ADMIN>() || v0 == 0x1::type_name::with_defining_ids<ASSISTANT>(), 1);
    }

    public fun authorize_cap<T0, T1>(arg0: &mut 0x2::object::UID, arg1: &AuthorityCap<T0, T1>) {
        let v0 = AuthorizedAuthorityCapKey<T0, T1>{cap_id: 0x2::object::id<AuthorityCap<T0, T1>>(arg1)};
        0x2::dynamic_field::add<AuthorizedAuthorityCapKey<T0, T1>, bool>(arg0, v0, true);
    }

    public fun authorized_authority_cap_key<T0, T1>(arg0: 0x2::object::ID) : AuthorizedAuthorityCapKey<T0, T1> {
        AuthorizedAuthorityCapKey<T0, T1>{cap_id: arg0}
    }

    public fun borrow_mut_id<T0, T1>(arg0: &mut AuthorityCap<T0, T1>, arg1: 0x1::internal::Permit<T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun deauthorize_cap<T0, T1>(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID) {
        let v0 = AuthorizedAuthorityCapKey<T0, T1>{cap_id: arg1};
        0x2::dynamic_field::remove<AuthorizedAuthorityCapKey<T0, T1>, bool>(arg0, v0);
    }

    public fun derived_cap_id<T0, T1>(arg0: &0x2::object::UID) : 0x2::object::ID {
        let v0 = AuthorityCapKey<T0, T1>{dummy_field: false};
        0x2::object::id_from_address(0x2::derived_object::derive_address<AuthorityCapKey<T0, T1>>(0x2::object::uid_to_inner(arg0), v0))
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

    public fun is_cap_authorized<T0, T1>(arg0: &0x2::object::UID, arg1: 0x2::object::ID) : bool {
        let v0 = AuthorizedAuthorityCapKey<T0, T1>{cap_id: arg1};
        0x2::dynamic_field::exists<AuthorizedAuthorityCapKey<T0, T1>>(arg0, v0)
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
        assert!(!0x2::dynamic_field::exists<SingletonKey<T0, ADMIN>>(arg0, v0), 0);
        let v1 = MultitonKey<T0, ADMIN>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<MultitonKey<T0, ADMIN>>(arg0, v1), 3);
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
        assert!(!0x2::dynamic_field::exists<SingletonKey<T0, ASSISTANT>>(arg0, v0), 0);
        let v1 = MultitonKey<T0, ASSISTANT>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<MultitonKey<T0, ASSISTANT>>(arg0, v1), 3);
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
        assert!(!0x2::dynamic_field::exists<SingletonKey<T0, T1>>(arg0, v0), 2);
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
        assert!(!0x2::dynamic_field::exists<SingletonKey<T0, ADMIN>>(arg0, v0), 2);
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
        assert!(!0x2::dynamic_field::exists<SingletonKey<T0, ASSISTANT>>(arg0, v0), 2);
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

