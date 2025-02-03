module 0xaba27ae3f45a57573668054bce6114d0a14826172ce335b224fe3306f0915f08::voting {
    struct ProposalPayment has copy, drop {
        payer: address,
        amount: u64,
    }

    public entry fun pay_for_proposal<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) >= 1, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0xc4000ea0fd3244857575799ef4f8164c7b42d1c5bf840cfd54030f608b07556d);
        let v0 = ProposalPayment{
            payer  : 0x2::tx_context::sender(arg1),
            amount : 1,
        };
        0x2::event::emit<ProposalPayment>(v0);
    }

    // decompiled from Move bytecode v6
}

