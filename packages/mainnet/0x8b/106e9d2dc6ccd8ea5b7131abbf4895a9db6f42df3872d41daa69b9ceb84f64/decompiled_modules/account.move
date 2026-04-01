module 0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account {
    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct ArvaAccount has store, key {
        id: 0x2::object::UID,
        sequence_number: u64,
    }

    struct AccountCreated has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
    }

    struct Deposited has copy, drop {
        account_id: 0x2::object::ID,
        amount: u64,
    }

    struct Withdrawn has copy, drop {
        account_id: 0x2::object::ID,
        amount: u64,
    }

    public fun balance<T0>(arg0: &ArvaAccount) : u64 {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<BalanceKey<T0>>(&arg0.id, v0)) {
            let v2 = BalanceKey<T0>{dummy_field: false};
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v2))
        } else {
            0
        }
    }

    public fun account_id(arg0: &ArvaAccount) : 0x2::object::ID {
        0x2::object::id<ArvaAccount>(arg0)
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : ArvaAccount {
        let v0 = ArvaAccount{
            id              : 0x2::object::new(arg0),
            sequence_number : 0,
        };
        let v1 = AccountCreated{
            account_id : 0x2::object::id<ArvaAccount>(&v0),
            owner      : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<AccountCreated>(v1);
        v0
    }

    entry fun create_account(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = create(arg0);
        0x2::transfer::transfer<ArvaAccount>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun credit<T0>(arg0: &mut ArvaAccount, arg1: 0x2::balance::Balance<T0>) {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<BalanceKey<T0>>(&arg0.id, v0)) {
            let v1 = BalanceKey<T0>{dummy_field: false};
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1), arg1);
        } else {
            let v2 = BalanceKey<T0>{dummy_field: false};
            0x2::dynamic_field::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v2, arg1);
        };
    }

    public(friend) fun debit<T0>(arg0: &mut ArvaAccount, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = BalanceKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<BalanceKey<T0>>(&arg0.id, v0), 0);
        let v1 = BalanceKey<T0>{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1);
        assert!(0x2::balance::value<T0>(v2) >= arg1, 0);
        0x2::balance::split<T0>(v2, arg1)
    }

    public fun deposit<T0>(arg0: &mut ArvaAccount, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = BalanceKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<BalanceKey<T0>>(&arg0.id, v1)) {
            let v2 = BalanceKey<T0>{dummy_field: false};
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v2), 0x2::coin::into_balance<T0>(arg1));
        } else {
            let v3 = BalanceKey<T0>{dummy_field: false};
            0x2::dynamic_field::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v3, 0x2::coin::into_balance<T0>(arg1));
        };
        let v4 = Deposited{
            account_id : 0x2::object::id<ArvaAccount>(arg0),
            amount     : v0,
        };
        0x2::event::emit<Deposited>(v4);
    }

    public(friend) fun id_mut(arg0: &mut ArvaAccount) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun id_ref(arg0: &ArvaAccount) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun increment_sequence(arg0: &mut ArvaAccount) {
        arg0.sequence_number = arg0.sequence_number + 1;
    }

    public fun sequence_number(arg0: &ArvaAccount) : u64 {
        arg0.sequence_number
    }

    public fun withdraw<T0>(arg0: &mut ArvaAccount, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 1);
        let v0 = BalanceKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<BalanceKey<T0>>(&arg0.id, v0), 0);
        let v1 = BalanceKey<T0>{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1);
        assert!(0x2::balance::value<T0>(v2) >= arg1, 0);
        let v3 = 0x2::balance::split<T0>(v2, arg1);
        let v4 = Withdrawn{
            account_id : 0x2::object::id<ArvaAccount>(arg0),
            amount     : arg1,
        };
        0x2::event::emit<Withdrawn>(v4);
        0x2::coin::from_balance<T0>(v3, arg2)
    }

    // decompiled from Move bytecode v6
}

