module 0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::fee_splitter {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeSplitter has key {
        id: 0x2::object::UID,
        payees: 0x2::vec_set::VecSet<address>,
        weights: 0x2::vec_map::VecMap<address, u64>,
        accumulated: 0x2::balance::Balance<0x2::sui::SUI>,
        total_distributed: u64,
    }

    struct FeesDeposited has copy, drop {
        amount: u64,
    }

    struct FeesDistributed has copy, drop {
        payee: address,
        amount: u64,
    }

    struct PayeeAdded has copy, drop {
        payee: address,
        weight: u64,
    }

    struct PayeeRemoved has copy, drop {
        payee: address,
    }

    struct WeightsUpdated has copy, drop {
        payees_len: u64,
    }

    public fun accumulated(arg0: &FeeSplitter) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.accumulated)
    }

    public(friend) entry fun add_payee(arg0: &AdminCap, arg1: &mut FeeSplitter, arg2: address, arg3: u64) {
        assert!(arg2 != @0x0, 1);
        assert!(arg3 > 0, 7);
        assert!(!0x2::vec_set::contains<address>(&arg1.payees, &arg2), 3);
        assert!(weights_sum_map(&arg1.weights) + arg3 <= 10000, 2);
        0x2::vec_set::insert<address>(&mut arg1.payees, arg2);
        0x2::vec_map::insert<address, u64>(&mut arg1.weights, arg2, arg3);
        let v0 = PayeeAdded{
            payee  : arg2,
            weight : arg3,
        };
        0x2::event::emit<PayeeAdded>(v0);
    }

    public fun deposit(arg0: &mut FeeSplitter, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.accumulated, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = FeesDeposited{amount: v0};
        0x2::event::emit<FeesDeposited>(v1);
    }

    public(friend) entry fun distribute(arg0: &AdminCap, arg1: &mut FeeSplitter, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.accumulated);
        if (v0 == 0) {
            return
        };
        let v1 = 0x2::vec_set::keys<address>(&arg1.payees);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(v1)) {
            let v3 = *0x1::vector::borrow<address>(v1, v2);
            let v4 = v0 * *0x2::vec_map::get<address, u64>(&arg1.weights, &v3) / 10000;
            assert!(v4 > 0, 5);
            let v5 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.accumulated, v4), arg2);
            let v6 = 0x2::coin::value<0x2::sui::SUI>(&v5);
            arg1.total_distributed = arg1.total_distributed + v6;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v5, v3);
            let v7 = FeesDistributed{
                payee  : v3,
                amount : v6,
            };
            0x2::event::emit<FeesDistributed>(v7);
            v2 = v2 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeSplitter{
            id                : 0x2::object::new(arg0),
            payees            : 0x2::vec_set::empty<address>(),
            weights           : 0x2::vec_map::empty<address, u64>(),
            accumulated       : 0x2::balance::zero<0x2::sui::SUI>(),
            total_distributed : 0,
        };
        0x2::transfer::share_object<FeeSplitter>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_payee(arg0: &FeeSplitter, arg1: &address) : bool {
        0x2::vec_set::contains<address>(&arg0.payees, arg1)
    }

    public fun payees_len(arg0: &FeeSplitter) : u64 {
        0x2::vec_set::length<address>(&arg0.payees)
    }

    public(friend) entry fun remove_payee(arg0: &AdminCap, arg1: &mut FeeSplitter, arg2: address) {
        assert!(0x2::vec_set::contains<address>(&arg1.payees, &arg2), 4);
        0x2::vec_set::remove<address>(&mut arg1.payees, &arg2);
        let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg1.weights, &arg2);
        let v2 = PayeeRemoved{payee: arg2};
        0x2::event::emit<PayeeRemoved>(v2);
    }

    public(friend) entry fun set_weights(arg0: &AdminCap, arg1: &mut FeeSplitter, arg2: vector<address>, arg3: vector<u64>) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 > 0, 6);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 13906834951732461567);
        let v1 = 0x2::vec_map::empty<address, u64>();
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<address>(&arg2, v3);
            let v5 = *0x1::vector::borrow<u64>(&arg3, v3);
            assert!(v5 > 0, 7);
            assert!(0x2::vec_set::contains<address>(&arg1.payees, &v4), 4);
            0x2::vec_map::insert<address, u64>(&mut v1, v4, v5);
            v2 = v2 + v5;
            v3 = v3 + 1;
        };
        assert!(v2 == 10000, 2);
        arg1.weights = v1;
        let v6 = WeightsUpdated{payees_len: v0};
        0x2::event::emit<WeightsUpdated>(v6);
    }

    public fun total_distributed(arg0: &FeeSplitter) : u64 {
        arg0.total_distributed
    }

    public fun weight(arg0: &FeeSplitter, arg1: &address) : u64 {
        assert!(0x2::vec_set::contains<address>(&arg0.payees, arg1), 4);
        *0x2::vec_map::get<address, u64>(&arg0.weights, arg1)
    }

    public fun weights_sum(arg0: &FeeSplitter) : u64 {
        weights_sum_map(&arg0.weights)
    }

    fun weights_sum_map(arg0: &0x2::vec_map::VecMap<address, u64>) : u64 {
        let v0 = 0x2::vec_map::keys<address, u64>(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v0)) {
            v1 = v1 + *0x2::vec_map::get<address, u64>(arg0, 0x1::vector::borrow<address>(&v0, v2));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v7
}

