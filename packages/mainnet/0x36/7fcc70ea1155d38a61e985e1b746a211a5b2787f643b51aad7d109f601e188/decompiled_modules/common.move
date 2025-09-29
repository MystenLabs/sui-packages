module 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common {
    public fun ASSERT_DATA_TYPE(arg0: u8) {
        assert!(arg0 >= TYPE_STATIC_BOOL() && arg0 <= TYPE_STATIC_VEC_VEC_U8(), (203 as u64));
    }

    public fun ASSERT_DESCRIPTIONLEN(arg0: &0x1::string::String) {
        ASSERT_STRLEN_LESS(arg0, 4000);
    }

    public fun ASSERT_DIV_ZERO(arg0: bool) {
        assert!(arg0, (207 as u64));
    }

    public fun ASSERT_ENDPOINTLEN(arg0: &0x1::string::String) {
        assert!(0x1::string::length(arg0) <= 1024, (200 as u64));
    }

    public fun ASSERT_MOD_ZERO(arg0: bool) {
        assert!(arg0, (208 as u64));
    }

    public fun ASSERT_NAMELEN(arg0: &0x1::string::String) {
        ASSERT_STRLEN_LESS(arg0, 64);
    }

    public fun ASSERT_NAMELEN_ANDNOT_EMPTY(arg0: &0x1::string::String) {
        ASSERT_NAMELEN(arg0);
        assert!(0x1::string::length(arg0) > 0, (201 as u64));
    }

    public fun ASSERT_NAME_DESCRIPTION_LEN(arg0: &0x1::string::String, arg1: &0x1::string::String) {
        ASSERT_NAMELEN(arg0);
        ASSERT_DESCRIPTIONLEN(arg1);
    }

    public fun ASSERT_RATE(arg0: u16) {
        assert!(arg0 <= 10000, (202 as u64));
    }

    public fun ASSERT_REPOSITORY_POLICY(arg0: &0x1::string::String, arg1: &0x1::string::String) {
        ASSERT_NAMELEN(arg0);
        ASSERT_STRLEN_LESS(arg1, 256);
    }

    public fun ASSERT_SERVICE_ITEM_NAME(arg0: &0x1::string::String) {
        ASSERT_STRLEN_LESS(arg0, 256);
    }

    public fun ASSERT_STRLEN_LESS(arg0: &0x1::string::String, arg1: u64) {
        assert!(0x1::string::length(arg0) <= arg1, (200 as u64));
    }

    public fun ASSERT_U256_ADD_UPFLOW(arg0: u256, arg1: u256) {
        assert!(115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg1 >= arg0, (204 as u64));
    }

    public fun ASSERT_U256_MUL_UPFLOW(arg0: u256, arg1: u256) {
        if (arg1 != 0) {
            assert!(arg0 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1, (205 as u64));
        };
    }

    public fun ASSERT_U256_SUB_UPFLOW(arg0: u256, arg1: u256) {
        assert!(arg0 >= arg1, (206 as u64));
    }

    public fun ASSERT_U64_ADD_UPFLOW(arg0: u64, arg1: u64) {
        assert!(18446744073709551615 - arg1 >= arg0, (204 as u64));
    }

    public fun ASSERT_U64_MUL_UPFLOW(arg0: u64, arg1: u64) {
        if (arg1 != 0) {
            assert!(arg0 <= 18446744073709551615 / arg1, (205 as u64));
        };
    }

    public fun ASSERT_U64_SUB_UPFLOW(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, (206 as u64));
    }

    public fun BUILD_TYPED_DATA(arg0: u8, arg1: &mut vector<u8>) {
        ASSERT_DATA_TYPE(arg0);
        0x1::vector::insert<u8>(arg1, arg0, 0);
    }

    public fun TYPE_ARB_ARBITRATION() : u8 {
        35
    }

    public fun TYPE_ARB_MACHINE() : u8 {
        37
    }

    public fun TYPE_ARB_ORDER() : u8 {
        34
    }

    public fun TYPE_ARB_PROGRESS() : u8 {
        36
    }

    public fun TYPE_ARB_SERVICE() : u8 {
        38
    }

    public fun TYPE_CLOCK() : u8 {
        61
    }

    public fun TYPE_CONSTANT() : u8 {
        80
    }

    public fun TYPE_FINISHED() : u8 {
        0
    }

    public fun TYPE_GUARD() : u8 {
        62
    }

    public fun TYPE_LOGIC_AND() : u8 {
        19
    }

    public fun TYPE_LOGIC_AS_U256_EQUAL() : u8 {
        15
    }

    public fun TYPE_LOGIC_AS_U256_GREATER() : u8 {
        11
    }

    public fun TYPE_LOGIC_AS_U256_GREATER_EQUAL() : u8 {
        12
    }

    public fun TYPE_LOGIC_AS_U256_LESSER() : u8 {
        13
    }

    public fun TYPE_LOGIC_AS_U256_LESSER_EQUAL() : u8 {
        14
    }

    public fun TYPE_LOGIC_EQUAL() : u8 {
        16
    }

    public fun TYPE_LOGIC_HAS_SUBSTRING() : u8 {
        17
    }

    public fun TYPE_LOGIC_NOT() : u8 {
        18
    }

    public fun TYPE_LOGIC_OR() : u8 {
        20
    }

    public fun TYPE_NUMBER_ADD() : u8 {
        2
    }

    public fun TYPE_NUMBER_ADDRESS() : u8 {
        7
    }

    public fun TYPE_NUMBER_DEVIDE() : u8 {
        5
    }

    public fun TYPE_NUMBER_MOD() : u8 {
        6
    }

    public fun TYPE_NUMBER_MULTIPLY() : u8 {
        4
    }

    public fun TYPE_NUMBER_SUBTRACT() : u8 {
        3
    }

    public fun TYPE_ORDER_MACHINE() : u8 {
        31
    }

    public fun TYPE_ORDER_PROGRESS() : u8 {
        30
    }

    public fun TYPE_ORDER_SERVICE() : u8 {
        32
    }

    public fun TYPE_PROGRESS_MACHINE() : u8 {
        33
    }

    public fun TYPE_QUERY() : u8 {
        1
    }

    public fun TYPE_SAFE_U128() : u8 {
        24
    }

    public fun TYPE_SAFE_U16() : u8 {
        22
    }

    public fun TYPE_SAFE_U64() : u8 {
        23
    }

    public fun TYPE_SAFE_U8() : u8 {
        21
    }

    public fun TYPE_SIGNER() : u8 {
        60
    }

    public fun TYPE_STATIC_ADDRESS() : u8 {
        101
    }

    public fun TYPE_STATIC_BOOL() : u8 {
        100
    }

    public fun TYPE_STATIC_STRING() : u8 {
        102
    }

    public fun TYPE_STATIC_U128() : u8 {
        106
    }

    public fun TYPE_STATIC_U16() : u8 {
        104
    }

    public fun TYPE_STATIC_U256() : u8 {
        107
    }

    public fun TYPE_STATIC_U64() : u8 {
        105
    }

    public fun TYPE_STATIC_U8() : u8 {
        103
    }

    public fun TYPE_STATIC_VEC_ADDRESS() : u8 {
        109
    }

    public fun TYPE_STATIC_VEC_BOOL() : u8 {
        108
    }

    public fun TYPE_STATIC_VEC_STRING() : u8 {
        110
    }

    public fun TYPE_STATIC_VEC_U128() : u8 {
        114
    }

    public fun TYPE_STATIC_VEC_U16() : u8 {
        112
    }

    public fun TYPE_STATIC_VEC_U256() : u8 {
        115
    }

    public fun TYPE_STATIC_VEC_U64() : u8 {
        113
    }

    public fun TYPE_STATIC_VEC_U8() : u8 {
        111
    }

    public fun TYPE_STATIC_VEC_VEC_U8() : u8 {
        116
    }

    public fun TYPE_STRING_LOWERCASE() : u8 {
        8
    }

    public fun string_lowercase(arg0: &0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v0)) {
            let v3 = 0x1::vector::borrow<u8>(v0, v2);
            let v4 = if (*v3 >= 65 && *v3 <= 90) {
                *v3 + 32
            } else if (*v3 >= 192 && *v3 <= 222) {
                *v3 + 32
            } else if (*v3 == 208) {
                240
            } else if (*v3 == 222) {
                254
            } else {
                *v3
            };
            0x1::vector::push_back<u8>(&mut v1, v4);
            v2 = v2 + 1;
        };
        0x1::string::utf8(v1)
    }

    public fun sub_vector<T0: copy>(arg0: &vector<T0>, arg1: u64) : vector<T0> {
        let v0 = 0x1::vector::empty<T0>();
        while (arg1 < 0x1::vector::length<T0>(arg0)) {
            0x1::vector::push_back<T0>(&mut v0, *0x1::vector::borrow<T0>(arg0, arg1));
        };
        v0
    }

    public fun time_expand(arg0: u64, arg1: u64) : u64 {
        ASSERT_U64_MUL_UPFLOW(arg0, 60000);
        let v0 = arg0 * 60000;
        ASSERT_U64_ADD_UPFLOW(v0, arg1);
        v0 + arg1
    }

    public fun time_expand2(arg0: u64, arg1: &0x2::clock::Clock) : u64 {
        time_expand(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    public fun time_expand3(arg0: u64, arg1: u64) : u64 {
        ASSERT_U64_ADD_UPFLOW(arg0, arg1);
        arg0 + arg1
    }

    public fun time_expand4(arg0: u64, arg1: &0x2::clock::Clock) : u64 {
        time_expand3(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    public fun time_in_range(arg0: u64, arg1: u64, arg2: u64) : bool {
        time_is_expired3(arg2, arg0) && time_is_expired3(arg1, arg2)
    }

    public fun time_in_range2(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) : bool {
        time_in_range(arg0, arg1, 0x2::clock::timestamp_ms(arg2))
    }

    public fun time_is_expired(arg0: u64, arg1: &0x2::clock::Clock) : bool {
        time_is_expired3(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    public fun time_is_expired2(arg0: &0x2::clock::Clock, arg1: u64) : bool {
        time_is_expired3(0x2::clock::timestamp_ms(arg0), arg1)
    }

    public fun time_is_expired3(arg0: u64, arg1: u64) : bool {
        arg0 > arg1
    }

    // decompiled from Move bytecode v6
}

