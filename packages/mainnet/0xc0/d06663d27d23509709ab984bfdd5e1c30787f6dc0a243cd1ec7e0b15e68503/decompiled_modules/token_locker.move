module 0xc0d06663d27d23509709ab984bfdd5e1c30787f6dc0a243cd1ec7e0b15e68503::token_locker {
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
        assert!(0x2::tx_context::sender(arg2) == arg0.beneficiary, 13906834741279326213);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.unlock_time, 13906834745574031361);
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        assert!(v0 > 0, 13906834758459064323);
        let v1 = TokensClaimed{
            lock_id     : 0x2::object::uid_to_bytes(&arg0.id),
            beneficiary : 0x2::tx_context::sender(arg2),
            amount      : v0,
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
        assert!(arg4 > 0x2::clock::timestamp_ms(arg2), 13906834522236125191);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v0) >= 1000000000, 13906834535121158153);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v0, 1000000000), arg5), @0x92a32ac7fd525f8bd37ed359423b8d7d858cad26224854dfbff1914b75ee658b);
        if (0x2::balance::value<0x2::sui::SUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
        };
        let v1 = 0x2::object::new(arg5);
        let v2 = TokensLocked{
            lock_id     : 0x2::object::uid_to_bytes(&v1),
            beneficiary : arg3,
            creator     : 0x2::tx_context::sender(arg5),
            amount      : 0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg0)),
            unlock_time : arg4,
            fee_charged : 1000000000,
        };
        0x2::event::emit<TokensLocked>(v2);
        let v3 = PlatformFeeCollected{
            lock_id    : 0x2::object::uid_to_bytes(&v1),
            fee_amount : 1000000000,
            admin      : @0x92a32ac7fd525f8bd37ed359423b8d7d858cad26224854dfbff1914b75ee658b,
        };
        0x2::event::emit<PlatformFeeCollected>(v3);
        let v4 = TokenLock<T0>{
            id          : v1,
            beneficiary : arg3,
            unlock_time : arg4,
            balance     : 0x2::coin::into_balance<T0>(arg0),
            creator     : 0x2::tx_context::sender(arg5),
        };
        0x2::transfer::share_object<TokenLock<T0>>(v4);
    }

    public fun platform_fee() : u64 {
        1000000000
    }

    public fun unlock_time<T0>(arg0: &TokenLock<T0>) : u64 {
        arg0.unlock_time
    }

    // decompiled from Move bytecode v7
}

