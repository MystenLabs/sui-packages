module 0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_treasury {
    struct AGUTreasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>,
        total_deposited: u64,
        total_spent: u64,
        spend_count: u64,
    }

    struct TreasuryDeposited has copy, drop {
        amount: u64,
        depositor: address,
        new_balance: u64,
    }

    struct TreasurySpent has copy, drop {
        amount: u64,
        recipient: address,
        reason: vector<u8>,
        remaining_balance: u64,
    }

    entry fun deposit(arg0: &mut AGUTreasury, arg1: 0x2::coin::Coin<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>(&arg1);
        assert!(v0 > 0, 702);
        0x2::balance::join<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>(&mut arg0.balance, 0x2::coin::into_balance<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>(arg1));
        arg0.total_deposited = arg0.total_deposited + v0;
        let v1 = TreasuryDeposited{
            amount      : v0,
            depositor   : 0x2::tx_context::sender(arg2),
            new_balance : 0x2::balance::value<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>(&arg0.balance),
        };
        0x2::event::emit<TreasuryDeposited>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AGUTreasury{
            id              : 0x2::object::new(arg0),
            balance         : 0x2::balance::zero<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>(),
            total_deposited : 0,
            total_spent     : 0,
            spend_count     : 0,
        };
        0x2::transfer::share_object<AGUTreasury>(v0);
    }

    entry fun spend(arg0: &0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::access_control::TreasuryManagerCap, arg1: &mut AGUTreasury, arg2: u64, arg3: address, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 702);
        assert!(0x2::balance::value<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>(&arg1.balance) >= arg2, 701);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>>(0x2::coin::from_balance<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>(0x2::balance::split<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>(&mut arg1.balance, arg2), arg5), arg3);
        arg1.total_spent = arg1.total_spent + arg2;
        arg1.spend_count = arg1.spend_count + 1;
        let v0 = TreasurySpent{
            amount            : arg2,
            recipient         : arg3,
            reason            : arg4,
            remaining_balance : 0x2::balance::value<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>(&arg1.balance),
        };
        0x2::event::emit<TreasurySpent>(v0);
    }

    public fun spend_count(arg0: &AGUTreasury) : u64 {
        arg0.spend_count
    }

    public fun total_deposited(arg0: &AGUTreasury) : u64 {
        arg0.total_deposited
    }

    public fun total_spent(arg0: &AGUTreasury) : u64 {
        arg0.total_spent
    }

    public fun treasury_balance(arg0: &AGUTreasury) : u64 {
        0x2::balance::value<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>(&arg0.balance)
    }

    // decompiled from Move bytecode v6
}

