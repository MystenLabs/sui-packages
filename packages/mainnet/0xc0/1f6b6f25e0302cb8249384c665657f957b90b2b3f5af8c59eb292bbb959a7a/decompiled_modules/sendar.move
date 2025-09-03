module 0xc01f6b6f25e0302cb8249384c665657f957b90b2b3f5af8c59eb292bbb959a7a::sendar {
    struct CashSent has copy, drop, store {
        amount: u64,
        sender: address,
        recipient: address,
    }

    public entry fun send_sui(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
        let v0 = CashSent{
            amount    : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            sender    : 0x2::tx_context::sender(arg2),
            recipient : arg1,
        };
        0x2::event::emit<CashSent>(v0);
    }

    public entry fun send_usdc(arg0: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg0, arg1);
        let v0 = CashSent{
            amount    : 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0),
            sender    : 0x2::tx_context::sender(arg2),
            recipient : arg1,
        };
        0x2::event::emit<CashSent>(v0);
    }

    // decompiled from Move bytecode v6
}

