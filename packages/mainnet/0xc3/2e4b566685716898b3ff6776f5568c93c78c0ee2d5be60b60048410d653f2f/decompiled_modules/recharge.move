module 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::recharge {
    struct Recharge<phantom T0> has store, key {
        id: 0x2::object::UID,
        coin_type: 0x1::type_name::TypeName,
        available_amount: u64,
        available_balance: 0x2::balance::Balance<T0>,
    }

    struct DepositEvent has copy, drop {
        sender: address,
        account: address,
        coin_type: 0x1::type_name::TypeName,
        deposit_amount: u64,
        is_inner: bool,
    }

    struct WithdrawEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        withdraw_amount: u64,
        is_inner: bool,
    }

    public fun admin_withdraw<T0>(arg0: &0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::admin::WithdrawCap, arg1: &mut Recharge<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(withdraw<T0>(arg1, arg2, false), arg3)
    }

    public fun coin_type<T0>(arg0: &Recharge<T0>) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public fun create_recharge<T0>(arg0: &0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Recharge<T0>{
            id                : 0x2::object::new(arg1),
            coin_type         : 0x1::type_name::get<T0>(),
            available_amount  : 0,
            available_balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Recharge<T0>>(v0);
    }

    public(friend) fun deposit<T0>(arg0: &mut Recharge<T0>, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        assert!(coin_type<T0>(arg0) == 0x1::type_name::get<T0>(), 1);
        let v0 = 0x2::coin::value<T0>(&arg1);
        arg0.available_amount = arg0.available_amount + v0;
        0x2::balance::join<T0>(&mut arg0.available_balance, 0x2::coin::into_balance<T0>(arg1));
        let v1 = DepositEvent{
            sender         : 0x2::tx_context::sender(arg4),
            account        : arg2,
            coin_type      : 0x1::type_name::get<T0>(),
            deposit_amount : v0,
            is_inner       : arg3,
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    public fun pub_deposit<T0>(arg0: &mut Recharge<T0>, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        deposit<T0>(arg0, arg1, arg2, false, arg3);
    }

    public(friend) fun withdraw<T0>(arg0: &mut Recharge<T0>, arg1: u64, arg2: bool) : 0x2::balance::Balance<T0> {
        assert!(coin_type<T0>(arg0) == 0x1::type_name::get<T0>(), 1);
        arg0.available_amount = arg0.available_amount - arg1;
        let v0 = WithdrawEvent{
            coin_type       : 0x1::type_name::get<T0>(),
            withdraw_amount : arg1,
            is_inner        : arg2,
        };
        0x2::event::emit<WithdrawEvent>(v0);
        0x2::balance::split<T0>(&mut arg0.available_balance, arg1)
    }

    // decompiled from Move bytecode v6
}

