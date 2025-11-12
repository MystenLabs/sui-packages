module 0xb3058839f43fc16ed0f3a63587648d6b65fc68dc388bf4d1cdc6a2ef0b1de753::para {
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

    public fun assert_balance_threshold<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 6);
    }

    public fun assert_profitable(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!(is_profitable(arg0, arg1, arg2, arg3), 5);
    }

    public fun assert_repayment_balances<T0, T1>(arg0: &0x2::balance::Balance<T0>, arg1: &0x2::balance::Balance<T1>, arg2: u64, arg3: u64) {
        assert!(validate_repayment_balances<T0, T1>(arg0, arg1, arg2, arg3), 2);
    }

    public fun balance_to_coin<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(arg0, arg1)
    }

    public fun balance_value<T0>(arg0: &0x2::balance::Balance<T0>) : u64 {
        0x2::balance::value<T0>(arg0)
    }

    public fun bootstrap(arg0: &mut 0x2::tx_context::TxContext) : (AdminCap, BotConfig) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = BotConfig{
            id  : 0x2::object::new(arg0),
            bot : 0x2::tx_context::sender(arg0),
        };
        (v0, v1)
    }

    public fun calculate_min_profitable_output(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg0 + arg1 + arg0 * arg2 / 10000
    }

    public fun calculate_profit_after_repayment<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) : u64 {
        let v0 = 0x2::balance::value<T0>(arg0);
        if (v0 > arg1) {
            v0 - arg1
        } else {
            0
        }
    }

    public fun calculate_repayment(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128);
        let v1 = v0 + v0 * (arg1 as u128) / 10000;
        assert!(v1 <= 18446744073709551615, 4);
        (v1 as u64)
    }

    public fun check_balance_threshold<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) : bool {
        0x2::balance::value<T0>(arg0) >= arg1
    }

    public fun coin_to_balance<T0>(arg0: 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(arg0)
    }

    public fun extract_profit<T0>(arg0: &BotConfig, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        assert!(0x2::tx_context::sender(arg3) == arg0.bot, 1);
        let v0 = 0x2::balance::value<T0>(arg1);
        assert!(v0 >= arg2, 2);
        let v1 = v0 - arg2;
        if (v1 == 0) {
            0x1::option::none<0x2::coin::Coin<T0>>()
        } else {
            0x1::option::some<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg1, v1), arg3))
        }
    }

    public fun flash_borrow<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool, arg3: bool, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun identity(arg0: u64) : u64 {
        arg0
    }

    public fun is_profitable(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        if (arg0 <= arg1) {
            return false
        };
        arg0 - arg1 > arg2 + arg1 * arg3 / 10000
    }

    public fun is_zero<T0>(arg0: &0x2::balance::Balance<T0>) : bool {
        0x2::balance::value<T0>(arg0) == 0
    }

    public fun merge_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(arg0, arg1);
    }

    public fun record_finish(arg0: &BotConfig, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.bot, 1);
        let v0 = ArbFinishEvent{
            path          : arg1,
            profit_amount : arg2,
        };
        0x2::event::emit<ArbFinishEvent>(v0);
    }

    public fun record_start(arg0: &BotConfig, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.bot, 1);
        let v0 = ArbStartEvent{
            path      : arg1,
            amount_in : arg2,
        };
        0x2::event::emit<ArbStartEvent>(v0);
    }

    public fun repay_flash<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun set_bot(arg0: AdminCap, arg1: &mut BotConfig, arg2: address) : AdminCap {
        arg1.bot = arg2;
        arg0
    }

    public fun split_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(arg0, arg1)
    }

    public fun split_repayment_and_profit<T0>(arg0: &BotConfig, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x1::option::Option<0x2::coin::Coin<T0>>) {
        assert!(0x2::tx_context::sender(arg3) == arg0.bot, 1);
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 >= arg2, 2);
        let v1 = v0 - arg2;
        if (v1 == 0) {
            (arg1, 0x1::option::none<0x2::coin::Coin<T0>>())
        } else {
            (arg1, 0x1::option::some<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1, v1), arg3)))
        }
    }

    public fun transfer_balance_to<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public fun turbos_flash_borrow<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: bool, arg2: u128, arg3: bool, arg4: address, arg5: u128, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, arg4, arg1, arg2, arg3, arg5, arg6, arg7, arg8)
    }

    public fun turbos_repay_flash<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun validate_repayment_balances<T0, T1>(arg0: &0x2::balance::Balance<T0>, arg1: &0x2::balance::Balance<T1>, arg2: u64, arg3: u64) : bool {
        0x2::balance::value<T0>(arg0) >= arg2 && 0x2::balance::value<T1>(arg1) >= arg3
    }

    // decompiled from Move bytecode v6
}

