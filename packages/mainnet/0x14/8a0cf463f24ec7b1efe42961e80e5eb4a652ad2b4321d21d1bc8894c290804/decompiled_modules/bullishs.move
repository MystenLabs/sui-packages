module 0x148a0cf463f24ec7b1efe42961e80e5eb4a652ad2b4321d21d1bc8894c290804::bullishs {
    struct CoinPool<phantom T0> has key {
        id: 0x2::object::UID,
        amount: 0x2::balance::Balance<T0>,
    }

    struct Config has key {
        id: 0x2::object::UID,
        managers: vector<address>,
        creator: address,
    }

    struct BullishsEvent has copy, drop {
        recipient: address,
        amount: u64,
    }

    public fun add_manager(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        0x1::vector::push_back<address>(&mut arg0.managers, arg1);
    }

    public fun create_pool<T0>(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = arg0.managers;
        assert!(0x1::vector::contains<address>(&v1, &v0), 1);
        let v2 = CoinPool<T0>{
            id     : 0x2::object::new(arg1),
            amount : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<CoinPool<T0>>(v2);
    }

    public fun deposit_coin<T0>(arg0: &mut Config, arg1: &mut CoinPool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.managers, &v0), 0);
        0x2::balance::join<T0>(&mut arg1.amount, 0x2::coin::into_balance<T0>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        let v2 = Config{
            id       : 0x2::object::new(arg0),
            managers : v1,
            creator  : v0,
        };
        0x2::transfer::share_object<Config>(v2);
    }

    public fun remove_manager(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.managers, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.managers, v1);
        };
    }

    public fun transfer_coin<T0>(arg0: &mut Config, arg1: &mut CoinPool<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x1::vector::contains<address>(&arg0.managers, &v0), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.amount, arg2), arg4), arg3);
        let v1 = BullishsEvent{
            recipient : arg3,
            amount    : arg2,
        };
        0x2::event::emit<BullishsEvent>(v1);
    }

    public fun withdraw_coin<T0>(arg0: &mut Config, arg1: &mut CoinPool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.managers, &v0), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.amount, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

