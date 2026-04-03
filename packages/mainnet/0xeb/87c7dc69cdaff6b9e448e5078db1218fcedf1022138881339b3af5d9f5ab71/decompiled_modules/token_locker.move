module 0xeb87c7dc69cdaff6b9e448e5078db1218fcedf1022138881339b3af5d9f5ab71::token_locker {
    struct TokenLock<phantom T0> has key {
        id: 0x2::object::UID,
        beneficiary: address,
        unlock_time: u64,
        balance: 0x2::balance::Balance<T0>,
        creator: address,
    }

    struct TokensLocked has copy, drop {
        lock_id: vector<u8>,
        beneficiary: address,
        creator: address,
        amount: u64,
        unlock_time: u64,
        fee_charged: u64,
    }

    struct TokensClaimed has copy, drop {
        lock_id: vector<u8>,
        beneficiary: address,
        amount: u64,
        remaining_balance: u64,
    }

    struct PlatformFeeCollected has copy, drop {
        lock_id: vector<u8>,
        fee_amount: u64,
        admin: address,
    }

    public fun balance<T0>(arg0: &TokenLock<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun admin() : address {
        @0x92a32ac7fd525f8bd37ed359423b8d7d858cad26224854dfbff1914b75ee658b
    }

    public fun beneficiary<T0>(arg0: &TokenLock<T0>) : address {
        arg0.beneficiary
    }

    public fun claim<T0>(arg0: &mut TokenLock<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.beneficiary, 13906834758459195397);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.unlock_time, 13906834762753900545);
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        assert!(v0 > 0, 13906834775638933507);
        let v1 = TokensClaimed{
            lock_id           : 0x2::object::uid_to_bytes(&arg0.id),
            beneficiary       : 0x2::tx_context::sender(arg2),
            amount            : v0,
            remaining_balance : 0x2::balance::value<T0>(&arg0.balance) - v0,
        };
        0x2::event::emit<TokensClaimed>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg2)
    }

    public fun claimable<T0>(arg0: &TokenLock<T0>, arg1: &0x2::clock::Clock) : u64 {
        if (0x2::clock::timestamp_ms(arg1) < arg0.unlock_time) {
            0
        } else {
            0x2::balance::value<T0>(&arg0.balance)
        }
    }

    public fun creator<T0>(arg0: &TokenLock<T0>) : address {
        arg0.creator
    }

    public fun is_expired<T0>(arg0: &TokenLock<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.unlock_time
    }

    public fun lock<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg0));
        assert!(v0 > 0, 13906834530826321931);
        assert!(arg4 > 0x2::clock::timestamp_ms(arg2), 13906834539415994375);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v1) >= 1000000000, 13906834552301027337);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1, 1000000000), arg5), @0x92a32ac7fd525f8bd37ed359423b8d7d858cad26224854dfbff1914b75ee658b);
        if (0x2::balance::value<0x2::sui::SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        };
        let v2 = 0x2::object::new(arg5);
        let v3 = TokensLocked{
            lock_id     : 0x2::object::uid_to_bytes(&v2),
            beneficiary : arg3,
            creator     : 0x2::tx_context::sender(arg5),
            amount      : v0,
            unlock_time : arg4,
            fee_charged : 1000000000,
        };
        0x2::event::emit<TokensLocked>(v3);
        let v4 = PlatformFeeCollected{
            lock_id    : 0x2::object::uid_to_bytes(&v2),
            fee_amount : 1000000000,
            admin      : @0x92a32ac7fd525f8bd37ed359423b8d7d858cad26224854dfbff1914b75ee658b,
        };
        0x2::event::emit<PlatformFeeCollected>(v4);
        let v5 = TokenLock<T0>{
            id          : v2,
            beneficiary : arg3,
            unlock_time : arg4,
            balance     : 0x2::coin::into_balance<T0>(arg0),
            creator     : 0x2::tx_context::sender(arg5),
        };
        0x2::transfer::share_object<TokenLock<T0>>(v5);
    }

    public fun platform_fee() : u64 {
        1000000000
    }

    public fun unlock_time<T0>(arg0: &TokenLock<T0>) : u64 {
        arg0.unlock_time
    }

    // decompiled from Move bytecode v7
}

