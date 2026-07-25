module 0x2a66d62630abffb30e4eeaef8d23feb2f3c1c4d0277c18903edc00a0e213d5ff::forward {
    struct Offer has store, key {
        id: 0x2::object::UID,
        opener: address,
        opener_is_long: bool,
        margin_mist: u64,
        asset_price_id: vector<u8>,
        collateral: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Forward has store, key {
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

    struct OfferOpened has copy, drop {
        offer_id: address,
        opener: address,
        opener_is_long: bool,
        margin_mist: u64,
        asset_price_id: vector<u8>,
    }

    struct OfferCancelled has copy, drop {
        offer_id: address,
    }

    struct Opened has copy, drop {
        forward_id: address,
        long_addr: address,
        short_addr: address,
        net_margin_mist: u64,
        open_fee_mist: u64,
        entry_sui_price_wad: u256,
        entry_asset_price_wad: u256,
    }

    struct Settled has copy, drop {
        forward_id: address,
        long_payout_mist: u64,
        short_payout_mist: u64,
        settle_fee_mist: u64,
        exit_sui_price_wad: u256,
        exit_asset_price_wad: u256,
    }

    public fun join(arg0: Offer, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Forward {
        let Offer {
            id             : v0,
            opener         : v1,
            opener_is_long : v2,
            margin_mist    : v3,
            asset_price_id : v4,
            collateral     : v5,
        } = arg0;
        0x2::object::delete(v0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == v3, 0);
        assert!(feed_id_bytes(arg2) == x"23d7315113f5b1d3ba7a83604c44b94d79f4fd69af77f804fc7f920a6dc65744", 5);
        assert!(feed_id_bytes(arg3) == v4, 5);
        let v6 = read_price_wad(arg2, arg4);
        let v7 = read_price_wad(arg3, arg4);
        let (v8, v9) = apply_open_fee(v3, 10);
        let (_, v11) = apply_open_fee(v3, 10);
        let v12 = v5;
        let v13 = 0x2::balance::split<0x2::sui::SUI>(&mut v12, v9);
        let v14 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut v13, 0x2::balance::split<0x2::sui::SUI>(&mut v14, v11));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v13, arg5), @0xfc7c016c248cea871ba2b1262f577098b0aa59e750db48ea878a4891e34412d4);
        let v15 = quote_margin_usd_wad(v8, v6);
        let (v16, v17, v18, v19) = if (v2) {
            (v1, 0x2::tx_context::sender(arg5), v12, v14)
        } else {
            (0x2::tx_context::sender(arg5), v1, v14, v12)
        };
        let v20 = Forward{
            id                    : 0x2::object::new(arg5),
            entry_sui_price_wad   : v6,
            entry_asset_price_wad : v7,
            margin_usd_wad        : v15,
            notional_wad          : quote_notional_wad(v15, v7),
            long_collateral       : v18,
            short_collateral      : v19,
            long_addr             : v16,
            short_addr            : v17,
        };
        let v21 = Opened{
            forward_id            : 0x2::object::uid_to_address(&v20.id),
            long_addr             : v16,
            short_addr            : v17,
            net_margin_mist       : v8,
            open_fee_mist         : v9 + v11,
            entry_sui_price_wad   : v6,
            entry_asset_price_wad : v7,
        };
        0x2::event::emit<Opened>(v21);
        v20
    }

    public fun apply_open_fee(arg0: u64, arg1: u64) : (u64, u64) {
        let v0 = arg0 * arg1 / 10000;
        (arg0 - v0, v0)
    }

    public fun apply_settle_fee(arg0: u64, arg1: u64, arg2: u64, arg3: bool, arg4: u64) : (u64, u64, u64) {
        let v0 = if (arg3) {
            arg0 - arg2
        } else {
            arg1 - arg2
        };
        let v1 = v0 * arg4 / 10000;
        let (v2, v3) = if (arg3) {
            (arg0 - v1, arg1)
        } else {
            (arg0, arg1 - v1)
        };
        (v2, v3, v1)
    }

    public fun cancel_offer(arg0: Offer, arg1: &mut 0x2::tx_context::TxContext) {
        let Offer {
            id             : v0,
            opener         : v1,
            opener_is_long : _,
            margin_mist    : _,
            asset_price_id : _,
            collateral     : v5,
        } = arg0;
        let v6 = v0;
        assert!(0x2::tx_context::sender(arg1) == v1, 4);
        0x2::object::delete(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v5, arg1), v1);
        let v7 = OfferCancelled{offer_id: 0x2::object::uid_to_address(&v6)};
        0x2::event::emit<OfferCancelled>(v7);
    }

    fun feed_id_bytes(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : vector<u8> {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1)
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

    public fun offer_margin_mist(arg0: &Offer) : u64 {
        arg0.margin_mist
    }

    public fun offer_opener(arg0: &Offer) : address {
        arg0.opener
    }

    public fun open_offer(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: bool, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 5);
        let v1 = Offer{
            id             : 0x2::object::new(arg3),
            opener         : 0x2::tx_context::sender(arg3),
            opener_is_long : arg1,
            margin_mist    : v0,
            asset_price_id : arg2,
            collateral     : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
        };
        let v2 = OfferOpened{
            offer_id       : 0x2::object::uid_to_address(&v1.id),
            opener         : v1.opener,
            opener_is_long : arg1,
            margin_mist    : v0,
            asset_price_id : v1.asset_price_id,
        };
        0x2::event::emit<OfferOpened>(v2);
        0x2::transfer::share_object<Offer>(v1);
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
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg1, 120);
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
        assert!(feed_id_bytes(arg1) == x"23d7315113f5b1d3ba7a83604c44b94d79f4fd69af77f804fc7f920a6dc65744", 5);
        let v11 = read_price_wad(arg1, arg3);
        let v12 = read_price_wad(arg2, arg3);
        let v13 = quote_value_usd_wad(v4, v12);
        let v14 = 0x2::balance::value<0x2::sui::SUI>(&v9);
        let (v15, v16) = if (v13 >= v3) {
            (true, v13 - v3)
        } else {
            (false, v3 - v13)
        };
        let (v17, v18) = settle_split(v14, usd_wad_to_mist(v16, v11), v15);
        let (v19, v20, v21) = apply_settle_fee(v17, v18, v14, v15, 500);
        0x2::balance::join<0x2::sui::SUI>(&mut v9, v6);
        if (v21 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v9, arg4), @0xfc7c016c248cea871ba2b1262f577098b0aa59e750db48ea878a4891e34412d4);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v9, v19), arg4), v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v9, v20), arg4), v8);
        let v22 = Settled{
            forward_id           : 0x2::object::uid_to_address(&v10),
            long_payout_mist     : v19,
            short_payout_mist    : v20,
            settle_fee_mist      : v21,
            exit_sui_price_wad   : v11,
            exit_asset_price_wad : v12,
        };
        0x2::event::emit<Settled>(v22);
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

