module 0x2b5d7ef1f557f2924ba37ed92b6dccdebc4519b6f8987027bb0bb698a5e95680::yy_balance {
    struct YyBalance<phantom T0> has key {
        id: 0x2::object::UID,
        yy_balace: 0x2::balance::Balance<T0>,
        users: 0x2::table::Table<address, User>,
    }

    struct User has store {
        id: 0x2::object::UID,
        balance: u64,
        withdrawal_balance: u64,
    }

    public(friend) fun extract_yy<T0>(arg0: &mut YyBalance<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.yy_balace;
        assert!(0x2::balance::value<T0>(v0) >= arg2, 111);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v0, arg2, arg3), arg1);
    }

    public fun findBalance<T0>(arg0: &YyBalance<T0>, arg1: address) : u64 {
        0x2::table::borrow<address, User>(&arg0.users, arg1).balance
    }

    public fun find_withdrawal_balance<T0>(arg0: &YyBalance<T0>, arg1: address) : u64 {
        0x2::table::borrow<address, User>(&arg0.users, arg1).withdrawal_balance
    }

    public(friend) fun init_new_resource<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = YyBalance<T0>{
            id        : 0x2::object::new(arg0),
            yy_balace : 0x2::balance::zero<T0>(),
            users     : 0x2::table::new<address, User>(arg0),
        };
        0x2::transfer::share_object<YyBalance<T0>>(v0);
    }

    public(friend) fun recharge_yy<T0>(arg0: &mut YyBalance<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.yy_balace, 0x2::coin::into_balance<T0>(arg1));
    }

    public(friend) fun set_add_yy_balance<T0>(arg0: &mut YyBalance<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.users;
        if (!0x2::table::contains<address, User>(v0, arg1)) {
            let v1 = User{
                id                 : 0x2::object::new(arg3),
                balance            : arg2,
                withdrawal_balance : 0,
            };
            0x2::table::add<address, User>(v0, arg1, v1);
        } else {
            let v2 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, arg1);
            v2.balance = v2.balance + arg2;
        };
    }

    public(friend) fun withdraw_yyV1<T0>(arg0: &mut YyBalance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, 0x2::tx_context::sender(arg2));
        assert!(arg1 > 0, 0);
        assert!(v0.balance >= arg1, 1);
        let v1 = &mut arg0.yy_balace;
        assert!(0x2::balance::value<T0>(v1) >= arg1, 111);
        v0.balance = v0.balance - arg1;
        v0.withdrawal_balance = v0.withdrawal_balance + arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v1, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

