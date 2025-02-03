module 0x9c6c4e3aac0dd921088c72d02836590712efdcfa093730e2b1e1514a0110edce::voting {
    struct ProposalPayment has copy, drop {
        payer: address,
        amount: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun pay_for_proposal(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= 1000000000, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
        let v0 = ProposalPayment{
            payer  : 0x2::tx_context::sender(arg2),
            amount : 1000000000,
        };
        0x2::event::emit<ProposalPayment>(v0);
    }

    // decompiled from Move bytecode v6
}

