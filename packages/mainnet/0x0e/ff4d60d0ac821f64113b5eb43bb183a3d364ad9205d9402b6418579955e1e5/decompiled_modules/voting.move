module 0xeff4d60d0ac821f64113b5eb43bb183a3d364ad9205d9402b6418579955e1e5::voting {
    struct ProposalPayment has copy, drop {
        payer: address,
        amount: u64,
    }

    public entry fun pay_for_proposal<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) >= 1000000, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0xc4000ea0fd3244857575799ef4f8164c7b42d1c5bf840cfd54030f608b07556d);
        let v0 = ProposalPayment{
            payer  : 0x2::tx_context::sender(arg1),
            amount : 1000000,
        };
        0x2::event::emit<ProposalPayment>(v0);
    }

    // decompiled from Move bytecode v6
}

