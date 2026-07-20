module 0xe71478d0c5bcd680358eb929f9f4dd1ec12e3d42f1bdc9198040690a3b4e48e5::gas_pool {
    struct GasPool has key {
        id: 0x2::object::UID,
        gas_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        savings_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        access_list: vector<address>,
        total_allocated_coins: u64,
        total_recycled_coins: u64,
        total_allocated_amount: u64,
        total_recycled_amount: u64,
    }

    struct GasPoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        owner: address,
    }

    struct GasCoinAllocated has copy, drop {
        coin_id: 0x2::object::ID,
        amount: u64,
    }

    struct GasCoinRecycled has copy, drop {
        amount: u64,
        to_savings: u64,
    }

    fun access_check(arg0: &vector<address>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(arg0)) {
            if (0x1::vector::borrow<address>(arg0, v1) == &v0) {
                return
            };
            v1 = v1 + 1;
        };
        abort 1
    }

    public fun alloc(arg0: &mut GasPool, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        access_check(&arg0.access_list, arg4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.gas_balance) >= arg1 * arg2, 2);
        let v0 = 0;
        while (v0 < arg1) {
            let v1 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.gas_balance, arg2), arg4);
            let v2 = GasCoinAllocated{
                coin_id : 0x2::object::id<0x2::coin::Coin<0x2::sui::SUI>>(&v1),
                amount  : arg2,
            };
            0x2::event::emit<GasCoinAllocated>(v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, arg3);
            arg0.total_allocated_coins = arg0.total_allocated_coins + 1;
            arg0.total_allocated_amount = arg0.total_allocated_amount + arg2;
            v0 = v0 + 1;
        };
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        let v2 = GasPool{
            id                     : 0x2::object::new(arg0),
            gas_balance            : 0x2::balance::zero<0x2::sui::SUI>(),
            savings_balance        : 0x2::balance::zero<0x2::sui::SUI>(),
            access_list            : v1,
            total_allocated_coins  : 0,
            total_recycled_coins   : 0,
            total_allocated_amount : 0,
            total_recycled_amount  : 0,
        };
        let v3 = GasPoolCreated{
            pool_id : 0x2::object::id<GasPool>(&v2),
            owner   : v0,
        };
        0x2::event::emit<GasPoolCreated>(v3);
        0x2::transfer::share_object<GasPool>(v2);
    }

    public fun deposit_gas(arg0: &mut GasPool, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.gas_balance, arg1);
    }

    public fun deposit_gas_coin(arg0: &mut GasPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.gas_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun gas_balance_value(arg0: &GasPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.gas_balance)
    }

    public fun grant_access(arg0: &mut GasPool, arg1: address, arg2: &0x2::tx_context::TxContext) {
        access_check(&arg0.access_list, arg2);
        0x1::vector::push_back<address>(&mut arg0.access_list, arg1);
    }

    public fun recycle(arg0: &mut GasPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let v2 = 0;
        if (v0 > arg2) {
            let v3 = v0 - arg2;
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.savings_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v3));
            v2 = v3;
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.gas_balance, v1);
        arg0.total_recycled_coins = arg0.total_recycled_coins + 1;
        arg0.total_recycled_amount = arg0.total_recycled_amount + v0;
        let v4 = GasCoinRecycled{
            amount     : 0x2::balance::value<0x2::sui::SUI>(&v1),
            to_savings : v2,
        };
        0x2::event::emit<GasCoinRecycled>(v4);
    }

    public fun savings_balance_value(arg0: &GasPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.savings_balance)
    }

    public fun total_allocated_coins(arg0: &GasPool) : u64 {
        arg0.total_allocated_coins
    }

    public fun total_recycled_coins(arg0: &GasPool) : u64 {
        arg0.total_recycled_coins
    }

    public fun withdraw_savings(arg0: &mut GasPool, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        access_check(&arg0.access_list, arg3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.savings_balance) >= arg1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.savings_balance, arg1), arg3), arg2);
    }

    // decompiled from Move bytecode v7
}

