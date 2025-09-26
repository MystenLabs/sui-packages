module 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::demand {
    struct Demand<T0: store + key> has key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        location: 0x1::string::String,
        bounty: vector<T0>,
        time_expire: u64,
        guard: 0x1::option::Option<address>,
        service_identifier: 0x1::option::Option<u8>,
        presenters: 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::Table<address, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::demand::Tips>,
        yes: 0x1::option::Option<address>,
        permission: address,
    }

    public fun new<T0: store + key>(arg0: 0x1::string::String, arg1: bool, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg5: &mut 0x2::tx_context::TxContext) : Demand<T0> {
        let v0 = 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission>(arg4);
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg4, &v0, 260, arg5);
        new_imp<T0>(&arg0, arg1, arg2, arg3, &v0, arg5)
    }

    fun transfer<T0: store + key>(arg0: &mut Demand<T0>, arg1: &address) {
        while (0x1::vector::length<T0>(&arg0.bounty) > 0) {
            0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(&mut arg0.bounty), *arg1);
        };
    }

    public fun create<T0: store + key>(arg0: Demand<T0>) : address {
        0x2::transfer::share_object<Demand<T0>>(arg0);
        0x2::object::id_address<Demand<T0>>(&arg0)
    }

    public fun deposit<T0: store + key>(arg0: &mut Demand<T0>, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::demand::HAS_YES(&arg0.yes);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::demand::BOUNTY_COUNT(0x1::vector::length<T0>(&arg0.bounty));
        0x1::vector::push_back<T0>(&mut arg0.bounty, arg1);
    }

    public fun description_set<T0: store + key>(arg0: &mut Demand<T0>, arg1: 0x1::string::String, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 264, arg3);
        description_set_imp<T0>(arg0, &arg1);
    }

    fun description_set_imp<T0: store + key>(arg0: &mut Demand<T0>, arg1: &0x1::string::String) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_DESCRIPTIONLEN(arg1);
        arg0.description = *arg1;
    }

    public fun description_set_with_passport<T0: store + key>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Demand<T0>, arg2: 0x1::string::String, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 264, arg4);
        description_set_imp<T0>(arg1, &arg2);
    }

    public fun guard_none<T0: store + key>(arg0: &mut Demand<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg2: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg1, &arg0.permission, 263, arg2);
        guard_none_imp<T0>(arg0);
    }

    fun guard_none_imp<T0: store + key>(arg0: &mut Demand<T0>) {
        arg0.guard = 0x1::option::none<address>();
        arg0.service_identifier = 0x1::option::none<u8>();
    }

    public fun guard_none_with_passport<T0: store + key>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Demand<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg2, &arg1.permission, 263, arg3);
        guard_none_imp<T0>(arg1);
    }

    public fun guard_query<T0: store + key>(arg0: &Demand<T0>, arg1: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport) {
        let v0 = 0x2::object::id_address<Demand<T0>>(arg0);
        let (v1, v2, _) = 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::ON_PASSPORT(arg1, &v0);
        if (v2 == 300) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<address>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_ADDRESS(), &arg0.permission);
        } else if (v2 == 302) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<u64>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64(), &arg0.time_expire);
        } else if (v2 == 303) {
            let v4 = 0x1::vector::length<T0>(&arg0.bounty);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<u64>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64(), &v4);
        } else if (v2 == 304) {
            let v5 = 0x1::option::is_some<address>(&arg0.guard);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL(), &v5);
        } else if (v2 == 305) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<address>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64(), 0x1::option::borrow<address>(&arg0.guard));
        } else if (v2 == 306) {
            let v6 = 0x1::option::is_some<u8>(&arg0.service_identifier);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL(), &v6);
        } else if (v2 == 307) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<u8>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U8(), 0x1::option::borrow<u8>(&arg0.service_identifier));
        } else if (v2 == 308) {
            let v7 = 0x1::option::is_some<address>(&arg0.yes);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL(), &v7);
        } else if (v2 == 309) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<address>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_ADDRESS(), 0x1::option::borrow<address>(&arg0.yes));
        } else if (v2 == 310) {
            let v8 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::length<address, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::demand::Tips>(&arg0.presenters);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<u64>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64(), &v8);
        } else if (v2 == 311) {
            let v9 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::contains<address, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::demand::Tips>(&arg0.id, &arg0.presenters, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_ADDRESS(v1));
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL(), &v9);
        } else if (v2 == 312) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<address>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_ADDRESS(), 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::demand::Tips_who(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::borrow<address, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::demand::Tips>(&arg0.id, &arg0.presenters, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_ADDRESS(v1))));
        } else if (v2 == 313) {
            let v10 = 0x1::type_name::get<T0>();
            let v11 = 0x1::string::from_ascii(*0x1::type_name::borrow_string(&v10));
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_STRING(), &v11);
        } else if (v2 == 314) {
            let v12 = 0x1::type_name::get_with_original_ids<T0>();
            let v13 = 0x1::string::from_ascii(*0x1::type_name::borrow_string(&v12));
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_STRING(), &v13);
        } else if (v2 == 315) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_STRING(), &arg0.location);
        } else {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::Q_CMD_NOT_MATCH();
        };
    }

    public fun guard_set<T0: store + key>(arg0: &mut Demand<T0>, arg1: &0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard, arg2: 0x1::option::Option<u8>, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg3, &arg0.permission, 263, arg4);
        guard_set_imp<T0>(arg0, arg1, &arg2);
    }

    fun guard_set_imp<T0: store + key>(arg0: &mut Demand<T0>, arg1: &0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard, arg2: &0x1::option::Option<u8>) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::ASSERT_IDENTIFIER_ADDRESS(arg1, arg2);
        arg0.guard = 0x1::option::some<address>(0x2::object::id_address<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard>(arg1));
        arg0.service_identifier = *arg2;
    }

    public fun guard_set_with_passport<T0: store + key>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Demand<T0>, arg2: &0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard, arg3: 0x1::option::Option<u8>, arg4: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg5: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg4, &arg1.permission, 263, arg5);
        guard_set_imp<T0>(arg1, arg2, &arg3);
    }

    public fun location_set<T0: store + key>(arg0: &mut Demand<T0>, arg1: 0x1::string::String, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 266, arg3);
        location_set_imp<T0>(arg0, &arg1);
    }

    fun location_set_imp<T0: store + key>(arg0: &mut Demand<T0>, arg1: &0x1::string::String) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_STRLEN_LESS(arg1, 256);
        arg0.location = *arg1;
    }

    public fun location_set_with_passport<T0: store + key>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Demand<T0>, arg2: 0x1::string::String, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 266, arg4);
        location_set_imp<T0>(arg1, &arg2);
    }

    fun new_imp<T0: store + key>(arg0: &0x1::string::String, arg1: bool, arg2: u64, arg3: &0x2::clock::Clock, arg4: &address, arg5: &mut 0x2::tx_context::TxContext) : Demand<T0> {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_DESCRIPTIONLEN(arg0);
        let v0 = 0x2::object::new(arg5);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = Demand<T0>{
            id                 : v0,
            description        : *arg0,
            location           : 0x1::string::utf8(b""),
            bounty             : 0x1::vector::empty<T0>(),
            time_expire        : 0x2::clock::timestamp_ms(arg3),
            guard              : 0x1::option::none<address>(),
            service_identifier : 0x1::option::none<u8>(),
            presenters         : 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::new<address, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::demand::Tips>(&v1),
            yes                : 0x1::option::none<address>(),
            permission         : *arg4,
        };
        let v3 = &mut v2;
        time_expand_imp<T0>(v3, arg1, arg2);
        v2
    }

    public fun new_with_passport<T0: store + key>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: 0x1::string::String, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg6: &mut 0x2::tx_context::TxContext) : Demand<T0> {
        let v0 = 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission>(arg5);
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg5, &v0, 260, arg6);
        new_imp<T0>(&arg1, arg2, arg3, arg4, &v0, arg6)
    }

    public fun permission_set<T0: store + key>(arg0: &mut Demand<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_CREATOR(arg1, arg3);
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_ADMIN(arg2, arg3);
        arg0.permission = 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission>(arg2);
    }

    public fun present<T0: store + key, T1>(arg0: &mut Demand<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::service::Service<T1>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::NEED_PASSPORT(0x1::option::is_none<address>(&arg0.guard));
        let v0 = 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::service::Service<T1>>(arg1);
        present_imp<T0>(arg0, &v0, &arg2, arg3);
    }

    fun present_imp<T0: store + key>(arg0: &mut Demand<T0>, arg1: &address, arg2: &0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_DESCRIPTIONLEN(arg2);
        let v0 = 0x2::tx_context::sender(arg3);
        if (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::contains<address, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::demand::Tips>(&arg0.id, &arg0.presenters, *arg1)) {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::demand::Tips_set(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::borrow_mut<address, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::demand::Tips>(&mut arg0.id, &mut arg0.presenters, *arg1), arg2, &v0);
        } else {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::demand::PRESENTERS_COUNT(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::length<address, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::demand::Tips>(&arg0.presenters));
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::add<address, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::demand::Tips>(&mut arg0.id, &mut arg0.presenters, *arg1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::demand::Tips_new(arg2, &v0));
        };
        let v1 = 0x2::object::id_address<Demand<T0>>(arg0);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::demand::PresentEvent_emit(&v1, arg1, arg2);
    }

    public fun present_with_passport<T0: store + key, T1>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Demand<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::service::Service<T1>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<address>(&arg1.guard)) {
            if (0x1::option::is_some<u8>(&arg1.service_identifier)) {
                let v0 = 0x1::vector::singleton<u8>(*0x1::option::borrow<u8>(&arg1.service_identifier));
                let (v1, _) = 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::ASSERT_PASSPORT_AND_VALUE(0x1::option::borrow<address>(&arg1.guard), arg0, &v0, arg4);
                let v3 = v1;
                0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::IDENTIFER_VALUE_NOT_FOUND(0x1::vector::length<address>(&v3) == 1);
                present_imp<T0>(arg1, 0x1::vector::borrow<address>(&v3, 0), &arg3, arg4);
                return
            };
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::ASSERT_PASSPORT(0x1::option::borrow<address>(&arg1.guard), arg0, arg4);
        };
        let v4 = 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::service::Service<T1>>(arg2);
        present_imp<T0>(arg1, &v4, &arg3, arg4);
    }

    public fun refund<T0: store + key>(arg0: &mut Demand<T0>, arg1: &0x2::clock::Clock, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 261, arg3);
        refund_imp<T0>(arg0, arg1, arg3);
    }

    fun refund_imp<T0: store + key>(arg0: &mut Demand<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::demand::TIME_NOT_COIMINT(arg0.time_expire, arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        transfer<T0>(arg0, &v0);
    }

    public fun refund_with_passport<T0: store + key>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Demand<T0>, arg2: &0x2::clock::Clock, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 261, arg4);
        refund_imp<T0>(arg1, arg2, arg4);
    }

    public fun time_expand<T0: store + key>(arg0: &mut Demand<T0>, arg1: bool, arg2: u64, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg3, &arg0.permission, 262, arg4);
        time_expand_imp<T0>(arg0, arg1, arg2);
    }

    fun time_expand_imp<T0: store + key>(arg0: &mut Demand<T0>, arg1: bool, arg2: u64) {
        if (arg1) {
            arg0.time_expire = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::time_expand3(arg2, arg0.time_expire);
        } else if (arg2 > arg0.time_expire) {
            arg0.time_expire = arg2;
        };
    }

    public fun time_expand_with_passport<T0: store + key>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Demand<T0>, arg2: bool, arg3: u64, arg4: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg5: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg4, &arg1.permission, 262, arg5);
        time_expand_imp<T0>(arg1, arg2, arg3);
    }

    public fun yes<T0: store + key>(arg0: &mut Demand<T0>, arg1: address, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 265, arg3);
        yes_imp<T0>(arg0, &arg1);
    }

    fun yes_imp<T0: store + key>(arg0: &mut Demand<T0>, arg1: &address) {
        let v0 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::borrow<address, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::demand::Tips>(&arg0.id, &arg0.presenters, *arg1);
        arg0.yes = 0x1::option::some<address>(*arg1);
        let v1 = 0x2::object::id_address<Demand<T0>>(arg0);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::demand::BountyEvent_emit(&v1, arg1, v0);
        let v2 = *0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::demand::Tips_who(v0);
        transfer<T0>(arg0, &v2);
    }

    public fun yes_with_passport<T0: store + key>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Demand<T0>, arg2: address, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 265, arg4);
        yes_imp<T0>(arg1, &arg2);
    }

    // decompiled from Move bytecode v6
}

