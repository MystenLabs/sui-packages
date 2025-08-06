module 0x2ff3ee6dd570f1d795d8eaac0d4c774e33d142b250e33f46b3063145c541a529::de_token {
    struct DE_TOKEN has drop {
        dummy_field: bool,
    }

    struct UnlockRequest<phantom T0> has store {
        start_at: u64,
        unlocked_at: u64,
        withdrawal: 0x2::balance::Balance<T0>,
        penalty: 0x2::balance::Balance<T0>,
    }

    struct DeToken<phantom T0> has key {
        id: 0x2::object::UID,
        locked_balance: 0x2::balance::Balance<T0>,
        unlock_requests: vector<UnlockRequest<T0>>,
    }

    public(friend) fun new<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : DeToken<T0> {
        assert!(0x2::balance::value<T0>(&arg0) != 0, 104);
        DeToken<T0>{
            id              : 0x2::object::new(arg1),
            locked_balance  : arg0,
            unlock_requests : 0x1::vector::empty<UnlockRequest<T0>>(),
        }
    }

    public(friend) fun transfer<T0>(arg0: DeToken<T0>, arg1: address) {
        0x2::transfer::transfer<DeToken<T0>>(arg0, arg1);
    }

    public(friend) fun cancel_unlock_request<T0>(arg0: &mut DeToken<T0>, arg1: u64, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        if (!0x1::vector::is_empty<UnlockRequest<T0>>(&arg0.unlock_requests)) {
            let UnlockRequest {
                start_at    : v3,
                unlocked_at : v4,
                withdrawal  : v5,
                penalty     : v6,
            } = 0x1::vector::remove<UnlockRequest<T0>>(&mut arg0.unlock_requests, arg1);
            let v7 = v6;
            let v8 = v5;
            assert!(0x2::clock::timestamp_ms(arg2) < v4, 102);
            0x2::balance::join<T0>(&mut arg0.locked_balance, v8);
            0x2::balance::join<T0>(&mut arg0.locked_balance, v7);
            (0x2::balance::value<T0>(&v8) + 0x2::balance::value<T0>(&v7), v3, v4)
        } else {
            (0, 0, 0)
        }
    }

    public(friend) fun claim<T0>(arg0: &mut DeToken<T0>, arg1: u64, arg2: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, u64, u64) {
        if (!0x1::vector::is_empty<UnlockRequest<T0>>(&arg0.unlock_requests)) {
            let UnlockRequest {
                start_at    : v4,
                unlocked_at : v5,
                withdrawal  : v6,
                penalty     : v7,
            } = 0x1::vector::remove<UnlockRequest<T0>>(&mut arg0.unlock_requests, arg1);
            assert!(0x2::clock::timestamp_ms(arg2) >= v5, 103);
            (v6, v7, v4, v5)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T0>(), 0, 0)
        }
    }

    public fun claimable_balance<T0>(arg0: &DeToken<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0;
        let v1 = &arg0.unlock_requests;
        let v2 = 0;
        while (v2 < 0x1::vector::length<UnlockRequest<T0>>(v1)) {
            let v3 = 0x1::vector::borrow<UnlockRequest<T0>>(v1, v2);
            if (v3.unlocked_at <= 0x2::clock::timestamp_ms(arg1)) {
                v0 = v0 + 0x2::balance::value<T0>(&v3.withdrawal);
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun claimable_requests<T0>(arg0: &DeToken<T0>, arg1: &0x2::clock::Clock) : vector<u64> {
        let v0 = &arg0.unlock_requests;
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<UnlockRequest<T0>>(v0)) {
            if (unlocked_at<T0>(0x1::vector::borrow<UnlockRequest<T0>>(v0, v2)) <= 0x2::clock::timestamp_ms(arg1)) {
                0x1::vector::push_back<u64>(&mut v1, v2);
            };
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun destroy<T0>(arg0: DeToken<T0>) {
        let DeToken {
            id              : v0,
            locked_balance  : v1,
            unlock_requests : v2,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v1);
        0x1::vector::destroy_empty<UnlockRequest<T0>>(v2);
    }

    fun init(arg0: DE_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<DE_TOKEN>(arg0, arg1);
    }

    public fun locked_balance<T0>(arg0: &DeToken<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.locked_balance)
    }

    public fun penalty<T0>(arg0: &UnlockRequest<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.penalty)
    }

    public fun penalty_fee(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u8) : u64 {
        0x2ff3ee6dd570f1d795d8eaac0d4c774e33d142b250e33f46b3063145c541a529::float::ceil(0x2ff3ee6dd570f1d795d8eaac0d4c774e33d142b250e33f46b3063145c541a529::float::mul(0x2ff3ee6dd570f1d795d8eaac0d4c774e33d142b250e33f46b3063145c541a529::float::from(arg0), 0x2ff3ee6dd570f1d795d8eaac0d4c774e33d142b250e33f46b3063145c541a529::float::sub(0x2ff3ee6dd570f1d795d8eaac0d4c774e33d142b250e33f46b3063145c541a529::float::from(1), return_rate(arg1, arg2, arg3, arg4))))
    }

    public(friend) fun request_unlock<T0>(arg0: &mut DeToken<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: &0x2::clock::Clock) {
        assert!(0x2::balance::value<T0>(&arg0.locked_balance) >= arg1, 101);
        let v0 = 0x2::balance::split<T0>(&mut arg0.locked_balance, arg1);
        let v1 = UnlockRequest<T0>{
            start_at    : 0x2::clock::timestamp_ms(arg6),
            unlocked_at : 0x2::clock::timestamp_ms(arg6) + arg2,
            withdrawal  : v0,
            penalty     : 0x2::balance::split<T0>(&mut v0, penalty_fee(arg1, arg2, arg3, arg4, arg5)),
        };
        0x1::vector::push_back<UnlockRequest<T0>>(&mut arg0.unlock_requests, v1);
    }

    public fun return_rate(arg0: u64, arg1: u64, arg2: u64, arg3: u8) : 0x2ff3ee6dd570f1d795d8eaac0d4c774e33d142b250e33f46b3063145c541a529::float::Float {
        if (arg3 > 100) {
            return 0x2ff3ee6dd570f1d795d8eaac0d4c774e33d142b250e33f46b3063145c541a529::float::from(0)
        };
        let v0 = 0x2ff3ee6dd570f1d795d8eaac0d4c774e33d142b250e33f46b3063145c541a529::float::from_percent(arg3);
        0x2ff3ee6dd570f1d795d8eaac0d4c774e33d142b250e33f46b3063145c541a529::float::add(v0, 0x2ff3ee6dd570f1d795d8eaac0d4c774e33d142b250e33f46b3063145c541a529::float::mul(0x2ff3ee6dd570f1d795d8eaac0d4c774e33d142b250e33f46b3063145c541a529::float::sub(0x2ff3ee6dd570f1d795d8eaac0d4c774e33d142b250e33f46b3063145c541a529::float::from_percent(100), v0), 0x2ff3ee6dd570f1d795d8eaac0d4c774e33d142b250e33f46b3063145c541a529::float::div(0x2ff3ee6dd570f1d795d8eaac0d4c774e33d142b250e33f46b3063145c541a529::float::from(arg0 - arg1), 0x2ff3ee6dd570f1d795d8eaac0d4c774e33d142b250e33f46b3063145c541a529::float::from(arg2 - arg1))))
    }

    public fun start_at<T0>(arg0: &UnlockRequest<T0>) : u64 {
        arg0.start_at
    }

    public fun unlock_requests<T0>(arg0: &DeToken<T0>) : &vector<UnlockRequest<T0>> {
        &arg0.unlock_requests
    }

    public fun unlocked_at<T0>(arg0: &UnlockRequest<T0>) : u64 {
        arg0.unlocked_at
    }

    public fun voting_power<T0>(arg0: &DeToken<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.locked_balance);
        let v1 = &arg0.unlock_requests;
        let v2 = 0;
        while (v2 < 0x1::vector::length<UnlockRequest<T0>>(v1)) {
            let v3 = 0x1::vector::borrow<UnlockRequest<T0>>(v1, v2);
            if (0x2::clock::timestamp_ms(arg1) < v3.unlocked_at) {
                v0 = v0 + (0x2::balance::value<T0>(&v3.withdrawal) + 0x2::balance::value<T0>(&v3.penalty)) / 2;
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun withdrawal<T0>(arg0: &UnlockRequest<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.withdrawal)
    }

    // decompiled from Move bytecode v6
}

