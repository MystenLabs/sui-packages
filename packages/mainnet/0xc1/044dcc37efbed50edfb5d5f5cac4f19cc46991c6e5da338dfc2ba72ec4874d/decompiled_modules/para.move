module 0xc1044dcc37efbed50edfb5d5f5cac4f19cc46991c6e5da338dfc2ba72ec4874d::para {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BotConfig has store, key {
        id: 0x2::object::UID,
        bot: address,
    }

    struct FlashLoanReceipt<phantom T0, phantom T1, phantom T2> has store {
        pool_id: address,
        loan_amount: u64,
        fee_amount: u64,
    }

    struct BalanceWrapper<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
    }

    struct ArbStartEvent has copy, drop, store {
        path: vector<u8>,
        amount_in: u64,
    }

    struct ArbFinishEvent has copy, drop, store {
        path: vector<u8>,
        profit_sui: u64,
    }

    struct FlashLoanEvent has copy, drop, store {
        pool_id: address,
        amount: u64,
        fee: u64,
    }

    struct SwapEvent has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
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

    public fun coin_to_balance<T0>(arg0: 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(arg0)
    }

    public fun flash_loan_base<T0, T1, T2>(arg0: &mut 0x2::object::UID, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, FlashLoanReceipt<T0, T1, T2>) {
        assert!(arg1 > 0, 5);
        let v0 = arg1 * 3 / 1000;
        let v1 = FlashLoanReceipt<T0, T1, T2>{
            pool_id     : 0x2::object::uid_to_address(arg0),
            loan_amount : arg1,
            fee_amount  : v0,
        };
        let v2 = FlashLoanEvent{
            pool_id : 0x2::object::uid_to_address(arg0),
            amount  : arg1,
            fee     : v0,
        };
        0x2::event::emit<FlashLoanEvent>(v2);
        (0x2::balance::zero<T0>(), v1)
    }

    public fun flash_loan_quote<T0, T1, T2>(arg0: &mut 0x2::object::UID, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, FlashLoanReceipt<T0, T1, T2>) {
        assert!(arg1 > 0, 5);
        let v0 = arg1 * 3 / 1000;
        let v1 = FlashLoanReceipt<T0, T1, T2>{
            pool_id     : 0x2::object::uid_to_address(arg0),
            loan_amount : arg1,
            fee_amount  : v0,
        };
        let v2 = FlashLoanEvent{
            pool_id : 0x2::object::uid_to_address(arg0),
            amount  : arg1,
            fee     : v0,
        };
        0x2::event::emit<FlashLoanEvent>(v2);
        (0x2::balance::zero<T1>(), v1)
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

    public fun mmt_a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x2::object::UID, arg2: &mut 0x2::object::UID, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::balance::destroy_zero<T0>(arg3);
        let v0 = SwapEvent{
            amount_in  : 0x2::balance::value<T0>(&arg3),
            amount_out : 0,
        };
        0x2::event::emit<SwapEvent>(v0);
        0x2::balance::zero<T1>()
    }

    public fun mmt_b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x2::object::UID, arg2: &mut 0x2::object::UID, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::balance::destroy_zero<T1>(arg3);
        let v0 = SwapEvent{
            amount_in  : 0x2::balance::value<T1>(&arg3),
            amount_out : 0,
        };
        0x2::event::emit<SwapEvent>(v0);
        0x2::balance::zero<T0>()
    }

    public fun move_balance_a_from_receipt<T0, T1, T2>(arg0: FlashLoanReceipt<T1, T0, T2>) : (0x2::balance::Balance<T0>, FlashLoanReceipt<T1, T0, T2>) {
        (0x2::balance::zero<T0>(), arg0)
    }

    public fun move_balance_b_from_receipt<T0, T1, T2>(arg0: FlashLoanReceipt<T0, T1, T2>) : (0x2::balance::Balance<T0>, FlashLoanReceipt<T0, T1, T2>) {
        (0x2::balance::zero<T0>(), arg0)
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

    public fun repay_loan_base<T0, T1, T2>(arg0: &mut 0x2::object::UID, arg1: 0x2::balance::Balance<T0>, arg2: FlashLoanReceipt<T0, T1, T2>) : 0x2::balance::Balance<T0> {
        let FlashLoanReceipt {
            pool_id     : _,
            loan_amount : v1,
            fee_amount  : v2,
        } = arg2;
        assert!(0x2::balance::value<T0>(&arg1) >= v1 + v2, 3);
        0x2::balance::destroy_zero<T0>(arg1);
        0x2::balance::zero<T0>()
    }

    public fun repay_loan_quote<T0, T1, T2>(arg0: &mut 0x2::object::UID, arg1: 0x2::balance::Balance<T1>, arg2: FlashLoanReceipt<T0, T1, T2>) : 0x2::balance::Balance<T1> {
        let FlashLoanReceipt {
            pool_id     : _,
            loan_amount : v1,
            fee_amount  : v2,
        } = arg2;
        assert!(0x2::balance::value<T1>(&arg1) >= v1 + v2, 3);
        0x2::balance::destroy_zero<T1>(arg1);
        0x2::balance::zero<T1>()
    }

    public fun set_bot(arg0: &AdminCap, arg1: &mut BotConfig, arg2: address) {
        arg1.bot = arg2;
    }

    public fun split_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(arg0, arg1)
    }

    public fun swap_with_min_out<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x2::object::UID, arg2: &mut 0x2::object::UID, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::balance::destroy_zero<T0>(arg3);
        let v0 = SwapEvent{
            amount_in  : 0x2::balance::value<T0>(&arg3),
            amount_out : 0,
        };
        0x2::event::emit<SwapEvent>(v0);
        0x2::balance::zero<T1>()
    }

    public fun tr<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun transfer_to<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    // decompiled from Move bytecode v6
}

