module 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership {
    struct Ownership has copy, drop, store {
        owner: 0x1::option::Option<address>,
        transfer_auth: 0x1::option::Option<address>,
        type: 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag,
    }

    struct Key has copy, drop, store {
        dummy_field: bool,
    }

    struct Frozen has copy, drop, store {
        dummy_field: bool,
    }

    struct INITIALIZE {
        dummy_field: bool,
    }

    struct UID_MUT {
        dummy_field: bool,
    }

    struct TRANSFER {
        dummy_field: bool,
    }

    struct MIGRATE {
        dummy_field: bool,
    }

    struct FREEZE {
        dummy_field: bool,
    }

    struct IsDestroyed has copy, drop, store {
        dummy_field: bool,
    }

    public fun add_object_id(arg0: &0x2::object::UID, arg1: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) : 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority {
        let v0 = get_owner(arg0);
        if (0x1::option::is_some<address>(&v0)) {
            assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_address<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(0x1::option::destroy_some<address>(v0), arg1), 1);
        };
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::add_object_id(arg0, arg1)
    }

    public fun as_owned_object<T0: key>(arg0: &mut 0x2::object::UID, arg1: 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::typed_id::TypedID<T0>, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert_valid_initialization<T0>(arg0, arg1, arg2);
        let v0 = Ownership{
            owner         : 0x1::option::none<address>(),
            transfer_auth : 0x1::option::none<address>(),
            type          : 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::get<T0>(),
        };
        let v1 = Key{dummy_field: false};
        0x2::dynamic_field::add<Key, Ownership>(arg0, v1, v0);
    }

    public fun as_shared_object<T0: key, T1>(arg0: &mut 0x2::object::UID, arg1: 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::typed_id::TypedID<T0>, arg2: address, arg3: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        as_shared_object_<T0>(arg0, arg1, arg2, 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::type_into_address<T1>(), arg3);
    }

    public fun as_shared_object_<T0: key>(arg0: &mut 0x2::object::UID, arg1: 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::typed_id::TypedID<T0>, arg2: address, arg3: address, arg4: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert_valid_initialization<T0>(arg0, arg1, arg4);
        let v0 = Ownership{
            owner         : 0x1::option::some<address>(arg2),
            transfer_auth : 0x1::option::some<address>(arg3),
            type          : 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::get<T0>(),
        };
        let v1 = Key{dummy_field: false};
        0x2::dynamic_field::add<Key, Ownership>(arg0, v1, v0);
    }

    public fun assert_valid_initialization<T0: key>(arg0: &0x2::object::UID, arg1: 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::typed_id::TypedID<T0>, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(!is_initialized(arg0), 5);
        assert!(0x2::object::uid_to_inner(arg0) == 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::typed_id::to_id<T0>(arg1), 3);
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_package<T0, INITIALIZE>(arg2), 0);
    }

    public fun begin_with_object_id(arg0: &0x2::object::UID) : 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority {
        let v0 = get_owner(arg0);
        assert!(0x1::option::is_none<address>(&v0), 7);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin_with_object_id(arg0)
    }

    public fun can_act_as_address_on_object<T0>(arg0: address, arg1: &0x2::object::UID, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) : bool {
        if (is_destroyed(arg1)) {
            false
        } else if (!is_initialized(arg1)) {
            false
        } else {
            let v1 = Key{dummy_field: false};
            0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_address_on_object<T0>(arg0, &0x2::dynamic_field::borrow<Key, Ownership>(arg1, v1).type, 0x2::object::uid_as_inner(arg1), arg2)
        }
    }

    public fun can_act_as_declaring_package<T0>(arg0: &0x2::object::UID, arg1: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) : bool {
        if (is_destroyed(arg0)) {
            false
        } else if (!is_initialized(arg0)) {
            false
        } else {
            let v1 = Key{dummy_field: false};
            let v2 = 0x2::dynamic_field::borrow<Key, Ownership>(arg0, v1);
            0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_package_on_object_<T0>(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::package_id(&v2.type), &v2.type, 0x2::object::uid_as_inner(arg0), arg1)
        }
    }

    public fun can_act_as_declaring_package_<T0: key, T1>(arg0: &T0, arg1: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) : bool {
        let v0 = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::get<T0>();
        let v1 = 0x2::object::id<T0>(arg0);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_package_on_object_<T1>(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::package_id(&v0), &v0, &v1, arg1)
    }

    public fun can_act_as_owner<T0>(arg0: &0x2::object::UID, arg1: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) : bool {
        if (is_destroyed(arg0)) {
            false
        } else if (!is_initialized(arg0)) {
            true
        } else {
            let v1 = Key{dummy_field: false};
            let v2 = 0x2::dynamic_field::borrow<Key, Ownership>(arg0, v1);
            0x1::option::is_none<address>(&v2.owner) || 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_address_on_object<T0>(*0x1::option::borrow<address>(&v2.owner), &v2.type, 0x2::object::uid_as_inner(arg0), arg1)
        }
    }

    public fun can_act_as_transfer_auth<T0>(arg0: &0x2::object::UID, arg1: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) : bool {
        if (is_destroyed(arg0)) {
            false
        } else if (!is_initialized(arg0)) {
            false
        } else {
            let v1 = Key{dummy_field: false};
            let v2 = 0x2::dynamic_field::borrow<Key, Ownership>(arg0, v1);
            0x1::option::is_none<address>(&v2.transfer_auth) && false || 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_address_on_object<T0>(*0x1::option::borrow<address>(&v2.transfer_auth), &v2.type, 0x2::object::uid_as_inner(arg0), arg1)
        }
    }

    public fun can_borrow_uid_mut(arg0: &0x2::object::UID, arg1: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) : bool {
        true
    }

    public fun destroy(arg0: &mut 0x2::object::UID, arg1: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(can_act_as_owner<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(arg0, arg1) || can_act_as_declaring_package<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(arg0, arg1), 1);
        let v0 = IsDestroyed{dummy_field: false};
        0x2::dynamic_field::add<IsDestroyed, bool>(arg0, v0, true);
    }

    public fun eject_transfer_auth(arg0: &mut 0x2::object::UID, arg1: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(can_act_as_transfer_auth<MIGRATE>(arg0, arg1), 2);
        let v0 = Key{dummy_field: false};
        0x2::dynamic_field::borrow_mut<Key, Ownership>(arg0, v0).transfer_auth = 0x1::option::none<address>();
    }

    public fun freeze_transfer(arg0: &mut 0x2::object::UID, arg1: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(can_act_as_transfer_auth<FREEZE>(arg0, arg1), 2);
        let v0 = Frozen{dummy_field: false};
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<Frozen, bool>(arg0, v0, true);
    }

    public fun get_owner(arg0: &0x2::object::UID) : 0x1::option::Option<address> {
        if (!is_initialized(arg0)) {
            return 0x1::option::none<address>()
        };
        let v0 = Key{dummy_field: false};
        0x2::dynamic_field::borrow<Key, Ownership>(arg0, v0).owner
    }

    public fun get_package_authority(arg0: &0x2::object::UID) : 0x1::option::Option<0x2::object::ID> {
        if (!is_initialized(arg0)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        let v0 = Key{dummy_field: false};
        0x1::option::some<0x2::object::ID>(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::package_id(&0x2::dynamic_field::borrow<Key, Ownership>(arg0, v0).type))
    }

    public fun get_transfer_authority(arg0: &0x2::object::UID) : 0x1::option::Option<address> {
        if (!is_initialized(arg0)) {
            return 0x1::option::none<address>()
        };
        let v0 = Key{dummy_field: false};
        0x2::dynamic_field::borrow<Key, Ownership>(arg0, v0).transfer_auth
    }

    public fun get_type(arg0: &0x2::object::UID) : 0x1::option::Option<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag> {
        if (!is_initialized(arg0)) {
            return 0x1::option::none<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>()
        };
        let v0 = Key{dummy_field: false};
        0x1::option::some<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>(0x2::dynamic_field::borrow<Key, Ownership>(arg0, v0).type)
    }

    public fun is_destroyed(arg0: &0x2::object::UID) : bool {
        let v0 = IsDestroyed{dummy_field: false};
        0x2::dynamic_field::exists_<IsDestroyed>(arg0, v0)
    }

    public fun is_frozen(arg0: &0x2::object::UID) : bool {
        let v0 = Frozen{dummy_field: false};
        0x2::dynamic_field::exists_<Frozen>(arg0, v0)
    }

    public fun is_initialized(arg0: &0x2::object::UID) : bool {
        let v0 = Key{dummy_field: false};
        0x2::dynamic_field::exists_<Key>(arg0, v0)
    }

    public fun make_owner_immutable(arg0: &mut 0x2::object::UID, arg1: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        set_transfer_auth(arg0, @0x0, arg1);
    }

    public fun set_transfer_auth(arg0: &mut 0x2::object::UID, arg1: address, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(can_act_as_declaring_package<MIGRATE>(arg0, arg2), 0);
        assert!(can_act_as_owner<MIGRATE>(arg0, arg2), 1);
        let v0 = Key{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<Key, Ownership>(arg0, v0);
        assert!(0x1::option::is_none<address>(&v1.transfer_auth), 8);
        v1.transfer_auth = 0x1::option::some<address>(arg1);
    }

    public fun transfer(arg0: &mut 0x2::object::UID, arg1: 0x1::option::Option<address>, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(can_act_as_transfer_auth<TRANSFER>(arg0, arg2), 2);
        let v0 = Key{dummy_field: false};
        0x2::dynamic_field::borrow_mut<Key, Ownership>(arg0, v0).owner = arg1;
    }

    public fun unfreeze_transfer(arg0: &mut 0x2::object::UID, arg1: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(can_act_as_transfer_auth<FREEZE>(arg0, arg1), 2);
        let v0 = Frozen{dummy_field: false};
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::drop<Frozen, bool>(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

