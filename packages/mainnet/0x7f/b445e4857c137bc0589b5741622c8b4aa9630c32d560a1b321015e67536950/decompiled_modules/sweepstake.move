module 0x7fb445e4857c137bc0589b5741622c8b4aa9630c32d560a1b321015e67536950::sweepstake {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        coin_name: 0x1::string::String,
    }

    struct NewTreasuryEvent has copy, drop {
        id: 0x2::object::ID,
    }

    struct DepositEvent has copy, drop {
        owner: address,
        coin: 0x1::string::String,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        withdraw_id: 0x1::string::String,
        owner: address,
        coin: 0x1::string::String,
        amount: u64,
    }

    entry fun deposit<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
        let v0 = DepositEvent{
            owner  : 0x2::tx_context::sender(arg2),
            coin   : arg0.coin_name,
            amount : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        new_treasury<0x2::sui::SUI>(&v0, 0x1::string::utf8(b"SUI"), arg0);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun new_treasury<T0>(arg0: &AdminCap, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        let v1 = NewTreasuryEvent{id: 0x2::object::uid_to_inner(&v0)};
        0x2::event::emit<NewTreasuryEvent>(v1);
        let v2 = Treasury<T0>{
            id        : v0,
            balance   : 0x2::balance::zero<T0>(),
            coin_name : arg1,
        };
        0x2::transfer::share_object<Treasury<T0>>(v2);
    }

    entry fun withdraw<T0>(arg0: &AdminCap, arg1: &mut Treasury<T0>, arg2: 0x1::string::String, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg3, 1002);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg3), arg5), arg4);
        let v0 = WithdrawEvent{
            withdraw_id : arg2,
            owner       : arg4,
            coin        : arg1.coin_name,
            amount      : arg3,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

