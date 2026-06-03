module 0xdb96d18376a5ae96e6bb35a39e36076cb66202d12413e5ed153e5a9f2274c282::apr {
    struct SyncKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun last_sync_ms(arg0: &0x2::object::UID) : u64 {
        let v0 = SyncKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<SyncKey>(arg0, v0)) {
            let v2 = SyncKey{dummy_field: false};
            *0x2::dynamic_field::borrow<SyncKey, u64>(arg0, v2)
        } else {
            0
        }
    }

    public(friend) fun realized(arg0: u256, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u256 {
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

    public(friend) fun set_sync_ms(arg0: &mut 0x2::object::UID, arg1: u64) {
        let v0 = SyncKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<SyncKey>(arg0, v0)) {
            let v1 = SyncKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<SyncKey, u64>(arg0, v1) = arg1;
        } else {
            let v2 = SyncKey{dummy_field: false};
            0x2::dynamic_field::add<SyncKey, u64>(arg0, v2, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

