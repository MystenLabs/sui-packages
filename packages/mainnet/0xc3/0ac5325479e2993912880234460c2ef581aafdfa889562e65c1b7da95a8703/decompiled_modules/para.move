module 0xc30ac5325479e2993912880234460c2ef581aafdfa889562e65c1b7da95a8703::para {
    struct BotConfig has key {
        id: 0x2::object::UID,
        bot: address,
        fee_bps: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ArbStartEvent has copy, drop {
        path: vector<u8>,
        amount_in: u64,
    }

    struct ArbFinishEvent has copy, drop {
        path: vector<u8>,
        profit_sui: u64,
    }

    struct FlashLoanEvent has copy, drop {
        pool_id: address,
        amount: u64,
        fee: u64,
    }

    public fun destroy_zero<T0>(arg0: 0x2::balance::Balance<T0>) {
        0x2::balance::destroy_zero<T0>(arg0);
    }

    public fun balance_to_coin<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(arg0, arg1)
    }

    public fun balance_to_coin_wrapper<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(arg0, arg1)
    }

    public fun balance_value<T0>(arg0: &0x2::balance::Balance<T0>) : u64 {
        0x2::balance::value<T0>(arg0)
    }

    public fun bootstrap(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = BotConfig{
            id      : 0x2::object::new(arg0),
            bot     : 0x2::tx_context::sender(arg0),
            fee_bps : 10,
        };
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<BotConfig>(v1);
    }

    public fun calculate_repayment(arg0: u64, arg1: u64) : u64 {
        arg0 + arg0 * arg1 / 10000
    }

    public fun coin_to_balance<T0>(arg0: 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(arg0)
    }

    public fun coin_to_repayment_balance<T0>(arg0: 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(arg0)
    }

    public fun get_cetus_global_config_id() : address {
        @0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f
    }

    public fun get_cetus_package_id() : address {
        @0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb
    }

    public fun is_zero<T0>(arg0: &0x2::balance::Balance<T0>) : bool {
        0x2::balance::value<T0>(arg0) == 0
    }

    public fun merge_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(arg0, arg1);
    }

    public fun record_finish(arg0: &BotConfig, arg1: vector<u8>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.bot, 1);
        let v0 = ArbFinishEvent{
            path       : arg1,
            profit_sui : arg2,
        };
        0x2::event::emit<ArbFinishEvent>(v0);
    }

    public fun record_start(arg0: &BotConfig, arg1: vector<u8>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.bot, 1);
        let v0 = ArbStartEvent{
            path      : arg1,
            amount_in : arg2,
        };
        0x2::event::emit<ArbStartEvent>(v0);
    }

    public fun set_bot(arg0: &AdminCap, arg1: &mut BotConfig, arg2: address) {
        arg1.bot = arg2;
    }

    public fun split_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(arg0, arg1)
    }

    public fun split_repayment_and_profit<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::into_balance<T0>(arg0);
        assert!(0x2::balance::value<T0>(&v0) >= arg1, 3);
        (0x2::balance::split<T0>(&mut v0, arg1), 0x2::coin::from_balance<T0>(v0, arg2))
    }

    public fun split_repayment_and_profit_from_balance<T0>(arg0: &BotConfig, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::coin::Coin<T0>) {
        assert!(0x2::tx_context::sender(arg3) == arg0.bot, 1);
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 >= arg2, 3);
        let v1 = v0 - arg2;
        let v2 = if (v1 > 0) {
            0x2::balance::split<T0>(&mut arg1, v1)
        } else {
            0x2::balance::zero<T0>()
        };
        (arg1, 0x2::coin::from_balance<T0>(v2, arg3))
    }

    public fun transfer_to<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public fun transfer_to_sender<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

