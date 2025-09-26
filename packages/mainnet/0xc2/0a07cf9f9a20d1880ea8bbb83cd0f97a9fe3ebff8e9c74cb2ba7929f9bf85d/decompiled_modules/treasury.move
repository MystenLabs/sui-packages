module 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::treasury {
    struct Record has copy, drop, store {
        op: u8,
        signer: address,
        payment: address,
        withdraw_guard: 0x1::option::Option<address>,
        amount: u64,
        time: u64,
    }

    public fun GUARD_COUNT(arg0: u64) {
        assert!(arg0 < 16, 2303);
    }

    public fun GUARD_NONE(arg0: bool) {
        assert!(arg0, 2305);
    }

    public fun IMMUTABLE(arg0: bool) {
        assert!(arg0, 2302);
    }

    public fun Is_record(arg0: &Record, arg1: u8, arg2: &0x1::option::Option<address>, arg3: &0x1::option::Option<address>, arg4: bool) : bool {
        let v0 = false;
        let v1 = false;
        let v2 = false;
        if (arg1 & arg0.op > 0) {
            v1 = true;
        };
        if (0x1::option::is_some<address>(arg2)) {
            if (*0x1::option::borrow<address>(arg2) == arg0.payment) {
                v2 = true;
            };
        } else {
            v2 = true;
        };
        if (0x1::option::is_some<address>(arg3)) {
            if (*0x1::option::borrow<address>(arg3) == arg0.signer) {
                v0 = true;
            };
        } else {
            v0 = true;
        };
        let v3 = if (arg4) {
            if (v2) {
                if (v1) {
                    v0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v3) {
            return true
        };
        if (!arg4) {
            let v4 = if (v2) {
                true
            } else if (v1) {
                true
            } else {
                v0
            };
            if (v4) {
                return true
            };
        };
        false
    }

    public fun MAX(arg0: bool) {
        assert!(arg0, 2307);
    }

    public fun MODE(arg0: bool) {
        assert!(arg0, 2306);
    }

    public fun NOT_FOUND(arg0: bool) {
        assert!(arg0, 2304);
    }

    public fun ONLY_GUARD(arg0: bool) {
        assert!(arg0, 2300);
    }

    public fun ONLY_GUARD_MODE(arg0: bool) {
        assert!(arg0, 2301);
    }

    public fun OP_DEPOSIT() : u8 {
        2
    }

    public fun OP_RECEIVE() : u8 {
        4
    }

    public fun OP_WITHDRAW() : u8 {
        1
    }

    public fun Record_amount(arg0: &Record) : u64 {
        arg0.amount
    }

    public fun Record_new(arg0: u8, arg1: &address, arg2: &0x1::option::Option<address>, arg3: u64, arg4: u64, arg5: &address) : Record {
        Record{
            op             : arg0,
            signer         : *arg5,
            payment        : *arg1,
            withdraw_guard : *arg2,
            amount         : arg3,
            time           : arg4,
        }
    }

    public fun Record_payment(arg0: &Record) : &address {
        &arg0.payment
    }

    public fun Record_signer(arg0: &Record) : &address {
        &arg0.signer
    }

    public fun Record_time(arg0: &Record) : u64 {
        arg0.time
    }

    public fun Record_withdraw_guard(arg0: &Record) : &0x1::option::Option<address> {
        &arg0.withdraw_guard
    }

    public fun WITHDRAW_MODE_BOTH() : u8 {
        2
    }

    public fun WITHDRAW_MODE_GUARD_ONLY() : u8 {
        1
    }

    public fun WITHDRAW_MODE_PERMISSION() : u8 {
        0
    }

    // decompiled from Move bytecode v6
}

