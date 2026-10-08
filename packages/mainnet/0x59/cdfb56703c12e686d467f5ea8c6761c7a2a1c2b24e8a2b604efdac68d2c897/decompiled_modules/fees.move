module 0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::fees {
    struct Fees<phantom T0> has store {
        recipient: address,
        balance: 0x2::balance::Balance<T0>,
    }

    public(friend) fun charge<T0>(arg0: &mut Fees<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (_, v1) = 0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::accounting::redemption_amounts(0x2::coin::value<T0>(&arg1), arg2);
        if (v1 > 0) {
            0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v1, arg3)));
        };
        arg1
    }

    public(friend) fun collect<T0>(arg0: &mut Fees<T0>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, address) {
        (0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg1), arg0.recipient)
    }

    public(friend) fun info<T0>(arg0: &Fees<T0>) : (address, u64) {
        (arg0.recipient, 0x2::balance::value<T0>(&arg0.balance))
    }

    public(friend) fun new<T0>(arg0: address) : Fees<T0> {
        assert!(arg0 != @0x0, 0);
        Fees<T0>{
            recipient : arg0,
            balance   : 0x2::balance::zero<T0>(),
        }
    }

    // decompiled from Move bytecode v7
}

