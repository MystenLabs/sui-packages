module 0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account {
    struct AccountWrapper has key {
        id: 0x2::object::UID,
        account: Account,
    }

    struct Account has store {
        account_id: 0x2::object::UID,
        owner: address,
        receive_address: address,
        balances: 0x2::bag::Bag,
        settlements: 0x2::bag::Bag,
        referrer_account_id: 0x1::option::Option<0x2::object::ID>,
        referrer_receive_address: 0x1::option::Option<address>,
    }

    struct DataKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct CoinKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Auth {
        kind: u8,
        owner: address,
    }

    public fun balance<T0>(arg0: &Account, arg1: &0x2::accumulator::AccumulatorRoot, arg2: &0x2::clock::Clock) : u64 {
        stored_balance<T0>(arg0) + unsettled_balance<T0>(arg0, arg1, arg2)
    }

    public fun account_id(arg0: &Account) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.account_id)
    }

    fun assert_owner(arg0: &AccountWrapper, arg1: address) {
        assert!(arg1 == arg0.account.owner, 0);
    }

    public fun attach<T0, T1: store>(arg0: &mut Account, arg1: 0x1::internal::Permit<T0>, arg2: T1) {
        let v0 = DataKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<DataKey<T0>, T1>(&mut arg0.account_id, v0, arg2);
    }

    public fun borrow_data<T0, T1: store>(arg0: &Account) : &T1 {
        let v0 = DataKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<DataKey<T0>, T1>(&arg0.account_id, v0)
    }

    public fun borrow_data_mut<T0, T1: store>(arg0: &mut Account, arg1: 0x1::internal::Permit<T0>) : &mut T1 {
        let v0 = DataKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<DataKey<T0>, T1>(&mut arg0.account_id, v0)
    }

    public fun deposit<T0>(arg0: &mut Account, arg1: 0x2::coin::Coin<T0>) {
        deposit_balance<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
        0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account_events::emit_deposited(account_id(arg0), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), 0x2::coin::value<T0>(&arg1), stored_balance<T0>(arg0));
    }

    fun deposit_balance<T0>(arg0: &mut Account, arg1: 0x2::balance::Balance<T0>) {
        let v0 = CoinKey<T0>{dummy_field: false};
        if (0x2::bag::contains<CoinKey<T0>>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<CoinKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<CoinKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    public fun deposit_funds<T0>(arg0: &mut AccountWrapper, arg1: Auth, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::accumulator::AccumulatorRoot, arg4: &0x2::clock::Clock) {
        settle<T0>(arg0, arg3, arg4);
        let v0 = load_account_mut(arg0, arg1);
        deposit<T0>(v0, arg2);
    }

    public fun detach<T0, T1: store>(arg0: &mut Account, arg1: 0x1::internal::Permit<T0>) : T1 {
        let v0 = DataKey<T0>{dummy_field: false};
        0x2::dynamic_field::remove<DataKey<T0>, T1>(&mut arg0.account_id, v0)
    }

    public fun generate_auth(arg0: &mut 0x2::tx_context::TxContext) : Auth {
        Auth{
            kind  : 0,
            owner : 0x2::tx_context::sender(arg0),
        }
    }

    public fun generate_auth_as_object(arg0: &mut 0x2::object::UID) : Auth {
        let v0 = 0x2::object::uid_to_inner(arg0);
        Auth{
            kind  : 0,
            owner : 0x2::object::id_to_address(&v0),
        }
    }

    public fun has_data<T0>(arg0: &Account) : bool {
        let v0 = DataKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists<DataKey<T0>>(&arg0.account_id, v0)
    }

    public fun id(arg0: &AccountWrapper) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun last_settlement_ms<T0>(arg0: &Account) : u64 {
        let v0 = CoinKey<T0>{dummy_field: false};
        if (0x2::bag::contains<CoinKey<T0>>(&arg0.settlements, v0)) {
            *0x2::bag::borrow<CoinKey<T0>, u64>(&arg0.settlements, v0)
        } else {
            0
        }
    }

    public fun load_account(arg0: &AccountWrapper) : &Account {
        &arg0.account
    }

    public fun load_account_mut(arg0: &mut AccountWrapper, arg1: Auth) : &mut Account {
        let Auth {
            kind  : v0,
            owner : v1,
        } = arg1;
        if (v0 == 0) {
            assert_owner(arg0, v1);
        } else {
            assert!(v0 == 1, 2);
        };
        &mut arg0.account
    }

    public(friend) fun new_app_auth() : Auth {
        Auth{
            kind  : 1,
            owner : @0x0,
        }
    }

    public(friend) fun new_derived<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: T1, arg3: address, arg4: 0x1::option::Option<0x2::object::ID>, arg5: 0x1::option::Option<address>, arg6: &mut 0x2::tx_context::TxContext) : AccountWrapper {
        let v0 = 0x2::derived_object::claim<T0>(arg0, arg1);
        let v1 = Account{
            account_id               : 0x2::derived_object::claim<T1>(arg0, arg2),
            owner                    : arg3,
            receive_address          : 0x2::object::uid_to_address(&v0),
            balances                 : 0x2::bag::new(arg6),
            settlements              : 0x2::bag::new(arg6),
            referrer_account_id      : arg4,
            referrer_receive_address : arg5,
        };
        AccountWrapper{
            id      : v0,
            account : v1,
        }
    }

    public fun owner(arg0: &Account) : address {
        arg0.owner
    }

    public fun receive_address(arg0: &Account) : address {
        arg0.receive_address
    }

    public fun referrer_account_id(arg0: &Account) : 0x1::option::Option<0x2::object::ID> {
        arg0.referrer_account_id
    }

    public fun referrer_receive_address(arg0: &Account) : 0x1::option::Option<address> {
        arg0.referrer_receive_address
    }

    fun set_last_settlement_ms<T0>(arg0: &mut Account, arg1: u64) {
        let v0 = CoinKey<T0>{dummy_field: false};
        if (0x2::bag::contains<CoinKey<T0>>(&arg0.settlements, v0)) {
            *0x2::bag::borrow_mut<CoinKey<T0>, u64>(&mut arg0.settlements, v0) = arg1;
        } else {
            0x2::bag::add<CoinKey<T0>, u64>(&mut arg0.settlements, v0, arg1);
        };
    }

    public fun settle<T0>(arg0: &mut AccountWrapper, arg1: &0x2::accumulator::AccumulatorRoot, arg2: &0x2::clock::Clock) {
        if (settled_this_timestamp<T0>(&arg0.account, arg2)) {
            return
        };
        let v0 = &mut arg0.account;
        set_last_settlement_ms<T0>(v0, 0x2::clock::timestamp_ms(arg2));
        let v1 = 0x2::balance::settled_funds_value<T0>(arg1, 0x2::object::uid_to_address(&arg0.id));
        if (v1 == 0) {
            return
        };
        let v2 = &mut arg0.account;
        deposit_balance<T0>(v2, 0x2::balance::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(&mut arg0.id, v1)));
        0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account_events::emit_funds_settled(account_id(&arg0.account), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), v1, stored_balance<T0>(&arg0.account));
    }

    fun settled_this_timestamp<T0>(arg0: &Account, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) == last_settlement_ms<T0>(arg0)
    }

    public fun share(arg0: AccountWrapper) {
        0x2::transfer::share_object<AccountWrapper>(arg0);
    }

    fun stored_balance<T0>(arg0: &Account) : u64 {
        let v0 = CoinKey<T0>{dummy_field: false};
        if (0x2::bag::contains<CoinKey<T0>>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<CoinKey<T0>, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    fun unsettled_balance<T0>(arg0: &Account, arg1: &0x2::accumulator::AccumulatorRoot, arg2: &0x2::clock::Clock) : u64 {
        if (settled_this_timestamp<T0>(arg0, arg2)) {
            0
        } else {
            0x2::balance::settled_funds_value<T0>(arg1, arg0.receive_address)
        }
    }

    public fun withdraw<T0>(arg0: &mut Account, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = withdraw_balance<T0>(arg0, arg1);
        0xa6f1b22aaeb429f6fd8f01c13f605256e00876457fd122da8a0e2c1045c75929::account_events::emit_withdrawn(account_id(arg0), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), arg1, stored_balance<T0>(arg0));
        0x2::coin::from_balance<T0>(v0, arg2)
    }

    fun withdraw_balance<T0>(arg0: &mut Account, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = CoinKey<T0>{dummy_field: false};
        assert!(0x2::bag::contains<CoinKey<T0>>(&arg0.balances, v0), 1);
        let v1 = 0x2::bag::borrow_mut<CoinKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 1);
        if (0x2::balance::value<T0>(v1) == arg1) {
            0x2::bag::remove<CoinKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0)
        } else {
            0x2::balance::split<T0>(v1, arg1)
        }
    }

    public fun withdraw_funds<T0>(arg0: &mut AccountWrapper, arg1: Auth, arg2: u64, arg3: &0x2::accumulator::AccumulatorRoot, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        settle<T0>(arg0, arg3, arg4);
        let v0 = load_account_mut(arg0, arg1);
        withdraw<T0>(v0, arg2, arg5)
    }

    // decompiled from Move bytecode v7
}

