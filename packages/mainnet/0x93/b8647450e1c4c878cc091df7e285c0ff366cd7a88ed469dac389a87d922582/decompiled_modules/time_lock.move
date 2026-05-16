module 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::time_lock {
    public fun is_unlocked(arg0: &0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::Form, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::time_lock_unlock_at(arg0);
        v0 > 0 && 0x2::clock::timestamp_ms(arg1) >= v0
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::Form, arg2: &0x2::clock::Clock) {
        let v0 = 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::time_lock_unlock_at(arg1);
        assert!(v0 > 0, 1);
        assert!(0x2::clock::timestamp_ms(arg2) >= v0, 0);
    }

    // decompiled from Move bytecode v6
}

