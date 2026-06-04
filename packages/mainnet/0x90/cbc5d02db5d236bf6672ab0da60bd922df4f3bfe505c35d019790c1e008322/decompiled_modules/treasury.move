module 0x90cbc5d02db5d236bf6672ab0da60bd922df4f3bfe505c35d019790c1e008322::treasury {
    struct Treasury has key {
        id: 0x2::object::UID,
        platform_balance: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
        referrals: 0x2::table::Table<address, 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>,
    }

    struct PaymentProcessed has copy, drop {
        payer: address,
        package_cost: u64,
        platform_fee: u64,
        referrer: 0x1::option::Option<address>,
        referrer_cut: u64,
    }

    struct ReferrerRegistered has copy, drop {
        referrer: address,
    }

    struct ReferralCredited has copy, drop {
        referrer: address,
        amount: u64,
    }

    struct ReferralFallback has copy, drop {
        intended_referrer: address,
        amount: u64,
        reason: vector<u8>,
    }

    struct ReferralClaimed has copy, drop {
        referrer: address,
        amount: u64,
    }

    struct PlatformWithdrawn has copy, drop {
        amount: u64,
    }

    public fun claim_rewards(arg0: &mut Treasury, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL> {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(&arg0.referrals, v0), 1);
        let v1 = 0x2::table::borrow_mut<address, 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(&mut arg0.referrals, v0);
        let v2 = 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v1);
        assert!(v2 > 0, 2);
        let v3 = ReferralClaimed{
            referrer : v0,
            amount   : v2,
        };
        0x2::event::emit<ReferralClaimed>(v3);
        0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v1, v2), arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id               : 0x2::object::new(arg0),
            platform_balance : 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(),
            referrals        : 0x2::table::new<address, 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(arg0),
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    public(friend) fun process_payment(arg0: &mut Treasury, arg1: &0x90cbc5d02db5d236bf6672ab0da60bd922df4f3bfe505c35d019790c1e008322::config::GlobalConfig, arg2: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg3: u64, arg4: 0x1::option::Option<address>, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = (0x90cbc5d02db5d236bf6672ab0da60bd922df4f3bfe505c35d019790c1e008322::config::max_bps() as u128);
        let v2 = (((arg3 as u128) * (0x90cbc5d02db5d236bf6672ab0da60bd922df4f3bfe505c35d019790c1e008322::config::platform_fee_bps(arg1) as u128) / v1) as u64);
        assert!(0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg2) >= v2, 3);
        if (v2 == 0) {
            let v3 = PaymentProcessed{
                payer        : v0,
                package_cost : arg3,
                platform_fee : 0,
                referrer     : arg4,
                referrer_cut : 0,
            };
            0x2::event::emit<PaymentProcessed>(v3);
            return
        };
        let v4 = 0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::coin::balance_mut<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg2), v2);
        let v5 = (((v2 as u128) * (0x90cbc5d02db5d236bf6672ab0da60bd922df4f3bfe505c35d019790c1e008322::config::referrer_share_bps(arg1) as u128) / v1) as u64);
        let v6 = 0;
        let v7 = 0x1::option::none<address>();
        if (v5 > 0 && 0x1::option::is_some<address>(&arg4)) {
            let v8 = *0x1::option::borrow<address>(&arg4);
            if (v8 == v0) {
                let v9 = ReferralFallback{
                    intended_referrer : v8,
                    amount            : v5,
                    reason            : b"self_referral",
                };
                0x2::event::emit<ReferralFallback>(v9);
            } else if (0x2::table::contains<address, 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(&arg0.referrals, v8)) {
                0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::table::borrow_mut<address, 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(&mut arg0.referrals, v8), 0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut v4, v5));
                v6 = v5;
                v7 = 0x1::option::some<address>(v8);
                let v10 = ReferralCredited{
                    referrer : v8,
                    amount   : v5,
                };
                0x2::event::emit<ReferralCredited>(v10);
            } else {
                let v11 = ReferralFallback{
                    intended_referrer : v8,
                    amount            : v5,
                    reason            : b"not_registered",
                };
                0x2::event::emit<ReferralFallback>(v11);
            };
        };
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.platform_balance, v4);
        let v12 = PaymentProcessed{
            payer        : v0,
            package_cost : arg3,
            platform_fee : v2,
            referrer     : v7,
            referrer_cut : v6,
        };
        0x2::event::emit<PaymentProcessed>(v12);
    }

    public fun register_referrer(arg0: &mut Treasury, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::table::contains<address, 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(&arg0.referrals, v0)) {
            0x2::table::add<address, 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(&mut arg0.referrals, v0, 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>());
            let v1 = ReferrerRegistered{referrer: v0};
            0x2::event::emit<ReferrerRegistered>(v1);
        };
    }

    public fun withdraw_platform_funds(arg0: &0x90cbc5d02db5d236bf6672ab0da60bd922df4f3bfe505c35d019790c1e008322::config::AdminCap, arg1: &mut Treasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL> {
        let v0 = PlatformWithdrawn{amount: arg2};
        0x2::event::emit<PlatformWithdrawn>(v0);
        0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg1.platform_balance, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

