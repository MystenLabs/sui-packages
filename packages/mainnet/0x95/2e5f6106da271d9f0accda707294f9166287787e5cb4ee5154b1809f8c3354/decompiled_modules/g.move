module 0x952e5f6106da271d9f0accda707294f9166287787e5cb4ee5154b1809f8c3354::g {
    struct G has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        savings_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        access_list: vector<address>,
        gas_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_allocated_coins: u64,
        total_recycled_coins: u64,
        total_allocated_amount: u64,
        total_recycled_amount: u64,
    }

    struct AllocEvent has copy, drop {
        coin_id: 0x2::object::ID,
        amount: u64,
    }

    struct RecycleEvent has copy, drop {
        coin_id: 0x2::object::ID,
        amount: u64,
    }

    fun access_check(arg0: &vector<address>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(arg0, &v0), 1);
    }

    public fun admin(arg0: &G) : address {
        arg0.admin
    }

    fun admin_check(arg0: &G, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 2);
    }

    public fun alloc(arg0: &mut G, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        access_check(&arg0.access_list, arg4);
        version_check(arg0);
        let v0 = (arg1 as u128) * (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 4);
        let v1 = (v0 as u64);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.gas_balance) >= v1, 3);
        let v2 = 0;
        while (v2 < arg1) {
            let v3 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.gas_balance, arg2), arg4);
            let v4 = AllocEvent{
                coin_id : 0x2::object::id<0x2::coin::Coin<0x2::sui::SUI>>(&v3),
                amount  : arg2,
            };
            0x2::event::emit<AllocEvent>(v4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, arg3);
            v2 = v2 + 1;
        };
        arg0.total_allocated_coins = arg0.total_allocated_coins + arg1;
        arg0.total_allocated_amount = arg0.total_allocated_amount + v1;
    }

    public fun deposit_gas(arg0: &mut G, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        version_check(arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.gas_balance, arg1);
    }

    public fun deposit_gas_coin(arg0: &mut G, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        version_check(arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.gas_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun deposit_savings(arg0: &mut G, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        version_check(arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.savings_balance, arg1);
    }

    public fun g_new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = G{
            id                     : 0x2::object::new(arg0),
            version                : 1,
            admin                  : 0x2::tx_context::sender(arg0),
            savings_balance        : 0x2::balance::zero<0x2::sui::SUI>(),
            access_list            : v0,
            gas_balance            : 0x2::balance::zero<0x2::sui::SUI>(),
            total_allocated_coins  : 0,
            total_recycled_coins   : 0,
            total_allocated_amount : 0,
            total_recycled_amount  : 0,
        };
        0x2::transfer::share_object<G>(v1);
    }

    public fun gas_balance(arg0: &G) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.gas_balance)
    }

    public fun grant_access(arg0: &mut G, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        admin_check(arg0, arg2);
        0x1::vector::push_back<address>(&mut arg0.access_list, arg1);
    }

    public fun has_sufficient_gas(arg0: &G, arg1: u64, arg2: u64) : bool {
        let v0 = (arg1 as u128) * (arg2 as u128);
        if (v0 > 18446744073709551615) {
            return false
        };
        0x2::balance::value<0x2::sui::SUI>(&arg0.gas_balance) >= (v0 as u64)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        g_new(arg0);
    }

    public fun is_access_listed(arg0: &G, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.access_list, &arg1)
    }

    public fun migrate(arg0: &mut G, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 2);
        assert!(arg0.version < 1, 5);
        arg0.version = 1;
    }

    public fun net_gas_cost(arg0: &G) : u64 {
        if (arg0.total_allocated_amount > arg0.total_recycled_amount) {
            arg0.total_allocated_amount - arg0.total_recycled_amount
        } else {
            0
        }
    }

    public fun recycle(arg0: &mut G, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64) {
        version_check(arg0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let v2 = if (arg2 > v0) {
            v0
        } else {
            arg2
        };
        let v3 = v0 - v2;
        if (v3 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.savings_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v3));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.gas_balance, v1);
        let v4 = RecycleEvent{
            coin_id : 0x2::object::id<0x2::coin::Coin<0x2::sui::SUI>>(&arg1),
            amount  : v0,
        };
        0x2::event::emit<RecycleEvent>(v4);
        arg0.total_recycled_coins = arg0.total_recycled_coins + 1;
        arg0.total_recycled_amount = arg0.total_recycled_amount + v0;
    }

    public fun replenish_admin_gas(arg0: &mut G, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        admin_check(arg0, arg3);
        version_check(arg0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg1);
        if (v0 < arg2) {
            let v1 = arg2 - v0;
            let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.gas_balance);
            let v3 = if (v1 > v2) {
                v2
            } else {
                v1
            };
            if (v3 > 0) {
                0x2::balance::join<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), 0x2::balance::split<0x2::sui::SUI>(&mut arg0.gas_balance, v3));
            };
        } else if (v0 > arg2) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.gas_balance, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), v0 - arg2));
        };
    }

    public fun revoke_access(arg0: &mut G, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        admin_check(arg0, arg2);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.access_list, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.access_list, v1);
        };
    }

    public fun savings_balance(arg0: &G) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.savings_balance)
    }

    public fun total_allocated_amount(arg0: &G) : u64 {
        arg0.total_allocated_amount
    }

    public fun total_allocated_coins(arg0: &G) : u64 {
        arg0.total_allocated_coins
    }

    public fun total_recycled_amount(arg0: &G) : u64 {
        arg0.total_recycled_amount
    }

    public fun total_recycled_coins(arg0: &G) : u64 {
        arg0.total_recycled_coins
    }

    public fun transfer_admin(arg0: &mut G, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        admin_check(arg0, arg2);
        arg0.admin = arg1;
    }

    public fun version(arg0: &G) : u64 {
        arg0.version
    }

    fun version_check(arg0: &G) {
        assert!(arg0.version == 1, 5);
    }

    public fun withdraw_all(arg0: &mut G, arg1: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<0x2::sui::SUI>) {
        version_check(arg0);
        admin_check(arg0, arg1);
        (0x2::balance::split<0x2::sui::SUI>(&mut arg0.gas_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.gas_balance)), 0x2::balance::split<0x2::sui::SUI>(&mut arg0.savings_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.savings_balance)))
    }

    public fun withdraw_all_savings_to_sender(arg0: &mut G, arg1: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        admin_check(arg0, arg1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.savings_balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.savings_balance, v0), arg1), 0x2::tx_context::sender(arg1));
        };
    }

    public fun withdraw_gas(arg0: &mut G, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        version_check(arg0);
        admin_check(arg0, arg2);
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.gas_balance, arg1)
    }

    public fun withdraw_gas_to_sender(arg0: &mut G, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        admin_check(arg0, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.gas_balance, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun withdraw_savings(arg0: &mut G, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        version_check(arg0);
        admin_check(arg0, arg2);
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.savings_balance, arg1)
    }

    public fun withdraw_savings_to_sender(arg0: &mut G, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        admin_check(arg0, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.savings_balance, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

