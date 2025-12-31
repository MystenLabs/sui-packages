module 0xdb1d6ee14a7fc1864361b87e194e893f5271b9f180ddf645b51b35301d0a854a::swap {
    struct FlashBuyBaseReceipt<phantom T0> {
        owe_quote_amount: u64,
        quote_fee: u64,
    }

    struct FlashSellBaseReceipt<phantom T0> {
        owe_base_amount: u64,
        base_fee: u64,
    }

    struct BuyBaseEvent has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        quote_in: u64,
        quote_fee: u64,
        base_out: u64,
        min_receive: u64,
    }

    struct SellBaseEvent has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        base_in: u64,
        base_fee: u64,
        quote_out: u64,
        min_receive: u64,
    }

    public fun flash_buy_base<T0, T1>(arg0: &mut 0xdb1d6ee14a7fc1864361b87e194e893f5271b9f180ddf645b51b35301d0a854a::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, FlashBuyBaseReceipt<0xdb1d6ee14a7fc1864361b87e194e893f5271b9f180ddf645b51b35301d0a854a::pool::Pool<T0, T1>>) {
        let v0 = compute_fee_amount(arg1, 0xdb1d6ee14a7fc1864361b87e194e893f5271b9f180ddf645b51b35301d0a854a::pool::get_fee_rate<T0, T1>(arg0));
        let v1 = arg1 - v0;
        let v2 = 0xdb1d6ee14a7fc1864361b87e194e893f5271b9f180ddf645b51b35301d0a854a::pool::flash_buy_base<T0, T1>(arg0, v1, arg3, arg4, arg5);
        assert!(0x2::balance::value<T0>(&v2) >= arg2, 1);
        let v3 = FlashBuyBaseReceipt<0xdb1d6ee14a7fc1864361b87e194e893f5271b9f180ddf645b51b35301d0a854a::pool::Pool<T0, T1>>{
            owe_quote_amount : v1,
            quote_fee        : v0,
        };
        let v4 = BuyBaseEvent{
            sender      : 0x2::tx_context::sender(arg6),
            pool_id     : 0x2::object::id<0xdb1d6ee14a7fc1864361b87e194e893f5271b9f180ddf645b51b35301d0a854a::pool::Pool<T0, T1>>(arg0),
            quote_in    : arg1,
            quote_fee   : v0,
            base_out    : 0x2::balance::value<T0>(&v2),
            min_receive : arg2,
        };
        0x2::event::emit<BuyBaseEvent>(v4);
        (v2, v3)
    }

    public fun flash_sell_base<T0, T1>(arg0: &mut 0xdb1d6ee14a7fc1864361b87e194e893f5271b9f180ddf645b51b35301d0a854a::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, FlashSellBaseReceipt<0xdb1d6ee14a7fc1864361b87e194e893f5271b9f180ddf645b51b35301d0a854a::pool::Pool<T0, T1>>) {
        let v0 = compute_fee_amount(arg1, 0xdb1d6ee14a7fc1864361b87e194e893f5271b9f180ddf645b51b35301d0a854a::pool::get_fee_rate<T0, T1>(arg0));
        let v1 = arg1 - v0;
        let v2 = 0xdb1d6ee14a7fc1864361b87e194e893f5271b9f180ddf645b51b35301d0a854a::pool::flash_sell_base<T0, T1>(arg0, v1, arg3, arg4, arg5);
        assert!(0x2::balance::value<T1>(&v2) >= arg2, 1);
        let v3 = FlashSellBaseReceipt<0xdb1d6ee14a7fc1864361b87e194e893f5271b9f180ddf645b51b35301d0a854a::pool::Pool<T0, T1>>{
            owe_base_amount : v1,
            base_fee        : v0,
        };
        let v4 = SellBaseEvent{
            sender      : 0x2::tx_context::sender(arg6),
            pool_id     : 0x2::object::id<0xdb1d6ee14a7fc1864361b87e194e893f5271b9f180ddf645b51b35301d0a854a::pool::Pool<T0, T1>>(arg0),
            base_in     : arg1,
            base_fee    : v0,
            quote_out   : 0x2::balance::value<T1>(&v2),
            min_receive : arg2,
        };
        0x2::event::emit<SellBaseEvent>(v4);
        (v2, v3)
    }

    fun compute_fee_amount(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 0xdb1d6ee14a7fc1864361b87e194e893f5271b9f180ddf645b51b35301d0a854a::constants::get_fee_dominator()
    }

    public fun repay_flash_buy_base<T0, T1>(arg0: &mut 0xdb1d6ee14a7fc1864361b87e194e893f5271b9f180ddf645b51b35301d0a854a::pool::Pool<T0, T1>, arg1: &mut 0x2::balance::Balance<T1>, arg2: FlashBuyBaseReceipt<0xdb1d6ee14a7fc1864361b87e194e893f5271b9f180ddf645b51b35301d0a854a::pool::Pool<T0, T1>>) {
        let FlashBuyBaseReceipt {
            owe_quote_amount : v0,
            quote_fee        : v1,
        } = arg2;
        assert!(v0 + v1 == 0x2::balance::value<T1>(arg1), 0);
        0xdb1d6ee14a7fc1864361b87e194e893f5271b9f180ddf645b51b35301d0a854a::pool::repay_reserve<T0, T1>(arg0, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(arg1, v0));
        0xdb1d6ee14a7fc1864361b87e194e893f5271b9f180ddf645b51b35301d0a854a::pool::contribute_fee<T0, T1>(arg0, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(arg1, v1));
    }

    public fun repay_flash_sell_base<T0, T1>(arg0: &mut 0xdb1d6ee14a7fc1864361b87e194e893f5271b9f180ddf645b51b35301d0a854a::pool::Pool<T0, T1>, arg1: &mut 0x2::balance::Balance<T0>, arg2: FlashSellBaseReceipt<0xdb1d6ee14a7fc1864361b87e194e893f5271b9f180ddf645b51b35301d0a854a::pool::Pool<T0, T1>>) {
        let FlashSellBaseReceipt {
            owe_base_amount : v0,
            base_fee        : v1,
        } = arg2;
        assert!(v0 + v1 == 0x2::balance::value<T0>(arg1), 0);
        0xdb1d6ee14a7fc1864361b87e194e893f5271b9f180ddf645b51b35301d0a854a::pool::repay_reserve<T0, T1>(arg0, 0x2::balance::split<T0>(arg1, v0), 0x2::balance::zero<T1>());
        0xdb1d6ee14a7fc1864361b87e194e893f5271b9f180ddf645b51b35301d0a854a::pool::contribute_fee<T0, T1>(arg0, 0x2::balance::split<T0>(arg1, v1), 0x2::balance::zero<T1>());
    }

    // decompiled from Move bytecode v6
}

