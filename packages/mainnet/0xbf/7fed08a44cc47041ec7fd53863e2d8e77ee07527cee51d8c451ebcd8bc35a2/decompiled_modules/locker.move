module 0xbf7fed08a44cc47041ec7fd53863e2d8e77ee07527cee51d8c451ebcd8bc35a2::locker {
    struct LiquidityLocker<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        unlock_time: u64,
        owner: address,
    }

    struct LockerAdmin has key {
        id: 0x2::object::UID,
        fee_percentage: u64,
    }

    struct LockerCreated<phantom T0> has copy, drop {
        owner: address,
        amount: u64,
        unlock_time: u64,
    }

    struct TokensUnlocked<phantom T0> has copy, drop {
        owner: address,
        amount: u64,
    }

    struct LockExtended<phantom T0> has copy, drop {
        owner: address,
        new_unlock_time: u64,
    }

    public fun create_locker<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &LockerAdmin, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 3);
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = v0 * arg3.fee_percentage / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, v1, arg4), @0xb67b6d0010113f3c107be7ef4ba9e5329a59f5c85f80077da0d5debf25051536);
        let v2 = 0x2::clock::timestamp_ms(arg2) + arg1;
        let v3 = 0x2::tx_context::sender(arg4);
        let v4 = LiquidityLocker<T0>{
            id          : 0x2::object::new(arg4),
            balance     : 0x2::coin::into_balance<T0>(arg0),
            unlock_time : v2,
            owner       : v3,
        };
        let v5 = LockerCreated<T0>{
            owner       : v3,
            amount      : v0 - v1,
            unlock_time : v2,
        };
        0x2::event::emit<LockerCreated<T0>>(v5);
        0x2::transfer::transfer<LiquidityLocker<T0>>(v4, v3);
    }

    public fun extend_lock<T0>(arg0: &mut LiquidityLocker<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(arg1 > 0, 3);
        arg0.unlock_time = arg0.unlock_time + arg1;
        let v0 = LockExtended<T0>{
            owner           : arg0.owner,
            new_unlock_time : arg0.unlock_time,
        };
        0x2::event::emit<LockExtended<T0>>(v0);
    }

    public fun get_balance<T0>(arg0: &LiquidityLocker<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_fee_percentage(arg0: &LockerAdmin) : u64 {
        arg0.fee_percentage
    }

    public fun get_unlock_time<T0>(arg0: &LiquidityLocker<T0>) : u64 {
        arg0.unlock_time
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LockerAdmin{
            id             : 0x2::object::new(arg0),
            fee_percentage : 35,
        };
        0x2::transfer::share_object<LockerAdmin>(v0);
    }

    public fun unlock<T0>(arg0: &mut LiquidityLocker<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.unlock_time, 1);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 2);
        let v0 = TokensUnlocked<T0>{
            owner  : arg0.owner,
            amount : arg1,
        };
        0x2::event::emit<TokensUnlocked<T0>>(v0);
        0x2::coin::take<T0>(&mut arg0.balance, arg1, arg3)
    }

    // decompiled from Move bytecode v6
}

