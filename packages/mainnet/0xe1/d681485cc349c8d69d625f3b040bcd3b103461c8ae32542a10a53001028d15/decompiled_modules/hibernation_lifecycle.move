module 0xe1d681485cc349c8d69d625f3b040bcd3b103461c8ae32542a10a53001028d15::hibernation_lifecycle {
    struct Key has copy, drop, store {
        dummy_field: bool,
    }

    struct State has copy, drop, store {
        winddown_ms: u64,
        hibernated_ms: u64,
        waking_ms: u64,
        last_wake_ms: u64,
        has_woken: bool,
        unlock_remaining: u64,
    }

    public(friend) fun begin(arg0: &mut 0x2::object::UID, arg1: u8, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u128, arg7: bool, arg8: u64, arg9: u64) {
        assert!(arg1 == 0 || arg1 == 5, 1);
        let v0 = if (arg7) {
            if (arg8 > 0) {
                if (arg4) {
                    if (arg5) {
                        arg6 < (arg8 as u128)
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        let v1 = status(arg0);
        assert!(!v1.has_woken || arg2 >= v1.last_wake_ms && arg2 - v1.last_wake_ms >= arg9, 3);
        v1.winddown_ms = arg2;
        v1.hibernated_ms = 0;
        v1.waking_ms = 0;
        v1.unlock_remaining = arg3;
        save(arg0, v1);
    }

    public(friend) fun finish_wake(arg0: &mut 0x2::object::UID, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = if (arg1 == 5) {
            let v1 = Key{dummy_field: false};
            0x2::dynamic_field::exists<Key>(arg0, v1)
        } else {
            false
        };
        assert!(v0, 1);
        let v2 = if (arg3 > 0) {
            if (arg4 > 0) {
                if (arg4 <= arg3) {
                    if (arg5 >= 5000) {
                        arg5 <= 9500
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 4);
        let v3 = (arg3 as u128) * (arg5 as u128);
        let v4 = (arg4 as u128) * 10000;
        let v5 = if (v4 >= v3) {
            v4 - v3
        } else {
            v3 - v4
        };
        assert!(v5 <= (arg3 as u128) * 200, 4);
        let v6 = Key{dummy_field: false};
        let v7 = 0x2::dynamic_field::borrow_mut<Key, State>(arg0, v6);
        assert!(arg2 >= v7.waking_ms && v7.unlock_remaining == 0, 1);
        v7.has_woken = true;
        v7.last_wake_ms = arg2;
    }

    public(friend) fun hibernate(arg0: &mut 0x2::object::UID, arg1: u8, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = if (arg1 == 1) {
            let v1 = Key{dummy_field: false};
            0x2::dynamic_field::exists<Key>(arg0, v1)
        } else {
            false
        };
        assert!(v0, 1);
        let v2 = Key{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<Key, State>(arg0, v2);
        let v4 = if (v3.unlock_remaining == 0) {
            if (arg3 == 0) {
                arg4 == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 4);
        assert!(arg2 >= v3.winddown_ms, 1);
        v3.hibernated_ms = arg2;
    }

    public fun hibernated_at(arg0: &State) : u64 {
        arg0.hibernated_ms
    }

    public fun last_wake(arg0: &State) : (bool, u64) {
        (arg0.has_woken, arg0.last_wake_ms)
    }

    public(friend) fun next_unlock(arg0: &mut 0x2::object::UID, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = Key{dummy_field: false};
        assert!(0x2::dynamic_field::exists<Key>(arg0, v0), 1);
        let v1 = Key{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<Key, State>(arg0, v1);
        v2.unlock_remaining = 0x1::u64::min(v2.unlock_remaining, arg1);
        if (v2.unlock_remaining == 0) {
            return 0x1::option::none<u64>()
        };
        v2.unlock_remaining = v2.unlock_remaining - 1;
        0x1::option::some<u64>(v2.unlock_remaining)
    }

    public fun remaining(arg0: &State) : u64 {
        arg0.unlock_remaining
    }

    fun save(arg0: &mut 0x2::object::UID, arg1: State) {
        let v0 = Key{dummy_field: false};
        if (0x2::dynamic_field::exists<Key>(arg0, v0)) {
            let v1 = Key{dummy_field: false};
            0x2::dynamic_field::remove<Key, State>(arg0, v1);
        };
        let v2 = Key{dummy_field: false};
        0x2::dynamic_field::add<Key, State>(arg0, v2, arg1);
    }

    public(friend) fun status(arg0: &0x2::object::UID) : State {
        let v0 = Key{dummy_field: false};
        if (0x2::dynamic_field::exists<Key>(arg0, v0)) {
            let v2 = Key{dummy_field: false};
            *0x2::dynamic_field::borrow<Key, State>(arg0, v2)
        } else {
            State{winddown_ms: 0, hibernated_ms: 0, waking_ms: 0, last_wake_ms: 0, has_woken: false, unlock_remaining: 0}
        }
    }

    public(friend) fun wake(arg0: &mut 0x2::object::UID, arg1: u8, arg2: u64, arg3: bool, arg4: bool, arg5: u128, arg6: u64, arg7: u64) {
        let v0 = if (arg1 == 2) {
            let v1 = Key{dummy_field: false};
            0x2::dynamic_field::exists<Key>(arg0, v1)
        } else {
            false
        };
        assert!(v0, 1);
        let v2 = if (arg3) {
            if (arg4) {
                arg5 > 2 * (arg6 as u128)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 2);
        let v3 = Key{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow_mut<Key, State>(arg0, v3);
        assert!(arg2 >= v4.hibernated_ms && arg2 - v4.hibernated_ms >= arg7, 3);
        assert!(v4.unlock_remaining == 0, 4);
        v4.waking_ms = arg2;
    }

    // decompiled from Move bytecode v7
}

