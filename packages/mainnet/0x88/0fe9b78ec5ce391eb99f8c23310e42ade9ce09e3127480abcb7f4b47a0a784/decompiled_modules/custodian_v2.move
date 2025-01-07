module 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::custodian_v2 {
    struct Account<phantom T0> has store {
        available_balance: 0x2::balance::Balance<T0>,
        locked_balance: 0x2::balance::Balance<T0>,
    }

    struct AccountCap has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct Custodian<phantom T0> has store, key {
        id: 0x2::object::UID,
        account_balances: 0x2::table::Table<address, Account<T0>>,
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) : Custodian<T0> {
        Custodian<T0>{
            id               : 0x2::object::new(arg0),
            account_balances : 0x2::table::new<address, Account<T0>>(arg0),
        }
    }

    public(friend) fun account_available_balance<T0>(arg0: &Custodian<T0>, arg1: address) : u64 {
        0x2::balance::value<T0>(&0x2::table::borrow<address, Account<T0>>(&arg0.account_balances, arg1).available_balance)
    }

    public(friend) fun account_balance<T0>(arg0: &Custodian<T0>, arg1: address) : (u64, u64) {
        if (!0x2::table::contains<address, Account<T0>>(&arg0.account_balances, arg1)) {
            return (0, 0)
        };
        let v0 = 0x2::table::borrow<address, Account<T0>>(&arg0.account_balances, arg1);
        (0x2::balance::value<T0>(&v0.available_balance), 0x2::balance::value<T0>(&v0.locked_balance))
    }

    public(friend) fun account_locked_balance<T0>(arg0: &Custodian<T0>, arg1: address) : u64 {
        0x2::balance::value<T0>(&0x2::table::borrow<address, Account<T0>>(&arg0.account_balances, arg1).locked_balance)
    }

    public fun account_owner(arg0: &AccountCap) : address {
        arg0.owner
    }

    fun borrow_mut_account_balance<T0>(arg0: &mut Custodian<T0>, arg1: address) : &mut Account<T0> {
        if (!0x2::table::contains<address, Account<T0>>(&arg0.account_balances, arg1)) {
            let v0 = Account<T0>{
                available_balance : 0x2::balance::zero<T0>(),
                locked_balance    : 0x2::balance::zero<T0>(),
            };
            0x2::table::add<address, Account<T0>>(&mut arg0.account_balances, arg1, v0);
        };
        0x2::table::borrow_mut<address, Account<T0>>(&mut arg0.account_balances, arg1)
    }

    public fun create_child_account_cap(arg0: &AccountCap, arg1: &mut 0x2::tx_context::TxContext) : AccountCap {
        assert!(0x2::object::uid_to_address(&arg0.id) == arg0.owner, 2);
        AccountCap{
            id    : 0x2::object::new(arg1),
            owner : arg0.owner,
        }
    }

    public(friend) fun decrease_user_available_balance<T0>(arg0: &mut Custodian<T0>, arg1: &AccountCap, arg2: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut borrow_mut_account_balance<T0>(arg0, arg1.owner).available_balance, arg2)
    }

    public(friend) fun decrease_user_locked_balance<T0>(arg0: &mut Custodian<T0>, arg1: address, arg2: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut borrow_mut_account_balance<T0>(arg0, arg1).locked_balance, arg2)
    }

    public fun delete_account_cap(arg0: AccountCap) {
        let AccountCap {
            id    : v0,
            owner : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun increase_user_available_balance<T0>(arg0: &mut Custodian<T0>, arg1: address, arg2: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut borrow_mut_account_balance<T0>(arg0, arg1).available_balance, arg2);
    }

    public(friend) fun increase_user_locked_balance<T0>(arg0: &mut Custodian<T0>, arg1: &AccountCap, arg2: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut borrow_mut_account_balance<T0>(arg0, arg1.owner).locked_balance, arg2);
    }

    public(friend) fun lock_balance<T0>(arg0: &mut Custodian<T0>, arg1: &AccountCap, arg2: u64) {
        let v0 = decrease_user_available_balance<T0>(arg0, arg1, arg2);
        increase_user_locked_balance<T0>(arg0, arg1, v0);
    }

    public(friend) fun mint_account_cap(arg0: &mut 0x2::tx_context::TxContext) : AccountCap {
        let v0 = 0x2::object::new(arg0);
        AccountCap{
            id    : v0,
            owner : 0x2::object::uid_to_address(&v0),
        }
    }

    public(friend) fun unlock_balance<T0>(arg0: &mut Custodian<T0>, arg1: address, arg2: u64) {
        let v0 = decrease_user_locked_balance<T0>(arg0, arg1, arg2);
        increase_user_available_balance<T0>(arg0, arg1, v0);
    }

    public(friend) fun withdraw_asset<T0>(arg0: &mut Custodian<T0>, arg1: u64, arg2: &AccountCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(decrease_user_available_balance<T0>(arg0, arg2, arg1), arg3)
    }

    // decompiled from Move bytecode v6
}

