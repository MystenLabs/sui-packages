module 0x8218061610f51c80f506f1c9560c8ad7010e558f9c5e7ee9051b3612625d2a19::no {
    struct NO has drop {
        dummy_field: bool,
    }

    struct SpamData has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        owner: address,
    }

    public fun balance(arg0: &SpamData) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun deposit(arg0: &mut SpamData, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun get_coin<T0, T1>(arg0: &mut SpamData, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<T0, T1>(arg1);
        if (arg2) {
            assert!(0x2::balance::value<T0>(v0) >= arg3, 0);
        } else {
            assert!(0x2::balance::value<T1>(v1) >= arg3, 0);
        };
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg4, 0);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg4, arg5)
    }

    fun init(arg0: NO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SpamData{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            owner   : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<SpamData>(v0);
    }

    public fun withdraw_all_balance(arg0: &mut SpamData, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v0 >= 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun withdraw_amount(arg0: &mut SpamData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg1, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

