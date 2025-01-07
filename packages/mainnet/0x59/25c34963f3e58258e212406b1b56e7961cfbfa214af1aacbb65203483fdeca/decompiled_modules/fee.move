module 0x5925c34963f3e58258e212406b1b56e7961cfbfa214af1aacbb65203483fdeca::fee {
    struct FeeManagerWitness has key {
        id: 0x2::object::UID,
    }

    struct FeeManager has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        reset_counter: vector<address>,
        withdraw_counter: vector<address>,
        cold: 0x2::vec_map::VecMap<address, bool>,
    }

    struct FeeManagerCreated has copy, drop, store {
        manager_address: address,
    }

    struct Fee has copy, drop, store {
        amount: u64,
    }

    struct FeeAddressReset has copy, drop, store {
        old_wallet: address,
        new_wallet: address,
    }

    struct Withdrawal has copy, drop, store {
        recipients: vector<address>,
        amount: u64,
    }

    public entry fun add_fee(arg0: &mut FeeManager, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = Fee{amount: 0x2::coin::value<0x2::sui::SUI>(&arg1)};
        0x2::event::emit<Fee>(v0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = FeeManager{
            id               : 0x2::object::new(arg0),
            balance          : 0x2::balance::zero<0x2::sui::SUI>(),
            reset_counter    : v0,
            withdraw_counter : v0,
            cold             : 0x2::vec_map::empty<address, bool>(),
        };
        let v2 = FeeManagerCreated{manager_address: 0x2::object::id_address<FeeManager>(&v1)};
        0x2::event::emit<FeeManagerCreated>(v2);
        0x2::transfer::public_share_object<FeeManager>(v1);
        let v3 = FeeManagerWitness{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<FeeManagerWitness>(v3, 0x2::tx_context::sender(arg0));
    }

    public entry fun initialize_fee_manager(arg0: FeeManagerWitness, arg1: &mut FeeManager, arg2: vector<address>) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 > 2, 0);
        let v1 = 0x2::vec_map::empty<address, bool>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<address>(&arg2, v2);
            assert!(v3 != @0x0, 1);
            0x2::vec_map::insert<address, bool>(&mut v1, v3, true);
            v2 = v2 + 1;
        };
        arg1.cold = v1;
        let FeeManagerWitness { id: v4 } = arg0;
        0x2::object::delete(v4);
    }

    public entry fun reset(arg0: &mut FeeManager, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = arg0.cold;
        assert!(0x2::vec_map::contains<address, bool>(&v1, &v0), 3);
        assert!(0x2::vec_map::contains<address, bool>(&v1, &arg1), 4);
        assert!(arg2 != @0x0, 1);
        assert!(!0x2::vec_map::contains<address, bool>(&v1, &arg2), 5);
        assert!(!0x1::vector::contains<address>(&arg0.reset_counter, &v0), 6);
        0x1::vector::push_back<address>(&mut arg0.reset_counter, v0);
        if (0x1::vector::length<address>(&arg0.reset_counter) > 0x2::vec_map::size<address, bool>(&v1) / 2) {
            arg0.reset_counter = 0x1::vector::empty<address>();
            let (_, _) = 0x2::vec_map::remove<address, bool>(&mut arg0.cold, &arg1);
            0x2::vec_map::insert<address, bool>(&mut arg0.cold, arg2, true);
            let v4 = FeeAddressReset{
                old_wallet : arg1,
                new_wallet : arg2,
            };
            0x2::event::emit<FeeAddressReset>(v4);
        };
    }

    fun split_and_pay(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1) - 1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, 0x2::coin::value<0x2::sui::SUI>(&v0) / 0x1::vector::length<address>(&arg1), arg2), *0x1::vector::borrow<address>(&arg1, v1));
            v1 = v1 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, *0x1::vector::borrow<address>(&arg1, 0x1::vector::length<address>(&arg1) - 1));
    }

    public entry fun withdraw(arg0: &mut FeeManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::vec_map::contains<address, bool>(&arg0.cold, &v0);
        assert!(v1, 3);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v2 >= arg1, 2);
        let v3 = 0x1::vector::contains<address>(&arg0.withdraw_counter, &v0);
        assert!(!v3, 6);
        0x1::vector::push_back<address>(&mut arg0.withdraw_counter, v0);
        let v4 = 0x1::vector::length<address>(&arg0.withdraw_counter);
        let v5 = 0x2::vec_map::size<address, bool>(&arg0.cold);
        if (v4 == v5) {
            let (v6, _) = 0x2::vec_map::into_keys_values<address, bool>(arg0.cold);
            split_and_pay(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), v6, arg2);
            arg0.withdraw_counter = 0x1::vector::empty<address>();
            let v8 = Withdrawal{
                recipients : v6,
                amount     : arg1,
            };
            0x2::event::emit<Withdrawal>(v8);
        };
    }

    // decompiled from Move bytecode v6
}

