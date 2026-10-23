module 0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work {
    struct WorkConfig has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        fee_recipient: address,
        arbiter: address,
        review_ms: u64,
        judge_ms: u64,
        arbiter_ms: u64,
        revision_ms: u64,
    }

    public fun arbiter(arg0: &WorkConfig) : address {
        arg0.arbiter
    }

    public fun arbiter_ms(arg0: &WorkConfig) : u64 {
        arg0.arbiter_ms
    }

    fun check_window(arg0: u64) {
        assert!(arg0 >= 60000 && arg0 <= 60 * 86400000, 2);
    }

    public fun create_config(arg0: &0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::shoutout::AdminCap, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = WorkConfig{
            id            : 0x2::object::new(arg3),
            fee_bps       : 150,
            fee_recipient : arg1,
            arbiter       : arg2,
            review_ms     : 3 * 86400000,
            judge_ms      : 7 * 86400000,
            arbiter_ms    : 14 * 86400000,
            revision_ms   : 3 * 86400000,
        };
        0x2::transfer::share_object<WorkConfig>(v0);
    }

    public fun fee_bps(arg0: &WorkConfig) : u64 {
        arg0.fee_bps
    }

    public fun fee_recipient(arg0: &WorkConfig) : address {
        arg0.fee_recipient
    }

    public(friend) fun give_back<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg0, arg1), arg3), arg2);
        };
    }

    public fun judge_ms(arg0: &WorkConfig) : u64 {
        arg0.judge_ms
    }

    public(friend) fun pay<T0>(arg0: &WorkConfig, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64, arg3: address, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let (v0, v1) = quote(arg0, arg2);
        let (v2, v3) = if (0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::exempt::is_exempt(arg3) || 0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::exempt::is_exempt(arg4)) {
            (v0 + v1, 0)
        } else {
            (v0, v1)
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg1, v3), arg5), arg0.fee_recipient);
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg1, v2), arg5), arg3);
        };
        (v2, v3)
    }

    public fun quote(arg0: &WorkConfig, arg1: u64) : (u64, u64) {
        let v0 = (((arg1 as u128) * (arg0.fee_bps as u128) / (10000 as u128)) as u64);
        (arg1 - v0, v0)
    }

    public fun review_ms(arg0: &WorkConfig) : u64 {
        arg0.review_ms
    }

    public fun revision_ms(arg0: &WorkConfig) : u64 {
        arg0.revision_ms
    }

    public fun set_arbiter(arg0: &0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::shoutout::AdminCap, arg1: &mut WorkConfig, arg2: address) {
        arg1.arbiter = arg2;
    }

    public fun set_fee_bps(arg0: &0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::shoutout::AdminCap, arg1: &mut WorkConfig, arg2: u64) {
        assert!(arg2 <= 500, 1);
        arg1.fee_bps = arg2;
    }

    public fun set_fee_recipient(arg0: &0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::shoutout::AdminCap, arg1: &mut WorkConfig, arg2: address) {
        arg1.fee_recipient = arg2;
    }

    public fun set_windows(arg0: &0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::shoutout::AdminCap, arg1: &mut WorkConfig, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        check_window(arg2);
        check_window(arg3);
        check_window(arg4);
        check_window(arg5);
        arg1.review_ms = arg2;
        arg1.judge_ms = arg3;
        arg1.arbiter_ms = arg4;
        arg1.revision_ms = arg5;
    }

    // decompiled from Move bytecode v7
}

