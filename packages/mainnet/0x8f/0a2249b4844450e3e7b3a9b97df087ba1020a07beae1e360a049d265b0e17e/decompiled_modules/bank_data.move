module 0x8f0a2249b4844450e3e7b3a9b97df087ba1020a07beae1e360a049d265b0e17e::bank_data {
    struct BankData has key {
        id: 0x2::object::UID,
        user: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct BANK_DATA has drop {
        dummy_field: bool,
    }

    public fun balance(arg0: &BankData) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun bank(arg0: &BankData) : address {
        arg0.user
    }

    public fun deposit(arg0: &mut BankData, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    fun init(arg0: BANK_DATA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<BANK_DATA>(arg0, arg1);
        let v0 = BankData{
            id      : 0x2::object::new(arg1),
            user    : 0x2::tx_context::sender(arg1),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::transfer<BankData>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun withdraw(arg0: &mut BankData, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == bank(arg0), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, balance(arg0), arg1), bank(arg0));
    }

    // decompiled from Move bytecode v6
}

