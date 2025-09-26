module 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport {
    public fun CONST(arg0: bool) {
        assert!(arg0, 1610);
    }

    public fun CONST_NOT_FOUND(arg0: bool) {
        assert!(arg0, 1612);
    }

    public fun FAIL(arg0: bool) {
        assert!(arg0, 1608);
    }

    public fun FINISHED(arg0: bool) {
        assert!(arg0, 1602);
    }

    public fun GET_ADDRESS(arg0: &mut vector<vector<u8>>) : address {
        let v0 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::new(0x1::vector::pop_back<vector<u8>>(arg0));
        TYPE(0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::peel_u8(&mut v0) == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_ADDRESS());
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::peel_address(&mut v0)
    }

    public fun GET_AS_U256(arg0: &mut vector<vector<u8>>) : u256 {
        let v0 = 0x1::vector::pop_back<vector<u8>>(arg0);
        GET_AS_U256_Imp(&v0)
    }

    public fun GET_AS_U256_Imp(arg0: &vector<u8>) : u256 {
        let v0 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::new(*arg0);
        let v1 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::peel_u8(&mut v0);
        if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U8()) {
            return (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::peel_u8(&mut v0) as u256)
        };
        if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U16()) {
            return (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::peel_u16(&mut v0) as u256)
        };
        if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U64()) {
            return (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::peel_u64(&mut v0) as u256)
        };
        if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U128()) {
            return (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::peel_u128(&mut v0) as u256)
        };
        if (v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_U256()) {
            return 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::peel_u256(&mut v0)
        };
        TYPE(false);
        0
    }

    public fun GET_BOOL(arg0: &mut vector<vector<u8>>) : bool {
        let v0 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::new(0x1::vector::pop_back<vector<u8>>(arg0));
        if (0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::peel_u8(&mut v0) == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_BOOL()) {
            return 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::peel_bool(&mut v0)
        };
        TYPE(false);
        false
    }

    public fun GET_U16(arg0: &mut vector<vector<u8>>) : u16 {
        let v0 = GET_AS_U256(arg0);
        U16_OVERFLOW(v0 < 65536);
        (v0 as u16)
    }

    public fun GET_U64(arg0: &mut vector<vector<u8>>) : u64 {
        let v0 = GET_AS_U256(arg0);
        U64_OVERFLOW(v0 < 18446744073709551615);
        (v0 as u64)
    }

    public fun GET_U8(arg0: &mut vector<vector<u8>>) : u8 {
        let v0 = GET_AS_U256(arg0);
        U8_OVERFLOW(v0 < 256);
        (v0 as u8)
    }

    public fun GET_VEC_U8(arg0: &mut vector<vector<u8>>) : vector<u8> {
        let v0 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::new(0x1::vector::pop_back<vector<u8>>(arg0));
        let v1 = 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::peel_u8(&mut v0);
        let v2 = v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_VEC_U8() || v1 == 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_STRING();
        TYPE(v2);
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::bcs::peel_vec_u8(&mut v0)
    }

    public fun GUARD_COUNT(arg0: u64) {
        assert!(arg0 < 8, 1606);
    }

    public fun GUARD_EXISTED() {
        abort 1614
    }

    public fun IDENTIFER_VALUE_NOT_FOUND(arg0: bool) {
        assert!(arg0, 1628);
    }

    public fun INPUT(arg0: u64) {
        assert!(arg0 > 0, 1611);
    }

    public fun LOGIC_COUNT(arg0: u8) {
        assert!(arg0 >= 2 && arg0 <= 6, 1600);
    }

    public fun MATCH(arg0: bool) {
        assert!(arg0, 1605);
    }

    public fun NEED_PASSPORT(arg0: bool) {
        assert!(arg0, 1618);
    }

    public fun OBJECT_INVALID_WITH_TYPE(arg0: bool) {
        assert!(arg0, 1625);
    }

    public fun QUERYDATA_GUARD_NOT_FOUND(arg0: bool) {
        assert!(arg0, 1623);
    }

    public fun QUERY_ADDR() {
        abort 1613
    }

    public fun Q_CMD_NOT_MATCH() {
        abort 1617
    }

    public fun Q_OBJECT_NOT_MATCH(arg0: bool) {
        assert!(arg0, 1616);
    }

    public fun RESULT(arg0: bool) {
        assert!(arg0, 1603);
    }

    public fun RES_TYPE(arg0: bool) {
        assert!(arg0, 1609);
    }

    public fun TYPE(arg0: bool) {
        assert!(arg0, 1604);
    }

    public fun U128_OVERFLOW(arg0: bool) {
        assert!(arg0, 1622);
    }

    public fun U132_OVERFLOW(arg0: bool) {
        assert!(arg0, 1627);
    }

    public fun U16_OVERFLOW(arg0: bool) {
        assert!(arg0, 1626);
    }

    public fun U64_OVERFLOW(arg0: bool) {
        assert!(arg0, 1621);
    }

    public fun U8_OVERFLOW(arg0: bool) {
        assert!(arg0, 1620);
    }

    public fun UNFINISHED(arg0: bool) {
        assert!(arg0, 1601);
    }

    public fun USED(arg0: bool) {
        assert!(arg0, 1607);
    }

    public fun WITNESS(arg0: bool) {
        assert!(arg0, 1615);
    }

    public fun WITNESS_TYPE_INVALID() {
        abort 1619
    }

    public fun WITNISS_TYPE_NOT_FOUND(arg0: bool) {
        assert!(arg0, 1624);
    }

    // decompiled from Move bytecode v6
}

