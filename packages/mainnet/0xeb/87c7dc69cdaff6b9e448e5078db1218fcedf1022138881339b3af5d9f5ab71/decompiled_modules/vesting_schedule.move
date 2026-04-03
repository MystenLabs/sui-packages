module 0xeb87c7dc69cdaff6b9e448e5078db1218fcedf1022138881339b3af5d9f5ab71::vesting_schedule {
    struct VestingWallet<phantom T0> has key {
        id: 0x2::object::UID,
        beneficiary: address,
        cliff_time: u64,
        end_time: u64,
        total_amount: u64,
        claimed: u64,
        balance: 0x2::balance::Balance<T0>,
        creator: address,
    }

    struct VestingScheduleCreated has copy, drop {
        wallet_id: vector<u8>,
        beneficiary: address,
        creator: address,
        total_amount: u64,
        cliff_time: u64,
        end_time: u64,
        fee_charged: u64,
    }

    struct TokensVested has copy, drop {
        wallet_id: vector<u8>,
        beneficiary: address,
        amount_claimed: u64,
        remaining_balance: u64,
    }

    struct PlatformFeeCollected has copy, drop {
        wallet_id: vector<u8>,
        fee_amount: u64,
        admin: address,
    }

    public fun new<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: address, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg0));
        assert!(v0 > 0, 13906834535121289227);
        assert!(arg4 >= 0x2::clock::timestamp_ms(arg2), 13906834543710961671);
        assert!(arg5 > arg4, 13906834548005928967);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v1) >= 1000000000, 13906834560890961929);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1, 1000000000), arg6), @0x92a32ac7fd525f8bd37ed359423b8d7d858cad26224854dfbff1914b75ee658b);
        if (0x2::balance::value<0x2::sui::SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg6), 0x2::tx_context::sender(arg6));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        };
        let v2 = 0x2::object::new(arg6);
        let v3 = VestingScheduleCreated{
            wallet_id    : 0x2::object::uid_to_bytes(&v2),
            beneficiary  : arg3,
            creator      : 0x2::tx_context::sender(arg6),
            total_amount : v0,
            cliff_time   : arg4,
            end_time     : arg5,
            fee_charged  : 1000000000,
        };
        0x2::event::emit<VestingScheduleCreated>(v3);
        let v4 = PlatformFeeCollected{
            wallet_id  : 0x2::object::uid_to_bytes(&v2),
            fee_amount : 1000000000,
            admin      : @0x92a32ac7fd525f8bd37ed359423b8d7d858cad26224854dfbff1914b75ee658b,
        };
        0x2::event::emit<PlatformFeeCollected>(v4);
        let v5 = VestingWallet<T0>{
            id           : v2,
            beneficiary  : arg3,
            cliff_time   : arg4,
            end_time     : arg5,
            total_amount : v0,
            claimed      : 0,
            balance      : 0x2::coin::into_balance<T0>(arg0),
            creator      : 0x2::tx_context::sender(arg6),
        };
        0x2::transfer::share_object<VestingWallet<T0>>(v5);
    }

    public fun admin() : address {
        @0x92a32ac7fd525f8bd37ed359423b8d7d858cad26224854dfbff1914b75ee658b
    }

    public fun beneficiary<T0>(arg0: &VestingWallet<T0>) : address {
        arg0.beneficiary
    }

    public fun claim<T0>(arg0: &mut VestingWallet<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.beneficiary, 13906834779934031877);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.cliff_time, 13906834784228737025);
        let v0 = claimable<T0>(arg0, arg1);
        assert!(v0 > 0, 13906834797113769987);
        arg0.claimed = arg0.claimed + v0;
        let v1 = TokensVested{
            wallet_id         : 0x2::object::uid_to_bytes(&arg0.id),
            beneficiary       : 0x2::tx_context::sender(arg2),
            amount_claimed    : v0,
            remaining_balance : 0x2::balance::value<T0>(&arg0.balance),
        };
        0x2::event::emit<TokensVested>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg2)
    }

    public fun claimable<T0>(arg0: &VestingWallet<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 < arg0.cliff_time) {
            return 0
        };
        let v1 = 0x2::balance::value<T0>(&arg0.balance);
        if (v1 == 0) {
            return 0
        };
        if (v0 >= arg0.end_time) {
            return v1
        };
        let v2 = (((arg0.total_amount as u128) * ((v0 - arg0.cliff_time) as u128) / ((arg0.end_time - arg0.cliff_time) as u128)) as u64);
        if (v2 <= arg0.claimed) {
            0
        } else {
            v2 - arg0.claimed
        }
    }

    public fun claimed<T0>(arg0: &VestingWallet<T0>) : u64 {
        arg0.claimed
    }

    public fun cliff_time<T0>(arg0: &VestingWallet<T0>) : u64 {
        arg0.cliff_time
    }

    public fun creator<T0>(arg0: &VestingWallet<T0>) : address {
        arg0.creator
    }

    public fun end_time<T0>(arg0: &VestingWallet<T0>) : u64 {
        arg0.end_time
    }

    public fun locked<T0>(arg0: &VestingWallet<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = vested_total<T0>(arg0, arg1);
        if (v0 >= arg0.total_amount) {
            0
        } else {
            arg0.total_amount - v0
        }
    }

    public fun platform_fee() : u64 {
        1000000000
    }

    public fun time_until_cliff<T0>(arg0: &VestingWallet<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.cliff_time) {
            0
        } else {
            arg0.cliff_time - v0
        }
    }

    public fun time_until_end<T0>(arg0: &VestingWallet<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.end_time) {
            0
        } else {
            arg0.end_time - v0
        }
    }

    public fun total_amount<T0>(arg0: &VestingWallet<T0>) : u64 {
        arg0.total_amount
    }

    public fun vested_bps<T0>(arg0: &VestingWallet<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = arg0.total_amount;
        if (v0 == 0) {
            return 0
        };
        (((vested_total<T0>(arg0, arg1) as u128) * 10000 / (v0 as u128)) as u64)
    }

    public fun vested_total<T0>(arg0: &VestingWallet<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.end_time) {
            arg0.total_amount
        } else if (v0 <= arg0.cliff_time) {
            0
        } else {
            (((arg0.total_amount as u128) * ((v0 - arg0.cliff_time) as u128) / ((arg0.end_time - arg0.cliff_time) as u128)) as u64)
        }
    }

    // decompiled from Move bytecode v7
}

