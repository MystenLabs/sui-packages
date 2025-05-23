module 0x5e84ec46dbc881e0d0c725e72e7ae0c8261b935f25e66d8594bcee994ae840ff::pool {
    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        treasury_balance: 0x2::balance::Balance<T0>,
        decimal: u8,
    }

    struct PoolAdminCap has key {
        id: 0x2::object::UID,
        creator: address,
        owners: 0x2::table::Table<u256, bool>,
        admins: 0x2::table::Table<u256, bool>,
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

    struct PoolOwnerSetting has copy, drop {
        sender: address,
        owner: u256,
        value: bool,
    }

    struct PoolAdminSetting has copy, drop {
        sender: address,
        admin: u256,
        value: bool,
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

    public(friend) fun create_pool<T0>(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0>{
            id               : 0x2::object::new(arg1),
            balance          : 0x2::balance::zero<T0>(),
            treasury_balance : 0x2::balance::zero<T0>(),
            decimal          : arg0,
        };
        0x2::transfer::share_object<Pool<T0>>(v0);
        let v1 = PoolCreate{creator: 0x2::tx_context::sender(arg1)};
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
            owners  : 0x2::table::new<u256, bool>(arg0),
            admins  : 0x2::table::new<u256, bool>(arg0),
        };
        0x2::transfer::transfer<PoolAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun normal_amount<T0>(arg0: &Pool<T0>, arg1: u64) : u64 {
        convert_amount(arg1, get_coin_decimal<T0>(arg0), 9)
    }

    public fun set_admin(arg0: &mut PoolAdminCap, arg1: u256, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<u256, bool>(&arg0.admins, arg1)) {
            0x2::table::add<u256, bool>(&mut arg0.admins, arg1, arg2);
        } else {
            *0x2::table::borrow_mut<u256, bool>(&mut arg0.admins, arg1) = arg2;
        };
        let v0 = PoolAdminSetting{
            sender : 0x2::tx_context::sender(arg3),
            admin  : arg1,
            value  : arg2,
        };
        0x2::event::emit<PoolAdminSetting>(v0);
    }

    public fun set_owner(arg0: &mut PoolAdminCap, arg1: u256, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<u256, bool>(&arg0.owners, arg1)) {
            0x2::table::add<u256, bool>(&mut arg0.owners, arg1, arg2);
        } else {
            *0x2::table::borrow_mut<u256, bool>(&mut arg0.owners, arg1) = arg2;
        };
        let v0 = PoolOwnerSetting{
            sender : 0x2::tx_context::sender(arg3),
            owner  : arg1,
            value  : arg2,
        };
        0x2::event::emit<PoolOwnerSetting>(v0);
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

    public fun withdraw_treasury<T0>(arg0: &mut PoolAdminCap, arg1: &mut Pool<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1.treasury_balance) >= arg2, 42002);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.treasury_balance, arg2), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

