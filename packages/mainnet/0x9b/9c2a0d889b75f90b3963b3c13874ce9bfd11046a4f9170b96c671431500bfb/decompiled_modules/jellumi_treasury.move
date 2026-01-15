module 0x9b9c2a0d889b75f90b3963b3c13874ce9bfd11046a4f9170b96c671431500bfb::jellumi_treasury {
    struct TreasuryAdminCap has key {
        id: 0x2::object::UID,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_collected: u64,
        total_withdrawn: u64,
    }

    struct DepositEvent has copy, drop {
        amount: u64,
        source: vector<u8>,
    }

    struct WithdrawEvent has copy, drop {
        amount: u64,
        recipient: address,
    }

    public fun balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun deposit(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_collected = arg0.total_collected + v0;
        let v1 = DepositEvent{
            amount : v0,
            source : arg2,
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    public fun deposit_simple(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_collected = arg0.total_collected + v0;
        let v1 = DepositEvent{
            amount : v0,
            source : b"external",
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TreasuryAdminCap{id: 0x2::object::new(arg0)};
        let v1 = Treasury{
            id              : 0x2::object::new(arg0),
            balance         : 0x2::balance::zero<0x2::sui::SUI>(),
            total_collected : 0,
            total_withdrawn : 0,
        };
        0x2::transfer::transfer<TreasuryAdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Treasury>(v1);
    }

    public fun total_collected(arg0: &Treasury) : u64 {
        arg0.total_collected
    }

    public fun total_withdrawn(arg0: &Treasury) : u64 {
        arg0.total_withdrawn
    }

    public fun withdraw(arg0: &TreasuryAdminCap, arg1: &mut Treasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.balance) >= arg2, 0);
        arg1.total_withdrawn = arg1.total_withdrawn + arg2;
        let v0 = WithdrawEvent{
            amount    : arg2,
            recipient : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<WithdrawEvent>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, arg2), arg3)
    }

    public fun withdraw_all(arg0: &TreasuryAdminCap, arg1: &mut Treasury, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        withdraw(arg0, arg1, v0, arg2)
    }

    // decompiled from Move bytecode v6
}

