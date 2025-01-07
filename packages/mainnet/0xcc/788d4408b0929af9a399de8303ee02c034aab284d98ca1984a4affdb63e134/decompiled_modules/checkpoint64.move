module 0xcc788d4408b0929af9a399de8303ee02c034aab284d98ca1984a4affdb63e134::checkpoint64 {
    struct Trace64 has store {
        checkpoints: vector<Checkpoint64>,
    }

    struct Checkpoint64 has copy, drop, store {
        key: u64,
        value: u64,
    }

    public fun length(arg0: &Trace64) : u64 {
        0x1::vector::length<Checkpoint64>(&arg0.checkpoints)
    }

    public fun at(arg0: &Trace64, arg1: u64) : &Checkpoint64 {
        assert!(length(arg0) > 0 && arg1 < length(arg0), 1);
        unsafe_borrow(&arg0.checkpoints, arg1)
    }

    public fun create() : Trace64 {
        Trace64{checkpoints: 0x1::vector::empty<Checkpoint64>()}
    }

    public fun drop(arg0: Trace64) {
        let Trace64 { checkpoints: v0 } = arg0;
        while (0x1::vector::length<Checkpoint64>(&v0) > 0) {
            0x1::vector::pop_back<Checkpoint64>(&mut v0);
        };
        0x1::vector::destroy_empty<Checkpoint64>(v0);
    }

    fun insert(arg0: &mut vector<Checkpoint64>, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = 0x1::vector::length<Checkpoint64>(arg0);
        let v1 = if (v0 > 0) {
            let v2 = unsafe_borrow_mut(arg0, v0 - 1);
            assert!(v2.key <= arg1, 0);
            if (v2.key == arg1) {
                v2.value = arg2;
            } else {
                let v3 = Checkpoint64{
                    key   : arg1,
                    value : arg2,
                };
                0x1::vector::push_back<Checkpoint64>(arg0, v3);
            };
            v2.value
        } else {
            let v4 = Checkpoint64{
                key   : arg1,
                value : arg2,
            };
            0x1::vector::push_back<Checkpoint64>(arg0, v4);
            0
        };
        (v1, arg2)
    }

    public fun key(arg0: &Checkpoint64) : u64 {
        arg0.key
    }

    public fun latest(arg0: &Trace64) : u64 {
        let v0 = 0x1::vector::length<Checkpoint64>(&arg0.checkpoints);
        if (v0 == 0) {
            0
        } else {
            unsafe_borrow(&arg0.checkpoints, v0 - 1).value
        }
    }

    public fun latest_checkpoint(arg0: &Trace64) : (bool, u64, u64) {
        let v0 = 0x1::vector::length<Checkpoint64>(&arg0.checkpoints);
        if (v0 == 0) {
            (false, 0, 0)
        } else {
            let v4 = unsafe_borrow(&arg0.checkpoints, v0 - 1);
            (true, v4.key, v4.value)
        }
    }

    fun lower_binary_lockup(arg0: &vector<Checkpoint64>, arg1: u64, arg2: u64, arg3: u64) : u64 {
        while (arg2 < arg3) {
            let v0 = 0xcc788d4408b0929af9a399de8303ee02c034aab284d98ca1984a4affdb63e134::math_utils::average_u64(arg2, arg3);
            if (unsafe_borrow(arg0, v0).key < arg1) {
                arg2 = v0 + 1;
                continue
            };
            arg3 = v0;
        };
        arg3
    }

    public fun lower_lockup(arg0: &Trace64, arg1: u64) : (u64, u64) {
        let v0 = 0x1::vector::length<Checkpoint64>(&arg0.checkpoints);
        let v1 = lower_binary_lockup(&arg0.checkpoints, arg1, 0, v0);
        if (v1 == v0) {
            (0, 0)
        } else {
            (v1, unsafe_borrow(&arg0.checkpoints, v1).value)
        }
    }

    public fun push(arg0: &mut Trace64, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = &mut arg0.checkpoints;
        insert(v0, arg1, arg2)
    }

    fun unsafe_borrow(arg0: &vector<Checkpoint64>, arg1: u64) : &Checkpoint64 {
        0x1::vector::borrow<Checkpoint64>(arg0, arg1)
    }

    fun unsafe_borrow_mut(arg0: &mut vector<Checkpoint64>, arg1: u64) : &mut Checkpoint64 {
        0x1::vector::borrow_mut<Checkpoint64>(arg0, arg1)
    }

    fun upper_binary_lockup(arg0: &vector<Checkpoint64>, arg1: u64, arg2: u64, arg3: u64) : u64 {
        while (arg2 < arg3) {
            let v0 = 0xcc788d4408b0929af9a399de8303ee02c034aab284d98ca1984a4affdb63e134::math_utils::average_u64(arg2, arg3);
            if (unsafe_borrow(arg0, v0).key > arg1) {
                arg3 = v0;
                continue
            };
            arg2 = v0 + 1;
        };
        arg3
    }

    public fun upper_lockup(arg0: &Trace64, arg1: u64) : (u64, u64) {
        let v0 = upper_binary_lockup(&arg0.checkpoints, arg1, 0, 0x1::vector::length<Checkpoint64>(&arg0.checkpoints));
        if (v0 == 0) {
            (0, 0)
        } else {
            (v0 - 1, unsafe_borrow(&arg0.checkpoints, v0 - 1).value)
        }
    }

    public fun upper_lockup_recent(arg0: &Trace64, arg1: u64) : (u64, u64) {
        let v0 = 0x1::vector::length<Checkpoint64>(&arg0.checkpoints);
        let v1 = 0;
        let v2 = v0;
        if (v0 > 5) {
            let v3 = v0 - 0xcc788d4408b0929af9a399de8303ee02c034aab284d98ca1984a4affdb63e134::math_utils::sqrt_u64(v0);
            if (arg1 < unsafe_borrow(&arg0.checkpoints, v3).key) {
                v2 = v3;
            } else {
                v1 = v3 + 1;
            };
        };
        let v4 = upper_binary_lockup(&arg0.checkpoints, arg1, v1, v2);
        if (v4 == 0) {
            (0, 0)
        } else {
            (v4 - 1, unsafe_borrow(&arg0.checkpoints, v4 - 1).value)
        }
    }

    public fun value(arg0: &Checkpoint64) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

