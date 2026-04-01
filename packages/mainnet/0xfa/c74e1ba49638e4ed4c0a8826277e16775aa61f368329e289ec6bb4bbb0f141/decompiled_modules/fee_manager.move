module 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::fee_manager {
    struct FeeConfig has copy, drop, store {
        platform_fee_bps: u16,
        min_listing_price: u64,
    }

    struct FeeBreakdown has drop {
        total_amount: u64,
        platform_fee: u64,
        royalty_fee: u64,
        seller_proceeds: u64,
    }

    public fun calculate_fee_breakdown(arg0: u64, arg1: u16, arg2: u16) : FeeBreakdown {
        assert!(arg0 > 0, 1);
        let v0 = calculate_platform_fee(arg0, arg1);
        let v1 = calculate_royalty_fee(arg0, arg2);
        FeeBreakdown{
            total_amount    : arg0,
            platform_fee    : v0,
            royalty_fee     : v1,
            seller_proceeds : arg0 - v0 - v1,
        }
    }

    public fun calculate_platform_fee(arg0: u64, arg1: u16) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun calculate_royalty_fee(arg0: u64, arg1: u16) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public(friend) fun deposit_to_treasury(arg0: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun get_fee_breakdown_platform_fee(arg0: &FeeBreakdown) : u64 {
        arg0.platform_fee
    }

    public fun get_fee_breakdown_royalty_fee(arg0: &FeeBreakdown) : u64 {
        arg0.royalty_fee
    }

    public fun get_fee_breakdown_seller_proceeds(arg0: &FeeBreakdown) : u64 {
        arg0.seller_proceeds
    }

    public fun get_fee_breakdown_total(arg0: &FeeBreakdown) : u64 {
        arg0.total_amount
    }

    public fun get_min_listing_price(arg0: &FeeConfig) : u64 {
        arg0.min_listing_price
    }

    public fun get_platform_fee_bps(arg0: &FeeConfig) : u16 {
        arg0.platform_fee_bps
    }

    public fun get_treasury_balance(arg0: &0x2::balance::Balance<0x2::sui::SUI>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(arg0)
    }

    public fun max_platform_fee_bps() : u16 {
        1000
    }

    public(friend) fun new_fee_config(arg0: u16, arg1: u64) : FeeConfig {
        assert!(arg0 <= 1000, 0);
        FeeConfig{
            platform_fee_bps  : arg0,
            min_listing_price : arg1,
        }
    }

    public(friend) fun split_payment(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u16, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1);
        (0x2::coin::split<0x2::sui::SUI>(&mut arg0, calculate_platform_fee(v0, arg1), arg3), 0x2::coin::split<0x2::sui::SUI>(&mut arg0, calculate_royalty_fee(v0, arg2), arg3), arg0)
    }

    public(friend) fun update_min_listing_price(arg0: &mut FeeConfig, arg1: u64) {
        arg0.min_listing_price = arg1;
    }

    public(friend) fun update_platform_fee(arg0: &mut FeeConfig, arg1: u16) : u16 {
        assert!(arg1 <= 1000, 0);
        arg0.platform_fee_bps = arg1;
        arg0.platform_fee_bps
    }

    public fun validate_listing_price(arg0: u64, arg1: &FeeConfig) : bool {
        arg0 >= arg1.min_listing_price
    }

    public(friend) fun withdraw_from_treasury(arg0: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::balance::value<0x2::sui::SUI>(arg0) >= arg1, 2);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(arg0, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

