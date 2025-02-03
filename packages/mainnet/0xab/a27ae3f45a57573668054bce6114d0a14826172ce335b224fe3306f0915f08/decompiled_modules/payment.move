module 0xaba27ae3f45a57573668054bce6114d0a14826172ce335b224fe3306f0915f08::payment {
    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct PaymentReceived has copy, drop {
        amount: u64,
        sender: address,
    }

    public fun get_required_payment() : u64 {
        1000000000
    }

    public fun get_treasury_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    public fun pay(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 1000000000;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= v0, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg0, v0, arg2)));
        let v1 = PaymentReceived{
            amount : v0,
            sender : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PaymentReceived>(v1);
    }

    public entry fun withdraw(arg0: &mut Treasury, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

