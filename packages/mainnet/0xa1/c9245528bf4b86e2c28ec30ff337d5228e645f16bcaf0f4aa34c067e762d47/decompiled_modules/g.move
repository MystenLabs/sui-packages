module 0x43b5e21082650611fcb9c85adfebe9ad03504c4f73cd922cab057e0e5d4d662c::g {
    struct G has key {
        id: 0x2::object::UID,
        savings_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        access_list: vector<address>,
        gas_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_allocated_coins: u64,
        total_recycled_coins: u64,
        total_allocated_amount: u64,
        total_recycled_amount: u64,
    }

    struct E has copy, drop {
        coin_id: 0x2::object::ID,
        amount: u64,
    }

    fun access_check(arg0: &vector<address>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(arg0, &v0), 2);
    }

    public fun alloc(arg0: &mut G, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        access_check(&arg0.access_list, arg4);
        let v0 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.gas_balance, arg1 * arg2);
        while (0x2::balance::value<0x2::sui::SUI>(&v0) > 0) {
            let v1 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v0, arg2), arg4);
            let v2 = E{
                coin_id : 0x2::object::id<0x2::coin::Coin<0x2::sui::SUI>>(&v1),
                amount  : arg2,
            };
            0x2::event::emit<E>(v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, arg3);
            arg0.total_allocated_coins = arg0.total_allocated_coins + 1;
            arg0.total_allocated_amount = arg0.total_allocated_amount + arg2;
        };
        0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
    }

    public fun deposit_gas(arg0: &mut G, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.gas_balance, arg1);
    }

    public fun deposit_gas_coin(arg0: &mut G, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.gas_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun deposit_savings(arg0: &mut G, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.savings_balance, arg1);
    }

    public fun g_new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = G{
            id                     : 0x2::object::new(arg0),
            savings_balance        : 0x2::balance::zero<0x2::sui::SUI>(),
            access_list            : 0x1::vector::singleton<address>(@0x30e0784ba08efa30b34f32638aea14b00b2e52136729c1780d7aea65d001f738),
            gas_balance            : 0x2::balance::zero<0x2::sui::SUI>(),
            total_allocated_coins  : 0,
            total_recycled_coins   : 0,
            total_allocated_amount : 0,
            total_recycled_amount  : 0,
        };
        0x2::transfer::share_object<G>(v0);
    }

    public fun grant_access(arg0: &mut G, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x30e0784ba08efa30b34f32638aea14b00b2e52136729c1780d7aea65d001f738, 1);
        0x1::vector::push_back<address>(&mut arg0.access_list, arg1);
    }

    public fun recycle(arg0: &mut G, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let v2 = v0;
        if (v0 > arg2) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.savings_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v0 - arg2));
            v2 = arg2;
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.gas_balance, v1);
        arg0.total_recycled_coins = arg0.total_recycled_coins + 1;
        arg0.total_recycled_amount = arg0.total_recycled_amount + v2;
    }

    public fun replenish_admin_gas(arg0: &mut G, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        access_check(&arg0.access_list, arg3);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg1);
        if (v0 >= arg2) {
            return
        };
        0x2::coin::join<0x2::sui::SUI>(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.gas_balance, arg2 - v0), arg3));
    }

    public fun withdraw_all(arg0: &mut G, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        access_check(&arg0.access_list, arg1);
        let v0 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.gas_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.gas_balance));
        0x2::balance::join<0x2::sui::SUI>(&mut v0, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.savings_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.savings_balance)));
        v0
    }

    public fun withdraw_all_savings_to_sender(arg0: &mut G, arg1: &mut 0x2::tx_context::TxContext) {
        access_check(&arg0.access_list, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.savings_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.savings_balance)), arg1), 0x2::tx_context::sender(arg1));
    }

    public fun withdraw_gas(arg0: &mut G, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        access_check(&arg0.access_list, arg2);
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.gas_balance, arg1)
    }

    public fun withdraw_savings(arg0: &mut G, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        access_check(&arg0.access_list, arg2);
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.savings_balance, arg1)
    }

    // decompiled from Move bytecode v6
}

