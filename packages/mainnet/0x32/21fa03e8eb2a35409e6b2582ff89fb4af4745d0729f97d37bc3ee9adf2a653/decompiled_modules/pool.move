module 0x3221fa03e8eb2a35409e6b2582ff89fb4af4745d0729f97d37bc3ee9adf2a653::pool {
    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
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

    public entry fun create_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Pool<T0>>(v0);
        let v1 = PoolCreate{creator: 0x2::tx_context::sender(arg0)};
        0x2::event::emit<PoolCreate>(v1);
    }

    public entry fun deposit<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = PoolDeposit{
            sender : 0x2::tx_context::sender(arg2),
            amount : 0x2::coin::value<T0>(&arg1),
            pool   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        };
        0x2::event::emit<PoolDeposit>(v0);
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

    public fun set_admin(arg0: &mut PoolAdminCap, arg1: u256, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg3), 42001);
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
        assert!(arg0.creator == 0x2::tx_context::sender(arg3), 42001);
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

    public entry fun withdraw<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolWithdraw{
            sender    : 0x2::tx_context::sender(arg3),
            recipient : arg2,
            amount    : arg1,
            pool      : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        };
        0x2::event::emit<PoolWithdraw>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

