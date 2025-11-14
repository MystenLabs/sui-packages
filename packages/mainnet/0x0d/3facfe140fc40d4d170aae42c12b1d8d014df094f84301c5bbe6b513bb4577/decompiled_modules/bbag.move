module 0xd3facfe140fc40d4d170aae42c12b1d8d014df094f84301c5bbe6b513bb4577::bbag {
    struct DexSwapInfo has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        user_list: vector<address>,
    }

    public fun add_coin(arg0: &mut DexSwapInfo, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(is_user(arg0, 0x2::tx_context::sender(arg2)), 1);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg1, arg2)
    }

    public fun add_user(arg0: &mut DexSwapInfo, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_user(arg0, 0x2::tx_context::sender(arg2)), 1);
        0x1::vector::append<address>(&mut arg0.user_list, arg1);
    }

    public fun get_coin(arg0: &mut DexSwapInfo, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(is_user(arg0, 0x2::tx_context::sender(arg2)), 1);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg1, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = DexSwapInfo{
            id        : 0x2::object::new(arg0),
            balance   : 0x2::balance::zero<0x2::sui::SUI>(),
            user_list : v0,
        };
        0x2::transfer::share_object<DexSwapInfo>(v1);
    }

    public fun is_user(arg0: &DexSwapInfo, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.user_list, &arg1)
    }

    public fun stake_coin(arg0: &mut DexSwapInfo, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_user(arg0, 0x2::tx_context::sender(arg2)), 1);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    public fun transfer_or_destroy_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun transfer_or_destroy_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun unstake_coin(arg0: &mut DexSwapInfo, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(is_user(arg0, 0x2::tx_context::sender(arg1)), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

