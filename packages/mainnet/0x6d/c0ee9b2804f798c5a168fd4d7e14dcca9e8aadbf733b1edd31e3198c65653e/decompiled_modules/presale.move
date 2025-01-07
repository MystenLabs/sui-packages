module 0x6dc0ee9b2804f798c5a168fd4d7e14dcca9e8aadbf733b1edd31e3198c65653e::presale {
    struct PresaleOwnerCap has key {
        id: 0x2::object::UID,
    }

    struct PresaleState<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        root: vector<u8>,
        exchange_rate: u64,
        private_start_time: u64,
        start_time: u64,
        period: u64,
        close_period: u64,
        service_fee: u64,
        current_presale_period: u64,
        private_sold_amount: u64,
        public_sold_amount: u64,
        fund_balance: 0x2::balance::Balance<T0>,
        is_private_sale_over: bool,
        is_presale_paused: bool,
        fund_coin_decimal: u64,
        reward_coin_decimal: u64,
        initial_rewards_amount: u64,
    }

    struct Recipient<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        presale_id: 0x2::object::ID,
        private_ft_balance: u64,
        ft_balance: u64,
        rt_balance: u64,
    }

    public fun assert_presale_finished<T0, T1>(arg0: &PresaleState<T0, T1>, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.start_time + arg0.current_presale_period, 12);
    }

    public fun assert_presale_going<T0, T1>(arg0: &PresaleState<T0, T1>, arg1: &0x2::clock::Clock) {
        assert!(!arg0.is_presale_paused, 10);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.start_time && v0 <= arg0.start_time + arg0.current_presale_period, 11);
    }

    entry fun create_sale<T0, T1>(arg0: &PresaleOwnerCap, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = PresaleState<T0, T1>{
            id                     : 0x2::object::new(arg11),
            root                   : arg1,
            exchange_rate          : arg2,
            private_start_time     : arg3,
            start_time             : arg4,
            period                 : arg5,
            close_period           : arg6,
            service_fee            : arg7,
            current_presale_period : arg5,
            private_sold_amount    : 0,
            public_sold_amount     : 0,
            fund_balance           : 0x2::balance::zero<T0>(),
            is_private_sale_over   : false,
            is_presale_paused      : false,
            fund_coin_decimal      : arg8,
            reward_coin_decimal    : arg9,
            initial_rewards_amount : arg10,
        };
        0x2::transfer::share_object<PresaleState<T0, T1>>(v0);
    }

    entry fun create_user_recipient<T0, T1>(arg0: &PresaleState<T0, T1>, arg1: &0x6dc0ee9b2804f798c5a168fd4d7e14dcca9e8aadbf733b1edd31e3198c65653e::vesting::VestingState<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<PresaleState<T0, T1>>(arg0) == 0x6dc0ee9b2804f798c5a168fd4d7e14dcca9e8aadbf733b1edd31e3198c65653e::vesting::presale_id<T1>(arg1), 14);
        let v0 = Recipient<T0, T1>{
            id                 : 0x2::object::new(arg2),
            presale_id         : 0x2::object::id<PresaleState<T0, T1>>(arg0),
            private_ft_balance : 0,
            ft_balance         : 0,
            rt_balance         : 0,
        };
        0x2::transfer::transfer<Recipient<T0, T1>>(v0, 0x2::tx_context::sender(arg2));
        0x6dc0ee9b2804f798c5a168fd4d7e14dcca9e8aadbf733b1edd31e3198c65653e::vesting::create_user_recipient<T1>(arg1, arg2);
    }

    entry fun deposit<T0, T1>(arg0: &mut PresaleState<T0, T1>, arg1: &mut Recipient<T0, T1>, arg2: &mut 0x6dc0ee9b2804f798c5a168fd4d7e14dcca9e8aadbf733b1edd31e3198c65653e::vesting::VestingState<T1>, arg3: &mut 0x6dc0ee9b2804f798c5a168fd4d7e14dcca9e8aadbf733b1edd31e3198c65653e::vesting::Recipient<T1>, arg4: u64, arg5: u64, arg6: vector<vector<u8>>, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert_presale_going<T0, T1>(arg0, arg8);
        assert!(0x2::object::id<PresaleState<T0, T1>>(arg0) == arg1.presale_id, 13);
        assert!(0x2::object::id<PresaleState<T0, T1>>(arg0) == 0x6dc0ee9b2804f798c5a168fd4d7e14dcca9e8aadbf733b1edd31e3198c65653e::vesting::presale_id<T1>(arg2), 14);
        0x6dc0ee9b2804f798c5a168fd4d7e14dcca9e8aadbf733b1edd31e3198c65653e::whitelist::verify(arg0.root, arg4, arg5, arg6, 0x2::tx_context::sender(arg9));
        let v0 = 0x2::clock::timestamp_ms(arg8);
        if (arg4 > 0) {
            let v1 = arg0.start_time + arg0.current_presale_period;
            assert!(v0 >= v1 - arg0.close_period && v0 <= v1, 5);
        };
        let v2 = 0x2::coin::value<T0>(&arg7);
        let v3 = arg1.ft_balance + v2;
        assert!(arg5 + arg1.private_ft_balance >= v3, 6);
        arg1.ft_balance = v3;
        arg1.rt_balance = arg1.rt_balance + v2 * 1000000 / arg0.exchange_rate * arg0.reward_coin_decimal / arg0.fund_coin_decimal;
        arg0.public_sold_amount = arg0.public_sold_amount + v2;
        0x2::balance::join<T0>(&mut arg0.fund_balance, 0x2::coin::into_balance<T0>(arg7));
        0x6dc0ee9b2804f798c5a168fd4d7e14dcca9e8aadbf733b1edd31e3198c65653e::vesting::update_recipient<T1>(arg2, arg3, arg1.rt_balance, arg8, arg9);
    }

    entry fun deposit_private<T0, T1>(arg0: &mut PresaleState<T0, T1>, arg1: &mut Recipient<T0, T1>, arg2: &mut 0x6dc0ee9b2804f798c5a168fd4d7e14dcca9e8aadbf733b1edd31e3198c65653e::vesting::VestingState<T1>, arg3: &mut 0x6dc0ee9b2804f798c5a168fd4d7e14dcca9e8aadbf733b1edd31e3198c65653e::vesting::Recipient<T1>, arg4: u64, arg5: u64, arg6: vector<vector<u8>>, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_private_sale_over, 7);
        assert!(0x2::object::id<PresaleState<T0, T1>>(arg0) == arg1.presale_id, 13);
        assert!(0x2::object::id<PresaleState<T0, T1>>(arg0) == 0x6dc0ee9b2804f798c5a168fd4d7e14dcca9e8aadbf733b1edd31e3198c65653e::vesting::presale_id<T1>(arg2), 14);
        0x6dc0ee9b2804f798c5a168fd4d7e14dcca9e8aadbf733b1edd31e3198c65653e::whitelist::verify(arg0.root, arg4, arg5, arg6, 0x2::tx_context::sender(arg9));
        0x2::clock::timestamp_ms(arg8);
        let v0 = 0x2::coin::value<T0>(&arg7);
        let v1 = arg1.ft_balance + v0;
        assert!(arg4 >= v1, 9);
        arg1.ft_balance = v1;
        arg1.rt_balance = arg1.rt_balance + v0 * 1000000 / arg0.exchange_rate;
        arg1.private_ft_balance = arg1.private_ft_balance + v0;
        arg0.private_sold_amount = arg0.private_sold_amount + v0;
        0x2::balance::join<T0>(&mut arg0.fund_balance, 0x2::coin::into_balance<T0>(arg7));
        0x6dc0ee9b2804f798c5a168fd4d7e14dcca9e8aadbf733b1edd31e3198c65653e::vesting::update_recipient<T1>(arg2, arg3, arg1.rt_balance, arg8, arg9);
    }

    entry fun end_private_sale<T0, T1>(arg0: &PresaleOwnerCap, arg1: &mut PresaleState<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.is_private_sale_over = true;
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (arg1.start_time < v0) {
            arg1.start_time = v0;
        };
    }

    entry fun extend_period<T0, T1>(arg0: &PresaleOwnerCap, arg1: &mut PresaleState<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.period = arg1.period + arg2;
        arg1.current_presale_period = arg1.current_presale_period + arg2;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PresaleOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PresaleOwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun pause_presale_by_emergency<T0, T1>(arg0: &PresaleOwnerCap, arg1: &mut PresaleState<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_presale_going<T0, T1>(arg1, arg2);
        arg1.is_presale_paused = true;
        arg1.current_presale_period = arg1.start_time + arg1.current_presale_period - 0x2::clock::timestamp_ms(arg2);
    }

    entry fun resume_presale<T0, T1>(arg0: &PresaleOwnerCap, arg1: &mut PresaleState<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_presale_paused, 3);
        arg1.is_presale_paused = false;
        arg1.start_time = 0x2::clock::timestamp_ms(arg2);
    }

    entry fun set_close_period<T0, T1>(arg0: &PresaleOwnerCap, arg1: &mut PresaleState<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.close_period = arg2;
    }

    entry fun set_start_time<T0, T1>(arg0: &PresaleOwnerCap, arg1: &mut PresaleState<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg1.start_time >= v0, 0);
        assert!(arg2 > v0, 1);
        arg1.start_time = arg2;
    }

    entry fun start_presale<T0, T1>(arg0: &PresaleOwnerCap, arg1: &mut PresaleState<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_private_sale_over, 2);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1.start_time > v0, 0);
        arg1.start_time = v0;
    }

    entry fun withdraw_fund<T0, T1>(arg0: &PresaleOwnerCap, arg1: &mut PresaleState<T0, T1>, arg2: address, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_presale_finished<T0, T1>(arg1, arg4);
        let v0 = 0x2::balance::value<T0>(&arg1.fund_balance);
        let v1 = v0 * arg1.service_fee / 1000000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.fund_balance, v1, arg5), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.fund_balance, v0 - v1, arg5), arg3);
    }

    entry fun withdraw_unsold<T0, T1>(arg0: &PresaleOwnerCap, arg1: &PresaleState<T0, T1>, arg2: &mut 0x6dc0ee9b2804f798c5a168fd4d7e14dcca9e8aadbf733b1edd31e3198c65653e::vesting::VestingState<T1>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_presale_finished<T0, T1>(arg1, arg4);
        assert!(0x2::object::id<PresaleState<T0, T1>>(arg1) == 0x6dc0ee9b2804f798c5a168fd4d7e14dcca9e8aadbf733b1edd31e3198c65653e::vesting::presale_id<T1>(arg2), 14);
        0x6dc0ee9b2804f798c5a168fd4d7e14dcca9e8aadbf733b1edd31e3198c65653e::vesting::withdraw_unsold<T1>(arg2, arg3, arg5);
    }

    // decompiled from Move bytecode v6
}

