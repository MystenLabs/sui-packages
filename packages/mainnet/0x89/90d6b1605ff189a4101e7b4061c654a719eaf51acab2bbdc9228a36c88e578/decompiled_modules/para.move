module 0x8990d6b1605ff189a4101e7b4061c654a719eaf51acab2bbdc9228a36c88e578::para {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BotConfig has store, key {
        id: 0x2::object::UID,
        bot: address,
    }

    struct ArbStartEvent has copy, drop, store {
        path: vector<u8>,
        amount_in: u64,
    }

    struct ArbFinishEvent has copy, drop, store {
        path: vector<u8>,
        profit_amount: u64,
    }

    public fun balance_to_coin<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(arg0, arg1)
    }

    public fun balance_value<T0>(arg0: &0x2::balance::Balance<T0>) : u64 {
        0x2::balance::value<T0>(arg0)
    }

    public fun bootstrap(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = BotConfig{
            id  : 0x2::object::new(arg0),
            bot : 0x2::tx_context::sender(arg0),
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

    public fun extract_profit<T0>(arg0: &BotConfig, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg3) == arg0.bot, 1);
        let v0 = 0x2::balance::value<T0>(arg1);
        assert!(v0 >= arg2, 2);
        let v1 = v0 - arg2;
        let v2 = if (v1 > 0) {
            0x2::balance::split<T0>(arg1, v1)
        } else {
            0x2::balance::zero<T0>()
        };
        0x2::coin::from_balance<T0>(v2, arg3)
    }

    public fun identity(arg0: u64) : u64 {
        arg0
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
            path          : arg1,
            profit_amount : arg2,
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

    public fun split_repayment_and_profit<T0>(arg0: &BotConfig, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::coin::Coin<T0>) {
        assert!(0x2::tx_context::sender(arg3) == arg0.bot, 1);
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 >= arg2, 2);
        let v1 = v0 - arg2;
        let v2 = if (v1 > 0) {
            0x2::balance::split<T0>(&mut arg1, v1)
        } else {
            0x2::balance::zero<T0>()
        };
        (arg1, 0x2::coin::from_balance<T0>(v2, arg3))
    }

    public fun transfer_balance_to<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    // decompiled from Move bytecode v6
}

