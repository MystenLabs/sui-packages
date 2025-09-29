module 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::repository {
    struct RepRecord has drop, store {
        key: 0x1::string::String,
        ids: vector<address>,
        typed_values: vector<vector<u8>>,
    }

    struct RepWitness has drop, store {
        key: 0x1::string::String,
        witness_ids: vector<u8>,
        typed_values: vector<vector<u8>>,
    }

    public fun DATA_TYPE(arg0: &vector<u8>) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 <= 204800 && v0 > 1, 2003);
        let v1 = *0x1::vector::borrow<u8>(arg0, 0);
        let v2 = if (v1 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U8()) {
            true
        } else if (v1 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL()) {
            true
        } else if (v1 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_U16()) {
            true
        } else if (v1 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64()) {
            true
        } else if (v1 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U128()) {
            true
        } else if (v1 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U256()) {
            true
        } else if (v1 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_STRING()) {
            true
        } else if (v1 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_U8()) {
            true
        } else if (v1 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS()) {
            true
        } else if (v1 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_U64()) {
            true
        } else if (v1 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_U128()) {
            true
        } else if (v1 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_U256()) {
            true
        } else if (v1 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_STRING()) {
            true
        } else if (v1 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_ADDRESS()) {
            true
        } else {
            v1 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U16()
        };
        assert!(v2, 2007);
    }

    public fun IsTypeMatch(arg0: u8, arg1: u8) : bool {
        if (arg1 == 200) {
            return arg0 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_ADDRESS()
        };
        if (arg1 == 201) {
            return arg0 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_ADDRESS()
        };
        if (arg1 == 202) {
            return if (arg0 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U64()) {
                true
            } else if (arg0 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U128()) {
                true
            } else if (arg0 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U256()) {
                true
            } else if (arg0 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U8()) {
                true
            } else {
                arg0 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_U16()
            }
        };
        if (arg1 == 203) {
            return if (arg0 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_U64()) {
                true
            } else if (arg0 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_U128()) {
                true
            } else if (arg0 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_U256()) {
                true
            } else if (arg0 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_U8()) {
                true
            } else {
                arg0 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_U16()
            }
        };
        if (arg1 == 204) {
            return arg0 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_STRING()
        };
        if (arg1 == 205) {
            return arg0 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_VEC_STRING()
        };
        if (arg1 == 206) {
            return arg0 == 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::TYPE_STATIC_BOOL()
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

    public fun POLICY_WITNESS_COUNT(arg0: u64) {
        assert!(arg0 <= 100, 2009);
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

    public fun RepRecord_add(arg0: &mut RepRecord, arg1: address, arg2: vector<u8>) {
        assert!(0x1::vector::length<address>(&arg0.ids) < 100, 2008);
        0x1::vector::push_back<address>(&mut arg0.ids, arg1);
        0x1::vector::push_back<vector<u8>>(&mut arg0.typed_values, arg2);
    }

    public fun RepRecord_borrow(arg0: &RepRecord) : (&0x1::string::String, &vector<address>, &vector<vector<u8>>) {
        (&arg0.key, &arg0.ids, &arg0.typed_values)
    }

    public fun RepRecord_new(arg0: 0x1::string::String, arg1: address, arg2: vector<u8>) : RepRecord {
        KEY(&arg0);
        RepRecord{
            key          : arg0,
            ids          : 0x1::vector::singleton<address>(arg1),
            typed_values : 0x1::vector::singleton<vector<u8>>(arg2),
        }
    }

    public fun RepWitness_add(arg0: &mut RepWitness, arg1: u8, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg0.witness_ids) < 100, 2008);
        0x1::vector::push_back<u8>(&mut arg0.witness_ids, arg1);
        0x1::vector::push_back<vector<u8>>(&mut arg0.typed_values, arg2);
    }

    public fun RepWitness_borrow(arg0: &RepWitness) : (&0x1::string::String, &vector<u8>, &vector<vector<u8>>) {
        (&arg0.key, &arg0.witness_ids, &arg0.typed_values)
    }

    public fun RepWitness_new(arg0: 0x1::string::String, arg1: u8, arg2: vector<u8>) : RepWitness {
        KEY(&arg0);
        RepWitness{
            key          : arg0,
            witness_ids  : 0x1::vector::singleton<u8>(arg1),
            typed_values : 0x1::vector::singleton<vector<u8>>(arg2),
        }
    }

    public fun STRICT(arg0: u8) {
        assert!(arg0 != 1, 2001);
    }

    public fun TYPE(arg0: bool) {
        assert!(arg0, 2000);
    }

    public fun TYPE_MESSAGE() : u8 {
        3
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

    public fun VALUE_TYPE_NOT_MATCH(arg0: &vector<u8>, arg1: &0x1::option::Option<u8>) {
        if (0x1::option::is_some<u8>(arg1)) {
            assert!(IsTypeMatch(*0x1::vector::borrow<u8>(arg0, 0), *0x1::option::borrow<u8>(arg1)), 2000);
        };
    }

    public fun WINESS_NOT_IN_POLICY(arg0: bool) {
        assert!(arg0, 2010);
    }

    public fun WITNESS_COUNT_NOT_MATCH(arg0: bool) {
        assert!(arg0, 2011);
    }

    // decompiled from Move bytecode v6
}

