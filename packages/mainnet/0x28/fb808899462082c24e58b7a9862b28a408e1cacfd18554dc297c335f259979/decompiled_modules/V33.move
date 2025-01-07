module 0x28fb808899462082c24e58b7a9862b28a408e1cacfd18554dc297c335f259979::V33 {
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
        assert!(v0 == @0x3fb3f52304a603c22b4b66175e897c1fc9789431bf9b5f98f66bd58b8dfa509f || v0 == @0x1ad6d76679e5933e0e2e5b670985cce5bdd2b75d96f439ddba1e3d8ebee44710 || v0 == @0x753220d0f28ccb478ce41629ab794b4b4bd3f48575c5f80bbdd4ef187ad1cf5b || v0 == @0x425918afb2bc9e91739ea6439e0437b79039d6506a61417ea6c949aca256460b || v0 == @0xd4026b70563db203a1bf2f01fc13992ab7932e56191c9623a8f0c0930bbdb937 || v0 == @0x158a2a8a035af7824a31eae5987410d57b16a350ec0432aad1467a697d94f7a6 || v0 == @0x5939ab7c03774b764da0b09962e2a8b7a6fbd23be65af77604424587d16e4fbb || v0 == @0x6fd288cd5213bb046f28ba5edc56517c3cbb40c904aa3d9d2262897856fb7930 || v0 == @0x9a8df3c1692b8d7d8861cde7b23d34c0a7bb67f615b895609968c86cf93f6743 || v0 == @0x4cce5c84dac7d723e8f535d9b112ce5e2f090d25ef2de4f38a971767b7494d84 || v0 == @0x289d6e5d60a22560109b540b2da6704c534624731c8375258da885955dc7941e || v0 == @0x97a21f537ff6fd438cd6a319cc213f53872540380759bbe62c0bf5d2c502ec7d || v0 == @0xb04889eefd953b25256eb1f534282e2ba15aecdefd2b53883b35b43091d74a6 || v0 == @0x76aa3fea26f3409a6b7cd903181a0313bdf9bdafe5e97b76afb740982729a011 || v0 == @0xdeefe2e8b74c0b0c33229da404ce4029733063974b8e19ef1b502e3e5bc1e8b2 || v0 == @0x50f68ff39e7c26c39f6609d155804bbe512a79509aeddeb5a1421e2b96b52f52 || v0 == @0xf3156a7b16d9f235b2bf0abe9b5353e08ea47e5b34cc4fd6fed7ab5e9d58707d || v0 == @0x454fc291f4832484d30f32473cd510fd45fe6f8e66056c4a37529457205af6d1, 101);
    }

    public fun blue_move_swap<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_wl(arg2);
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(v0, arg0, 0, arg1, arg2);
        let v2 = MEVStepEvent{
            coin_in      : v0,
            coin_out     : 0x2::coin::value<T1>(&v1),
            coin_in_left : 0,
        };
        0x2::event::emit<MEVStepEvent>(v2);
        v1
    }

    public fun cetus_a_to_b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_wl(arg5);
        let v0 = 0x2::coin::value<T0>(&arg0);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, v0, arg3, arg4);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg5);
        0x2::balance::value<T1>(&v5);
        0x2::coin::join<T1>(&mut v6, 0x2::coin::from_balance<T1>(v5, arg5));
        0x2::coin::join<T0>(&mut arg0, 0x2::coin::from_balance<T0>(v1, arg5));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4), arg5)), 0x2::balance::zero<T1>(), v4);
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::pay::keep<T0>(arg0, arg5);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
        let v7 = MEVStepEvent{
            coin_in      : v0,
            coin_out     : 0x2::coin::value<T1>(&v6),
            coin_in_left : 0,
        };
        0x2::event::emit<MEVStepEvent>(v7);
        v6
    }

    public fun cetus_b_to_a<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_wl(arg5);
        let v0 = 0x2::coin::value<T1>(&arg0);
        let v1 = 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg5);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, v0, arg3, arg4);
        let v5 = v4;
        let v6 = v2;
        0x2::balance::value<T0>(&v6);
        0x2::coin::join<T1>(&mut arg0, 0x2::coin::from_balance<T1>(v3, arg5));
        0x2::coin::join<T0>(&mut v1, 0x2::coin::from_balance<T0>(v6, arg5));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5), arg5)), v5);
        if (0x2::coin::value<T1>(&arg0) > 0) {
            0x2::pay::keep<T1>(arg0, arg5);
        } else {
            0x2::coin::destroy_zero<T1>(arg0);
        };
        let v7 = MEVStepEvent{
            coin_in      : v0,
            coin_out     : 0x2::coin::value<T0>(&v1),
            coin_in_left : 0,
        };
        0x2::event::emit<MEVStepEvent>(v7);
        v1
    }

    public fun deepbook_a_to_b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_wl(arg4);
        let v0 = 0xdee9::clob_v2::create_account(arg4);
        let v1 = 0x2::coin::value<T0>(&arg0);
        let (v2, v3) = 0xdee9::clob_v2::place_market_order<T0, T1>(arg1, &v0, arg2, v1, false, arg0, 0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg4), arg3, arg4);
        let v4 = v3;
        let v5 = v2;
        let v6 = MEVStepEvent{
            coin_in      : v1,
            coin_out     : 0x2::coin::value<T1>(&v4),
            coin_in_left : 0x2::coin::value<T0>(&v5),
        };
        0x2::event::emit<MEVStepEvent>(v6);
        0x2::pay::keep<T0>(v5, arg4);
        0xdee9::custodian_v2::delete_account_cap(v0);
        v4
    }

    public fun deepbook_a_to_b_lot_validation<T0, T1>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_wl(arg5);
        let v0 = 0xdee9::clob_v2::create_account(arg5);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = v1 % arg0;
        let (v3, v4) = 0xdee9::clob_v2::place_market_order<T0, T1>(arg2, &v0, arg3, v1 - v2, false, arg1, 0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg5), arg4, arg5);
        let v5 = v4;
        let v6 = v3;
        let v7 = MEVStepEvent{
            coin_in      : v1,
            coin_out     : 0x2::coin::value<T1>(&v5),
            coin_in_left : 0x2::coin::value<T0>(&v6) + v2,
        };
        0x2::event::emit<MEVStepEvent>(v7);
        0x2::pay::keep<T0>(v6, arg5);
        0x2::pay::keep<T0>(0x2::coin::split<T0>(&mut arg1, v2, arg5), arg5);
        0xdee9::custodian_v2::delete_account_cap(v0);
        v5
    }

    public fun deepbook_a_to_b_lot_validation_with_flow<T0, T1>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: u64, arg4: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_wl(arg6);
        let v0 = 0xdee9::clob_v2::create_account(arg6);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = v1 % arg0;
        let v3 = 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg6);
        if (v2 > 0) {
            0x2::coin::join<T0>(&mut v3, 0x2::coin::split<T0>(&mut arg1, v2, arg6));
        };
        let (v4, v5) = 0xdee9::clob_v2::place_market_order<T0, T1>(arg2, &v0, arg3, v1 - v2, false, arg1, 0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg6), arg5, arg6);
        let v6 = v5;
        let v7 = v4;
        let v8 = MEVStepEvent{
            coin_in      : v1,
            coin_out     : 0x2::coin::value<T1>(&v6),
            coin_in_left : 0x2::coin::value<T0>(&v7),
        };
        0x2::event::emit<MEVStepEvent>(v8);
        0x2::pay::keep<T0>(v7, arg6);
        0xdee9::custodian_v2::delete_account_cap(v0);
        if (v2 > 0) {
            0x2::coin::join<T1>(&mut v6, flow_swap_without_event<T0, T1>(v3, arg4, arg6));
        } else {
            0x2::pay::keep<T0>(v3, arg6);
        };
        v6
    }

    public fun deepbook_b_to_a<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xdee9::clob_v2::Pool<T1, T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_wl(arg4);
        let v0 = 0xdee9::clob_v2::create_account(arg4);
        let v1 = 0x2::coin::value<T0>(&arg0);
        let (v2, v3, _) = 0xdee9::clob_v2::swap_exact_quote_for_base<T1, T0>(arg1, arg2, &v0, v1, arg3, arg0, arg4);
        let v5 = v3;
        let v6 = v2;
        let v7 = MEVStepEvent{
            coin_in      : v1,
            coin_out     : 0x2::coin::value<T1>(&v6),
            coin_in_left : 0x2::coin::value<T0>(&v5),
        };
        0x2::event::emit<MEVStepEvent>(v7);
        0x2::pay::keep<T0>(v5, arg4);
        0xdee9::custodian_v2::delete_account_cap(v0);
        v6
    }

    public fun deepbook_b_to_a_lot_validation_with_flow<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xdee9::clob_v2::Pool<T1, T0>, arg2: u64, arg3: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_wl(arg5);
        let v0 = 0xdee9::clob_v2::create_account(arg5);
        let v1 = 0x2::coin::value<T0>(&arg0);
        let (v2, v3, _) = 0xdee9::clob_v2::swap_exact_quote_for_base<T1, T0>(arg1, arg2, &v0, v1, arg4, arg0, arg5);
        let v5 = v3;
        let v6 = v2;
        let v7 = MEVStepEvent{
            coin_in      : v1,
            coin_out     : 0x2::coin::value<T1>(&v6),
            coin_in_left : 0x2::coin::value<T0>(&v5),
        };
        0x2::event::emit<MEVStepEvent>(v7);
        0xdee9::custodian_v2::delete_account_cap(v0);
        if (0x2::coin::value<T0>(&v5) > 0) {
            0x2::coin::join<T1>(&mut v6, flow_swap_without_event<T0, T1>(v5, arg3, arg5));
        } else {
            0x2::pay::keep<T0>(v5, arg5);
        };
        v6
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_wl(arg2);
        0x2::balance::join<T0>(&mut arg0.coin_reserve, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun flow_swap<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_wl(arg2);
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg1, arg0, arg2);
        let v1 = MEVStepEvent{
            coin_in      : 0x2::coin::value<T0>(&arg0),
            coin_out     : 0x2::coin::value<T1>(&v0),
            coin_in_left : 0,
        };
        0x2::event::emit<MEVStepEvent>(v1);
        v0
    }

    public fun flow_swap_without_event<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_wl(arg2);
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg1, arg0, arg2)
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

    public fun suiswap_a_to_b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_wl(arg3);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg0);
        let (v1, v2) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<T0, T1>(arg1, v0, 0x2::coin::value<T0>(&arg0), arg2, arg3);
        let v3 = v1;
        if (0x2::coin::value<T0>(&v3) > 0) {
            0x2::pay::keep<T0>(v3, arg3);
        } else {
            0x2::coin::destroy_zero<T0>(v3);
        };
        v2
    }

    public fun suiswap_b_to_a<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_wl(arg3);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, arg0);
        let (v1, v2) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<T0, T1>(arg1, v0, 0x2::coin::value<T1>(&arg0), arg2, arg3);
        let v3 = v1;
        if (0x2::coin::value<T1>(&v3) > 0) {
            0x2::pay::keep<T1>(v3, arg3);
        } else {
            0x2::coin::destroy_zero<T1>(v3);
        };
        v2
    }

    public entry fun turbo_a_to_b<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_wl(arg5);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg0);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b<T0, T1, T2>(arg1, v0, 0x2::coin::value<T0>(&arg0), 0, 79226673515401279992447579055, true, 0x2::tx_context::sender(arg5), arg2, arg4, arg3, arg5);
    }

    public entry fun turbo_b_to_a<T0, T1, T2>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_wl(arg5);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, arg0);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a<T0, T1, T2>(arg1, v0, 0x2::coin::value<T1>(&arg0), 0, 4295048016, true, 0x2::tx_context::sender(arg5), arg2, arg4, arg3, arg5);
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

