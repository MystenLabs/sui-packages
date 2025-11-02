module 0x57dc12634e4985d19703c93957466549a4bcc21b2355e0959b1e6b133bad99e::vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, 0x2::bag::Bag>,
    }

    struct Deposit has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    struct Withdraw has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    public fun claim<T0>(arg0: &mut Vault, arg1: &0x57dc12634e4985d19703c93957466549a4bcc21b2355e0959b1e6b133bad99e::config::Config, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x57dc12634e4985d19703c93957466549a4bcc21b2355e0959b1e6b133bad99e::config::check_version(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = 0x2::coin::from_balance<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(0x2::table::borrow_mut<address, 0x2::bag::Bag>(&mut arg0.users, v1), v0), arg2);
        let v3 = Withdraw{
            coin_type : v0,
            amount    : 0x2::coin::value<T0>(&v2),
            recipient : v1,
        };
        0x2::event::emit<Withdraw>(v3);
        v2
    }

    public fun deposit<T0>(arg0: &mut Vault, arg1: &0x57dc12634e4985d19703c93957466549a4bcc21b2355e0959b1e6b133bad99e::config::Config, arg2: &0x57dc12634e4985d19703c93957466549a4bcc21b2355e0959b1e6b133bad99e::admin::AdminCap, arg3: 0x2::coin::Coin<T0>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x57dc12634e4985d19703c93957466549a4bcc21b2355e0959b1e6b133bad99e::config::check_version(arg1);
        if (0x2::coin::value<T0>(&arg3) == 0) {
            0x2::coin::destroy_zero<T0>(arg3);
            return
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::table::contains<address, 0x2::bag::Bag>(&arg0.users, arg4)) {
            0x2::table::add<address, 0x2::bag::Bag>(&mut arg0.users, arg4, 0x2::bag::new(arg5));
        };
        let v1 = 0x2::table::borrow_mut<address, 0x2::bag::Bag>(&mut arg0.users, arg4);
        if (!0x2::bag::contains<0x1::type_name::TypeName>(v1, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, v0, 0x2::balance::zero<T0>());
        };
        0x2::coin::put<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, v0), arg3);
        let v2 = Deposit{
            coin_type : v0,
            amount    : 0x2::coin::value<T0>(&arg3),
            recipient : arg4,
        };
        0x2::event::emit<Deposit>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id    : 0x2::object::new(arg0),
            users : 0x2::table::new<address, 0x2::bag::Bag>(arg0),
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    public fun unclaimed_balance<T0>(arg0: &Vault, arg1: address) : u64 {
        if (!0x2::table::contains<address, 0x2::bag::Bag>(&arg0.users, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, 0x2::bag::Bag>(&arg0.users, arg1);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(v0, v1)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v0, v1))
    }

    // decompiled from Move bytecode v6
}

