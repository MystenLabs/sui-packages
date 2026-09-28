module 0x2c7e6c7c8a947aebc2d9e326a5108c5f66ac7447db4462d41b1a4665f1bdd6f8::billing {
    struct Treasury has key {
        id: 0x2::object::UID,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
        received: u64,
    }

    struct TreasuryCap has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::object::ID,
    }

    struct Paid has copy, drop {
        treasury: 0x2::object::ID,
        payer: address,
        account: address,
        amount: u64,
        note: vector<u8>,
    }

    struct Withdrawn has copy, drop {
        treasury: 0x2::object::ID,
        amount: u64,
        to: address,
    }

    public fun balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.funds)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id       : 0x2::object::new(arg0),
            funds    : 0x2::balance::zero<0x2::sui::SUI>(),
            received : 0,
        };
        let v1 = TreasuryCap{
            id       : 0x2::object::new(arg0),
            treasury : 0x2::object::id<Treasury>(&v0),
        };
        0x2::transfer::share_object<Treasury>(v0);
        0x2::transfer::public_transfer<TreasuryCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun pay(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 0);
        arg0.received = arg0.received + v0;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.funds, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = Paid{
            treasury : 0x2::object::id<Treasury>(arg0),
            payer    : 0x2::tx_context::sender(arg4),
            account  : arg2,
            amount   : v0,
            note     : arg3,
        };
        0x2::event::emit<Paid>(v1);
    }

    public fun received(arg0: &Treasury) : u64 {
        arg0.received
    }

    public fun withdraw(arg0: &TreasuryCap, arg1: &mut Treasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.treasury == 0x2::object::id<Treasury>(arg1), 1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.funds) >= arg2, 1);
        let v0 = Withdrawn{
            treasury : 0x2::object::id<Treasury>(arg1),
            amount   : arg2,
            to       : arg3,
        };
        0x2::event::emit<Withdrawn>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.funds, arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v7
}

