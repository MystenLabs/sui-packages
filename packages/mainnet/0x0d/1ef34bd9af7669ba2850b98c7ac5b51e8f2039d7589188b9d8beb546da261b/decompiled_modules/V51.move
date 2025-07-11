module 0xd1ef34bd9af7669ba2850b98c7ac5b51e8f2039d7589188b9d8beb546da261b::V51 {
    struct AccessList has store, key {
        id: 0x2::object::UID,
        list: vector<address>,
    }

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

    struct MEVEvent has copy, drop, store {
        amountOut: u64,
    }

    struct MEVStepEvent has copy, drop, store {
        coin_in: u64,
        coin_out: u64,
        coin_in_left: u64,
    }

    fun assert_wl(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = if (v0 == @0x3fb3f52304a603c22b4b66175e897c1fc9789431bf9b5f98f66bd58b8dfa509f) {
            true
        } else if (v0 == @0x1ad6d76679e5933e0e2e5b670985cce5bdd2b75d96f439ddba1e3d8ebee44710) {
            true
        } else if (v0 == @0x753220d0f28ccb478ce41629ab794b4b4bd3f48575c5f80bbdd4ef187ad1cf5b) {
            true
        } else if (v0 == @0x425918afb2bc9e91739ea6439e0437b79039d6506a61417ea6c949aca256460b) {
            true
        } else if (v0 == @0xd4026b70563db203a1bf2f01fc13992ab7932e56191c9623a8f0c0930bbdb937) {
            true
        } else if (v0 == @0x158a2a8a035af7824a31eae5987410d57b16a350ec0432aad1467a697d94f7a6) {
            true
        } else if (v0 == @0x5939ab7c03774b764da0b09962e2a8b7a6fbd23be65af77604424587d16e4fbb) {
            true
        } else if (v0 == @0x6fd288cd5213bb046f28ba5edc56517c3cbb40c904aa3d9d2262897856fb7930) {
            true
        } else if (v0 == @0x9a8df3c1692b8d7d8861cde7b23d34c0a7bb67f615b895609968c86cf93f6743) {
            true
        } else if (v0 == @0x4cce5c84dac7d723e8f535d9b112ce5e2f090d25ef2de4f38a971767b7494d84) {
            true
        } else if (v0 == @0x289d6e5d60a22560109b540b2da6704c534624731c8375258da885955dc7941e) {
            true
        } else if (v0 == @0x97a21f537ff6fd438cd6a319cc213f53872540380759bbe62c0bf5d2c502ec7d) {
            true
        } else if (v0 == @0xb04889eefd953b25256eb1f534282e2ba15aecdefd2b53883b35b43091d74a6) {
            true
        } else if (v0 == @0x76aa3fea26f3409a6b7cd903181a0313bdf9bdafe5e97b76afb740982729a011) {
            true
        } else if (v0 == @0xdeefe2e8b74c0b0c33229da404ce4029733063974b8e19ef1b502e3e5bc1e8b2) {
            true
        } else if (v0 == @0x50f68ff39e7c26c39f6609d155804bbe512a79509aeddeb5a1421e2b96b52f52) {
            true
        } else if (v0 == @0xf3156a7b16d9f235b2bf0abe9b5353e08ea47e5b34cc4fd6fed7ab5e9d58707d) {
            true
        } else {
            v0 == @0x454fc291f4832484d30f32473cd510fd45fe6f8e66056c4a37529457205af6d1
        };
        assert!(v1, 101);
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_wl(arg2);
        0x2::balance::join<T0>(&mut arg0.coin_reserve, 0x2::coin::into_balance<T0>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<0x2::sui::SUI>{
            id           : 0x2::object::new(arg0),
            coin_reserve : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Vault<0x2::sui::SUI>>(v0);
    }

    public entry fun keep_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert_wl(arg3);
        let v0 = 0x2::coin::value<T0>(&arg0);
        if (arg2) {
            if (v0 < arg1) {
                abort 222
            };
        };
        let v1 = MEVEvent{amountOut: v0};
        0x2::event::emit<MEVEvent>(v1);
        0x2::pay::keep<T0>(arg0, arg3);
    }

    public fun kriya_a_to_b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_wl(arg3);
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg1, arg0, v0, arg2, arg3);
        let v2 = MEVStepEvent{
            coin_in      : v0,
            coin_out     : 0x2::coin::value<T1>(&v1),
            coin_in_left : 0,
        };
        0x2::event::emit<MEVStepEvent>(v2);
        v1
    }

    public fun kriya_b_to_a<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_wl(arg3);
        let v0 = 0x2::coin::value<T1>(&arg0);
        let v1 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg1, arg0, v0, arg2, arg3);
        let v2 = MEVStepEvent{
            coin_in      : v0,
            coin_out     : 0x2::coin::value<T0>(&v1),
            coin_in_left : 0,
        };
        0x2::event::emit<MEVStepEvent>(v2);
        v1
    }

    public fun kriya_v3_a_to_b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_wl(arg5);
        let v0 = 0x2::coin::value<T0>(&arg0);
        let (v1, v2, v3) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg1, true, true, v0, arg2, arg3, arg4, arg5);
        let v4 = v3;
        let v5 = 0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg5);
        let (v6, _) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::swap_receipt_debts(&v4);
        0x2::coin::join<T1>(&mut v5, 0x2::coin::from_balance<T1>(v2, arg5));
        0x2::coin::join<T0>(&mut arg0, 0x2::coin::from_balance<T0>(v1, arg5));
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg1, v4, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg0, v6, arg5)), 0x2::balance::zero<T1>(), arg4, arg5);
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::pay::keep<T0>(arg0, arg5);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
        let v8 = MEVStepEvent{
            coin_in      : v0,
            coin_out     : 0x2::coin::value<T1>(&v5),
            coin_in_left : 0,
        };
        0x2::event::emit<MEVStepEvent>(v8);
        v5
    }

    public fun kriya_v3_b_to_a<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_wl(arg5);
        let v0 = 0x2::coin::value<T1>(&arg0);
        let v1 = 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg5);
        let (v2, v3, v4) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg1, false, true, v0, arg2, arg3, arg4, arg5);
        let v5 = v4;
        let (_, v7) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::swap_receipt_debts(&v5);
        0x2::coin::join<T1>(&mut arg0, 0x2::coin::from_balance<T1>(v3, arg5));
        0x2::coin::join<T0>(&mut v1, 0x2::coin::from_balance<T0>(v2, arg5));
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg1, v5, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg0, v7, arg5)), arg4, arg5);
        if (0x2::coin::value<T1>(&arg0) > 0) {
            0x2::pay::keep<T1>(arg0, arg5);
        } else {
            0x2::coin::destroy_zero<T1>(arg0);
        };
        let v8 = MEVStepEvent{
            coin_in      : v0,
            coin_out     : 0x2::coin::value<T0>(&v1),
            coin_in_left : 0,
        };
        0x2::event::emit<MEVStepEvent>(v8);
        v1
    }

    public fun loan<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoan<T0>) {
        assert_wl(arg2);
        let v0 = FlashLoan<T0>{loan_coin_amount: arg1};
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_reserve, arg1), arg2), v0)
    }

    public fun repay<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: FlashLoan<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_wl(arg3);
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

    public fun turbo_helper<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_wl(arg2);
        if (0x2::coin::value<T1>(&arg1) > 0) {
            0x2::pay::keep<T1>(arg1, arg2);
        } else {
            0x2::coin::destroy_zero<T1>(arg1);
        };
        arg0
    }

    public fun withdraw_all<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_wl(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_reserve, 0x2::balance::value<T0>(&mut arg0.coin_reserve)), arg1), @0x454fc291f4832484d30f32473cd510fd45fe6f8e66056c4a37529457205af6d1);
    }

    // decompiled from Move bytecode v6
}

