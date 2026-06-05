module 0xbe1526976d757a90ab59b287a29f547f86ec5ea3b7f361ce3822339e726ae983::main {
    struct WalletCreated has copy, drop {
        wallet_id: 0x2::object::ID,
        merchant: address,
        amount: u64,
        transaction_id: u64,
    }

    struct PaymentProcessed has copy, drop {
        wallet_id: 0x2::object::ID,
        merchant: address,
        input_amount: u64,
        usdc_distributed: u64,
        fee_collected: u64,
    }

    struct Wallet<phantom T0> has store, key {
        id: 0x2::object::UID,
        merchant: address,
        amount: u64,
        transaction_id: u64,
    }

    fun distributeUsdc(arg0: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: address, arg2: u64, arg3: 0x2::object::UID, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0);
        let v1 = v0 * 100 / 10000;
        let v2 = 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0);
        let v3 = PaymentProcessed{
            wallet_id        : 0x2::object::uid_to_inner(&arg3),
            merchant         : arg1,
            input_amount     : arg2,
            usdc_distributed : v0 - v1,
            fee_collected    : v1,
        };
        0x2::event::emit<PaymentProcessed>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v2, v1), arg4), @0x997043ec15507d6f1d52c5b5396fcc9f8b0db67495dedc7d6b5927f24271f7f1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v2, arg4), arg1);
        0x2::object::delete(arg3);
    }

    public fun generatePaymentWallet<T0>(arg0: address, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg3);
        let v1 = Wallet<T0>{
            id             : v0,
            merchant       : arg0,
            amount         : arg1,
            transaction_id : arg2,
        };
        let v2 = WalletCreated{
            wallet_id      : 0x2::object::uid_to_inner(&v0),
            merchant       : arg0,
            amount         : arg1,
            transaction_id : arg2,
        };
        0x2::event::emit<WalletCreated>(v2);
        0x2::transfer::share_object<Wallet<T0>>(v1);
    }

    public fun merge_all_usdc(arg0: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: vector<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>) {
        while (!0x1::vector::is_empty<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&arg1)) {
            0x2::coin::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, 0x1::vector::pop_back<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&mut arg1));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1);
    }

    public fun pay_swap<T0>(arg0: 0x2::coin::Coin<T0>, arg1: Wallet<T0>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let Wallet {
            id             : v0,
            merchant       : v1,
            amount         : v2,
            transaction_id : _,
        } = arg1;
        assert!(0x2::coin::value<T0>(&arg0) == v2, 3);
        let (v4, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg0, 0x2::coin::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg5), arg3, 0, arg4, arg5);
        let v7 = v6;
        let v8 = v4;
        if (0x2::coin::value<T0>(&v8) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<T0>(v8);
        };
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v7, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v7);
        };
        distributeUsdc(v5, v1, v2, v0, arg5);
    }

    public fun pay_usdc(arg0: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: Wallet<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &mut 0x2::tx_context::TxContext) {
        let Wallet {
            id             : v0,
            merchant       : v1,
            amount         : v2,
            transaction_id : _,
        } = arg1;
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0) == v2, 3);
        distributeUsdc(arg0, v1, v2, v0, arg2);
    }

    public fun withdraw_to_merchant(arg0: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0) >= arg1, 1);
        let v0 = 0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0, arg1, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v0, arg1 * 100 / 10000, arg3), @0x997043ec15507d6f1d52c5b5396fcc9f8b0db67495dedc7d6b5927f24271f7f1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(v0, arg2);
        if (0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0);
        };
    }

    // decompiled from Move bytecode v7
}

