module 0x6e957f725baa33b6b8dd4bb543977ba1c00e1bb9dd4af6562f1f52c76378c372::rewards {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RewardConfig has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        lock_duration_ms: u64,
        consumer_bps: u64,
        merchant_bps: u64,
        merchant_referrer_bps: u64,
        regional_agent_bps: u64,
        upline_bps: vector<u64>,
    }

    struct LockedReward<phantom T0> has store, key {
        id: 0x2::object::UID,
        order_id: vector<u8>,
        beneficiary: address,
        unlock_at_ms: u64,
        balance: 0x2::balance::Balance<T0>,
    }

    struct DistributionCompleted<phantom T0> has copy, drop {
        order_id: vector<u8>,
        total_amount: u64,
        consumer: address,
        consumer_amount: u64,
        unlock_at_ms: u64,
        merchant: address,
        merchant_amount: u64,
        merchant_referrer: address,
        merchant_referrer_amount: u64,
        regional_agent: address,
        regional_agent_amount: u64,
        pending_recipient: address,
    }

    struct UplineRewardPaid<phantom T0> has copy, drop {
        order_id: vector<u8>,
        level: u64,
        recipient: address,
        amount: u64,
    }

    struct RewardClaimed<phantom T0> has copy, drop {
        order_id: vector<u8>,
        beneficiary: address,
        amount: u64,
    }

    struct LockDurationUpdated has copy, drop {
        old_duration_ms: u64,
        new_duration_ms: u64,
    }

    fun assert_current(arg0: &RewardConfig) {
        assert!(arg0.version == 1, 7);
    }

    fun assert_distribution(arg0: &RewardConfig) {
        assert!(0x1::vector::length<u64>(&arg0.upline_bps) == 8, 4);
        let v0 = arg0.consumer_bps + arg0.merchant_bps + arg0.merchant_referrer_bps + arg0.regional_agent_bps;
        let v1 = 0;
        while (v1 < 8) {
            v0 = v0 + *0x1::vector::borrow<u64>(&arg0.upline_bps, v1);
            v1 = v1 + 1;
        };
        assert!(v0 == 10000, 4);
    }

    public fun beneficiary<T0>(arg0: &LockedReward<T0>) : address {
        arg0.beneficiary
    }

    fun bps_amount(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun claim<T0>(arg0: LockedReward<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let LockedReward {
            id           : v0,
            order_id     : v1,
            beneficiary  : v2,
            unlock_at_ms : v3,
            balance      : v4,
        } = arg0;
        let v5 = v4;
        assert!(0x2::tx_context::sender(arg2) == v2, 6);
        assert!(0x2::clock::timestamp_ms(arg1) >= v3, 5);
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg2), v2);
        let v6 = RewardClaimed<T0>{
            order_id    : v1,
            beneficiary : v2,
            amount      : 0x2::balance::value<T0>(&v5),
        };
        0x2::event::emit<RewardClaimed<T0>>(v6);
    }

    public fun create(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = RewardConfig{
            id                    : 0x2::object::new(arg1),
            version               : 1,
            paused                : false,
            lock_duration_ms      : arg0,
            consumer_bps          : 6000,
            merchant_bps          : 1500,
            merchant_referrer_bps : 400,
            regional_agent_bps    : 300,
            upline_bps            : vector[350, 700, 250, 200, 125, 85, 55, 35],
        };
        assert_distribution(&v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<RewardConfig>(v1);
    }

    public fun distribute<T0>(arg0: &RewardConfig, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: address, arg4: address, arg5: address, arg6: vector<address>, arg7: address, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_current(arg0);
        assert!(!arg0.paused, 1);
        let v0 = if (arg2 != @0x0) {
            if (arg3 != @0x0) {
                arg7 != @0x0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        assert!(0x1::vector::length<address>(&arg6) == 8, 4);
        assert!(!0x1::vector::is_empty<u8>(&arg8), 3);
        assert_distribution(arg0);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0, 3);
        let v2 = bps_amount(v1, arg0.merchant_bps);
        let v3 = bps_amount(v1, arg0.merchant_referrer_bps);
        let v4 = bps_amount(v1, arg0.regional_agent_bps);
        let v5 = &mut arg1;
        transfer_share<T0>(v5, v2, arg3, arg7, arg10);
        let v6 = &mut arg1;
        transfer_share<T0>(v6, v3, arg4, arg7, arg10);
        let v7 = &mut arg1;
        transfer_share<T0>(v7, v4, arg5, arg7, arg10);
        let v8 = 0;
        while (v8 < 8) {
            let v9 = bps_amount(v1, *0x1::vector::borrow<u64>(&arg0.upline_bps, v8));
            let v10 = resolved_recipient(*0x1::vector::borrow<address>(&arg6, v8), arg7);
            let v11 = &mut arg1;
            transfer_share<T0>(v11, v9, v10, arg7, arg10);
            let v12 = UplineRewardPaid<T0>{
                order_id  : arg8,
                level     : v8 + 1,
                recipient : v10,
                amount    : v9,
            };
            0x2::event::emit<UplineRewardPaid<T0>>(v12);
            v8 = v8 + 1;
        };
        let v13 = 0x2::clock::timestamp_ms(arg9) + arg0.lock_duration_ms;
        let v14 = LockedReward<T0>{
            id           : 0x2::object::new(arg10),
            order_id     : arg8,
            beneficiary  : arg2,
            unlock_at_ms : v13,
            balance      : 0x2::coin::into_balance<T0>(arg1),
        };
        0x2::transfer::transfer<LockedReward<T0>>(v14, arg2);
        let v15 = DistributionCompleted<T0>{
            order_id                 : arg8,
            total_amount             : v1,
            consumer                 : arg2,
            consumer_amount          : 0x2::coin::value<T0>(&arg1),
            unlock_at_ms             : v13,
            merchant                 : resolved_recipient(arg3, arg7),
            merchant_amount          : v2,
            merchant_referrer        : resolved_recipient(arg4, arg7),
            merchant_referrer_amount : v3,
            regional_agent           : resolved_recipient(arg5, arg7),
            regional_agent_amount    : v4,
            pending_recipient        : arg7,
        };
        0x2::event::emit<DistributionCompleted<T0>>(v15);
    }

    public fun is_paused(arg0: &RewardConfig) : bool {
        arg0.paused
    }

    public fun lock_duration_ms(arg0: &RewardConfig) : u64 {
        arg0.lock_duration_ms
    }

    public fun locked_amount<T0>(arg0: &LockedReward<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun order_id<T0>(arg0: &LockedReward<T0>) : vector<u8> {
        arg0.order_id
    }

    fun resolved_recipient(arg0: address, arg1: address) : address {
        if (arg0 == @0x0) {
            arg1
        } else {
            arg0
        }
    }

    public fun set_distribution(arg0: &AdminCap, arg1: &mut RewardConfig, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u64>) {
        assert_current(arg1);
        assert!(0x1::vector::length<u64>(&arg6) == 8, 4);
        arg1.consumer_bps = arg2;
        arg1.merchant_bps = arg3;
        arg1.merchant_referrer_bps = arg4;
        arg1.regional_agent_bps = arg5;
        arg1.upline_bps = arg6;
        assert_distribution(arg1);
    }

    public fun set_lock_duration(arg0: &AdminCap, arg1: &mut RewardConfig, arg2: u64) {
        assert_current(arg1);
        arg1.lock_duration_ms = arg2;
        let v0 = LockDurationUpdated{
            old_duration_ms : arg1.lock_duration_ms,
            new_duration_ms : arg2,
        };
        0x2::event::emit<LockDurationUpdated>(v0);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut RewardConfig, arg2: bool) {
        assert_current(arg1);
        arg1.paused = arg2;
    }

    fun transfer_share<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, arg1, arg4), resolved_recipient(arg2, arg3));
        };
    }

    public fun unlock_at_ms<T0>(arg0: &LockedReward<T0>) : u64 {
        arg0.unlock_at_ms
    }

    // decompiled from Move bytecode v7
}

