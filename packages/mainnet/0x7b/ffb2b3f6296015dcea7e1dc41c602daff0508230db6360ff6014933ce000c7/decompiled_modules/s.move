module 0x7bffb2b3f6296015dcea7e1dc41c602daff0508230db6360ff6014933ce000c7::s {
    struct FlashLoanEvent<phantom T0> has copy, drop {
        loan_coin: u64,
        repay_coin: u64,
    }

    struct FlashLoan<phantom T0> {
        loan_coin_amount: u64,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        coin_reserve: 0x2::balance::Balance<T0>,
    }

    public fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id           : 0x2::object::new(arg0),
            coin_reserve : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    fun assert_wl(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x284b1f9aa264cd1c4ccfcfc4a790d9ad7fd0d4c15793aa261d75021e79ec64e || 0x2::tx_context::sender(arg0) == @0x89e722aac3c0c5f4eaa07e23d267ad3a7e7603002fb915097bfdb7eff832ea2f || 0x2::tx_context::sender(arg0) == @0xe33abbc55fd28c906926fb0e9a0d4be25bbe268d3e0e9468d0d5972ef81e68e6 || 0x2::tx_context::sender(arg0) == @0x5d3ee35ea448dff7f5413b2892ab891b29a3f28c7dc69e668fc04c90934b802c || 0x2::tx_context::sender(arg0) == @0x3ba7a1b459baf985a224f358c9b2c5f0390825130aa7614ec964c62037e73449 || 0x2::tx_context::sender(arg0) == @0x9333c5d724a000bc2f8c92a22db08f369811773d2f321cfe7b8ca611b6cbb8d1, 101);
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.coin_reserve, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun loan<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoan<T0>) {
        let v0 = FlashLoan<T0>{loan_coin_amount: arg1};
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_reserve, arg1), arg2), v0)
    }

    public fun repay<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: FlashLoan<T0>) {
        let FlashLoan { loan_coin_amount: v0 } = arg2;
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 >= v0, 104);
        0x2::balance::join<T0>(&mut arg0.coin_reserve, 0x2::coin::into_balance<T0>(arg1));
        let v2 = FlashLoanEvent<T0>{
            loan_coin  : v0,
            repay_coin : v1,
        };
        0x2::event::emit<FlashLoanEvent<T0>>(v2);
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_wl(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_reserve, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun withdraw_batch<T0>(arg0: &mut Vault<T0>, arg1: vector<u64>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_wl(arg3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_reserve, *0x1::vector::borrow<u64>(&arg1, v0)), arg3), *0x1::vector::borrow<address>(&arg2, v0));
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

