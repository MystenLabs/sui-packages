module 0xe8e14d54703ef30c0629116690ffbbbe6066518f9ed5ba5bddd06ea9aa1c3083::forward {
    struct Forward has key {
        id: 0x2::object::UID,
        entry_sui_price_wad: u256,
        entry_asset_price_wad: u256,
        margin_usd_wad: u256,
        notional_wad: u256,
        long_collateral: 0x2::balance::Balance<0x2::sui::SUI>,
        short_collateral: 0x2::balance::Balance<0x2::sui::SUI>,
        long_addr: address,
        short_addr: address,
    }

    struct Opened has copy, drop {
        forward_id: address,
        long_addr: address,
        short_addr: address,
        margin_mist: u64,
        entry_sui_price_wad: u256,
        entry_asset_price_wad: u256,
    }

    struct Settled has copy, drop {
        forward_id: address,
        long_payout_mist: u64,
        short_payout_mist: u64,
        exit_sui_price_wad: u256,
        exit_asset_price_wad: u256,
    }

    public fun long_addr(arg0: &Forward) : address {
        arg0.long_addr
    }

    public fun margin_usd_wad(arg0: &Forward) : u256 {
        arg0.margin_usd_wad
    }

    fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun notional_wad(arg0: &Forward) : u256 {
        arg0.notional_wad
    }

    public fun open(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: address, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : Forward {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == v0, 0);
        let v1 = read_price_wad(arg4, arg6);
        let v2 = read_price_wad(arg5, arg6);
        let v3 = quote_margin_usd_wad(v0, v1);
        let v4 = Forward{
            id                    : 0x2::object::new(arg7),
            entry_sui_price_wad   : v1,
            entry_asset_price_wad : v2,
            margin_usd_wad        : v3,
            notional_wad          : quote_notional_wad(v3, v2),
            long_collateral       : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            short_collateral      : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            long_addr             : arg2,
            short_addr            : arg3,
        };
        let v5 = Opened{
            forward_id            : 0x2::object::uid_to_address(&v4.id),
            long_addr             : arg2,
            short_addr            : arg3,
            margin_mist           : v0,
            entry_sui_price_wad   : v1,
            entry_asset_price_wad : v2,
        };
        0x2::event::emit<Opened>(v5);
        v4
    }

    public fun pow10(arg0: u8) : u256 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun price_to_wad(arg0: u64, arg1: u8, arg2: bool) : u256 {
        assert!(arg2, 3);
        assert!(arg1 <= 18, 3);
        (arg0 as u256) * pow10(18 - arg1)
    }

    public fun quote_margin_usd_wad(arg0: u64, arg1: u256) : u256 {
        (arg0 as u256) * arg1 / 1000000000
    }

    public fun quote_notional_wad(arg0: u256, arg1: u256) : u256 {
        arg0 * 1000000000000000000 / arg1
    }

    public fun quote_value_usd_wad(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1 / 1000000000000000000
    }

    fun read_price_wad(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x2::clock::Clock) : u256 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg1, 60);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1), 2);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v2);
        let v4 = if (v3) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v2)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v2)
        };
        price_to_wad(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1), (v4 as u8), v3)
    }

    public fun settle(arg0: Forward, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let Forward {
            id                    : v0,
            entry_sui_price_wad   : _,
            entry_asset_price_wad : _,
            margin_usd_wad        : v3,
            notional_wad          : v4,
            long_collateral       : v5,
            short_collateral      : v6,
            long_addr             : v7,
            short_addr            : v8,
        } = arg0;
        let v9 = v5;
        let v10 = v0;
        0x2::object::delete(v10);
        let v11 = read_price_wad(arg1, arg3);
        let v12 = read_price_wad(arg2, arg3);
        let v13 = quote_value_usd_wad(v4, v12);
        let (v14, v15) = if (v13 >= v3) {
            (true, v13 - v3)
        } else {
            (false, v3 - v13)
        };
        let (v16, v17) = settle_split(0x2::balance::value<0x2::sui::SUI>(&v9), usd_wad_to_mist(v15, v11), v14);
        0x2::balance::join<0x2::sui::SUI>(&mut v9, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v9, v16), arg4), v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v9, arg4), v8);
        let v18 = Settled{
            forward_id           : 0x2::object::uid_to_address(&v10),
            long_payout_mist     : v16,
            short_payout_mist    : v17,
            exit_sui_price_wad   : v11,
            exit_asset_price_wad : v12,
        };
        0x2::event::emit<Settled>(v18);
    }

    public fun settle_split(arg0: u64, arg1: u64, arg2: bool) : (u64, u64) {
        let v0 = min_u64(arg1, arg0);
        if (arg2) {
            (arg0 + v0, arg0 - v0)
        } else {
            (arg0 - v0, arg0 + v0)
        }
    }

    public fun short_addr(arg0: &Forward) : address {
        arg0.short_addr
    }

    public fun usd_wad_to_mist(arg0: u256, arg1: u256) : u64 {
        ((arg0 * 1000000000 / arg1) as u64)
    }

    // decompiled from Move bytecode v7
}

