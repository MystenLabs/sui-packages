module 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::progress {
    struct Progress has key {
        id: 0x2::object::UID,
        machine: address,
        parent: 0x1::option::Option<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Parent>,
        context_repository: 0x1::option::Option<address>,
        current: 0x1::string::String,
        task: 0x1::option::Option<address>,
        namedOperator: 0x2::vec_map::VecMap<0x1::string::String, vector<address>>,
        session: 0x2::vec_map::VecMap<0x1::string::String, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Session>,
        history: 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::TableVec<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>,
    }

    public fun new(arg0: 0x1::option::Option<address>, arg1: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) : Progress {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::permission_id(arg1), 650, arg3);
        new_imp(&arg0, arg1, arg3)
    }

    fun ASSERT_PERMISSION(arg0: &Progress, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &0x1::string::String, arg4: &0x1::option::Option<u16>, arg5: &mut 0x2::tx_context::TxContext) {
        if (IsNamedOperator(arg0, arg3, arg5)) {
            return
        };
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::PERM_NONE(0x1::option::is_some<u16>(arg4));
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::permission_id(arg1), *0x1::option::borrow<u16>(arg4), arg5);
    }

    fun ASSERT_PERMISSION_WITH_PASSPORT(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &Progress, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &0x1::string::String, arg5: &0x1::option::Option<u16>, arg6: &mut 0x2::tx_context::TxContext) {
        if (IsNamedOperator(arg1, arg4, arg6)) {
            return
        };
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::PERM_NONE(0x1::option::is_some<u16>(arg5));
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::permission_id(arg2), *0x1::option::borrow<u16>(arg5), arg6);
    }

    fun INFOMATION(arg0: &Progress, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg2: &0x1::string::String, arg3: &0x1::string::String) : (u32, u16, 0x1::option::Option<address>, vector<u8>, 0x1::string::String, 0x1::option::Option<u16>) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::MACHINE(arg0.machine == 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine>(arg1));
        let v0 = 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::node_borrow(arg1, arg2);
        let (v1, v2, v3, v4, v5) = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::machine::forward_data(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::machine::forward_borrow(v0, &arg0.current, arg3));
        (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::machine::threshold(v0, &arg0.current), v1, v2, v3, *v4, *v5)
    }

    fun IsNamedOperator(arg0: &Progress, arg1: &0x1::string::String, arg2: &0x2::tx_context::TxContext) : bool {
        if (0x2::vec_map::contains<0x1::string::String, vector<address>>(&arg0.namedOperator, arg1)) {
            let v0 = 0x2::tx_context::sender(arg2);
            return 0x1::vector::contains<address>(0x2::vec_map::get<0x1::string::String, vector<address>>(&arg0.namedOperator, arg1), &v0)
        };
        false
    }

    public(friend) fun OrderPayer_set(arg0: &mut Progress, arg1: &vector<address>) {
        let v0 = 0x1::string::utf8(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::ORDER_PAYER());
        if (0x2::vec_map::contains<0x1::string::String, vector<address>>(&arg0.namedOperator, &v0)) {
            *0x2::vec_map::get_mut<0x1::string::String, vector<address>>(&mut arg0.namedOperator, &v0) = *arg1;
        } else {
            0x2::vec_map::insert<0x1::string::String, vector<address>>(&mut arg0.namedOperator, v0, *arg1);
        };
    }

    public fun context_repository_none(arg0: &mut Progress, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::permission_id(arg1), 653, arg3);
        context_repository_none_imp(arg0, arg1);
    }

    fun context_repository_none_imp(arg0: &mut Progress, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::MACHINE(arg0.machine == 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine>(arg1));
        arg0.context_repository = 0x1::option::none<address>();
    }

    public fun context_repository_none_with_passport(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Progress, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::permission_id(arg2), 653, arg4);
        context_repository_none_imp(arg1, arg2);
    }

    public fun context_repository_set(arg0: &mut Progress, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::repository::Repository, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg3, 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::permission_id(arg2), 653, arg4);
        context_repository_set_imp(arg0, arg1, arg2);
    }

    fun context_repository_set_imp(arg0: &mut Progress, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::repository::Repository, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::MACHINE(arg0.machine == 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine>(arg2));
        arg0.context_repository = 0x1::option::some<address>(0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::repository::Repository>(arg1));
    }

    public fun context_repository_set_with_passport(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Progress, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::repository::Repository, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg4: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg5: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg4, 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::permission_id(arg3), 653, arg5);
        context_repository_set_imp(arg1, arg2, arg3);
    }

    public fun create(arg0: Progress) : address {
        0x2::transfer::share_object<Progress>(arg0);
        0x2::object::id_address<Progress>(&arg0)
    }

    public fun guard_query(arg0: &Progress, arg1: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport) {
        let v0 = 0x2::object::id_address<Progress>(arg0);
        let (v1, v2, _) = 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::ON_PASSPORT(arg1, &v0);
        if (v2 == 800) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<address>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_ADDRESS(), &arg0.machine);
        } else if (v2 == 801) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_STRING(), &arg0.current);
        } else if (v2 == 802) {
            let v4 = 0x1::option::is_some<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Parent>(&arg0.parent);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL(), &v4);
        } else if (v2 == 803) {
            let v5 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Parent_parent(&arg0.parent);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<address>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_ADDRESS(), &v5);
        } else if (v2 == 804) {
            let v6 = 0x1::option::is_some<address>(&arg0.task);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL(), &v6);
        } else if (v2 == 805) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<address>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_ADDRESS(), 0x1::option::borrow<address>(&arg0.task));
        } else if (v2 == 806) {
            let v7 = 0x1::string::utf8(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_VEC_U8(v1));
            let v8 = 0x2::vec_map::contains<0x1::string::String, vector<address>>(&arg0.namedOperator, &v7);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL(), &v8);
        } else if (v2 == 807) {
            let v9 = 0x1::string::utf8(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_VEC_U8(v1));
            let v10 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_ADDRESS(v1);
            let v11 = 0x1::vector::contains<address>(0x2::vec_map::get<0x1::string::String, vector<address>>(&arg0.namedOperator, &v9), &v10);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL(), &v11);
        } else if (v2 == 808) {
            let v12 = 0x1::option::is_some<address>(&arg0.context_repository);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL(), &v12);
        } else if (v2 == 809) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<address>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_ADDRESS(), 0x1::option::borrow<address>(&arg0.context_repository));
        } else if (v2 == 810) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<u64>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64(), 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History_time(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::borrow<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&arg0.id, &arg0.history, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::length<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&arg0.history) - 1)));
        } else if (v2 == 811) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_STRING(), 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History_node(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::borrow<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&arg0.id, &arg0.history, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::length<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&arg0.history) - 1)));
        } else if (v2 == 812) {
            let v13 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::length<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&arg0.history);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<u64>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64(), &v13);
        } else if (v2 == 813) {
            let v14 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Parent_session_index(&arg0.parent);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<u64>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64(), &v14);
        } else if (v2 == 814) {
            let v15 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Parent_next_node(&arg0.parent);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_STRING(), &v15);
        } else if (v2 == 815) {
            let v16 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Parent_forward(&arg0.parent);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_STRING(), &v16);
        } else if (v2 == 816) {
            let v17 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Parent_node(&arg0.parent);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_STRING(), &v17);
        } else if (v2 == 817) {
            let v18 = session_holder3(arg0, v1);
            let v19 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Holder_accomplished(&v18);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL(), &v19);
        } else if (v2 == 818) {
            let v20 = session_holder3(arg0, v1);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<address>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_ADDRESS(), 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Holder_who(&v20));
        } else if (v2 == 819) {
            let v21 = session_holder3(arg0, v1);
            let v22 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Holder_msg(&v21);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_STRING(), &v22);
        } else if (v2 == 820) {
            let v23 = session_holder2(arg0, v1);
            let v24 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Holder_orders_count(&v23);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<u64>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64(), &v24);
        } else if (v2 == 821) {
            let v25 = session_holder3(arg0, v1);
            let v26 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Holder_time(&v25);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<u64>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64(), &v26);
        } else if (v2 == 822) {
            let v27 = session_holder3(arg0, v1);
            let v28 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_ADDRESS(v1);
            let v29 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Holder_has_order(&v27, &v28);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64(), &v29);
        } else if (v2 == 823) {
            let v30 = session_holder2(arg0, v1);
            let v31 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Holder_accomplished(&v30);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL(), &v31);
        } else if (v2 == 824) {
            let v32 = session_holder2(arg0, v1);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<address>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_ADDRESS(), 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Holder_who(&v32));
        } else if (v2 == 825) {
            let v33 = session_holder2(arg0, v1);
            let v34 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Holder_msg(&v33);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_STRING(), &v34);
        } else if (v2 == 826) {
            let v35 = session_holder2(arg0, v1);
            let v36 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Holder_orders_count(&v35);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<u64>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64(), &v36);
        } else if (v2 == 827) {
            let v37 = session_holder2(arg0, v1);
            let v38 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Holder_time(&v37);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<u64>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64(), &v38);
        } else if (v2 == 828) {
            let v39 = session_holder2(arg0, v1);
            let v40 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_ADDRESS(v1);
            let v41 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Holder_has_order(&v39, &v40);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64(), &v41);
        } else if (v2 == 829) {
            let v42 = recent_session_holder(arg0, v1);
            let v43 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Holder_accomplished(&v42);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL(), &v43);
        } else if (v2 == 830) {
            let v44 = recent_session_holder(arg0, v1);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<address>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_ADDRESS(), 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Holder_who(&v44));
        } else if (v2 == 831) {
            let v45 = recent_session_holder(arg0, v1);
            let v46 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Holder_msg(&v45);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<0x1::string::String>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_STRING(), &v46);
        } else if (v2 == 832) {
            let v47 = recent_session_holder(arg0, v1);
            let v48 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Holder_orders_count(&v47);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<u64>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64(), &v48);
        } else if (v2 == 833) {
            let v49 = recent_session_holder(arg0, v1);
            let v50 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Holder_time(&v49);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<u64>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64(), &v50);
        } else if (v2 == 834) {
            let v51 = recent_session_holder(arg0, v1);
            let v52 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_ADDRESS(v1);
            let v53 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Holder_has_order(&v51, &v52);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<bool>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL(), &v53);
        } else if (v2 == 835) {
            let v54 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::length<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&arg0.history);
            let v55 = 0;
            while (v54 > 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Max_RecordLen(v54)) {
                if (*0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History_node(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::borrow<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&arg0.id, &arg0.history, v54 - 1)) == 0x1::string::utf8(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_VEC_U8(v1))) {
                    let v56 = v55;
                    v55 = v56 + 1;
                };
                v54 = v54 - 1;
            };
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<u64>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64(), &v55);
        } else if (v2 == 836) {
            let v57 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::length<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&arg0.history);
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::NOT_FOUND_IN_HISTORY(v57 > 0);
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<u64>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64(), 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History_time(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::borrow<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&arg0.id, &arg0.history, v57 - 1)));
        } else if (v2 == 837) {
            let v58 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::length<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&arg0.history);
            let v59 = v58;
            let v60 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Max_RecordLen(v58);
            while (v59 > v60) {
                let v61 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::borrow<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&arg0.id, &arg0.history, v59 - 1);
                if (*0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History_node(v61) == 0x1::string::utf8(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_VEC_U8(v1))) {
                    0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<u64>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64(), 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History_time(v61));
                    break
                };
                v59 = v59 - 1;
            };
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::NOT_FOUND_IN_HISTORY(v59 > v60);
        } else if (v2 == 838) {
            let v62 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Max_RecordLen2(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::length<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&arg0.history));
            let v63 = 0;
            while (v63 < v62) {
                let v64 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::borrow<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&arg0.id, &arg0.history, v63);
                if (*0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History_node(v64) == 0x1::string::utf8(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_VEC_U8(v1))) {
                    0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<u64>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64(), 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History_time(v64));
                    break
                };
                v63 = v63 + 1;
            };
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::NOT_FOUND_IN_HISTORY(v63 < v62);
        } else if (v2 == 839) {
            let v65 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::length<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&arg0.history);
            let v66 = v65;
            let v67 = 0;
            let v68 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Max_RecordLen(v65);
            while (v66 > v68) {
                if (*0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History_node(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::borrow<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&arg0.id, &arg0.history, v66 - 1)) == 0x1::string::utf8(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_VEC_U8(v1))) {
                    if (v67 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_U64(v1)) {
                        let v69 = v66 - 1;
                        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<u64>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64(), &v69);
                        break
                    };
                    v67 = v67 + 1;
                };
                v66 = v66 - 1;
            };
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::NOT_FOUND_IN_HISTORY(v66 > v68);
        } else if (v2 == 840) {
            let v70 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Max_RecordLen2(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::length<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&arg0.history));
            let v71 = 0;
            let v72 = 0;
            while (v71 < v70) {
                if (*0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History_node(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::borrow<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&arg0.id, &arg0.history, v71)) == 0x1::string::utf8(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_VEC_U8(v1))) {
                    if (v72 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_U64(v1)) {
                        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<u64>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64(), &v71);
                        break
                    };
                    v72 = v72 + 1;
                };
                let v73 = v71;
                v71 = v73 - 1;
            };
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::NOT_FOUND_IN_HISTORY(v71 < v70);
        } else {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::Q_CMD_NOT_MATCH();
        };
    }

    public fun hold(arg0: &mut Progress, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: bool, arg5: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        hold_imp(arg0, arg1, &arg2, &arg3, arg4, arg5, true, arg6, arg7);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::length<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&arg0.history)
    }

    fun hold_imp(arg0: &mut Progress, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg2: &0x1::string::String, arg3: &0x1::string::String, arg4: bool, arg5: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, _, _, _, v4, v5) = INFOMATION(arg0, arg1, arg2, arg3);
        let v6 = v5;
        let v7 = v4;
        if (!arg6 && !arg4) {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Session_hold(&mut arg0.session, arg2, arg3, v0, false, true, arg7, arg8);
        } else {
            ASSERT_PERMISSION(arg0, arg1, arg5, &v7, &v6, arg8);
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Session_hold(&mut arg0.session, arg2, arg3, v0, arg4, false, arg7, arg8);
        };
    }

    fun hold_imp_with_passport(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Progress, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg3: &0x1::string::String, arg4: &0x1::string::String, arg5: bool, arg6: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, _, _, _, v4, v5) = INFOMATION(arg1, arg2, arg3, arg4);
        let v6 = v5;
        let v7 = v4;
        ASSERT_PERMISSION_WITH_PASSPORT(arg0, arg1, arg2, arg6, &v7, &v6, arg8);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Session_hold(&mut arg1.session, arg3, arg4, v0, arg5, false, arg7, arg8);
    }

    public fun hold_with_passport(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Progress, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: bool, arg6: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        hold_imp_with_passport(arg0, arg1, arg2, &arg3, &arg4, arg5, arg6, arg7, arg8);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::length<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&arg1.history)
    }

    public fun namedOperator_set(arg0: &mut Progress, arg1: 0x1::string::String, arg2: vector<address>, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg4: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg5: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg4, 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::permission_id(arg3), 651, arg5);
        namedOperator_set_imp(arg0, &arg1, &arg2, arg3);
    }

    fun namedOperator_set_imp(arg0: &mut Progress, arg1: &0x1::string::String, arg2: &vector<address>, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_NAMELEN(arg1);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::OPOR_COUNT(0x1::vector::length<address>(arg2));
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::MACHINE(arg0.machine == 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine>(arg3));
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::NOT_PAYER(0x1::string::as_bytes(arg1));
        if (0x2::vec_map::contains<0x1::string::String, vector<address>>(&arg0.namedOperator, arg1)) {
            *0x2::vec_map::get_mut<0x1::string::String, vector<address>>(&mut arg0.namedOperator, arg1) = *arg2;
        } else {
            0x2::vec_map::insert<0x1::string::String, vector<address>>(&mut arg0.namedOperator, *arg1, *arg2);
        };
    }

    public fun namedOperator_set_with_passport(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Progress, arg2: 0x1::string::String, arg3: vector<address>, arg4: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg5: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg6: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg5, 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::permission_id(arg4), 651, arg6);
        namedOperator_set_imp(arg1, &arg2, &arg3, arg4);
    }

    public(friend) fun new2(arg0: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg1: &address, arg2: &mut 0x2::tx_context::TxContext) : Progress {
        let v0 = 0x1::option::some<address>(*arg1);
        new_imp(&v0, arg0, arg2)
    }

    fun new_imp(arg0: &0x1::option::Option<address>, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg2: &mut 0x2::tx_context::TxContext) : Progress {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::on_progress_new(arg1);
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine>(arg1);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::NewProgressEvent_emit(&v1, &v2, arg0);
        Progress{
            id                 : v0,
            machine            : 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine>(arg1),
            parent             : 0x1::option::none<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Parent>(),
            context_repository : 0x1::option::none<address>(),
            current            : 0x1::string::utf8(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::INITIAL_NODE_NAME()),
            task               : *arg0,
            namedOperator      : 0x2::vec_map::empty<0x1::string::String, vector<address>>(),
            session            : 0x2::vec_map::empty<0x1::string::String, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Session>(),
            history            : 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::empty<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&v1),
        }
    }

    public fun new_with_passport(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: 0x1::option::Option<address>, arg2: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) : Progress {
        let v0 = new_imp(&arg1, arg2, arg4);
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::permission_id(arg2), 650, arg4);
        v0
    }

    public fun next(arg0: &mut Progress, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        let (v0, v1, v2, _, v4, v5) = INFOMATION(arg0, arg1, &arg2, &arg3);
        let v6 = v5;
        let v7 = v4;
        let v8 = v2;
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::NEED_PASSPORT(0x1::option::is_none<address>(&v8));
        ASSERT_PERMISSION(arg0, arg1, arg5, &v7, &v6, arg7);
        let v9 = 0x1::vector::empty<address>();
        session_accomplish(arg0, &arg2, &arg3, v0, v1, &arg4, &v9, arg6, arg7);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::length<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&arg0.history)
    }

    public fun next_with_passport(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Progress, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        let (v0, v1, v2, v3, v4, v5) = INFOMATION(arg1, arg2, &arg3, &arg4);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = v2;
        ASSERT_PERMISSION_WITH_PASSPORT(arg0, arg1, arg2, arg6, &v7, &v6, arg8);
        if (0x1::option::is_some<address>(&v9)) {
            if (0x1::vector::is_empty<u8>(&v8)) {
                0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::ASSERT_PASSPORT(0x1::option::borrow<address>(&v9), arg0, arg8);
            } else {
                let (v10, _) = 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::ASSERT_PASSPORT_AND_VALUE(0x1::option::borrow<address>(&v9), arg0, &v8, arg8);
                let v12 = v10;
                0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::IDENTIFER_VALUE_NOT_FOUND(0x1::vector::length<address>(&v12) == 0x1::vector::length<u8>(&v8));
                session_accomplish(arg1, &arg3, &arg4, v0, v1, &arg5, &v12, arg7, arg8);
                return 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::length<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&arg1.history)
            };
        };
        let v13 = 0x1::vector::empty<address>();
        session_accomplish(arg1, &arg3, &arg4, v0, v1, &arg5, &v13, arg7, arg8);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::length<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&arg1.history)
    }

    public fun parent_none(arg0: &mut Progress, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg2, 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::permission_id(arg1), 655, arg3);
        parent_none_imp(arg0);
    }

    fun parent_none_imp(arg0: &mut Progress) {
        arg0.parent = 0x1::option::none<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Parent>();
    }

    public fun parent_none_with_passport(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Progress, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg3, 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::permission_id(arg2), 655, arg4);
        parent_none_imp(arg1);
    }

    public fun parent_set(arg0: &mut Progress, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg2: &Progress, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg7: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg6, 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::permission_id(arg1), 655, arg7);
        parent_set_imp(arg0, arg2, arg3, &arg4, &arg5);
    }

    fun parent_set_imp(arg0: &mut Progress, arg1: &Progress, arg2: u64, arg3: &0x1::string::String, arg4: &0x1::string::String) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_NAMELEN_ANDNOT_EMPTY(arg3);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_NAMELEN_ANDNOT_EMPTY(arg4);
        let (v0, v1) = session_holder(arg1, arg2, arg3, arg4);
        let v2 = v1;
        let v3 = v0;
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::PARENT(0x1::option::is_some<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Holder>(&v3));
        let v4 = 0x2::object::id_address<Progress>(arg1);
        arg0.parent = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Parent_new(&v4, arg2, arg3, arg4, 0x1::option::borrow<0x1::string::String>(&v2));
    }

    public fun parent_set_with_passport(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Progress, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg3: &Progress, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg8: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg7, 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::permission_id(arg2), 655, arg8);
        parent_set_imp(arg1, arg3, arg4, &arg5, &arg6);
    }

    fun recent_session_holder(arg0: &Progress, arg1: &mut vector<vector<u8>>) : 0x1::option::Option<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Holder> {
        let v0 = 0x1::string::utf8(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_VEC_U8(arg1));
        let v1 = 0x1::string::utf8(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_VEC_U8(arg1));
        let v2 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::length<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&arg0.history);
        while (v2 > 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Max_RecordLen(v2)) {
            let v3 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::borrow<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&arg0.id, &arg0.history, v2 - 1);
            if (*0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History_node(v3) == 0x1::string::utf8(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_VEC_U8(arg1))) {
                return 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Session_holder(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History_session(v3), &v0, &v1)
            };
            v2 = v2 - 1;
        };
        0x1::option::none<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Holder>()
    }

    fun session_accomplish(arg0: &mut Progress, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: u32, arg4: u16, arg5: &0x1::string::String, arg6: &vector<address>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_DESCRIPTIONLEN(arg5);
        if (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Session_accomplish(&mut arg0.session, arg1, arg2, arg3, arg4, arg6, arg5, arg7, arg8)) {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::push_back<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&mut arg0.id, &mut arg0.history, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History_new(&arg0.current, arg1, &arg0.session, arg7));
            arg0.session = 0x2::vec_map::empty<0x1::string::String, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Session>();
            arg0.current = *arg1;
        };
    }

    fun session_holder(arg0: &Progress, arg1: u64, arg2: &0x1::string::String, arg3: &0x1::string::String) : (0x1::option::Option<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Holder>, 0x1::option::Option<0x1::string::String>) {
        if (arg1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::length<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&arg0.history)) {
            return (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Session_holder(&arg0.session, arg2, arg3), 0x1::option::some<0x1::string::String>(arg0.current))
        };
        if (arg1 < 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::length<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&arg0.history)) {
            return 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History_session_holder(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::borrow<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&arg0.id, &arg0.history, arg1), arg2, arg3)
        };
        (0x1::option::none<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Holder>(), 0x1::option::none<0x1::string::String>())
    }

    fun session_holder2(arg0: &Progress, arg1: &mut vector<vector<u8>>) : 0x1::option::Option<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Holder> {
        let v0 = 0x1::string::utf8(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_VEC_U8(arg1));
        let v1 = 0x1::string::utf8(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_VEC_U8(arg1));
        let (v2, _) = session_holder(arg0, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_U64(arg1), &v0, &v1);
        v2
    }

    fun session_holder3(arg0: &Progress, arg1: &mut vector<vector<u8>>) : 0x1::option::Option<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Holder> {
        let v0 = 0x1::string::utf8(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_VEC_U8(arg1));
        let v1 = 0x1::string::utf8(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::GET_VEC_U8(arg1));
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::Session_holder(&arg0.session, &v0, &v1)
    }

    public fun session_index_current(arg0: &Progress) : u64 {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::table_vec::length<0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::History>(&arg0.history)
    }

    public fun task_set(arg0: &mut Progress, arg1: address, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT(arg3, 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::permission_id(arg2), 652, arg4);
        task_set_imp(arg0, &arg1, arg2);
    }

    fun task_set_imp(arg0: &mut Progress, arg1: &address, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::MACHINE(arg0.machine == 0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine>(arg2));
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress::TASK(0x1::option::is_none<address>(&arg0.task));
        arg0.task = 0x1::option::some<address>(*arg1);
    }

    public fun task_set_with_passport(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Progress, arg2: address, arg3: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg4: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg5: &mut 0x2::tx_context::TxContext) {
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::ASSERT_RIGHT_WITH_PASSPORT(arg0, arg4, 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::permission_id(arg3), 652, arg5);
        task_set_imp(arg1, &arg2, arg3);
    }

    public fun unhold(arg0: &mut Progress, arg1: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::HAS_RIGHT(arg4, 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::permission_id(arg1), 654, arg6)) {
            hold_imp(arg0, arg1, &arg2, &arg3, false, arg4, false, arg5, arg6);
        } else {
            hold_imp(arg0, arg1, &arg2, &arg3, false, arg4, true, arg5, arg6);
        };
    }

    public fun unhold_with_passport(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: &mut Progress, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::Machine, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        if (0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::HAS_RIGHT_WITH_PASSPORT(arg0, arg5, 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::machine::permission_id(arg2), 654, arg7)) {
            hold_imp(arg1, arg2, &arg3, &arg4, false, arg5, false, arg6, arg7);
        } else {
            hold_imp_with_passport(arg0, arg1, arg2, &arg3, &arg4, false, arg5, arg6, arg7);
        };
    }

    public fun witness(arg0: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport, arg1: u8, arg2: vector<u8>, arg3: &Progress) {
        let v0 = 0x1::vector::singleton<u8>(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_PROGRESS_MACHINE());
        let v1 = 0x1::vector::singleton<address>(arg3.machine);
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::witness_add(arg0, arg1, &arg2, &v0, &v1);
    }

    // decompiled from Move bytecode v6
}

