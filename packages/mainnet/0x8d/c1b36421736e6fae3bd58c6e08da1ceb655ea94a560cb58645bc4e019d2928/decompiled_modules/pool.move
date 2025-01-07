module 0xdb5cfa5ad07fec2fbaf60f8006bd8f72ea3c5fc88b57b222f139060b88156ec9::pool {
    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        treasury_balance: 0x2::balance::Balance<T0>,
        decimal: u8,
    }

    struct PoolAdminCap has store, key {
        id: 0x2::object::UID,
        creator: address,
    }

    struct PoolCreate has copy, drop {
        creator: address,
    }

    struct PoolBalanceRegister has copy, drop {
        sender: address,
        amount: u64,
        new_amount: u64,
        pool: 0x1::ascii::String,
    }

    struct PoolDeposit has copy, drop {
        sender: address,
        amount: u64,
        pool: 0x1::ascii::String,
    }

    struct PoolWithdraw has copy, drop {
        sender: address,
        recipient: address,
        amount: u64,
        pool: 0x1::ascii::String,
    }

    public fun convert_amount(arg0: u64, arg1: u8, arg2: u8) : u64 {
        while (arg1 != arg2) {
            if (arg1 < arg2) {
                arg0 = arg0 * 10;
                arg1 = arg1 + 1;
                continue
            };
            arg0 = arg0 / 10;
            arg1 = arg1 - 1;
        };
        arg0
    }

    public(friend) fun create_pool<T0>(arg0: &PoolAdminCap, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0>{
            id               : 0x2::object::new(arg2),
            balance          : 0x2::balance::zero<T0>(),
            treasury_balance : 0x2::balance::zero<T0>(),
            decimal          : arg1,
        };
        0x2::transfer::share_object<Pool<T0>>(v0);
        let v1 = PoolCreate{creator: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<PoolCreate>(v1);
    }

    public(friend) fun deposit<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = PoolDeposit{
            sender : 0x2::tx_context::sender(arg2),
            amount : 0x2::coin::value<T0>(&arg1),
            pool   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        };
        0x2::event::emit<PoolDeposit>(v0);
    }

    public(friend) fun deposit_treasury<T0>(arg0: &mut Pool<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 42002);
        0x2::balance::join<T0>(&mut arg0.treasury_balance, 0x2::balance::split<T0>(&mut arg0.balance, arg1));
    }

    public fun get_coin_decimal<T0>(arg0: &Pool<T0>) : u8 {
        arg0.decimal
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolAdminCap{
            id      : 0x2::object::new(arg0),
            creator : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::public_transfer<PoolAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun normal_amount<T0>(arg0: &Pool<T0>, arg1: u64) : u64 {
        convert_amount(arg1, get_coin_decimal<T0>(arg0), 9)
    }

    public fun unnormal_amount<T0>(arg0: &Pool<T0>, arg1: u64) : u64 {
        convert_amount(arg1, 9, get_coin_decimal<T0>(arg0))
    }

    public(friend) fun withdraw<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolWithdraw{
            sender    : 0x2::tx_context::sender(arg3),
            recipient : arg2,
            amount    : arg1,
            pool      : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        };
        0x2::event::emit<PoolWithdraw>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg3), arg2);
    }

    public(friend) fun withdraw_reserve_balance<T0>(arg0: &PoolAdminCap, arg1: &mut Pool<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg2, 42002);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg4), arg3);
    }

    public fun withdraw_treasury<T0>(arg0: &mut PoolAdminCap, arg1: &mut Pool<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1.treasury_balance) >= arg2, 42002);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.treasury_balance, arg2), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

