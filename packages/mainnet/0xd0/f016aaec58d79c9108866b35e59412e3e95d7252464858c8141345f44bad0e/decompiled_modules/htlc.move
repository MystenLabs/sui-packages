module 0xd0f016aaec58d79c9108866b35e59412e3e95d7252464858c8141345f44bad0e::htlc {
    struct HTLC<phantom T0> has key {
        id: 0x2::object::UID,
        sender: address,
        receiver: address,
        amount: u64,
        balance: 0x2::balance::Balance<T0>,
        hashlock: vector<u8>,
        timelock_ms: u64,
        claimed: bool,
        refunded: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PauseState has key {
        id: 0x2::object::UID,
        paused: bool,
    }

    struct PlatformFeeConfig has key {
        id: 0x2::object::UID,
        platform_fee_recipient: address,
        min_fee_bps: u64,
        max_rebate_bps: u64,
    }

    struct HTLCLocked has copy, drop {
        htlc_id: 0x2::object::ID,
        sender: address,
        receiver: address,
        hashlock: vector<u8>,
        timelock_ms: u64,
        amount: u64,
        coin_type: 0x1::ascii::String,
        fee_recipient: address,
        fee_bps: u64,
        rebate_recipient: address,
        rebate_bps: u64,
    }

    struct HTLCClaimed has copy, drop {
        htlc_id: 0x2::object::ID,
        preimage: vector<u8>,
        hashlock: vector<u8>,
    }

    struct HTLCRefunded has copy, drop {
        htlc_id: 0x2::object::ID,
    }

    public entry fun claim<T0>(arg0: &PauseState, arg1: &mut HTLC<T0>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 11);
        assert!(!arg1.claimed, 4);
        assert!(!arg1.refunded, 5);
        assert!(0x2::tx_context::sender(arg4) == arg1.receiver, 10);
        assert!(0x2::clock::timestamp_ms(arg3) < arg1.timelock_ms, 8);
        assert!(0x1::hash::sha2_256(arg2) == arg1.hashlock, 6);
        arg1.claimed = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.balance), arg4), arg1.receiver);
        let v0 = HTLCClaimed{
            htlc_id  : 0x2::object::id<HTLC<T0>>(arg1),
            preimage : arg2,
            hashlock : arg1.hashlock,
        };
        0x2::event::emit<HTLCClaimed>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = PauseState{
            id     : 0x2::object::new(arg0),
            paused : false,
        };
        0x2::transfer::share_object<PauseState>(v1);
        let v2 = PlatformFeeConfig{
            id                     : 0x2::object::new(arg0),
            platform_fee_recipient : @0x0,
            min_fee_bps            : 0,
            max_rebate_bps         : 10000,
        };
        0x2::transfer::share_object<PlatformFeeConfig>(v2);
    }

    public entry fun lock<T0>(arg0: &PauseState, arg1: &PlatformFeeConfig, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: u64, arg5: address, arg6: address, arg7: u64, arg8: address, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 11);
        assert!(0x2::coin::value<T0>(&arg2) >= 1000000000, 14);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 1);
        if (arg1.platform_fee_recipient != @0x0) {
            assert!(arg6 == arg1.platform_fee_recipient, 15);
        };
        if (arg1.min_fee_bps > 0) {
            assert!(arg7 >= arg1.min_fee_bps, 16);
        };
        assert!(arg9 <= arg1.max_rebate_bps, 17);
        assert!(arg4 >= 0x2::clock::timestamp_ms(arg10) + 900000, 2);
        assert!(arg5 != @0x0, 3);
        assert!(arg7 <= 10000, 12);
        assert!(arg9 <= 10000, 13);
        let v0 = (((0x2::coin::value<T0>(&arg2) as u128) * (arg7 as u128) / 10000) as u64);
        if (v0 > 0 && arg6 != @0x0) {
            let v1 = 0x2::coin::split<T0>(&mut arg2, v0, arg11);
            let v2 = (((v0 as u128) * (arg9 as u128) / 10000) as u64);
            if (v2 > 0 && arg8 != @0x0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v1, v2, arg11), arg8);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, arg6);
        };
        let v3 = 0x2::coin::value<T0>(&arg2);
        assert!(v3 > 0, 0);
        let v4 = 0x2::tx_context::sender(arg11);
        let v5 = HTLC<T0>{
            id          : 0x2::object::new(arg11),
            sender      : v4,
            receiver    : arg5,
            amount      : v3,
            balance     : 0x2::coin::into_balance<T0>(arg2),
            hashlock    : arg3,
            timelock_ms : arg4,
            claimed     : false,
            refunded    : false,
        };
        let v6 = HTLCLocked{
            htlc_id          : 0x2::object::id<HTLC<T0>>(&v5),
            sender           : v4,
            receiver         : arg5,
            hashlock         : v5.hashlock,
            timelock_ms      : arg4,
            amount           : v3,
            coin_type        : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            fee_recipient    : arg6,
            fee_bps          : arg7,
            rebate_recipient : arg8,
            rebate_bps       : arg9,
        };
        0x2::event::emit<HTLCLocked>(v6);
        0x2::transfer::share_object<HTLC<T0>>(v5);
    }

    public entry fun pause(arg0: &AdminCap, arg1: &mut PauseState) {
        arg1.paused = true;
    }

    public entry fun refund<T0>(arg0: &PauseState, arg1: &mut HTLC<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 11);
        assert!(!arg1.claimed, 4);
        assert!(!arg1.refunded, 5);
        assert!(0x2::tx_context::sender(arg3) == arg1.sender, 9);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.timelock_ms, 7);
        arg1.refunded = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.balance), arg3), arg1.sender);
        let v0 = HTLCRefunded{htlc_id: 0x2::object::id<HTLC<T0>>(arg1)};
        0x2::event::emit<HTLCRefunded>(v0);
    }

    public entry fun set_platform_fee(arg0: &AdminCap, arg1: &mut PlatformFeeConfig, arg2: address, arg3: u64, arg4: u64) {
        assert!(arg3 <= 10000, 12);
        assert!(arg4 <= 10000, 13);
        arg1.platform_fee_recipient = arg2;
        arg1.min_fee_bps = arg3;
        arg1.max_rebate_bps = arg4;
    }

    public entry fun unpause(arg0: &AdminCap, arg1: &mut PauseState) {
        arg1.paused = false;
    }

    // decompiled from Move bytecode v6
}

