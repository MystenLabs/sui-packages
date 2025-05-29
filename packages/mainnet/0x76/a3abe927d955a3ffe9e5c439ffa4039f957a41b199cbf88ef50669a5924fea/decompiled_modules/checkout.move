module 0x76a3abe927d955a3ffe9e5c439ffa4039f957a41b199cbf88ef50669a5924fea::checkout {
    struct SuiPayPaymentEvent has copy, drop, store {
        link_id: 0x1::string::String,
        amount_usdc: u64,
        sender: address,
        deposit_address: address,
    }

    public fun make_payment(arg0: 0x1::string::String, arg1: u64, arg2: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2) >= arg1, 1);
        let v0 = 0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, arg3);
        0x76a3abe927d955a3ffe9e5c439ffa4039f957a41b199cbf88ef50669a5924fea::fee::take_fee(&mut v0, 100, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(v0, @0x58d6b87e21a8b3ba343e67450e8597cbcd4e9942d8d43f2bc9261547213d0663);
        let v1 = SuiPayPaymentEvent{
            link_id         : arg0,
            amount_usdc     : arg1,
            sender          : 0x2::tx_context::sender(arg3),
            deposit_address : @0x58d6b87e21a8b3ba343e67450e8597cbcd4e9942d8d43f2bc9261547213d0663,
        };
        0x2::event::emit<SuiPayPaymentEvent>(v1);
    }

    public fun make_payment_custody(arg0: address, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3) >= arg2, 1);
        let v0 = 0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, arg4);
        0x76a3abe927d955a3ffe9e5c439ffa4039f957a41b199cbf88ef50669a5924fea::fee::take_fee(&mut v0, 100, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(v0, arg0);
        let v1 = SuiPayPaymentEvent{
            link_id         : arg1,
            amount_usdc     : arg2,
            sender          : 0x2::tx_context::sender(arg4),
            deposit_address : arg0,
        };
        0x2::event::emit<SuiPayPaymentEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

