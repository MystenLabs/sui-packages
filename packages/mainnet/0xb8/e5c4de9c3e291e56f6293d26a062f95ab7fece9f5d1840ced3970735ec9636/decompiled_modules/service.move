module 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::service {
    struct Required has copy, drop, store {
        customer_required_info: vector<0x1::string::String>,
        service_pubkey: 0x1::string::String,
        time: u64,
    }

    struct Service<phantom T0> has key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        location: 0x1::string::String,
        sales: 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::Table<0x1::string::String, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale>,
        payee: address,
        withdraw_guard: 0x2::vec_map::VecMap<address, u16>,
        refund_guard: 0x2::vec_map::VecMap<address, u16>,
        repositories: vector<address>,
        buy_guard: 0x1::option::Option<address>,
        machine: 0x1::option::Option<address>,
        endpoint: 0x1::option::Option<0x1::string::String>,
        bPublished: bool,
        bPaused: bool,
        customer_required: 0x1::option::Option<Required>,
        extern_withdraw_treasuries: vector<address>,
        arbitrations: vector<address>,
        permission: address,
    }

    public fun new<T0>(arg0: 0x1::string::String, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) : Service<T0> {
        let v0 = 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission>(arg2);
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &v0, 200, arg3);
        new_imp<T0>(&arg0, arg1, &v0, arg3)
    }

    public fun create<T0>(arg0: Service<T0>) : address {
        0x2::transfer::share_object<Service<T0>>(arg0);
        0x2::object::id_address<Service<T0>>(&arg0)
    }

    public fun refund<T0>(arg0: &Service<T0>, arg1: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Order<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::ORDER(*0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::service<T0>(arg1) == 0x2::object::id_address<Service<T0>>(arg0));
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::NEED_PASSPORT(0x2::vec_map::is_empty<address, u16>(&arg0.refund_guard));
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::refund<T0>(arg1, arg2);
    }

    public fun refund_by_service<T0>(arg0: &mut Service<T0>, arg1: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Order<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 219, arg3);
        refund_by_service_imp<T0>(arg0, arg1, arg3);
    }

    public fun refund_with_passport<T0>(arg0: &Service<T0>, arg1: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Order<T0>, arg2: &0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard, arg3: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::ORDER(*0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::service<T0>(arg1) == 0x2::object::id_address<Service<T0>>(arg0));
        let v0 = 0x2::object::id_address<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard>(arg2);
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::ASSERT_PASSPORT(&v0, arg3, arg5);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::GUARD(0x2::vec_map::contains<address, u16>(&arg0.refund_guard, &v0));
        let v1 = 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::refund_with_passport<T0>(arg1, *0x2::vec_map::get<address, u16>(&arg0.refund_guard, &v0), arg5);
        if (0x2::coin::value<T0>(&v1) > 0) {
            let v2 = 0x1::option::some<address>(0x2::object::id_address<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard>(arg2));
            let v3 = 0x1::option::none<address>();
            let v4 = 0x1::string::utf8(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::REFUND_DEVISION_GUARD());
            let v5 = 0x1::option::some<address>(0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Order<T0>>(arg1));
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::payment::create2<T0>(&arg0.payee, v1, &v2, &v3, 0, &v4, &v5, arg4, arg5);
        } else {
            0x2::coin::destroy_zero<T0>(v1);
        };
    }

    public fun withdraw_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &Service<T0>, arg2: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Order<T0>, arg3: &0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard, arg4: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T0>, arg5: 0x1::option::Option<address>, arg6: u64, arg7: 0x1::string::String, arg8: &0x2::clock::Clock, arg9: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg10: &mut 0x2::tx_context::TxContext) : address {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg9, &arg1.permission, 208, arg10);
        let v0 = 0x1::option::none<address>();
        withdraw_with_passport_imp<T0>(arg0, arg1, arg2, arg3, arg4, &arg5, &v0, arg6, &arg7, arg8, arg10)
    }

    public fun arbitration_add<T0, T1>(arg0: &mut Service<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arbitration::Arbitration<T1>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 217, arg3);
        arbitration_add_imp<T0, T1>(arg0, arg1);
    }

    fun arbitration_add_imp<T0, T1>(arg0: &mut Service<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arbitration::Arbitration<T1>) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::PUBLISHED(arg0.bPublished);
        let v0 = 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arbitration::Arbitration<T1>>(arg1);
        if (!0x1::vector::contains<address>(&arg0.arbitrations, &v0)) {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::ARBITRATION_COUNT(0x1::vector::length<address>(&arg0.arbitrations));
            0x1::vector::push_back<address>(&mut arg0.arbitrations, v0);
        };
    }

    public fun arbitration_add_with_passport<T0, T1>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arbitration::Arbitration<T1>, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 217, arg4);
        arbitration_add_imp<T0, T1>(arg1, arg2);
    }

    public fun arbitration_remove<T0>(arg0: &mut Service<T0>, arg1: vector<address>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 217, arg3);
        arbitration_remove_imp<T0>(arg0, &arg1);
    }

    public fun arbitration_remove_all<T0>(arg0: &mut Service<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg2: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg1, &arg0.permission, 217, arg2);
        arbitration_remove_all_imp<T0>(arg0);
    }

    fun arbitration_remove_all_imp<T0>(arg0: &mut Service<T0>) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::PUBLISHED(arg0.bPublished);
        arg0.arbitrations = 0x1::vector::empty<address>();
    }

    public fun arbitration_remove_all_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg2, &arg1.permission, 217, arg3);
        arbitration_remove_all_imp<T0>(arg1);
    }

    fun arbitration_remove_imp<T0>(arg0: &mut Service<T0>, arg1: &vector<address>) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::PUBLISHED(arg0.bPublished);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg1)) {
            let (v1, v2) = 0x1::vector::index_of<address>(&arg0.arbitrations, 0x1::vector::borrow<address>(arg1, v0));
            if (v1) {
                0x1::vector::remove<address>(&mut arg0.arbitrations, v2);
            };
            v0 = v0 + 1;
        };
    }

    public fun arbitration_remove_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: vector<address>, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 217, arg4);
        arbitration_remove_imp<T0>(arg1, &arg2);
    }

    public fun buy<T0>(arg0: &mut Service<T0>, arg1: vector<0x1::string::String>, arg2: vector<u64>, arg3: vector<u64>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Order<T0> {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::NEED_PASSPORT(0x1::option::is_none<address>(&arg0.buy_guard));
        let v0 = &mut arg2;
        buy_imp<T0>(arg0, &arg1, v0, &arg3, arg4, arg5, arg6)
    }

    public fun buy_guard_none<T0>(arg0: &mut Service<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg2: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg1, &arg0.permission, 209, arg2);
        buy_guard_none_imp<T0>(arg0);
    }

    fun buy_guard_none_imp<T0>(arg0: &mut Service<T0>) {
        arg0.buy_guard = 0x1::option::none<address>();
    }

    public fun buy_guard_none_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg2, &arg1.permission, 209, arg3);
        buy_guard_none_imp<T0>(arg1);
    }

    public fun buy_guard_set<T0>(arg0: &mut Service<T0>, arg1: &0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 209, arg3);
        buy_guard_set_imp<T0>(arg0, arg1);
    }

    fun buy_guard_set_imp<T0>(arg0: &mut Service<T0>, arg1: &0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard) {
        0x1::option::swap_or_fill<address>(&mut arg0.buy_guard, 0x2::object::id_address<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard>(arg1));
    }

    public fun buy_guard_set_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: &0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 209, arg4);
        buy_guard_set_imp<T0>(arg1, arg2);
    }

    fun buy_imp<T0>(arg0: &mut Service<T0>, arg1: &vector<0x1::string::String>, arg2: &mut vector<u64>, arg3: &vector<u64>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Order<T0> {
        let (v0, v1) = buy_to_pay<T0>(arg0, arg1, arg2, arg3, true, true);
        let v2 = v1;
        let v3 = 0x2::object::id_address<Service<T0>>(arg0);
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::order<T0>(&v3, arg4, arg1, arg2, arg3, &v2, v0, arg5, arg6)
    }

    fun buy_to_pay<T0>(arg0: &mut Service<T0>, arg1: &vector<0x1::string::String>, arg2: &mut vector<u64>, arg3: &vector<u64>, arg4: bool, arg5: bool) : (u64, vector<0x1::option::Option<0x1::string::String>>) {
        let v0 = 0x1::vector::length<0x1::string::String>(arg1);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::ITEM_COUNT(v0);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::UNPUBLISHED(arg0.bPublished);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::PAUSED(arg0.bPaused);
        let v1 = v0 == 0x1::vector::length<u64>(arg2) && v0 == 0x1::vector::length<u64>(arg3);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::COUNTS(v1);
        let v2 = 0x1::vector::empty<0x1::option::Option<0x1::string::String>>();
        let v3 = 0;
        let v4 = 0;
        while (v4 < v0) {
            let v5 = 0x1::vector::borrow_mut<u64>(arg2, v4);
            let v6 = 0x1::vector::borrow<u64>(arg3, v4);
            let (v7, v8, v9) = resolveItem<T0>(arg0, 0x1::vector::borrow<0x1::string::String>(arg1, v4), *v5, *v6, arg4);
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::NOT_FOUND(v7);
            if (arg5) {
                0x1::vector::push_back<0x1::option::Option<0x1::string::String>>(&mut v2, v9);
            };
            *v5 = v8;
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_U64_MUL_UPFLOW(v8, *v6);
            let v10 = v8 * *v6;
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_U64_ADD_UPFLOW(v3, v10);
            v3 = v3 + v10;
            v4 = v4 + 1;
        };
        (v3, v2)
    }

    public fun buy_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: vector<0x1::string::String>, arg3: vector<u64>, arg4: vector<u64>, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Order<T0> {
        let v0 = &mut arg3;
        let v1 = buy_imp<T0>(arg1, &arg2, v0, &arg4, arg5, arg6, arg7);
        if (0x1::option::is_some<address>(&arg1.buy_guard)) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::ASSERT_PASSPORT(0x1::option::borrow<address>(&arg1.buy_guard), arg0, arg7);
        };
        v1
    }

    public fun calc_value_amount<T0>(arg0: &mut Service<T0>, arg1: vector<0x1::string::String>, arg2: vector<u64>, arg3: vector<u64>) : u64 {
        let v0 = &mut arg2;
        let (v1, _) = buy_to_pay<T0>(arg0, &arg1, v0, &arg3, false, false);
        v1
    }

    public fun clone<T0, T1>(arg0: &mut Service<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg2: &mut 0x2::tx_context::TxContext) : Service<T1> {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg1, &arg0.permission, 213, arg2);
        clone_imp<T0, T1>(arg0, arg2)
    }

    fun clone_imp<T0, T1>(arg0: &Service<T0>, arg1: &mut 0x2::tx_context::TxContext) : Service<T1> {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_address(&v0);
        Service<T1>{
            id                         : v0,
            description                : arg0.description,
            location                   : arg0.location,
            sales                      : 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::new<0x1::string::String, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale>(&v1),
            payee                      : arg0.payee,
            withdraw_guard             : arg0.withdraw_guard,
            refund_guard               : arg0.refund_guard,
            repositories               : arg0.repositories,
            buy_guard                  : arg0.buy_guard,
            machine                    : arg0.machine,
            endpoint                   : arg0.endpoint,
            bPublished                 : false,
            bPaused                    : true,
            customer_required          : arg0.customer_required,
            extern_withdraw_treasuries : arg0.extern_withdraw_treasuries,
            arbitrations               : arg0.arbitrations,
            permission                 : arg0.permission,
        }
    }

    public fun clone_with_passport<T0, T1>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) : Service<T1> {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg2, &arg1.permission, 213, arg3);
        clone_imp<T0, T1>(arg1, arg3)
    }

    public fun description_set<T0>(arg0: &mut Service<T0>, arg1: 0x1::string::String, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 201, arg3);
        description_set_imp<T0>(arg0, &arg1);
    }

    fun description_set_imp<T0>(arg0: &mut Service<T0>, arg1: &0x1::string::String) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_DESCRIPTIONLEN(arg1);
        arg0.description = *arg1;
    }

    public fun description_set_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: 0x1::string::String, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 201, arg4);
        description_set_imp<T0>(arg1, &arg2);
    }

    public fun dicount_buy_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: vector<0x1::string::String>, arg3: vector<u64>, arg4: vector<u64>, arg5: 0x2::coin::Coin<T0>, arg6: 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Discount, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Order<T0> {
        let v0 = &mut arg3;
        let v1 = disoucnt_buy_imp<T0>(arg1, &arg2, v0, &arg4, arg5, arg6, arg7, arg8);
        if (0x1::option::is_some<address>(&arg1.buy_guard)) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::ASSERT_PASSPORT(0x1::option::borrow<address>(&arg1.buy_guard), arg0, arg8);
        };
        v1
    }

    fun dicscount_create_imp<T0>(arg0: &Service<T0>, arg1: &0x1::string::String, arg2: u8, arg3: u64, arg4: 0x1::option::Option<u64>, arg5: &0x1::option::Option<u64>, arg6: u64, arg7: u64, arg8: &address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_NAMELEN(arg1);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::DNT_TIME(arg6 > 0);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::DNT_COUNT(arg7);
        let v0 = 0x2::object::id_address<Service<T0>>(arg0);
        let v1 = 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::discounts(&v0, arg1, arg2, arg3, &arg4, arg5, arg6, arg7, arg9, arg10);
        while (!0x1::vector::is_empty<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Discount>(&v1)) {
            0x2::transfer::public_transfer<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Discount>(0x1::vector::pop_back<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Discount>(&mut v1), *arg8);
        };
        0x1::vector::destroy_empty<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Discount>(v1);
    }

    public fun dicscount_create_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &Service<T0>, arg2: 0x1::string::String, arg3: u8, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: u64, arg8: u64, arg9: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg10: address, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg9, &arg1.permission, 207, arg12);
        dicscount_create_imp<T0>(arg1, &arg2, arg3, arg4, arg5, &arg6, arg7, arg8, &arg10, arg11, arg12);
    }

    public fun discount_buy<T0>(arg0: &mut Service<T0>, arg1: vector<0x1::string::String>, arg2: vector<u64>, arg3: vector<u64>, arg4: 0x2::coin::Coin<T0>, arg5: 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Discount, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Order<T0> {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::NEED_PASSPORT(0x1::option::is_none<address>(&arg0.buy_guard));
        let v0 = &mut arg2;
        disoucnt_buy_imp<T0>(arg0, &arg1, v0, &arg3, arg4, arg5, arg6, arg7)
    }

    public fun discount_create<T0>(arg0: &Service<T0>, arg1: 0x1::string::String, arg2: u8, arg3: u64, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: u64, arg7: u64, arg8: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg9: address, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg8, &arg0.permission, 207, arg11);
        dicscount_create_imp<T0>(arg0, &arg1, arg2, arg3, arg4, &arg5, arg6, arg7, &arg9, arg10, arg11);
    }

    fun disoucnt_buy_imp<T0>(arg0: &mut Service<T0>, arg1: &vector<0x1::string::String>, arg2: &mut vector<u64>, arg3: &vector<u64>, arg4: 0x2::coin::Coin<T0>, arg5: 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Discount, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Order<T0> {
        let (v0, v1) = buy_to_pay<T0>(arg0, arg1, arg2, arg3, true, true);
        let v2 = v1;
        let v3 = 0x2::object::id_address<Service<T0>>(arg0);
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::discount_order<T0>(&v3, arg4, arg1, arg2, arg3, &v2, v0, arg5, arg6, arg7)
    }

    public fun endpoint_set<T0>(arg0: &mut Service<T0>, arg1: 0x1::option::Option<0x1::string::String>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 211, arg3);
        endpoint_set_imp<T0>(arg0, arg1);
    }

    fun endpoint_set_imp<T0>(arg0: &mut Service<T0>, arg1: 0x1::option::Option<0x1::string::String>) {
        if (0x1::option::is_some<0x1::string::String>(&arg1)) {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_ENDPOINTLEN(0x1::option::borrow<0x1::string::String>(&arg1));
        };
        arg0.endpoint = arg1;
    }

    public fun endpoint_set_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: 0x1::option::Option<0x1::string::String>, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 211, arg4);
        endpoint_set_imp<T0>(arg1, arg2);
    }

    public fun guard_query<T0>(arg0: &Service<T0>, arg1: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport) {
        let v0 = 0x2::object::id_address<Service<T0>>(arg0);
        let (v1, v2, _) = 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::ON_PASSPORT(arg1, &v0);
        if (v2 == 400) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<address>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_ADDRESS(), &arg0.permission);
        } else if (v2 == 401) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<address>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_ADDRESS(), &arg0.payee);
        } else if (v2 == 402) {
            let v4 = 0x1::option::is_some<address>(&arg0.buy_guard);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL(), &v4);
        } else if (v2 == 403) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<address>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_ADDRESS(), 0x1::option::borrow<address>(&arg0.buy_guard));
        } else if (v2 == 404) {
            let v5 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_ADDRESS(v1);
            let v6 = 0x1::vector::contains<address>(&arg0.repositories, &v5);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL(), &v6);
        } else if (v2 == 405) {
            let v7 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_ADDRESS(v1);
            let v8 = 0x2::vec_map::contains<address, u16>(&arg0.withdraw_guard, &v7);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL(), &v8);
        } else if (v2 == 406) {
            let v9 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_ADDRESS(v1);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<u16>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U16(), 0x2::vec_map::get<address, u16>(&arg0.withdraw_guard, &v9));
        } else if (v2 == 407) {
            let v10 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_ADDRESS(v1);
            let v11 = 0x2::vec_map::contains<address, u16>(&arg0.refund_guard, &v10);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL(), &v11);
        } else if (v2 == 408) {
            let v12 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_ADDRESS(v1);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<u16>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U16(), 0x2::vec_map::get<address, u16>(&arg0.refund_guard, &v12));
        } else if (v2 == 409) {
            let v13 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::contains<0x1::string::String, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale>(&arg0.id, &arg0.sales, 0x1::string::utf8(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_VEC_U8(v1)));
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL(), &v13);
        } else if (v2 == 410) {
            let v14 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale_price(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::borrow<0x1::string::String, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale>(&arg0.id, &arg0.sales, 0x1::string::utf8(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_VEC_U8(v1))));
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<u64>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64(), &v14);
        } else if (v2 == 411) {
            let v15 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale_stock(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::borrow<0x1::string::String, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale>(&arg0.id, &arg0.sales, 0x1::string::utf8(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_VEC_U8(v1))));
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<u64>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64(), &v15);
        } else if (v2 == 412) {
            let v16 = 0x1::option::is_some<address>(&arg0.machine);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL(), &v16);
        } else if (v2 == 413) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<address>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_ADDRESS(), 0x1::option::borrow<address>(&arg0.machine));
        } else if (v2 == 414) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL(), &arg0.bPaused);
        } else if (v2 == 415) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL(), &arg0.bPublished);
        } else if (v2 == 416) {
            let v17 = 0x1::option::is_some<Required>(&arg0.customer_required);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL(), &v17);
        } else if (v2 == 417) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_STRING(), &0x1::option::borrow<Required>(&arg0.customer_required).service_pubkey);
        } else if (v2 == 418) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<vector<0x1::string::String>>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_STRING(), &0x1::option::borrow<Required>(&arg0.customer_required).customer_required_info);
        } else if (v2 == 419) {
            let v18 = 0x1::vector::length<address>(&arg0.extern_withdraw_treasuries);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<u64>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64(), &v18);
        } else if (v2 == 420) {
            let v19 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_ADDRESS(v1);
            let v20 = 0x1::vector::contains<address>(&arg0.extern_withdraw_treasuries, &v19);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL(), &v20);
        } else if (v2 == 421) {
            let v21 = 0x1::vector::length<address>(&arg0.arbitrations);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<u64>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64(), &v21);
        } else if (v2 == 422) {
            let v22 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_ADDRESS(v1);
            let v23 = 0x1::vector::contains<address>(&arg0.arbitrations, &v22);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL(), &v23);
        } else if (v2 == 423) {
            let v24 = 0x1::type_name::get<T0>();
            let v25 = 0x1::string::from_ascii(*0x1::type_name::borrow_string(&v24));
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_STRING(), &v25);
        } else if (v2 == 424) {
            let v26 = 0x1::type_name::get_with_original_ids<T0>();
            let v27 = 0x1::string::from_ascii(*0x1::type_name::borrow_string(&v26));
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_STRING(), &v27);
        } else if (v2 == 425) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_STRING(), &arg0.location);
        } else {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::Q_CMD_NOT_MATCH();
        };
    }

    public fun location_set<T0>(arg0: &mut Service<T0>, arg1: 0x1::string::String, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 218, arg3);
        location_set_imp<T0>(arg0, &arg1);
    }

    fun location_set_imp<T0>(arg0: &mut Service<T0>, arg1: &0x1::string::String) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_STRLEN_LESS(arg1, 256);
        arg0.location = *arg1;
    }

    public fun location_set_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: 0x1::string::String, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 218, arg4);
        location_set_imp<T0>(arg1, &arg2);
    }

    public fun machine_none<T0>(arg0: &mut Service<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg2: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg1, &arg0.permission, 210, arg2);
        machine_none_imp<T0>(arg0);
    }

    fun machine_none_imp<T0>(arg0: &mut Service<T0>) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::PUBLISHED(arg0.bPublished);
        arg0.machine = 0x1::option::none<address>();
    }

    public fun machine_none_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg2, &arg1.permission, 210, arg3);
        machine_none_imp<T0>(arg1);
    }

    public fun machine_set<T0>(arg0: &mut Service<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 210, arg3);
        machine_set_imp<T0>(arg0, arg1);
    }

    fun machine_set_imp<T0>(arg0: &mut Service<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::PUBLISHED(arg0.bPublished);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::MACHINE_PUBLISHED(0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::published(arg1));
        arg0.machine = 0x1::option::some<address>(0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine>(arg1));
    }

    public fun machine_set_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 210, arg4);
        machine_set_imp<T0>(arg1, arg2);
    }

    fun new_imp<T0>(arg0: &0x1::string::String, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T0>, arg2: &address, arg3: &mut 0x2::tx_context::TxContext) : Service<T0> {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_DESCRIPTIONLEN(arg0);
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_address(&v0);
        Service<T0>{
            id                         : v0,
            description                : *arg0,
            location                   : 0x1::string::utf8(b""),
            sales                      : 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::new<0x1::string::String, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale>(&v1),
            payee                      : 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T0>>(arg1),
            withdraw_guard             : 0x2::vec_map::empty<address, u16>(),
            refund_guard               : 0x2::vec_map::empty<address, u16>(),
            repositories               : 0x1::vector::empty<address>(),
            buy_guard                  : 0x1::option::none<address>(),
            machine                    : 0x1::option::none<address>(),
            endpoint                   : 0x1::option::none<0x1::string::String>(),
            bPublished                 : false,
            bPaused                    : false,
            customer_required          : 0x1::option::none<Required>(),
            extern_withdraw_treasuries : 0x1::vector::empty<address>(),
            arbitrations               : 0x1::vector::empty<address>(),
            permission                 : *arg2,
        }
    }

    public fun new_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: 0x1::string::String, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T0>, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) : Service<T0> {
        let v0 = 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission>(arg3);
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &v0, 200, arg4);
        new_imp<T0>(&arg1, arg2, &v0, arg4)
    }

    public fun order_bind_machine<T0>(arg0: &mut Service<T0>, arg1: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Order<T0>, arg2: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg3: &mut 0x2::tx_context::TxContext) : 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::progress::Progress {
        let v0 = 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine>(arg2);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::ORDER(*0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::service<T0>(arg1) == 0x2::object::id_address<Service<T0>>(arg0));
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::MACHINE(*0x1::option::borrow<address>(&arg0.machine) == v0);
        let v1 = 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Order<T0>>(arg1);
        let v2 = 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::progress::new2(arg2, &v1, arg3);
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::set_progress<T0>(arg1, &mut v2, &v0);
        v2
    }

    public fun order_create<T0>(arg0: &mut Service<T0>, arg1: 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Order<T0>) : address {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::ORDER(*0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::service<T0>(&arg1) == 0x2::object::id_address<Service<T0>>(arg0));
        if (0x1::option::is_some<address>(&arg0.machine)) {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::MACHINE(0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::has_progress<T0>(&arg1));
        };
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::create<T0>(arg1)
    }

    public fun order_required_info_update<T0>(arg0: &Service<T0>, arg1: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Order<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::ORDER(*0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::service<T0>(arg1) == 0x2::object::id_address<Service<T0>>(arg0));
        if (0x1::option::is_some<Required>(&arg0.customer_required)) {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::PUBKEY_NOT_MATCH(arg2 == 0x1::option::borrow<Required>(&arg0.customer_required).service_pubkey);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::required_info_answer<T0>(arg1, &arg2, &arg3, arg4);
        };
    }

    public fun pause<T0>(arg0: &mut Service<T0>, arg1: bool, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 215, arg3);
        pause_imp<T0>(arg0, arg1);
    }

    fun pause_imp<T0>(arg0: &mut Service<T0>, arg1: bool) {
        arg0.bPaused = arg1;
    }

    public fun pause_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: bool, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 215, arg4);
        pause_imp<T0>(arg1, arg2);
    }

    public fun payee_set<T0>(arg0: &mut Service<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 203, arg3);
        payee_set_imp<T0>(arg0, arg1);
    }

    fun payee_set_imp<T0>(arg0: &mut Service<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T0>) {
        arg0.payee = 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T0>>(arg1);
    }

    public fun payee_set_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T0>, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 203, arg4);
        payee_set_imp<T0>(arg1, arg2);
    }

    public fun permission_set<T0>(arg0: &mut Service<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_CREATOR(arg1, arg3);
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_ADMIN(arg2, arg3);
        arg0.permission = 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission>(arg2);
    }

    public fun price_set<T0>(arg0: &mut Service<T0>, arg1: 0x1::string::String, arg2: u64, arg3: bool, arg4: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg5: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg4, &arg0.permission, 202, arg5);
        price_set_imp<T0>(arg0, &arg1, arg2, arg3);
    }

    fun price_set_imp<T0>(arg0: &mut Service<T0>, arg1: &0x1::string::String, arg2: u64, arg3: bool) {
        if (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::contains<0x1::string::String, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale>(&arg0.id, &arg0.sales, *arg1)) {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale_price_set(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::borrow_mut<0x1::string::String, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale>(&mut arg0.id, &mut arg0.sales, *arg1), arg2);
        } else {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::NOT_FOUND(!arg3);
        };
    }

    public fun price_set_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: 0x1::string::String, arg3: u64, arg4: bool, arg5: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg6: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg5, &arg1.permission, 202, arg6);
        price_set_imp<T0>(arg1, &arg2, arg3, arg4);
    }

    public fun publish<T0>(arg0: &mut Service<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg2: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg1, &arg0.permission, 212, arg2);
        publish_imp<T0>(arg0);
    }

    fun publish_imp<T0>(arg0: &mut Service<T0>) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::NEED_WITHDRAW_GUARD(0x2::vec_map::size<address, u16>(&arg0.withdraw_guard) > 0);
        arg0.bPublished = true;
        arg0.bPaused = false;
    }

    public fun publish_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg2, &arg1.permission, 212, arg3);
        publish_imp<T0>(arg1);
    }

    fun refund_by_service_imp<T0>(arg0: &Service<T0>, arg1: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Order<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::ORDER(*0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::service<T0>(arg1) == 0x2::object::id_address<Service<T0>>(arg0));
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::refund_by_service<T0>(arg1, arg2);
    }

    public fun refund_by_service_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Order<T0>, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 219, arg4);
        refund_by_service_imp<T0>(arg1, arg2, arg4);
    }

    public fun refund_guard_add<T0>(arg0: &mut Service<T0>, arg1: &0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard, arg2: u16, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg3, &arg0.permission, 206, arg4);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_RATE(arg2);
        refund_guard_add_imp<T0>(arg0, arg1, arg2);
    }

    fun refund_guard_add_imp<T0>(arg0: &mut Service<T0>, arg1: &0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard, arg2: u16) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::PUBLISHED(arg0.bPublished);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_RATE(arg2);
        let v0 = 0x2::object::id_address<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard>(arg1);
        if (!0x2::vec_map::contains<address, u16>(&arg0.refund_guard, &v0)) {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::GUARD_COUNT(0x2::vec_map::size<address, u16>(&arg0.refund_guard));
            0x2::vec_map::insert<address, u16>(&mut arg0.refund_guard, v0, arg2);
        } else {
            *0x2::vec_map::get_mut<address, u16>(&mut arg0.refund_guard, &v0) = arg2;
        };
    }

    public fun refund_guard_add_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: &0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard, arg3: u16, arg4: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg5: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg4, &arg1.permission, 206, arg5);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_RATE(arg3);
        refund_guard_add_imp<T0>(arg1, arg2, arg3);
    }

    public fun refund_guard_remove<T0>(arg0: &mut Service<T0>, arg1: vector<address>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 206, arg3);
        refund_guard_remove_imp<T0>(arg0, &arg1);
    }

    public fun refund_guard_remove_all<T0>(arg0: &mut Service<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg2: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg1, &arg0.permission, 206, arg2);
        refund_guard_remove_all_imp<T0>(arg0);
    }

    fun refund_guard_remove_all_imp<T0>(arg0: &mut Service<T0>) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::PUBLISHED(arg0.bPublished);
        arg0.refund_guard = 0x2::vec_map::empty<address, u16>();
    }

    public fun refund_guard_remove_all_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg2, &arg1.permission, 206, arg3);
        refund_guard_remove_all_imp<T0>(arg1);
    }

    fun refund_guard_remove_imp<T0>(arg0: &mut Service<T0>, arg1: &vector<address>) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::PUBLISHED(arg0.bPublished);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg1)) {
            let v1 = 0x1::vector::borrow<address>(arg1, v0);
            if (0x2::vec_map::contains<address, u16>(&arg0.refund_guard, v1)) {
                let (_, _) = 0x2::vec_map::remove<address, u16>(&mut arg0.refund_guard, v1);
            };
            v0 = v0 + 1;
        };
    }

    public fun refund_guard_remove_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: vector<address>, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 206, arg4);
        refund_guard_remove_imp<T0>(arg1, &arg2);
    }

    public fun refund_with_arb<T0, T1>(arg0: &Service<T0>, arg1: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Order<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::Arb<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::ORDER(*0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::service<T0>(arg1) == 0x2::object::id_address<Service<T0>>(arg0));
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::ORD_ARB_NOT_MATCH(*0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::order<T1>(arg2) == 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Order<T0>>(arg1));
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::ARBITRATION_NOT_MATCH(0x1::vector::contains<address>(&arg0.arbitrations, 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::arbitration_address<T1>(arg2)));
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::ARB_PENDING(0x1::option::is_some<u64>(0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::indemnity<T1>(arg2)));
        let v0 = 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::refund_indemnity<T0>(arg1, 0x1::option::borrow<u64>(0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::indemnity<T1>(arg2)), arg4);
        if (0x2::coin::value<T0>(&v0) > 0) {
            let v1 = 0x1::option::some<address>(0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::arb::Arb<T1>>(arg2));
            let v2 = 0x1::option::none<address>();
            let v3 = 0x1::string::utf8(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::REFUND_DEVISION_ARB());
            let v4 = 0x1::option::some<address>(0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Order<T0>>(arg1));
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::payment::create2<T0>(&arg0.payee, v0, &v1, &v2, 0, &v3, &v4, arg3, arg4);
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
    }

    public fun repository_add<T0>(arg0: &mut Service<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::repository::Repository, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 204, arg3);
        repository_add_imp<T0>(arg0, arg1);
    }

    fun repository_add_imp<T0>(arg0: &mut Service<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::repository::Repository) {
        let v0 = 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::repository::Repository>(arg1);
        if (!0x1::vector::contains<address>(&arg0.repositories, &v0)) {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::REP_COUNT(0x1::vector::length<address>(&arg0.repositories));
            0x1::vector::push_back<address>(&mut arg0.repositories, v0);
        };
    }

    public fun repository_add_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::repository::Repository, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 204, arg4);
        repository_add_imp<T0>(arg1, arg2);
    }

    public fun repository_remove<T0>(arg0: &mut Service<T0>, arg1: vector<address>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 204, arg3);
        repository_remove_imp<T0>(arg0, &arg1);
    }

    public fun repository_remove_all<T0>(arg0: &mut Service<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg2: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg1, &arg0.permission, 204, arg2);
        repository_remove_all_imp<T0>(arg0);
    }

    fun repository_remove_all_imp<T0>(arg0: &mut Service<T0>) {
        arg0.repositories = 0x1::vector::empty<address>();
    }

    public fun repository_remove_all_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg2, &arg1.permission, 204, arg3);
        repository_remove_all_imp<T0>(arg1);
    }

    fun repository_remove_imp<T0>(arg0: &mut Service<T0>, arg1: &vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg1)) {
            let (v1, v2) = 0x1::vector::index_of<address>(&arg0.repositories, 0x1::vector::borrow<address>(arg1, v0));
            if (v1) {
                0x1::vector::remove<address>(&mut arg0.repositories, v2);
            };
            v0 = v0 + 1;
        };
    }

    public fun repository_remove_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: vector<address>, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 204, arg4);
        repository_remove_imp<T0>(arg1, &arg2);
    }

    public fun required_none<T0>(arg0: &mut Service<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg2: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg1, &arg0.permission, 214, arg2);
        required_none_imp<T0>(arg0);
    }

    fun required_none_imp<T0>(arg0: &mut Service<T0>) {
        arg0.customer_required = 0x1::option::none<Required>();
    }

    public fun required_none_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg2, &arg1.permission, 214, arg3);
        required_none_imp<T0>(arg1);
    }

    public fun required_pubkey_set<T0>(arg0: &mut Service<T0>, arg1: 0x1::string::String, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 214, arg3);
        required_pubkey_set_imp<T0>(arg0, &arg1);
    }

    fun required_pubkey_set_imp<T0>(arg0: &mut Service<T0>, arg1: &0x1::string::String) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::NEED_PUBKEY(!0x1::string::is_empty(arg1));
        0x1::option::borrow_mut<Required>(&mut arg0.customer_required).service_pubkey = *arg1;
    }

    public fun required_pubkey_set_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: 0x1::string::String, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 214, arg4);
        required_pubkey_set_imp<T0>(arg1, &arg2);
    }

    public fun required_set<T0>(arg0: &mut Service<T0>, arg1: vector<0x1::string::String>, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg5: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg4, &arg0.permission, 214, arg5);
        required_set_imp<T0>(arg0, &arg1, &arg2, arg3);
    }

    fun required_set_imp<T0>(arg0: &mut Service<T0>, arg1: &vector<0x1::string::String>, arg2: &0x1::string::String, arg3: &0x2::clock::Clock) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::REQ(arg2, arg1);
        let v0 = Required{
            customer_required_info : *arg1,
            service_pubkey         : *arg2,
            time                   : 0x2::clock::timestamp_ms(arg3),
        };
        arg0.customer_required = 0x1::option::some<Required>(v0);
    }

    public fun required_set_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: vector<0x1::string::String>, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg6: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg5, &arg1.permission, 214, arg6);
        required_set_imp<T0>(arg1, &arg2, &arg3, arg4);
    }

    fun resolveItem<T0>(arg0: &mut Service<T0>, arg1: &0x1::string::String, arg2: u64, arg3: u64, arg4: bool) : (bool, u64, 0x1::option::Option<0x1::string::String>) {
        if (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::contains<0x1::string::String, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale>(&arg0.id, &arg0.sales, *arg1)) {
            let (v0, v1) = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale_resolve(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::borrow_mut<0x1::string::String, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale>(&mut arg0.id, &mut arg0.sales, *arg1), arg2, arg3, arg4);
            let v2 = v1;
            if (0x1::option::is_some<0x1::string::String>(&v2)) {
                return (true, v0, v2)
            };
            return (true, v0, arg0.endpoint)
        };
        (false, 0, 0x1::option::none<0x1::string::String>())
    }

    public fun sale_endpoint_set<T0>(arg0: &mut Service<T0>, arg1: 0x1::string::String, arg2: 0x1::option::Option<0x1::string::String>, arg3: bool, arg4: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg5: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg4, &arg0.permission, 202, arg5);
        sale_endpoint_set_imp<T0>(arg0, &arg1, &arg2, arg3);
    }

    fun sale_endpoint_set_imp<T0>(arg0: &mut Service<T0>, arg1: &0x1::string::String, arg2: &0x1::option::Option<0x1::string::String>, arg3: bool) {
        if (0x1::option::is_some<0x1::string::String>(arg2)) {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_ENDPOINTLEN(0x1::option::borrow<0x1::string::String>(arg2));
        };
        if (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::contains<0x1::string::String, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale>(&arg0.id, &arg0.sales, *arg1)) {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale_endpoint_set(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::borrow_mut<0x1::string::String, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale>(&mut arg0.id, &mut arg0.sales, *arg1), arg2);
        } else {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::NOT_FOUND(!arg3);
        };
    }

    public fun sale_endpoint_set_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>, arg4: bool, arg5: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg6: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg5, &arg1.permission, 202, arg6);
        sale_endpoint_set_imp<T0>(arg1, &arg2, &arg3, arg4);
    }

    public fun sales_add<T0>(arg0: &mut Service<T0>, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: vector<u64>, arg4: vector<u64>, arg5: bool, arg6: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg7: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg6, &arg0.permission, 202, arg7);
        sales_add_imp<T0>(arg0, &arg1, &arg2, &arg3, &arg4, arg5);
    }

    fun sales_add_imp<T0>(arg0: &mut Service<T0>, arg1: &vector<0x1::string::String>, arg2: &vector<0x1::string::String>, arg3: &vector<u64>, arg4: &vector<u64>, arg5: bool) {
        let v0 = 0x1::vector::length<0x1::string::String>(arg1);
        let v1 = if (v0 == 0x1::vector::length<u64>(arg3)) {
            if (v0 == 0x1::vector::length<u64>(arg4)) {
                v0 == 0x1::vector::length<0x1::string::String>(arg2)
            } else {
                false
            }
        } else {
            false
        };
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::COUNTS(v1);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x1::vector::borrow<0x1::string::String>(arg1, v2);
            let v4 = 0x1::vector::borrow<0x1::string::String>(arg2, v2);
            let v5 = 0x1::vector::borrow<u64>(arg3, v2);
            let v6 = 0x1::vector::borrow<u64>(arg4, v2);
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_SERVICE_ITEM_NAME(v3);
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_ENDPOINTLEN(v4);
            let v7 = 0x1::option::none<0x1::string::String>();
            if (0x1::string::length(v4) > 0) {
                v7 = 0x1::option::some<0x1::string::String>(*v4);
            };
            if (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::contains<0x1::string::String, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale>(&arg0.id, &arg0.sales, *v3)) {
                0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::ITEM_EXIST(!arg5);
            } else {
                0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::add<0x1::string::String, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale>(&mut arg0.id, &mut arg0.sales, *v3, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale_new(&v7, *v5, *v6));
            };
            v2 = v2 + 1;
        };
    }

    public fun sales_add_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: vector<u64>, arg5: vector<u64>, arg6: bool, arg7: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg8: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg7, &arg1.permission, 202, arg8);
        sales_add_imp<T0>(arg1, &arg2, &arg3, &arg4, &arg5, arg6);
    }

    public fun sales_remove<T0>(arg0: &mut Service<T0>, arg1: vector<0x1::string::String>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 202, arg3);
        sales_remove_imp<T0>(arg0, &arg1);
    }

    fun sales_remove_imp<T0>(arg0: &mut Service<T0>, arg1: &vector<0x1::string::String>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(arg1)) {
            let v1 = 0x1::vector::borrow<0x1::string::String>(arg1, v0);
            if (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::contains<0x1::string::String, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale>(&arg0.id, &arg0.sales, *v1)) {
                0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::remove<0x1::string::String, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale>(&mut arg0.id, &mut arg0.sales, *v1);
            };
            v0 = v0 + 1;
        };
    }

    public fun sales_remove_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: vector<0x1::string::String>, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 202, arg4);
        sales_remove_imp<T0>(arg1, &arg2);
    }

    public fun stock_add<T0>(arg0: &mut Service<T0>, arg1: 0x1::string::String, arg2: u64, arg3: bool, arg4: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg5: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg4, &arg0.permission, 202, arg5);
        stock_add_imp<T0>(arg0, &arg1, arg2, arg3);
    }

    fun stock_add_imp<T0>(arg0: &mut Service<T0>, arg1: &0x1::string::String, arg2: u64, arg3: bool) {
        if (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::contains<0x1::string::String, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale>(&arg0.id, &arg0.sales, *arg1)) {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale_stock_add(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::borrow_mut<0x1::string::String, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale>(&mut arg0.id, &mut arg0.sales, *arg1), arg2);
        } else {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::NOT_FOUND(!arg3);
        };
    }

    public fun stock_add_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: 0x1::string::String, arg3: u64, arg4: bool, arg5: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg6: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg5, &arg1.permission, 202, arg6);
        stock_add_imp<T0>(arg1, &arg2, arg3, arg4);
    }

    public fun stock_reduce<T0>(arg0: &mut Service<T0>, arg1: 0x1::string::String, arg2: u64, arg3: bool, arg4: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg5: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg4, &arg0.permission, 202, arg5);
        stock_reduce_imp<T0>(arg0, &arg1, arg2, arg3);
    }

    fun stock_reduce_imp<T0>(arg0: &mut Service<T0>, arg1: &0x1::string::String, arg2: u64, arg3: bool) {
        if (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::contains<0x1::string::String, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale>(&arg0.id, &arg0.sales, *arg1)) {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale_stock_reduce(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::borrow_mut<0x1::string::String, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale>(&mut arg0.id, &mut arg0.sales, *arg1), arg2);
        } else {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::NOT_FOUND(!arg3);
        };
    }

    public fun stock_reduce_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: 0x1::string::String, arg3: u64, arg4: bool, arg5: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg6: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg5, &arg1.permission, 202, arg6);
        stock_reduce_imp<T0>(arg1, &arg2, arg3, arg4);
    }

    public fun stock_set<T0>(arg0: &mut Service<T0>, arg1: 0x1::string::String, arg2: u64, arg3: bool, arg4: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg5: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg4, &arg0.permission, 202, arg5);
        stock_set_imp<T0>(arg0, &arg1, arg2, arg3);
    }

    fun stock_set_imp<T0>(arg0: &mut Service<T0>, arg1: &0x1::string::String, arg2: u64, arg3: bool) {
        if (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::contains<0x1::string::String, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale>(&arg0.id, &arg0.sales, *arg1)) {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale_stock_set(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table::borrow_mut<0x1::string::String, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::Sale>(&mut arg0.id, &mut arg0.sales, *arg1), arg2);
        } else {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::NOT_FOUND(!arg3);
        };
    }

    public fun stock_set_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: 0x1::string::String, arg3: u64, arg4: bool, arg5: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg6: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg5, &arg1.permission, 202, arg6);
        stock_set_imp<T0>(arg1, &arg2, arg3, arg4);
    }

    public fun treasury_add<T0, T1>(arg0: &mut Service<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T1>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 216, arg3);
        treasury_add_imp<T0, T1>(arg0, arg1);
    }

    fun treasury_add_imp<T0, T1>(arg0: &mut Service<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T1>) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::ASSERT_WITHDRAW_MODE_GUARD_ONLY<T1>(arg1);
        let v0 = 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T1>>(arg1);
        if (!0x1::vector::contains<address>(&arg0.extern_withdraw_treasuries, &v0)) {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::TRE_COUNT(0x1::vector::length<address>(&arg0.extern_withdraw_treasuries));
            0x1::vector::push_back<address>(&mut arg0.extern_withdraw_treasuries, v0);
        };
    }

    public fun treasury_add_with_passport<T0, T1>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T1>, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 216, arg4);
        treasury_add_imp<T0, T1>(arg1, arg2);
    }

    public fun treasury_remove<T0>(arg0: &mut Service<T0>, arg1: vector<address>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 216, arg3);
        treasury_remove_imp<T0>(arg0, &arg1);
    }

    public fun treasury_remove_all<T0>(arg0: &mut Service<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg2: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg1, &arg0.permission, 216, arg2);
        treasury_remove_all_imp<T0>(arg0);
    }

    fun treasury_remove_all_imp<T0>(arg0: &mut Service<T0>) {
        arg0.extern_withdraw_treasuries = 0x1::vector::empty<address>();
    }

    public fun treasury_remove_all_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg2, &arg1.permission, 216, arg3);
        treasury_remove_all_imp<T0>(arg1);
    }

    fun treasury_remove_imp<T0>(arg0: &mut Service<T0>, arg1: &vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg1)) {
            let (v1, v2) = 0x1::vector::index_of<address>(&arg0.extern_withdraw_treasuries, 0x1::vector::borrow<address>(arg1, v0));
            if (v1) {
                0x1::vector::remove<address>(&mut arg0.extern_withdraw_treasuries, v2);
            };
            v0 = v0 + 1;
        };
    }

    public fun treasury_remove_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: vector<address>, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 215, arg4);
        treasury_remove_imp<T0>(arg1, &arg2);
    }

    public fun withdraw_forGuard_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &Service<T0>, arg2: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Order<T0>, arg3: &0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard, arg4: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T0>, arg5: 0x1::option::Option<address>, arg6: &0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard, arg7: u64, arg8: 0x1::string::String, arg9: &0x2::clock::Clock, arg10: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg11: &mut 0x2::tx_context::TxContext) : address {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg10, &arg1.permission, 208, arg11);
        let v0 = 0x1::option::some<address>(0x2::object::id_address<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard>(arg6));
        withdraw_with_passport_imp<T0>(arg0, arg1, arg2, arg3, arg4, &arg5, &v0, arg7, &arg8, arg9, arg11)
    }

    public fun withdraw_guard_add<T0>(arg0: &mut Service<T0>, arg1: &0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard, arg2: u16, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg3, &arg0.permission, 205, arg4);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_RATE(arg2);
        withdraw_guard_add_imp<T0>(arg0, arg1, arg2);
    }

    fun withdraw_guard_add_imp<T0>(arg0: &mut Service<T0>, arg1: &0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard, arg2: u16) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::PUBLISHED(arg0.bPublished);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_RATE(arg2);
        let v0 = 0x2::object::id_address<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard>(arg1);
        if (!0x2::vec_map::contains<address, u16>(&arg0.withdraw_guard, &v0)) {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::GUARD_COUNT(0x2::vec_map::size<address, u16>(&arg0.withdraw_guard));
            0x2::vec_map::insert<address, u16>(&mut arg0.withdraw_guard, v0, arg2);
        } else {
            *0x2::vec_map::get_mut<address, u16>(&mut arg0.withdraw_guard, &v0) = arg2;
        };
    }

    public fun withdraw_guard_add_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: &0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard, arg3: u16, arg4: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg5: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg4, &arg1.permission, 205, arg5);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_RATE(arg3);
        withdraw_guard_add_imp<T0>(arg1, arg2, arg3);
    }

    public fun withdraw_guard_remove<T0>(arg0: &mut Service<T0>, arg1: vector<address>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, &arg0.permission, 205, arg3);
        withdraw_guard_remove_imp<T0>(arg0, &arg1);
    }

    public fun withdraw_guard_remove_all<T0>(arg0: &mut Service<T0>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg2: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg1, &arg0.permission, 205, arg2);
        withdraw_guard_remove_all_imp<T0>(arg0);
    }

    fun withdraw_guard_remove_all_imp<T0>(arg0: &mut Service<T0>) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::PUBLISHED(arg0.bPublished);
        arg0.withdraw_guard = 0x2::vec_map::empty<address, u16>();
    }

    public fun withdraw_guard_remove_all_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg2, &arg1.permission, 205, arg3);
        withdraw_guard_remove_all_imp<T0>(arg1);
    }

    fun withdraw_guard_remove_imp<T0>(arg0: &mut Service<T0>, arg1: &vector<address>) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::PUBLISHED(arg0.bPublished);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg1)) {
            let v1 = 0x1::vector::borrow<address>(arg1, v0);
            if (0x2::vec_map::contains<address, u16>(&arg0.withdraw_guard, v1)) {
                let (_, _) = 0x2::vec_map::remove<address, u16>(&mut arg0.withdraw_guard, v1);
            };
            v0 = v0 + 1;
        };
    }

    public fun withdraw_guard_remove_with_passport<T0>(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Service<T0>, arg2: vector<address>, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, &arg1.permission, 205, arg4);
        withdraw_guard_remove_imp<T0>(arg1, &arg2);
    }

    fun withdraw_with_passport_imp<T0>(arg0: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &Service<T0>, arg2: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Order<T0>, arg3: &0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard, arg4: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T0>, arg5: &0x1::option::Option<address>, arg6: &0x1::option::Option<address>, arg7: u64, arg8: &0x1::string::String, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : address {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::ORDER(*0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::service<T0>(arg2) == 0x2::object::id_address<Service<T0>>(arg1));
        let v0 = 0x2::object::id_address<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard::Guard>(arg3);
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::ASSERT_PASSPORT(&v0, arg0, arg10);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::GUARD(0x2::vec_map::contains<address, u16>(&arg1.withdraw_guard, &v0));
        let v1 = 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::treasury::Treasury<T0>>(arg4);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::service::FEE_TRE_NOT_MATCH(arg1.payee == v1);
        let v2 = 0x1::option::some<address>(0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::Order<T0>>(arg2));
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::payment::create2<T0>(&v1, 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::order::withdraw_with_passport<T0>(arg2, *0x2::vec_map::get<address, u16>(&arg1.withdraw_guard, &v0), arg10), arg5, arg6, arg7, arg8, &v2, arg9, arg10)
    }

    // decompiled from Move bytecode v6
}

