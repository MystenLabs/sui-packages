module 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arbitration {
    struct Arbitration<phantom T0> has key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        location: 0x1::string::String,
        voting_guard: 0x2::vec_map::VecMap<address, u64>,
        usage_guard: 0x1::option::Option<address>,
        fee: u64,
        endpoint: 0x1::option::Option<0x1::string::String>,
        bPaused: bool,
        fee_treasury: address,
        permission: address,
    }

    public fun new<T0>(arg0: 0x1::string::String, arg1: u64, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T0>, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) : Arbitration<T0> {
        let v0 = 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission>(arg3);
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg3, &v0, 800, arg4);
        new_imp<T0>(&arg0, arg1, arg2, &v0, arg4)
    }

    public fun arbitration<T0>(arg0: &Arbitration<T0>, arg1: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::Arb<T0>, arg2: 0x1::string::String, arg3: 0x1::option::Option<u64>, arg4: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg5: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg4, &arg0.permission, 808, arg5);
        arbitration_imp<T0>(arg0, arg1, &arg2, arg3);
    }

    public fun vote<T0>(arg0: &Arbitration<T0>, arg1: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::Arb<T0>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg5: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg4, &arg0.permission, 807, arg5);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::NEED_PASSPORT(0x2::vec_map::is_empty<address, u64>(&arg0.voting_guard));
        let v0 = 0x2::tx_context::sender(arg5);
        vote_imp<T0>(arg0, arg1, &v0, &arg2, 1, arg3);
    }

    public fun withdraw<T0>(arg0: &Arbitration<T0>, arg1: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::Arb<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T0>, arg3: 0x1::option::Option<address>, arg4: u64, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg8: &mut 0x2::tx_context::TxContext) : address {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg7, &arg0.permission, 809, arg8);
        let v0 = 0x1::option::none<address>();
        withdraw_imp<T0>(arg0, arg1, arg2, &arg3, &v0, arg4, &arg5, arg6, arg8)
    }

    fun arbitration_imp<T0>(arg0: &Arbitration<T0>, arg1: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::Arb<T0>, arg2: &0x1::string::String, arg3: 0x1::option::Option<u64>) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::arbitration::NOT_MATCH(*0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::arbitration_address<T0>(arg1) == 0x2::object::id_address<Arbitration<T0>>(arg0));
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_DESCRIPTIONLEN(arg2);
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::arbitration<T0>(arg1, arg2, arg3);
    }

    public fun arbitration_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &Arbitration<T0>, arg2: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::Arb<T0>, arg3: 0x1::string::String, arg4: 0x1::option::Option<u64>, arg5: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg6: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg5, &arg1.permission, 808, arg6);
        arbitration_imp<T0>(arg1, arg2, &arg3, arg4);
    }

    public fun create<T0>(arg0: Arbitration<T0>) : address {
        0x2::transfer::share_object<Arbitration<T0>>(arg0);
        0x2::object::id_address<Arbitration<T0>>(&arg0)
    }

    public fun description_set<T0>(arg0: &mut Arbitration<T0>, arg1: 0x1::string::String, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 801, arg3);
        description_set_imp<T0>(arg0, &arg1);
    }

    fun description_set_imp<T0>(arg0: &mut Arbitration<T0>, arg1: &0x1::string::String) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_DESCRIPTIONLEN(arg1);
        arg0.description = *arg1;
    }

    public fun description_set_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Arbitration<T0>, arg2: 0x1::string::String, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 801, arg4);
        description_set_imp<T0>(arg1, &arg2);
    }

    public fun dispute<T0, T1>(arg0: &mut Arbitration<T0>, arg1: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Order<T1>, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::Arb<T0> {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::NEED_PASSPORT(0x1::option::is_none<address>(&arg0.usage_guard));
        dispute_imp<T0, T1>(arg0, arg1, &arg2, &arg3, arg4, arg5, arg6)
    }

    fun dispute_imp<T0, T1>(arg0: &Arbitration<T0>, arg1: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Order<T1>, arg2: &0x1::string::String, arg3: &vector<0x1::string::String>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::Arb<T0> {
        let v0 = 0x2::tx_context::sender(arg6);
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::ASSERT_ORDER_PERMISSION<T1>(arg1, &v0);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::arbitration::PAUSED(arg0.bPaused);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::arbitration::FEE(0x2::coin::value<T0>(&arg4) >= arg0.fee);
        let v1 = 0x2::object::id_address<Arbitration<T0>>(arg0);
        let v2 = 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Order<T1>>(arg1);
        let v3 = 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::new<T0>(&v1, &v2, arg2, arg3, 0x2::coin::split<T0>(&mut arg4, arg0.fee, arg6), arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, v0);
        let v4 = 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::Arb<T0>>(&v3);
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::dispute<T1>(arg1, &v4);
        v3
    }

    public fun dispute_with_passport<T0, T1>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Arbitration<T0>, arg2: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Order<T1>, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::Arb<T0> {
        if (0x1::option::is_some<address>(&arg1.usage_guard)) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::ASSERT_PASSPORT(0x1::option::borrow<address>(&arg1.usage_guard), arg0, arg7);
        };
        dispute_imp<T0, T1>(arg1, arg2, &arg3, &arg4, arg5, arg6, arg7)
    }

    public fun endpoint_none<T0>(arg0: &mut Arbitration<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg2: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg1, &arg0.permission, 804, arg2);
        endpoint_none_imp<T0>(arg0);
    }

    fun endpoint_none_imp<T0>(arg0: &mut Arbitration<T0>) {
        arg0.endpoint = 0x1::option::none<0x1::string::String>();
    }

    public fun endpoint_none_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Arbitration<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg2, &arg1.permission, 804, arg3);
        endpoint_none_imp<T0>(arg1);
    }

    public fun endpoint_set<T0>(arg0: &mut Arbitration<T0>, arg1: 0x1::string::String, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 804, arg3);
        endpoint_set_imp<T0>(arg0, &arg1);
    }

    fun endpoint_set_imp<T0>(arg0: &mut Arbitration<T0>, arg1: &0x1::string::String) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_ENDPOINTLEN(arg1);
        arg0.endpoint = 0x1::option::some<0x1::string::String>(*arg1);
    }

    public fun endpoint_set_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Arbitration<T0>, arg2: 0x1::string::String, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 804, arg4);
        endpoint_set_imp<T0>(arg1, &arg2);
    }

    public fun fee_set<T0>(arg0: &mut Arbitration<T0>, arg1: u64, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 802, arg3);
        fee_set_imp<T0>(arg0, arg1);
    }

    fun fee_set_imp<T0>(arg0: &mut Arbitration<T0>, arg1: u64) {
        arg0.fee = arg1;
    }

    public fun fee_set_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Arbitration<T0>, arg2: u64, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 802, arg4);
        fee_set_imp<T0>(arg1, arg2);
    }

    public fun guard_query<T0>(arg0: &Arbitration<T0>, arg1: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport) {
        let v0 = 0x2::object::id_address<Arbitration<T0>>(arg0);
        let (v1, v2, _) = 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::ON_PASSPORT(arg1, &v0);
        if (v2 == 1500) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<address>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_ADDRESS(), &arg0.permission);
        } else if (v2 == 1501) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL(), &arg0.bPaused);
        } else if (v2 == 1502) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<u64>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64(), &arg0.fee);
        } else if (v2 == 1503) {
            let v4 = 0x1::option::is_some<0x1::string::String>(&arg0.endpoint);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL(), &v4);
        } else if (v2 == 1504) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_STRING(), 0x1::option::borrow<0x1::string::String>(&arg0.endpoint));
        } else if (v2 == 1505) {
            let v5 = 0x1::option::is_some<address>(&arg0.usage_guard);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL(), &v5);
        } else if (v2 == 1506) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<address>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_ADDRESS(), 0x1::option::borrow<address>(&arg0.usage_guard));
        } else if (v2 == 1507) {
            let v6 = 0x2::vec_map::size<address, u64>(&arg0.voting_guard);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<u64>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64(), &v6);
        } else if (v2 == 1508) {
            let v7 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_ADDRESS(v1);
            let v8 = 0x2::vec_map::contains<address, u64>(&arg0.voting_guard, &v7);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL(), &v8);
        } else if (v2 == 1509) {
            let v9 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_ADDRESS(v1);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<u64>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64(), 0x2::vec_map::get<address, u64>(&arg0.voting_guard, &v9));
        } else if (v2 == 1510) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<address>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_ADDRESS(), &arg0.fee_treasury);
        } else if (v2 == 1511) {
            let v10 = 0x1::type_name::get<T0>();
            let v11 = 0x1::string::from_ascii(*0x1::type_name::borrow_string(&v10));
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_STRING(), &v11);
        } else if (v2 == 1512) {
            let v12 = 0x1::type_name::get_with_original_ids<T0>();
            let v13 = 0x1::string::from_ascii(*0x1::type_name::borrow_string(&v12));
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_STRING(), &v13);
        } else if (v2 == 1513) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_STRING(), &arg0.location);
        } else {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::Q_CMD_NOT_MATCH();
        };
    }

    public fun location_set<T0>(arg0: &mut Arbitration<T0>, arg1: 0x1::string::String, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 811, arg3);
        location_set_imp<T0>(arg0, &arg1);
    }

    fun location_set_imp<T0>(arg0: &mut Arbitration<T0>, arg1: &0x1::string::String) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_STRLEN_LESS(arg1, 256);
        arg0.location = *arg1;
    }

    public fun location_set_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Arbitration<T0>, arg2: 0x1::string::String, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 811, arg4);
        location_set_imp<T0>(arg1, &arg2);
    }

    fun new_imp<T0>(arg0: &0x1::string::String, arg1: u64, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T0>, arg3: &address, arg4: &mut 0x2::tx_context::TxContext) : Arbitration<T0> {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_DESCRIPTIONLEN(arg0);
        Arbitration<T0>{
            id           : 0x2::object::new(arg4),
            description  : *arg0,
            location     : 0x1::string::utf8(b""),
            voting_guard : 0x2::vec_map::empty<address, u64>(),
            usage_guard  : 0x1::option::none<address>(),
            fee          : arg1,
            endpoint     : 0x1::option::none<0x1::string::String>(),
            bPaused      : true,
            fee_treasury : 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T0>>(arg2),
            permission   : *arg3,
        }
    }

    public fun new_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: 0x1::string::String, arg2: u64, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T0>, arg4: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg5: &mut 0x2::tx_context::TxContext) : Arbitration<T0> {
        let v0 = 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission>(arg4);
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg4, &v0, 800, arg5);
        new_imp<T0>(&arg1, arg2, arg3, &v0, arg5)
    }

    public fun pause<T0>(arg0: &mut Arbitration<T0>, arg1: bool, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 806, arg3);
        pause_imp<T0>(arg0, arg1);
    }

    fun pause_imp<T0>(arg0: &mut Arbitration<T0>, arg1: bool) {
        arg0.bPaused = arg1;
    }

    public fun pause_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Arbitration<T0>, arg2: bool, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 806, arg4);
        pause_imp<T0>(arg1, arg2);
    }

    public fun permission_set<T0>(arg0: &mut Arbitration<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_CREATOR(arg1, arg3);
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_ADMIN(arg2, arg3);
        arg0.permission = 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission>(arg2);
    }

    public fun usage_guard_none<T0>(arg0: &mut Arbitration<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg2: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg1, &arg0.permission, 805, arg2);
        usage_guard_none_imp<T0>(arg0);
    }

    fun usage_guard_none_imp<T0>(arg0: &mut Arbitration<T0>) {
        arg0.usage_guard = 0x1::option::none<address>();
    }

    public fun usage_guard_none_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Arbitration<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg2, &arg1.permission, 805, arg3);
        usage_guard_none_imp<T0>(arg1);
    }

    public fun usage_guard_set<T0>(arg0: &mut Arbitration<T0>, arg1: &0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 805, arg3);
        usage_guard_set_imp<T0>(arg0, arg1);
    }

    fun usage_guard_set_imp<T0>(arg0: &mut Arbitration<T0>, arg1: &0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard) {
        arg0.usage_guard = 0x1::option::some<address>(0x2::object::id_address<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard>(arg1));
    }

    public fun usage_guard_set_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Arbitration<T0>, arg2: &0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 805, arg4);
        usage_guard_set_imp<T0>(arg1, arg2);
    }

    public fun vote2_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &Arbitration<T0>, arg2: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::Arb<T0>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg6: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg5, &arg1.permission, 807, arg6);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::NEED_PASSPORT(0x2::vec_map::is_empty<address, u64>(&arg1.voting_guard));
        let v0 = 0x2::tx_context::sender(arg6);
        vote_imp<T0>(arg1, arg2, &v0, &arg3, 1, arg4);
    }

    fun vote_imp<T0>(arg0: &Arbitration<T0>, arg1: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::Arb<T0>, arg2: &address, arg3: &vector<u8>, arg4: u64, arg5: &0x2::clock::Clock) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::arbitration::NOT_MATCH(*0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::arbitration_address<T0>(arg1) == 0x2::object::id_address<Arbitration<T0>>(arg0));
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::vote<T0>(arg1, arg2, arg3, arg4, arg5);
    }

    public fun vote_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard, arg2: &Arbitration<T0>, arg3: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::Arb<T0>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg7: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg6, &arg2.permission, 807, arg7);
        let v0 = 0x2::object::id_address<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard>(arg1);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::arbitration::GUARD(0x2::vec_map::contains<address, u64>(&arg2.voting_guard, &v0));
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::ASSERT_PASSPORT(&v0, arg0, arg7);
        let v1 = 0x2::tx_context::sender(arg7);
        vote_imp<T0>(arg2, arg3, &v1, &arg4, *0x2::vec_map::get<address, u64>(&arg2.voting_guard, &v0), arg5);
    }

    public fun voting_guard_add<T0>(arg0: &mut Arbitration<T0>, arg1: &0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard, arg2: u64, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg3, &arg0.permission, 803, arg4);
        voting_guard_add_imp<T0>(arg0, arg1, arg2);
    }

    fun voting_guard_add_imp<T0>(arg0: &mut Arbitration<T0>, arg1: &0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard, arg2: u64) {
        let v0 = 0x2::object::id_address<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard>(arg1);
        if (0x2::vec_map::contains<address, u64>(&arg0.voting_guard, &v0)) {
            *0x2::vec_map::get_mut<address, u64>(&mut arg0.voting_guard, &v0) = arg2;
        } else {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::arbitration::GUARD_COUNT(0x2::vec_map::size<address, u64>(&arg0.voting_guard));
            0x2::vec_map::insert<address, u64>(&mut arg0.voting_guard, v0, arg2);
        };
    }

    public fun voting_guard_add_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Arbitration<T0>, arg2: &0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard, arg3: u64, arg4: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg5: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg4, &arg1.permission, 803, arg5);
        voting_guard_add_imp<T0>(arg1, arg2, arg3);
    }

    public fun voting_guard_remove<T0>(arg0: &mut Arbitration<T0>, arg1: vector<address>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 803, arg3);
        voting_guard_remove_imp<T0>(arg0, &arg1);
    }

    fun voting_guard_remove_all_imp<T0>(arg0: &mut Arbitration<T0>) {
        arg0.voting_guard = 0x2::vec_map::empty<address, u64>();
    }

    fun voting_guard_remove_imp<T0>(arg0: &mut Arbitration<T0>, arg1: &vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg1)) {
            let v1 = 0x1::vector::borrow<address>(arg1, v0);
            if (0x2::vec_map::contains<address, u64>(&arg0.voting_guard, v1)) {
                let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.voting_guard, v1);
            };
            v0 = v0 + 1;
        };
    }

    public fun voting_guard_remove_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Arbitration<T0>, arg2: vector<address>, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 803, arg4);
        voting_guard_remove_imp<T0>(arg1, &arg2);
    }

    public fun voting_guard_removeall<T0>(arg0: &mut Arbitration<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg2: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg1, &arg0.permission, 803, arg2);
        voting_guard_remove_all_imp<T0>(arg0);
    }

    public fun voting_guard_removeall_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Arbitration<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg2, &arg1.permission, 803, arg3);
        voting_guard_remove_all_imp<T0>(arg1);
    }

    public fun withdraw_forGuard<T0>(arg0: &Arbitration<T0>, arg1: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::Arb<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T0>, arg3: 0x1::option::Option<address>, arg4: &0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard, arg5: u64, arg6: 0x1::string::String, arg7: &0x2::clock::Clock, arg8: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg9: &mut 0x2::tx_context::TxContext) : address {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg8, &arg0.permission, 809, arg9);
        let v0 = 0x1::option::some<address>(0x2::object::id_address<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard>(arg4));
        withdraw_imp<T0>(arg0, arg1, arg2, &arg3, &v0, arg5, &arg6, arg7, arg9)
    }

    public fun withdraw_forGuard_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &Arbitration<T0>, arg2: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::Arb<T0>, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T0>, arg4: 0x1::option::Option<address>, arg5: &0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard, arg6: u64, arg7: 0x1::string::String, arg8: &0x2::clock::Clock, arg9: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg10: &mut 0x2::tx_context::TxContext) : address {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg9, &arg1.permission, 809, arg10);
        let v0 = 0x1::option::some<address>(0x2::object::id_address<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard>(arg5));
        withdraw_imp<T0>(arg1, arg2, arg3, &arg4, &v0, arg6, &arg7, arg8, arg10)
    }

    fun withdraw_imp<T0>(arg0: &Arbitration<T0>, arg1: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::Arb<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T0>, arg3: &0x1::option::Option<address>, arg4: &0x1::option::Option<address>, arg5: u64, arg6: &0x1::string::String, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : address {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::arbitration::NOT_MATCH(*0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::arbitration_address<T0>(arg1) == 0x2::object::id_address<Arbitration<T0>>(arg0));
        let v0 = 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T0>>(arg2);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::arbitration::TREASURY(arg0.fee_treasury == v0);
        let v1 = 0x1::option::some<address>(0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::Arb<T0>>(arg1));
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::payment::create2<T0>(&v0, 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::withdraw<T0>(arg1, arg8), arg3, arg4, arg5, arg6, &v1, arg7, arg8)
    }

    public fun withdraw_treasury_set<T0>(arg0: &mut Arbitration<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 810, arg3);
        withdraw_treasury_set_imp<T0>(arg0, arg1);
    }

    fun withdraw_treasury_set_imp<T0>(arg0: &mut Arbitration<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T0>) {
        arg0.fee_treasury = 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T0>>(arg1);
    }

    public fun withdraw_treasury_set_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Arbitration<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T0>, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 810, arg4);
        withdraw_treasury_set_imp<T0>(arg1, arg2);
    }

    public fun withdraw_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &Arbitration<T0>, arg2: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::Arb<T0>, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T0>, arg4: 0x1::option::Option<address>, arg5: u64, arg6: 0x1::string::String, arg7: &0x2::clock::Clock, arg8: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg9: &mut 0x2::tx_context::TxContext) : address {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg8, &arg1.permission, 809, arg9);
        let v0 = 0x1::option::none<address>();
        withdraw_imp<T0>(arg1, arg2, arg3, &arg4, &v0, arg5, &arg6, arg7, arg9)
    }

    // decompiled from Move bytecode v6
}

