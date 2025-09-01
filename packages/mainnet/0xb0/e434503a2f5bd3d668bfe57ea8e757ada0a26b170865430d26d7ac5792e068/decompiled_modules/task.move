module 0xb0e434503a2f5bd3d668bfe57ea8e757ada0a26b170865430d26d7ac5792e068::task {
    struct CheckInEvent has copy, drop {
        user_id: u64,
        sender: address,
    }

    struct RechargeEvent has copy, drop {
        order_id: u64,
        amount: u64,
        sender: address,
    }

    struct WithdrawEvent has copy, drop {
        amount: u64,
        receiver: address,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        admin: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun withdraw_all(arg0: &mut Treasury, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.admin, 2);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v1 > 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance), arg1), v0);
        let v2 = WithdrawEvent{
            amount   : v1,
            receiver : v0,
        };
        0x2::event::emit<WithdrawEvent>(v2);
    }

    public fun check_in(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 != 0, 3);
        let v0 = CheckInEvent{
            user_id : arg0,
            sender  : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<CheckInEvent>(v0);
    }

    public fun create_treasury(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id      : 0x2::object::new(arg1),
            admin   : arg0,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    public fun get_treasury_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun recharge(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= arg3, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, arg3, arg4)));
        let v0 = RechargeEvent{
            order_id : arg1,
            amount   : arg3,
            sender   : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<RechargeEvent>(v0);
    }

    public fun withdraw(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin, 2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg1, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg2), v0);
        let v1 = WithdrawEvent{
            amount   : arg1,
            receiver : v0,
        };
        0x2::event::emit<WithdrawEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

