module 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::repository {
    struct RepRecord has drop, store {
        id: address,
        typed_value: vector<u8>,
    }

    struct RepData has drop, store {
        key: 0x1::string::String,
        records: vector<RepRecord>,
    }

    public fun DATA_TYPE(arg0: &vector<u8>) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 <= 204800 && v0 > 1, 2003);
        let v1 = *0x1::vector::borrow<u8>(arg0, 0);
        let v2 = if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U8()) {
            true
        } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL()) {
            true
        } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_U16()) {
            true
        } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64()) {
            true
        } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U128()) {
            true
        } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U256()) {
            true
        } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_STRING()) {
            true
        } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_U8()) {
            true
        } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_ADDRESS()) {
            true
        } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_U64()) {
            true
        } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_U128()) {
            true
        } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_U256()) {
            true
        } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_STRING()) {
            true
        } else if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_ADDRESS()) {
            true
        } else {
            v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U16()
        };
        assert!(v2, 2007);
    }

    public fun IsTypeMatch(arg0: u8, arg1: u8) : bool {
        if (arg1 == 200) {
            return arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_ADDRESS()
        };
        if (arg1 == 201) {
            return arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_ADDRESS()
        };
        if (arg1 == 202) {
            return if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64()) {
                true
            } else if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U128()) {
                true
            } else if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U256()) {
                true
            } else if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U8()) {
                true
            } else {
                arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U16()
            }
        };
        if (arg1 == 203) {
            return if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_U64()) {
                true
            } else if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_U128()) {
                true
            } else if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_U256()) {
                true
            } else if (arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_U8()) {
                true
            } else {
                arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_U16()
            }
        };
        if (arg1 == 204) {
            return arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_STRING()
        };
        if (arg1 == 205) {
            return arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_STRING()
        };
        if (arg1 == 206) {
            return arg0 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL()
        };
        false
    }

    public fun KEY(arg0: &0x1::string::String) {
        assert!(0x1::string::length(arg0) <= 128, 2002);
    }

    public fun MODE(arg0: u8) {
        assert!(arg0 == 0 || arg0 == 1, 2004);
    }

    public fun POLICY_COUNT(arg0: u64) {
        assert!(arg0 < 120, 2005);
    }

    public fun POLICY_MODE_FREE() : u8 {
        0
    }

    public fun POLICY_MODE_STRICT() : u8 {
        1
    }

    public fun POLICY_TYPE(arg0: u8) {
        assert!(arg0 >= 200 && arg0 <= 206, 2006);
    }

    public fun Policy_Data_Type_Address() : u8 {
        200
    }

    public fun Policy_Data_Type_Address_Vec() : u8 {
        201
    }

    public fun Policy_Data_Type_Bool() : u8 {
        206
    }

    public fun Policy_Data_Type_PositiveNumber() : u8 {
        202
    }

    public fun Policy_Data_Type_PositiveNumber_Vec() : u8 {
        203
    }

    public fun Policy_Data_Type_String() : u8 {
        204
    }

    public fun Policy_Data_Type_String_Vec() : u8 {
        205
    }

    public fun RepData_add(arg0: &mut RepData, arg1: address, arg2: vector<u8>) {
        assert!(0x1::vector::length<RepRecord>(&arg0.records) < 100, 2008);
        let v0 = RepRecord{
            id          : arg1,
            typed_value : arg2,
        };
        0x1::vector::push_back<RepRecord>(&mut arg0.records, v0);
    }

    public fun RepData_borrow(arg0: &RepData, arg1: u64, arg2: 0x1::option::Option<u8>) : (&0x1::string::String, &address, &vector<u8>) {
        let v0 = 0x1::vector::borrow<RepRecord>(&arg0.records, arg1);
        if (0x1::option::is_some<u8>(&arg2)) {
            assert!(IsTypeMatch(*0x1::vector::borrow<u8>(&v0.typed_value, 0), *0x1::option::borrow<u8>(&arg2)), 2000);
        };
        (&arg0.key, &v0.id, &v0.typed_value)
    }

    public fun RepData_key(arg0: &RepData) : &0x1::string::String {
        &arg0.key
    }

    public fun RepData_length(arg0: &RepData) : u64 {
        0x1::vector::length<RepRecord>(&arg0.records)
    }

    public fun RepData_new(arg0: 0x1::string::String, arg1: address, arg2: vector<u8>) : RepData {
        KEY(&arg0);
        let v0 = RepRecord{
            id          : arg1,
            typed_value : arg2,
        };
        RepData{
            key     : arg0,
            records : 0x1::vector::singleton<RepRecord>(v0),
        }
    }

    public fun STRICT(arg0: u8) {
        assert!(arg0 != 1, 2001);
    }

    public fun TYPE(arg0: bool) {
        assert!(arg0, 2000);
    }

    public fun TYPE_NORMAL() : u8 {
        0
    }

    public fun TYPE_WOWOK_GRANTEE() : u8 {
        1
    }

    public fun TYPE_WOWOK_ORACLE() : u8 {
        2
    }

    // decompiled from Move bytecode v6
}

