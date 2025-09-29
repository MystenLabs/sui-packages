module 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::passport {
    struct GuardData has copy, drop, store {
        guard_id: address,
        constants: vector<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Constant>,
        bcs: 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::BCS,
        witness: Witness,
    }

    struct Witness has copy, drop, store {
        identifier: vector<u8>,
        type: vector<u8>,
        object: vector<address>,
    }

    struct Passport has key {
        id: 0x2::object::UID,
        guard: vector<GuardData>,
        process: vector<vector<u8>>,
        tx_hash: vector<u8>,
        guard_cursor: u64,
        bStartVerify: bool,
        result: bool,
        current_object: address,
        internal_check: vector<address>,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : Passport {
        Passport{
            id             : 0x2::object::new(arg0),
            guard          : 0x1::vector::empty<GuardData>(),
            process        : 0x1::vector::empty<vector<u8>>(),
            tx_hash        : *0x2::tx_context::digest(arg0),
            guard_cursor   : 0,
            bStartVerify   : false,
            result         : false,
            current_object : @0x0,
            internal_check : 0x1::vector::empty<address>(),
        }
    }

    public fun ASSERT_PASSPORT(arg0: &address, arg1: &Passport, arg2: &0x2::tx_context::TxContext) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::FAIL(USE_PASSPORT(arg0, arg1, arg2));
    }

    public fun ASSERT_PASSPORT_AND_VALUE(arg0: &address, arg1: &Passport, arg2: &vector<u8>, arg3: bool, arg4: &0x2::tx_context::TxContext) : vector<address> {
        ASSERT_PASSPORT(arg0, arg1, arg4);
        if (0x1::vector::is_empty<u8>(arg2)) {
            return 0x1::vector::empty<address>()
        };
        let v0 = 0x1::vector::length<GuardData>(&arg1.guard);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<GuardData>(&arg1.guard, v1);
            if (v2.guard_id == *arg0) {
                let v3 = 0;
                let v4 = 0x1::vector::empty<address>();
                while (v3 < 0x1::vector::length<u8>(arg2)) {
                    let v5 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Constant_value(&v2.constants, *0x1::vector::borrow<u8>(arg2, v3), 0x1::option::some<bool>(true));
                    if (*0x1::vector::borrow<u8>(&v5, 0) == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS()) {
                        0x1::vector::remove<u8>(&mut v5, 0);
                        0x1::vector::push_back<address>(&mut v4, 0x2::address::from_bytes(v5));
                    } else {
                        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::NOT_CONVERT_NUMBER_ALLOWED(arg3);
                        0x1::vector::remove<u8>(&mut v5, 0);
                        0x1::vector::push_back<address>(&mut v4, 0x2::address::from_u256(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_AS_U256_Imp(&v5)));
                    };
                    v3 = v3 + 1;
                };
                return v4
            };
            v1 = v1 + 1;
        };
        if (v1 == v0) {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::MATCH(false);
        };
        0x1::vector::empty<address>()
    }

    public(friend) fun BUILD_RESULT_DATA<T0>(arg0: &mut vector<vector<u8>>, arg1: u8, arg2: &T0) {
        let v0 = 0x1::bcs::to_bytes<T0>(arg2);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::BUILD_TYPED_DATA(arg1, &mut v0);
        0x1::vector::push_back<vector<u8>>(arg0, v0);
    }

    public(friend) fun ON_PASSPORT(arg0: &mut Passport, arg1: &address) : (&mut vector<vector<u8>>, u16, &mut vector<address>) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::FINISHED(!finished(arg0));
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::Q_OBJECT_NOT_MATCH(*arg1 == arg0.current_object);
        arg0.current_object = @0x0;
        (&mut arg0.process, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_u16(&mut 0x1::vector::borrow_mut<GuardData>(&mut arg0.guard, arg0.guard_cursor).bcs), &mut arg0.internal_check)
    }

    public(friend) fun USE_PASSPORT(arg0: &address, arg1: &Passport, arg2: &0x2::tx_context::TxContext) : bool {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::MATCH(has_guard(arg1, arg0));
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::UNFINISHED(finished(arg1));
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::USED(arg1.tx_hash == *0x2::tx_context::digest(arg2));
        arg1.result
    }

    public fun destroy(arg0: Passport) {
        let Passport {
            id             : v0,
            guard          : _,
            process        : _,
            tx_hash        : _,
            guard_cursor   : _,
            bStartVerify   : _,
            result         : _,
            current_object : _,
            internal_check : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun finished(arg0: &Passport) : bool {
        let v0 = 0x1::vector::length<GuardData>(&arg0.guard);
        if (v0 == 0) {
            return true
        };
        arg0.guard_cursor == v0
    }

    public fun freezen(arg0: Passport) {
        0x2::transfer::freeze_object<Passport>(arg0);
    }

    public fun guard_add(arg0: &mut Passport, arg1: &0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard, arg2: vector<u8>, arg3: vector<vector<u8>>) {
        if (arg0.bStartVerify) {
            return
        };
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::INPUT(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::input_length(arg1));
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GUARD_COUNT(0x1::vector::length<GuardData>(&arg0.guard));
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::CONST(0x1::vector::length<u8>(&arg2) == 0x1::vector::length<vector<u8>>(&arg3));
        let v0 = 0;
        while (v0 < 0x1::vector::length<GuardData>(&arg0.guard)) {
            if (0x1::vector::borrow<GuardData>(&arg0.guard, v0).guard_id == 0x2::object::id_address<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard>(arg1)) {
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GUARD_EXISTED();
                return
            };
            v0 = v0 + 1;
        };
        let v1 = *0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::constants(arg1);
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Constant_add(&mut v1, &arg2, &arg3);
        let v2 = Witness{
            identifier : 0x1::vector::empty<u8>(),
            type       : 0x1::vector::empty<u8>(),
            object     : 0x1::vector::empty<address>(),
        };
        let v3 = GuardData{
            guard_id  : 0x2::object::id_address<0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Guard>(arg1),
            constants : v1,
            bcs       : *0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::input_borrow(arg1),
            witness   : v2,
        };
        0x1::vector::push_back<GuardData>(&mut arg0.guard, v3);
    }

    public fun has_guard(arg0: &Passport, arg1: &address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<GuardData>(&arg0.guard)) {
            if (0x1::vector::borrow<GuardData>(&arg0.guard, v0).guard_id == *arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun on_finish(arg0: &Passport, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::USED(arg0.tx_hash == *0x2::tx_context::digest(arg2));
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::FAIL(arg0.result);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.internal_check)) {
            let v1 = 0x1::vector::borrow<address>(&arg0.internal_check, v0);
            let v2 = 0;
            while (v2 < 0x1::vector::length<GuardData>(&arg0.guard)) {
                if (0x1::vector::borrow<GuardData>(&arg0.guard, v2).guard_id == *v1) {
                    break
                };
                v2 = v2 + 1;
            };
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::QUERYDATA_GUARD_NOT_FOUND(v2 != 0x1::vector::length<GuardData>(&arg0.guard));
            v0 = v0 + 1;
        };
    }

    public fun passport_verify(arg0: &mut Passport, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.bStartVerify = true;
        if (finished(arg0)) {
            on_finish(arg0, arg1, arg2);
            return
        };
        let v0 = 0x1::vector::borrow_mut<GuardData>(&mut arg0.guard, arg0.guard_cursor);
        loop {
            if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::length(&v0.bcs) == 0) {
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::RESULT(0x1::vector::length<vector<u8>>(&arg0.process) == 1);
                let v1 = 0x1::vector::remove<vector<u8>>(&mut arg0.process, 0);
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::RESULT(0x1::vector::length<u8>(&v1) == 2);
                let v2 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::new(v1);
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::RES_TYPE(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_u8(&mut v2) == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL());
                if (arg0.guard_cursor == 0) {
                    arg0.result = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_bool(&mut v2);
                } else {
                    let v3 = arg0.result && 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_bool(&mut v2);
                    arg0.result = v3;
                };
                arg0.process = 0x1::vector::empty<vector<u8>>();
                arg0.guard_cursor = arg0.guard_cursor + 1;
                if (finished(arg0)) {
                    on_finish(arg0, arg1, arg2);
                    return
                };
                v0 = 0x1::vector::borrow_mut<GuardData>(&mut arg0.guard, arg0.guard_cursor);
                continue
            };
            let v4 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_u8(&mut v0.bcs);
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_QUERY()) {
                break
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_SIGNER()) {
                let v5 = 0x2::address::to_bytes(0x2::tx_context::sender(arg2));
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::BUILD_TYPED_DATA(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), &mut v5);
                0x1::vector::push_back<vector<u8>>(&mut arg0.process, v5);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_GUARD()) {
                let v6 = 0x2::address::to_bytes(v0.guard_id);
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::BUILD_TYPED_DATA(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), &mut v6);
                0x1::vector::push_back<vector<u8>>(&mut arg0.process, v6);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_CLOCK()) {
                let v7 = 0x2::clock::timestamp_ms(arg1);
                let v8 = 0x1::bcs::to_bytes<u64>(&v7);
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::BUILD_TYPED_DATA(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &mut v8);
                0x1::vector::push_back<vector<u8>>(&mut arg0.process, v8);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_CONSTANT()) {
                let v9 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Constant_value(&v0.constants, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_u8(&mut v0.bcs), 0x1::option::none<bool>());
                let v10 = 0x1::vector::borrow_mut<u8>(&mut v9, 0);
                if (*v10 >= 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL() && *v10 <= 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U256()) {
                    0x1::vector::push_back<vector<u8>>(&mut arg0.process, v9);
                    continue
                };
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::TYPE(false);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL()) {
                let v11 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_bool(&mut v0.bcs);
                let v12 = &mut arg0.process;
                BUILD_RESULT_DATA<bool>(v12, v4, &v11);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U8()) {
                let v13 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_u8(&mut v0.bcs);
                let v14 = &mut arg0.process;
                BUILD_RESULT_DATA<u8>(v14, v4, &v13);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U16()) {
                let v15 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_u16(&mut v0.bcs);
                let v16 = &mut arg0.process;
                BUILD_RESULT_DATA<u16>(v16, v4, &v15);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS()) {
                let v17 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_address(&mut v0.bcs);
                let v18 = &mut arg0.process;
                BUILD_RESULT_DATA<address>(v18, v4, &v17);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64()) {
                let v19 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_u64(&mut v0.bcs);
                let v20 = &mut arg0.process;
                BUILD_RESULT_DATA<u64>(v20, v4, &v19);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U128()) {
                let v21 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_u128(&mut v0.bcs);
                let v22 = &mut arg0.process;
                BUILD_RESULT_DATA<u128>(v22, v4, &v21);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U256()) {
                let v23 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_u256(&mut v0.bcs);
                let v24 = &mut arg0.process;
                BUILD_RESULT_DATA<u256>(v24, v4, &v23);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_U8() || v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_STRING()) {
                let v25 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_vec_u8(&mut v0.bcs);
                let v26 = &mut arg0.process;
                BUILD_RESULT_DATA<vector<u8>>(v26, v4, &v25);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_U16()) {
                let v27 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_vec_u16(&mut v0.bcs);
                let v28 = &mut arg0.process;
                BUILD_RESULT_DATA<vector<u16>>(v28, v4, &v27);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_U64()) {
                let v29 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_vec_u64(&mut v0.bcs);
                let v30 = &mut arg0.process;
                BUILD_RESULT_DATA<vector<u64>>(v30, v4, &v29);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_U16()) {
                let v31 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_vec_u16(&mut v0.bcs);
                let v32 = &mut arg0.process;
                BUILD_RESULT_DATA<vector<u16>>(v32, v4, &v31);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_BOOL()) {
                let v33 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_vec_bool(&mut v0.bcs);
                let v34 = &mut arg0.process;
                BUILD_RESULT_DATA<vector<bool>>(v34, v4, &v33);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_ADDRESS()) {
                let v35 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_vec_address(&mut v0.bcs);
                let v36 = &mut arg0.process;
                BUILD_RESULT_DATA<vector<address>>(v36, v4, &v35);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_U128()) {
                let v37 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_vec_u128(&mut v0.bcs);
                let v38 = &mut arg0.process;
                BUILD_RESULT_DATA<vector<u128>>(v38, v4, &v37);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_U256()) {
                let v39 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_vec_u256(&mut v0.bcs);
                let v40 = &mut arg0.process;
                BUILD_RESULT_DATA<vector<u256>>(v40, v4, &v39);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_VEC_U8() || v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_STRING()) {
                let v41 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_vec_vec_u8(&mut v0.bcs);
                let v42 = &mut arg0.process;
                BUILD_RESULT_DATA<vector<vector<u8>>>(v42, v4, &v41);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_LOGIC_AS_U256_GREATER()) {
                let v43 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_u8(&mut v0.bcs);
                let v44 = true;
                let v45 = 1;
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::LOGIC_COUNT(v43);
                while (v45 < v43) {
                    let v46 = v44 && 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_AS_U256(&mut arg0.process) > 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_AS_U256(&mut arg0.process);
                    v44 = v46;
                    v45 = v45 + 1;
                };
                let v47 = &mut arg0.process;
                BUILD_RESULT_DATA<bool>(v47, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v44);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_LOGIC_AS_U256_GREATER_EQUAL()) {
                let v48 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_u8(&mut v0.bcs);
                let v49 = true;
                let v50 = 1;
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::LOGIC_COUNT(v48);
                while (v50 < v48) {
                    let v51 = v49 && 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_AS_U256(&mut arg0.process) >= 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_AS_U256(&mut arg0.process);
                    v49 = v51;
                    v50 = v50 + 1;
                };
                let v52 = &mut arg0.process;
                BUILD_RESULT_DATA<bool>(v52, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v49);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_LOGIC_AS_U256_LESSER()) {
                let v53 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_u8(&mut v0.bcs);
                let v54 = true;
                let v55 = 1;
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::LOGIC_COUNT(v53);
                while (v55 < v53) {
                    let v56 = v54 && 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_AS_U256(&mut arg0.process) < 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_AS_U256(&mut arg0.process);
                    v54 = v56;
                    v55 = v55 + 1;
                };
                let v57 = &mut arg0.process;
                BUILD_RESULT_DATA<bool>(v57, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v54);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_LOGIC_AS_U256_LESSER_EQUAL()) {
                let v58 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_u8(&mut v0.bcs);
                let v59 = true;
                let v60 = 1;
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::LOGIC_COUNT(v58);
                while (v60 < v58) {
                    let v61 = v59 && 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_AS_U256(&mut arg0.process) <= 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_AS_U256(&mut arg0.process);
                    v59 = v61;
                    v60 = v60 + 1;
                };
                let v62 = &mut arg0.process;
                BUILD_RESULT_DATA<bool>(v62, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v59);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_LOGIC_AS_U256_EQUAL()) {
                let v63 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_u8(&mut v0.bcs);
                let v64 = true;
                let v65 = 1;
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::LOGIC_COUNT(v63);
                while (v65 < v63) {
                    let v66 = v64 && 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_AS_U256(&mut arg0.process) == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_AS_U256(&mut arg0.process);
                    v64 = v66;
                    v65 = v65 + 1;
                };
                let v67 = &mut arg0.process;
                BUILD_RESULT_DATA<bool>(v67, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v64);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_LOGIC_EQUAL()) {
                let v68 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_u8(&mut v0.bcs);
                let v69 = true;
                let v70 = 1;
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::LOGIC_COUNT(v68);
                while (v70 < v68) {
                    let v71 = v69 && 0x1::vector::pop_back<vector<u8>>(&mut arg0.process) == 0x1::vector::pop_back<vector<u8>>(&mut arg0.process);
                    v69 = v71;
                    v70 = v70 + 1;
                };
                let v72 = &mut arg0.process;
                BUILD_RESULT_DATA<bool>(v72, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v69);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_LOGIC_HAS_SUBSTRING()) {
                let v73 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_u8(&mut v0.bcs);
                let v74 = true;
                let v75 = 1;
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::LOGIC_COUNT(v73);
                let v76 = 0x1::string::utf8(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_VEC_U8(&mut arg0.process));
                while (v75 < v73) {
                    let v77 = 0x1::string::utf8(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_VEC_U8(&mut arg0.process));
                    let v78 = v74 && 0x1::string::index_of(&v76, &v77) != 0x1::string::length(&v76);
                    v74 = v78;
                    v75 = v75 + 1;
                };
                let v79 = &mut arg0.process;
                BUILD_RESULT_DATA<bool>(v79, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v74);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_LOGIC_NOT()) {
                let v80 = &mut arg0.process;
                let v81 = !0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_BOOL(&mut arg0.process);
                BUILD_RESULT_DATA<bool>(v80, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v81);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_LOGIC_AND()) {
                let v82 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_u8(&mut v0.bcs);
                let v83 = true;
                let v84 = 0;
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::LOGIC_COUNT(v82);
                while (v84 < v82) {
                    let v85 = v83 && 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_BOOL(&mut arg0.process);
                    v83 = v85;
                    v84 = v84 + 1;
                };
                let v86 = &mut arg0.process;
                BUILD_RESULT_DATA<bool>(v86, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v83);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_LOGIC_OR()) {
                let v87 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_u8(&mut v0.bcs);
                let v88 = false;
                let v89 = 0;
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::LOGIC_COUNT(v87);
                while (v89 < v87) {
                    let v90 = v88 || 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_BOOL(&mut arg0.process);
                    v88 = v90;
                    v89 = v89 + 1;
                };
                let v91 = &mut arg0.process;
                BUILD_RESULT_DATA<bool>(v91, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL(), &v88);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_NUMBER_ADD()) {
                let v92 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_u8(&mut v0.bcs);
                let v93 = 1;
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::LOGIC_COUNT(v92);
                let v94 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_AS_U256(&mut arg0.process);
                while (v93 < v92) {
                    let v95 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_AS_U256(&mut arg0.process);
                    0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_U256_ADD_UPFLOW(v94, v95);
                    let v96 = v94;
                    v94 = v96 + v95;
                    v93 = v93 + 1;
                };
                let v97 = &mut arg0.process;
                BUILD_RESULT_DATA<u256>(v97, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U256(), &v94);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_NUMBER_SUBTRACT()) {
                let v98 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_u8(&mut v0.bcs);
                let v99 = 1;
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::LOGIC_COUNT(v98);
                let v100 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_AS_U256(&mut arg0.process);
                while (v99 < v98) {
                    let v101 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_AS_U256(&mut arg0.process);
                    0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_U256_SUB_UPFLOW(v100, v101);
                    let v102 = v100;
                    v100 = v102 - v101;
                    v99 = v99 + 1;
                };
                let v103 = &mut arg0.process;
                BUILD_RESULT_DATA<u256>(v103, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U256(), &v100);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_NUMBER_MULTIPLY()) {
                let v104 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_u8(&mut v0.bcs);
                let v105 = 1;
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::LOGIC_COUNT(v104);
                let v106 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_AS_U256(&mut arg0.process);
                while (v105 < v104) {
                    let v107 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_AS_U256(&mut arg0.process);
                    0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_U256_MUL_UPFLOW(v106, v107);
                    let v108 = v106;
                    v106 = v108 * v107;
                    v105 = v105 + 1;
                };
                let v109 = &mut arg0.process;
                BUILD_RESULT_DATA<u256>(v109, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U256(), &v106);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_NUMBER_DEVIDE()) {
                let v110 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_u8(&mut v0.bcs);
                let v111 = 1;
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::LOGIC_COUNT(v110);
                let v112 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_AS_U256(&mut arg0.process);
                while (v111 < v110) {
                    let v113 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_AS_U256(&mut arg0.process);
                    0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_DIV_ZERO(v113 != 0);
                    let v114 = v112;
                    v112 = v114 / v113;
                    v111 = v111 + 1;
                };
                let v115 = &mut arg0.process;
                BUILD_RESULT_DATA<u256>(v115, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U256(), &v112);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_NUMBER_MOD()) {
                let v116 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_u8(&mut v0.bcs);
                let v117 = 1;
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::LOGIC_COUNT(v116);
                let v118 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_AS_U256(&mut arg0.process);
                while (v117 < v116) {
                    0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_MOD_ZERO(v118 != 0);
                    let v119 = v118;
                    v118 = v119 % 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_AS_U256(&mut arg0.process);
                    v117 = v117 + 1;
                };
                let v120 = &mut arg0.process;
                BUILD_RESULT_DATA<u256>(v120, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U256(), &v118);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_NUMBER_ADDRESS()) {
                let v121 = &mut arg0.process;
                let v122 = 0x2::address::from_u256(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_AS_U256(&mut arg0.process));
                BUILD_RESULT_DATA<address>(v121, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), &v122);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STRING_LOWERCASE()) {
                let v123 = 0x1::string::utf8(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_VEC_U8(&mut arg0.process));
                let v124 = &mut arg0.process;
                let v125 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::string_lowercase(&v123);
                BUILD_RESULT_DATA<0x1::string::String>(v124, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_STRING(), &v125);
                continue
            };
            if (v4 >= 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_ORDER_PROGRESS() && v4 <= 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_ARB_SERVICE()) {
                let v126 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_u8(&mut v0.bcs);
                let v127 = &mut arg0.process;
                let v128 = witness(&v0.witness, v126, v4);
                BUILD_RESULT_DATA<address>(v127, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS(), &v128);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_SAFE_U8()) {
                let v129 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_AS_U256(&mut arg0.process);
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::U8_OVERFLOW(v129 < 256);
                let v130 = &mut arg0.process;
                let v131 = (v129 as u8);
                BUILD_RESULT_DATA<u8>(v130, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U8(), &v131);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_SAFE_U16()) {
                let v132 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_AS_U256(&mut arg0.process);
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::U8_OVERFLOW(v132 < 65536);
                let v133 = &mut arg0.process;
                let v134 = (v132 as u16);
                BUILD_RESULT_DATA<u16>(v133, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U16(), &v134);
                continue
            };
            if (v4 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_SAFE_U64()) {
                let v135 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::GET_AS_U256(&mut arg0.process);
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::U64_OVERFLOW(v135 < 18446744073709551616);
                let v136 = &mut arg0.process;
                let v137 = (v135 as u64);
                BUILD_RESULT_DATA<u64>(v136, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64(), &v137);
                continue
            };
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::TYPE(false);
        };
        let v138 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_u8(&mut v0.bcs);
        if (v138 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_CONSTANT()) {
            let v139 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::guard::Constant_value(&v0.constants, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_u8(&mut v0.bcs), 0x1::option::none<bool>());
            if (*0x1::vector::borrow<u8>(&v139, 0) == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS()) {
                0x1::vector::remove<u8>(&mut v139, 0);
                arg0.current_object = 0x2::address::from_bytes(v139);
            } else {
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::QUERY_ADDR();
            };
        } else if (v138 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS()) {
            arg0.current_object = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_address(&mut v0.bcs);
        } else if (v138 >= 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_ORDER_PROGRESS() && v138 <= 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_ARB_SERVICE()) {
            arg0.current_object = witness(&v0.witness, 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::bcs::peel_u8(&mut v0.bcs), v138);
        } else {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::QUERY_ADDR();
        };
    }

    public fun query_result(arg0: &Passport) : (bool, vector<address>) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<GuardData>(&arg0.guard)) {
            0x1::vector::push_back<address>(&mut v0, 0x1::vector::borrow<GuardData>(&arg0.guard, v1).guard_id);
            v1 = v1 + 1;
        };
        (arg0.result, v0)
    }

    fun witness(arg0: &Witness, arg1: u8, arg2: u8) : address {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::WITNESS(0x1::vector::contains<u8>(&arg0.identifier, &arg1));
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg0.type)) {
            if (*0x1::vector::borrow<u8>(&arg0.type, v0) == arg2) {
                return *0x1::vector::borrow<address>(&arg0.object, v0)
            };
            v0 = v0 + 1;
        };
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::passport::WITNISS_TYPE_NOT_FOUND(false);
        @0x0
    }

    public(friend) fun witness_add(arg0: &mut Passport, arg1: u8, arg2: &vector<u8>, arg3: &vector<u8>, arg4: &vector<address>) {
        if (arg0.bStartVerify) {
            return
        };
        let v0 = Witness{
            identifier : *arg2,
            type       : *arg3,
            object     : *arg4,
        };
        0x1::vector::borrow_mut<GuardData>(&mut arg0.guard, (arg1 as u64)).witness = v0;
    }

    // decompiled from Move bytecode v6
}

