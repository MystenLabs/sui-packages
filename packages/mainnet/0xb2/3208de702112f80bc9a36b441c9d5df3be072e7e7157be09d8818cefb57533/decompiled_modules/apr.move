module 0xb23208de702112f80bc9a36b441c9d5df3be072e7e7157be09d8818cefb57533::apr {
    struct SyncKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RatioKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun last_ratio(arg0: &0x2::object::UID) : u256 {
        let v0 = RatioKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<RatioKey>(arg0, v0)) {
            let v2 = RatioKey{dummy_field: false};
            *0x2::dynamic_field::borrow<RatioKey, u256>(arg0, v2)
        } else {
            0
        }
    }

    public fun last_sync_ms(arg0: &0x2::object::UID) : u64 {
        let v0 = SyncKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<SyncKey>(arg0, v0)) {
            let v2 = SyncKey{dummy_field: false};
            *0x2::dynamic_field::borrow<SyncKey, u64>(arg0, v2)
        } else {
            0
        }
    }

    public fun ratio_from_amounts(arg0: u64, arg1: u64) : u256 {
        if (arg1 == 0) {
            0
        } else {
            (arg0 as u256) * 1000000000000000000 / (arg1 as u256)
        }
    }

    public fun realized(arg0: u256, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u256 {
        let v0 = if (arg1 == 0) {
            true
        } else if (arg2 <= arg1) {
            true
        } else if (arg3 == 0) {
            true
        } else {
            arg4 <= arg3
        };
        if (v0) {
            return arg0
        };
        let v1 = arg4 - arg3;
        if (v1 < 3600000) {
            return arg0
        };
        ((arg2 - arg1) as u256) * 31536000000 * 1000000000000000000 / (arg1 as u256) * (v1 as u256)
    }

    fun set_ratio(arg0: &mut 0x2::object::UID, arg1: u256) {
        let v0 = RatioKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<RatioKey>(arg0, v0)) {
            let v1 = RatioKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<RatioKey, u256>(arg0, v1) = arg1;
        } else {
            let v2 = RatioKey{dummy_field: false};
            0x2::dynamic_field::add<RatioKey, u256>(arg0, v2, arg1);
        };
    }

    public fun set_sync_ms(arg0: &mut 0x2::object::UID, arg1: u64) {
        let v0 = SyncKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<SyncKey>(arg0, v0)) {
            let v1 = SyncKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<SyncKey, u64>(arg0, v1) = arg1;
        } else {
            let v2 = SyncKey{dummy_field: false};
            0x2::dynamic_field::add<SyncKey, u64>(arg0, v2, arg1);
        };
    }

    public fun update_apr_from_ratio(arg0: &mut 0x2::object::UID, arg1: u256, arg2: u256, arg3: u64) : u256 {
        let v0 = last_sync_ms(arg0);
        if (v0 == 0) {
            set_sync_ms(arg0, arg3);
            set_ratio(arg0, arg2);
            return arg1
        };
        if (arg3 <= v0 || arg3 - v0 < 180000) {
            return arg1
        };
        let v1 = last_ratio(arg0);
        let v2 = if (v1 > 0 && arg2 > v1) {
            (arg2 - v1) * 31536000000 * 1000000000000000000 / v1 * ((arg3 - v0) as u256)
        } else {
            arg1
        };
        set_sync_ms(arg0, arg3);
        set_ratio(arg0, arg2);
        v2
    }

    // decompiled from Move bytecode v7
}

