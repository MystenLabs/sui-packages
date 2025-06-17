module 0x8a77954fc150592e1b4a754eff69473cb78ab9643f36865e03428876043a68f6::aftermath_ptb_wrapper {
    struct AftermathPTBSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        method: vector<u8>,
    }

    public entry fun ptb_demo_call(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AftermathPTBSwapExecuted{
            sender    : 0x2::tx_context::sender(arg1),
            amount_in : arg0,
            method    : b"ptb_demo",
        };
        0x2::event::emit<AftermathPTBSwapExecuted>(v0);
    }

    public entry fun swap_sui_to_usdc_ptb(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 3401);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = AftermathPTBSwapExecuted{
            sender    : v1,
            amount_in : v0,
            method    : b"ptb_aftermath_wrapper",
        };
        0x2::event::emit<AftermathPTBSwapExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
    }

    // decompiled from Move bytecode v6
}

