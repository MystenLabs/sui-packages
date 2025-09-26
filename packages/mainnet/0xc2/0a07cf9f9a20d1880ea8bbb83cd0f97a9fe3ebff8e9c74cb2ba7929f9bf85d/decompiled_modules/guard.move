module 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::guard {
    struct Constant has copy, drop, store {
        identifier: u8,
        bWitness: bool,
        value: vector<u8>,
        module_name: 0x1::option::Option<0x1::string::String>,
    }

    struct Guard has key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        id_description: 0x2::vec_map::VecMap<u8, 0x1::string::String>,
        constants: vector<Constant>,
        input: 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::BCS,
    }

    public fun new(arg0: 0x1::string::String, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : Guard {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_DESCRIPTIONLEN(&arg0);
        assert!(0x1::vector::length<u8>(&arg1) > 0 && 0x1::vector::length<u8>(&arg1) <= (10240 as u64), (300 as u64));
        Guard{
            id             : 0x2::object::new(arg2),
            description    : arg0,
            id_description : 0x2::vec_map::empty<u8, 0x1::string::String>(),
            constants      : 0x1::vector::empty<Constant>(),
            input          : 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::new_non_reserve(&arg1),
        }
    }

    fun ASSERT_CONSTANT_TYPE(arg0: bool, arg1: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg1) > 0, (301 as u64));
        let v0 = *0x1::vector::borrow<u8>(arg1, 0);
        assert!(v0 >= 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL() && v0 <= 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U256(), (301 as u64));
        if (arg0) {
            assert!(0x1::vector::length<u8>(arg1) == 1, (302 as u64));
        } else {
            assert!(0x1::vector::length<u8>(arg1) > 1, (303 as u64));
        };
    }

    public fun ASSERT_IDENTIFIER_ADDRESS(arg0: &Guard, arg1: &0x1::option::Option<u8>) {
        if (0x1::option::is_some<u8>(arg1)) {
            let v0 = identifier_type(arg0, *0x1::option::borrow<u8>(arg1));
            assert!(0x1::option::is_some<u8>(&v0), 305);
            assert!(*0x1::option::borrow<u8>(&v0) == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_ADDRESS(), 306);
        };
    }

    public fun Constant_add(arg0: &mut vector<Constant>, arg1: &vector<u8>, arg2: &vector<vector<u8>>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Constant>(arg0)) {
            let v1 = 0x1::vector::borrow_mut<Constant>(arg0, v0);
            if (!v1.bWitness) {
                v0 = v0 + 1;
                continue
            };
            let v2 = 0x1::vector::length<u8>(arg1);
            let v3 = 0;
            while (v3 < v2) {
                let v4 = 0x1::vector::borrow<vector<u8>>(arg2, v3);
                if (v1.identifier == *0x1::vector::borrow<u8>(arg1, v3)) {
                    if (*0x1::vector::borrow<u8>(&v1.value, 0) == *0x1::vector::borrow<u8>(v4, 0)) {
                        v1.value = *v4;
                        break
                    } else {
                        break
                    };
                };
                v3 = v3 + 1;
            };
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::WITNESS(v3 < v2);
            v0 = v0 + 1;
        };
    }

    public fun Constant_value(arg0: &vector<Constant>, arg1: u8, arg2: 0x1::option::Option<bool>) : vector<u8> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Constant>(arg0)) {
            let v1 = 0x1::vector::borrow<Constant>(arg0, v0);
            if (v1.identifier == arg1) {
                if (0x1::option::is_some<bool>(&arg2)) {
                    if (v1.bWitness != *0x1::option::borrow<bool>(&arg2)) {
                        abort 307
                    };
                };
                return v1.value
            };
            v0 = v0 + 1;
        };
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::CONST_NOT_FOUND(false);
        0x1::vector::empty<u8>()
    }

    public fun constant(arg0: &Constant) : (u8, bool, &vector<u8>) {
        (arg0.identifier, arg0.bWitness, &arg0.value)
    }

    public fun constant_add(arg0: &mut Guard, arg1: u8, arg2: bool, arg3: vector<u8>, arg4: 0x1::option::Option<0x1::string::String>) {
        ASSERT_CONSTANT_TYPE(arg2, &arg3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<Constant>(&arg0.constants)) {
            if (0x1::vector::borrow_mut<Constant>(&mut arg0.constants, v0).identifier == arg1) {
                abort (304 as u64)
            };
            v0 = v0 + 1;
        };
        let v1 = Constant{
            identifier  : arg1,
            bWitness    : arg2,
            value       : arg3,
            module_name : 0x1::option::none<0x1::string::String>(),
        };
        0x1::vector::push_back<Constant>(&mut arg0.constants, v1);
        if (0x1::option::is_some<0x1::string::String>(&arg4)) {
            let v2 = 0x1::option::borrow<0x1::string::String>(&arg4);
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_NAMELEN(v2);
            0x2::vec_map::insert<u8, 0x1::string::String>(&mut arg0.id_description, arg1, *v2);
        };
    }

    fun constant_exists(arg0: &vector<Constant>, arg1: u8) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Constant>(arg0)) {
            if (0x1::vector::borrow<Constant>(arg0, v0).identifier == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun constant_mut(arg0: &mut Constant) : (u8, bool, &mut vector<u8>) {
        (arg0.identifier, arg0.bWitness, &mut arg0.value)
    }

    public fun constant_remove(arg0: &mut Guard, arg1: u8) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Constant>(&arg0.constants)) {
            if (0x1::vector::borrow<Constant>(&arg0.constants, v0).identifier == arg1) {
                0x1::vector::remove<Constant>(&mut arg0.constants, v0);
                return
            };
            v0 = v0 + 1;
        };
    }

    public fun constant_remove_all(arg0: &mut Guard) {
        arg0.constants = 0x1::vector::empty<Constant>();
    }

    public fun constants(arg0: &Guard) : &vector<Constant> {
        &arg0.constants
    }

    public fun constants_length(arg0: &Guard) : u64 {
        0x1::vector::length<Constant>(&arg0.constants)
    }

    public fun create(arg0: Guard) : address {
        let v0 = &mut arg0;
        validate_and_infer(v0);
        0x2::transfer::freeze_object<Guard>(arg0);
        0x2::object::id_address<Guard>(&arg0)
    }

    public fun description_set(arg0: &mut Guard, arg1: 0x1::string::String) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_DESCRIPTIONLEN(&arg1);
        arg0.description = arg1;
    }

    fun get_module_name_for_query(arg0: u16) : vector<u8> {
        if (arg0 >= 1 && arg0 <= 9) {
            return b"permission"
        };
        if (arg0 >= 100 && arg0 <= 123) {
            return b"repository"
        };
        if (arg0 >= 200 && arg0 <= 207) {
            return b"entity"
        };
        if (arg0 >= 300 && arg0 <= 315) {
            return b"demand"
        };
        if (arg0 >= 400 && arg0 <= 425) {
            return b"service"
        };
        if (arg0 >= 500 && arg0 <= 521) {
            return b"order"
        };
        if (arg0 >= 700 && arg0 <= 705) {
            return b"machine"
        };
        if (arg0 >= 800 && arg0 <= 840) {
            return b"progress"
        };
        if (arg0 >= 900 && arg0 <= 901) {
            return b"wowok"
        };
        if (arg0 >= 1200 && arg0 <= 1217) {
            return b"payment"
        };
        if (arg0 >= 1400 && arg0 <= 1430) {
            return b"treasury"
        };
        if (arg0 >= 1500 && arg0 <= 1513) {
            return b"arbitration"
        };
        assert!(arg0 >= 1600 && arg0 <= 1616, (309 as u64));
        b"arb"
    }

    fun identifier_type(arg0: &Guard, arg1: u8) : 0x1::option::Option<u8> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Constant>(&arg0.constants)) {
            let v1 = 0x1::vector::borrow<Constant>(&arg0.constants, v0);
            if (v1.identifier == arg1 && v1.bWitness) {
                return 0x1::option::some<u8>(*0x1::vector::borrow<u8>(&v1.value, 0))
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u8>()
    }

    fun infer_module_type_from_witness_type(arg0: u8) : vector<u8> {
        let v0 = if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_ORDER_PROGRESS()) {
            true
        } else if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_ORDER_MACHINE()) {
            true
        } else {
            arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_ORDER_SERVICE()
        };
        if (v0) {
            return b"order"
        };
        if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_PROGRESS_MACHINE()) {
            return b"progress"
        };
        let v1 = if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_ARB_ORDER()) {
            true
        } else if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_ARB_ARBITRATION()) {
            true
        } else if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_ARB_PROGRESS()) {
            true
        } else if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_ARB_MACHINE()) {
            true
        } else {
            arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_ARB_SERVICE()
        };
        assert!(v1, (313 as u64));
        b"arb"
    }

    public fun input_borrow(arg0: &Guard) : &0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::BCS {
        &arg0.input
    }

    public fun input_borrowmut(arg0: &mut Guard) : &mut 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::BCS {
        &mut arg0.input
    }

    public fun input_length(arg0: &Guard) : u64 {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::length(&arg0.input)
    }

    public fun isWineessModule(arg0: &Guard, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg1)) {
            let v1 = 0x1::vector::borrow<u8>(arg1, v0);
            let v2 = 0x1::vector::length<Constant>(&arg0.constants);
            let v3 = 0;
            while (v3 < v2) {
                let v4 = 0x1::vector::borrow<Constant>(&arg0.constants, v3);
                if (v4.identifier == *v1) {
                    let v5 = if (!v4.bWitness) {
                        true
                    } else if (0x1::option::is_none<0x1::string::String>(&v4.module_name)) {
                        true
                    } else {
                        *arg2 != *0x1::string::as_bytes(0x1::option::borrow<0x1::string::String>(&v4.module_name))
                    };
                    if (v5) {
                        return false
                    } else {
                        break
                    };
                };
                v3 = v3 + 1;
            };
            if (v3 >= v2) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    fun update_constant_module_name(arg0: &mut vector<Constant>, arg1: u8, arg2: &vector<u8>, arg3: bool) {
        let v0 = 0;
        let v1 = 0x1::vector::length<Constant>(arg0);
        while (v0 < v1) {
            let v2 = 0x1::vector::borrow_mut<Constant>(arg0, v0);
            if (v2.identifier == arg1) {
                if (arg3 && !v2.bWitness) {
                    abort (310 as u64)
                };
                if (*arg2 == b"") {
                    break
                };
                if (0x1::option::is_none<0x1::string::String>(&v2.module_name)) {
                    v2.module_name = 0x1::option::some<0x1::string::String>(0x1::string::utf8(*arg2));
                    break
                };
                if (*0x1::string::as_bytes(0x1::option::borrow<0x1::string::String>(&v2.module_name)) != *arg2) {
                    abort (311 as u64)
                } else {
                    break
                };
            };
            v0 = v0 + 1;
        };
        if (v0 == v1) {
            abort (305 as u64)
        };
    }

    fun validate_and_infer(arg0: &mut Guard) {
        let v0 = arg0.input;
        while (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::length(&v0) > 0) {
            let v1 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::peel_u8(&mut v0);
            let v2 = if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_QUERY()) {
                let v3 = &mut v0;
                let v4 = &mut arg0.constants;
                validate_query_type(v3, v4)
            } else {
                let v5 = if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_SIGNER()) {
                    true
                } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_CLOCK()) {
                    true
                } else {
                    v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_GUARD()
                };
                if (v5) {
                    true
                } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_CONSTANT()) {
                    let v6 = &mut v0;
                    validate_constant_reference(v6, &arg0.constants)
                } else if (v1 >= 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_ORDER_PROGRESS() && v1 <= 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_ARB_SERVICE()) {
                    let v7 = &mut v0;
                    let v8 = &mut arg0.constants;
                    validate_witness_type(v7, v8, v1)
                } else if (v1 >= 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL() && v1 <= 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_VEC_U8()) {
                    let v9 = &mut v0;
                    validate_static_type(v1, v9)
                } else {
                    let v10 = if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_LOGIC_NOT()) {
                        true
                    } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_NUMBER_ADDRESS()) {
                        true
                    } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STRING_LOWERCASE()) {
                        true
                    } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_SAFE_U8()) {
                        true
                    } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_SAFE_U16()) {
                        true
                    } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_SAFE_U64()) {
                        true
                    } else {
                        v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_SAFE_U128()
                    };
                    if (v10) {
                        let v11 = &mut v0;
                        validate_unary_operator(v1, v11)
                    } else {
                        let v12 = if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_LOGIC_AS_U256_GREATER()) {
                            true
                        } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_LOGIC_AS_U256_GREATER_EQUAL()) {
                            true
                        } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_LOGIC_AS_U256_LESSER()) {
                            true
                        } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_LOGIC_AS_U256_LESSER_EQUAL()) {
                            true
                        } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_LOGIC_AS_U256_EQUAL()) {
                            true
                        } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_NUMBER_ADD()) {
                            true
                        } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_NUMBER_SUBTRACT()) {
                            true
                        } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_NUMBER_MULTIPLY()) {
                            true
                        } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_NUMBER_DEVIDE()) {
                            true
                        } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_NUMBER_MOD()) {
                            true
                        } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_LOGIC_EQUAL()) {
                            true
                        } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_LOGIC_HAS_SUBSTRING()) {
                            true
                        } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_LOGIC_AND()) {
                            true
                        } else {
                            v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_LOGIC_OR()
                        };
                        assert!(v12, 308);
                        let v13 = &mut v0;
                        validate_nary_operator(v1, v13)
                    }
                }
            };
            if (!v2) {
                abort 314
            };
        };
    }

    fun validate_constant_reference(arg0: &mut 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::BCS, arg1: &vector<Constant>) : bool {
        if (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::length(arg0) == 0) {
            return false
        };
        if (!constant_exists(arg1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::peel_u8(arg0))) {
            return false
        };
        true
    }

    fun validate_nary_operator(arg0: u8, arg1: &mut 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::BCS) : bool {
        if (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::length(arg1) == 0) {
            return false
        };
        if (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::peel_u8(arg1) < 2) {
            return false
        };
        true
    }

    fun validate_query_type(arg0: &mut 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::BCS, arg1: &mut vector<Constant>) : bool {
        if (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::length(arg0) == 0) {
            return false
        };
        let v0 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::peel_u8(arg0);
        if (v0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_CONSTANT()) {
            if (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::length(arg0) == 0) {
                return false
            };
            if (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::length(arg0) < 2) {
                return false
            };
            let v1 = get_module_name_for_query(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::peel_u16(arg0));
            update_constant_module_name(arg1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::peel_u8(arg0), &v1, false);
        } else if (v0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_ADDRESS()) {
            if (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::length(arg0) < 32) {
                return false
            };
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::peel_address(arg0);
            if (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::length(arg0) < 2) {
                return false
            };
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::peel_u16(arg0);
        } else if (v0 >= 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_ORDER_PROGRESS() && v0 <= 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_ARB_SERVICE()) {
            if (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::length(arg0) == 0) {
                return false
            };
            if (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::length(arg0) < 2) {
                return false
            };
            let v2 = get_module_name_for_query(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::peel_u16(arg0));
            let v3 = infer_module_type_from_witness_type(v0);
            if (v2 == b"order") {
                assert!(v0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_ARB_ORDER(), (309 as u64));
            } else if (v2 == b"progress") {
                assert!(v0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_ORDER_PROGRESS() || v0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_ARB_PROGRESS(), (309 as u64));
            } else if (v2 == b"arbitration") {
                assert!(v0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_ARB_ARBITRATION(), (309 as u64));
            } else if (v2 == b"machine") {
                let v4 = if (v0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_ORDER_MACHINE()) {
                    true
                } else if (v0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_PROGRESS_MACHINE()) {
                    true
                } else {
                    v0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_ARB_MACHINE()
                };
                assert!(v4, (309 as u64));
            } else {
                assert!(v2 == b"service", (309 as u64));
                assert!(v0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_ORDER_SERVICE() || v0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_ARB_SERVICE(), (309 as u64));
            };
            update_constant_module_name(arg1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::peel_u8(arg0), &v3, true);
        } else {
            return false
        };
        true
    }

    fun validate_static_type(arg0: u8, arg1: &mut 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::BCS) : bool {
        let v0 = 1;
        if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL() || arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U8()) {
        } else if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U16()) {
            v0 = 2;
        } else if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_ADDRESS()) {
            v0 = 32;
        } else if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64()) {
            v0 = 8;
        } else if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U128()) {
            v0 = 16;
        } else if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U256()) {
            v0 = 32;
        } else {
            let v1 = if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_BOOL()) {
                true
            } else if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_ADDRESS()) {
                true
            } else if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_U8()) {
                true
            } else if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_STRING()) {
                true
            } else if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_U16()) {
                true
            } else if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_U64()) {
                true
            } else if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_U128()) {
                true
            } else {
                arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_U256()
            };
            if (v1) {
                let v2 = 1;
                if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_U16()) {
                    v2 = 2;
                } else if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_ADDRESS()) {
                    v2 = 32;
                } else if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_U64()) {
                    v2 = 8;
                } else if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_U128()) {
                    v2 = 16;
                } else if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_U256()) {
                    v2 = 32;
                };
                v0 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::peel_vec_length(arg1) * v2;
            } else {
                assert!(arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_VEC_U8() || arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_STRING(), 312);
                let v3 = 0;
                while (v3 < 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::peel_vec_length(arg1)) {
                    let v4 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::peel_vec_length(arg1);
                    if (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::length(arg1) < v4) {
                        return false
                    };
                    let v5 = 0;
                    while (v5 < v4) {
                        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::peel_u8(arg1);
                        v5 = v5 + 1;
                    };
                    v3 = v3 + 1;
                };
                return true
            };
        };
        if (v0 > 0) {
            if (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::length(arg1) < v0) {
                return false
            };
            let v6 = 0;
            while (v6 < v0) {
                0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::peel_u8(arg1);
                v6 = v6 + 1;
            };
        };
        true
    }

    fun validate_unary_operator(arg0: u8, arg1: &mut 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::BCS) : bool {
        true
    }

    fun validate_witness_type(arg0: &mut 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::BCS, arg1: &mut vector<Constant>, arg2: u8) : bool {
        if (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::length(arg0) == 0) {
            return false
        };
        let v0 = infer_module_type_from_witness_type(arg2);
        update_constant_module_name(arg1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::peel_u8(arg0), &v0, true);
        true
    }

    // decompiled from Move bytecode v6
}

