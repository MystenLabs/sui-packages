module 0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::pool {
    struct Pool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        investor_map: 0x2::vec_map::VecMap<address, u64>,
    }

    struct Bill {
        amount: u64,
    }

    struct DisburseBonusEvent has copy, drop {
        bonus: u64,
        owner: address,
    }

    public(friend) fun disburse_bonus(arg0: &mut Pool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg1 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.balance)) {
            arg1
        } else {
            0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
        };
        if (v0 == 0) {
            return
        };
        let v1 = v0 / 10;
        let v2 = v0 - v1;
        let v3 = 0x2::tx_context::sender(arg2);
        let v4 = DisburseBonusEvent{
            bonus : v2,
            owner : v3,
        };
        0x2::event::emit<DisburseBonusEvent>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v2), arg2), v3);
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        let v6 = get_total(arg0);
        if (v5 >= v6) {
            split_award_to_investors(arg0, v1, v5);
        } else {
            split_award_to_investors(arg0, v1 * 7 / 10, v6);
        };
    }

    fun get_total(arg0: &Pool) : u64 {
        let v0 = 0;
        let v1 = 0x2::vec_map::keys<address, u64>(&arg0.investor_map);
        while (0x1::vector::length<address>(&v1) > 0) {
            let v2 = 0x1::vector::pop_back<address>(&mut v1);
            v0 = v0 + *0x2::vec_map::get<address, u64>(&arg0.investor_map, &v2);
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id           : 0x2::object::new(arg0),
            balance      : 0x2::balance::zero<0x2::sui::SUI>(),
            investor_map : 0x2::vec_map::empty<address, u64>(),
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public fun invest(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x2::vec_map::contains<address, u64>(&arg0.investor_map, &v0)) {
            let v1 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.investor_map, &v0);
            *v1 = *v1 + 0x2::coin::value<0x2::sui::SUI>(&arg1);
        } else {
            0x2::vec_map::insert<address, u64>(&mut arg0.investor_map, v0, 0x2::coin::value<0x2::sui::SUI>(&arg1));
        };
    }

    public fun invest_withdraw(arg0: &mut Pool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        let v1 = get_total(arg0);
        let v2 = 0x2::tx_context::sender(arg1);
        let (v3, v4) = 0x2::vec_map::remove<address, u64>(&mut arg0.investor_map, &v2);
        let v5 = if (v0 >= v1) {
            v4
        } else {
            v0 * v4 / v1
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v5), arg1), v3);
    }

    public fun loan(arg0: &mut Pool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, Bill) {
        let v0 = Bill{amount: arg1};
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg2), v0)
    }

    public fun loan_all(arg0: &mut Pool, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, Bill) {
        let v0 = Bill{amount: 0x2::balance::value<0x2::sui::SUI>(&arg0.balance)};
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance), arg1), v0)
    }

    public(friend) fun pay_ticket(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 1000000000, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun repay(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: Bill, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let Bill { amount: v0 } = arg2;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v0 + v0 / 100, arg3)));
        arg1
    }

    fun split_award_to_investors(arg0: &mut Pool, arg1: u64, arg2: u64) {
        let v0 = 0x2::vec_map::keys<address, u64>(&arg0.investor_map);
        while (0x1::vector::length<address>(&v0) > 0) {
            let v1 = 0x1::vector::pop_back<address>(&mut v0);
            let v2 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.investor_map, &v1);
            *v2 = *v2 + arg1 * *v2 / arg2;
        };
    }

    entry fun withdraw(arg0: &0x2::package::Publisher, arg1: &mut Pool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        let v1 = get_total(arg1);
        if (v0 > v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v0 - v1), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    // decompiled from Move bytecode v6
}

