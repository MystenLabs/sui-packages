module 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::dutch {
    struct Auction<phantom T0, phantom T1> has store {
        start_ts_ms: u64,
        end_ts_ms: u64,
        price_config: PriceConfig,
        bid_index: u64,
        bids: 0x2::table::Table<u64, Bid<T1>>,
        ownerships: 0x2::table::Table<address, vector<u64>>,
        total_bid_size: u64,
        able_to_remove_bid: bool,
    }

    struct PriceConfig has store {
        decay_speed: u64,
        initial_price: u64,
        final_price: u64,
    }

    struct Bid<phantom T0> has store {
        price: u64,
        size: u64,
        ts_ms: u64,
        balance: 0x2::balance::Balance<T0>,
        bidder: address,
    }

    struct NewBid<phantom T0> has copy, drop {
        signer: address,
        bid_index: u64,
        price: u64,
        size: u64,
        balance: u64,
        ts_ms: u64,
    }

    struct RemoveBid<phantom T0> has copy, drop {
        signer: address,
        bid_index: u64,
        balance: u64,
        ts_ms: u64,
    }

    struct Delivery<phantom T0> has copy, drop {
        signer: address,
        bid_index: u64,
        delivery_price: u64,
        size: u64,
    }

    struct SwitchRemoveBidAbility<phantom T0> has copy, drop {
        signer: address,
        able_to_remove_bid: bool,
    }

    struct CloseAuction<phantom T0> has copy, drop {
        signer: address,
    }

    public fun new<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : Auction<T0, T1> {
        assert!(arg3 >= arg4 && arg3 > 0 && arg4 > 0, 6);
        assert!(arg2 > 0, 7);
        let v0 = PriceConfig{
            decay_speed   : arg2,
            initial_price : arg3,
            final_price   : arg4,
        };
        Auction<T0, T1>{
            start_ts_ms        : arg0,
            end_ts_ms          : arg1,
            price_config       : v0,
            bid_index          : 0,
            bids               : 0x2::table::new<u64, Bid<T1>>(arg6),
            ownerships         : 0x2::table::new<address, vector<u64>>(arg6),
            total_bid_size     : 0,
            able_to_remove_bid : arg5,
        }
    }

    public fun close<T0, T1>(arg0: &T0, arg1: Auction<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.end_ts_ms = 0x2::clock::timestamp_ms(arg2);
        let (v0, _, _, _, _, _, _) = delivery<T0, T1>(arg0, arg1, 0, 1, 1, 0, 0x1::option::none<u64>(), arg2, arg3);
        0x2::balance::destroy_zero<T1>(v0);
        let v7 = CloseAuction<T1>{signer: 0x2::tx_context::sender(arg3)};
        0x2::event::emit<CloseAuction<T1>>(v7);
    }

    fun decay_formula(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = arg0 - arg1;
        while (arg2 > 0) {
            let v1 = (v0 as u128) * ((arg5 - arg3) as u128) / ((arg4 - arg3) as u128);
            v0 = (v1 as u64);
            arg2 = arg2 - 1;
        };
        arg0 - v0
    }

    public fun delivery<T0, T1>(arg0: &T0, arg1: Auction<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::option::Option<u64>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::vec_map::VecMap<address, u64>, u64, u64, u64, u64, u64) {
        assert!(0x2::clock::timestamp_ms(arg7) > arg1.start_ts_ms, 4);
        let v0 = 0x2::balance::zero<T1>();
        let v1 = arg1.price_config.final_price;
        let v2 = 0;
        let v3 = 0;
        while (v3 < arg2 && v2 < arg1.bid_index) {
            if (0x2::table::contains<u64, Bid<T1>>(&arg1.bids, v2)) {
                let v4 = 0x2::table::borrow<u64, Bid<T1>>(&arg1.bids, v2);
                v3 = v3 + v4.size;
                v1 = v4.price;
            };
            v2 = v2 + 1;
        };
        if (v3 >= arg2) {
            v3 = arg2;
        } else {
            v1 = arg1.price_config.final_price;
        };
        let v5 = Delivery<T1>{
            signer         : 0x2::tx_context::sender(arg8),
            bid_index      : arg1.bid_index,
            delivery_price : v1,
            size           : arg2,
        };
        let v6 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg4);
        let v7 = if (0x1::option::is_some<u64>(&arg6)) {
            ((((v6 * 30) as u128) * (arg5 as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(*0x1::option::borrow<u64>(&arg6)) as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(4) as u128) * (v6 as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg3) as u128)) as u64)
        } else {
            v6 * 30 / 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(4)
        };
        let v8 = v1 * 1000 / 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(4);
        let v9 = if (v7 > v8) {
            v8
        } else {
            v7
        };
        let v10 = 0x2::vec_map::empty<address, u64>();
        let v11 = 0;
        let v12 = 0x2::balance::zero<T1>();
        while (!0x2::table::is_empty<u64, Bid<T1>>(&arg1.bids)) {
            if (0x2::table::contains<u64, Bid<T1>>(&arg1.bids, v11)) {
                let Bid {
                    price   : _,
                    size    : v14,
                    ts_ms   : _,
                    balance : v16,
                    bidder  : v17,
                } = 0x2::table::remove<u64, Bid<T1>>(&mut arg1.bids, v11);
                let v18 = v17;
                let v19 = v16;
                if (arg2 > 0) {
                    let v20 = if (v14 <= arg2) {
                        v14
                    } else {
                        arg2
                    };
                    let v21 = (((v9 as u128) * (v20 as u128) / (v6 as u128)) as u64);
                    0x2::balance::join<T1>(&mut v0, 0x2::balance::split<T1>(&mut v19, (((v1 as u128) * (v20 as u128) / (v6 as u128)) as u64)));
                    if (0x2::balance::value<T1>(&v19) > v21) {
                        0x2::balance::join<T1>(&mut v12, 0x2::balance::split<T1>(&mut v19, v21));
                        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v19, arg8), v18);
                    } else {
                        0x2::balance::join<T1>(&mut v12, v19);
                    };
                    if (0x2::vec_map::contains<address, u64>(&v10, &v18)) {
                        let v22 = 0x2::vec_map::get_mut<address, u64>(&mut v10, &v18);
                        *v22 = *v22 + v20;
                    } else {
                        0x2::vec_map::insert<address, u64>(&mut v10, v18, v20);
                    };
                    arg2 = arg2 - v20;
                } else {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v19, arg8), v18);
                };
            };
            v11 = v11 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v12, arg8), @0xb90d6bddf3df46fc5590d412d062c00145dfae1d31446c0f206c61edf02ef5ba);
        let Auction {
            start_ts_ms        : _,
            end_ts_ms          : _,
            price_config       : v25,
            bid_index          : _,
            bids               : v27,
            ownerships         : v28,
            total_bid_size     : _,
            able_to_remove_bid : _,
        } = arg1;
        let PriceConfig {
            decay_speed   : _,
            initial_price : _,
            final_price   : _,
        } = v25;
        0x2::table::destroy_empty<u64, Bid<T1>>(v27);
        0x2::table::drop<address, vector<u64>>(v28);
        0x2::event::emit<Delivery<T1>>(v5);
        (v0, v10, 0x2::balance::value<T1>(&v0), v1, v3, v9, 0x2::balance::value<T1>(&v12))
    }

    public fun get_auction_bids<T0, T1>(arg0: &Auction<T0, T1>) : &0x2::table::Table<u64, Bid<T1>> {
        &arg0.bids
    }

    public fun get_auction_period<T0, T1>(arg0: &Auction<T0, T1>) : (u64, u64) {
        (arg0.start_ts_ms, arg0.end_ts_ms)
    }

    public fun get_bid_index<T0, T1>(arg0: &Auction<T0, T1>) : u64 {
        arg0.bid_index
    }

    public fun get_decayed_price<T0, T1>(arg0: &Auction<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        decay_formula(arg0.price_config.initial_price, arg0.price_config.final_price, arg0.price_config.decay_speed, arg0.start_ts_ms, arg0.end_ts_ms, 0x2::clock::timestamp_ms(arg1))
    }

    public fun get_ownerships<T0, T1>(arg0: &Auction<T0, T1>) : &0x2::table::Table<address, vector<u64>> {
        &arg0.ownerships
    }

    public fun get_user_bid_info<T0, T1>(arg0: &Auction<T0, T1>, arg1: u64) : (u64, u64, u64, u64, address) {
        let v0 = 0x2::table::borrow<u64, Bid<T1>>(&arg0.bids, arg1);
        (v0.price, v0.size, v0.ts_ms, 0x2::balance::value<T1>(&v0.balance), v0.bidder)
    }

    public fun new_bid<T0, T1>(arg0: &mut Auction<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: vector<0x2::coin::Coin<T1>>, arg6: u64, arg7: 0x1::option::Option<u64>, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64, address) {
        let v0 = 0x2::clock::timestamp_ms(arg8);
        assert!(v0 >= arg0.start_ts_ms, 3);
        assert!(v0 <= arg0.end_ts_ms, 5);
        assert!(arg1 > 0, 0);
        assert!(arg1 / arg4 > 0 && arg1 % arg4 == 0, 8);
        let v1 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg2);
        let v2 = if (0x1::option::is_some<u64>(&arg7)) {
            ((((arg1 * 30 / 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(4)) as u128) * (arg6 as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(*0x1::option::borrow<u64>(&arg7)) as u128)) as u64)
        } else {
            arg1 * 30 / 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(4)
        };
        let v3 = get_decayed_price<T0, T1>(arg0, arg8);
        let v4 = (((v3 as u128) * (arg1 as u128) / (v1 as u128)) as u64);
        let v5 = v4 * 1000 / 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(4);
        let v6 = if (v2 > v5) {
            v5
        } else {
            v2
        };
        let v7 = ((((v4 + v6) as u128) * (v1 as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg3) as u128)) as u64);
        assert!(v7 > 0, 8);
        let v8 = arg0.bid_index;
        let v9 = 0x2::tx_context::sender(arg9);
        arg0.bid_index = v8 + 1;
        arg0.total_bid_size = arg0.total_bid_size + arg1;
        let v10 = Bid<T1>{
            price   : v3,
            size    : arg1,
            ts_ms   : v0,
            balance : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::extract_balance<T1>(arg5, v7, arg9),
            bidder  : v9,
        };
        0x2::table::add<u64, Bid<T1>>(&mut arg0.bids, v8, v10);
        if (0x2::table::contains<address, vector<u64>>(&arg0.ownerships, v9)) {
            0x1::vector::push_back<u64>(0x2::table::borrow_mut<address, vector<u64>>(&mut arg0.ownerships, v9), v8);
        } else {
            0x2::table::add<address, vector<u64>>(&mut arg0.ownerships, v9, 0x1::vector::singleton<u64>(v8));
        };
        let v11 = NewBid<T1>{
            signer    : v9,
            bid_index : v8,
            price     : v3,
            size      : arg1,
            balance   : v7,
            ts_ms     : v0,
        };
        0x2::event::emit<NewBid<T1>>(v11);
        (v8, v3, arg1, v7, v0, v9)
    }

    public fun remove_bid<T0, T1>(arg0: &mut Auction<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.able_to_remove_bid, 9);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.start_ts_ms, 3);
        assert!(v0 <= arg0.end_ts_ms, 5);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, vector<u64>>(&arg0.ownerships, v1), 1);
        let v2 = 0x2::table::borrow_mut<address, vector<u64>>(&mut arg0.ownerships, v1);
        let (v3, v4) = 0x1::vector::index_of<u64>(v2, &arg1);
        assert!(v3, 2);
        0x1::vector::swap_remove<u64>(v2, v4);
        let Bid {
            price   : _,
            size    : _,
            ts_ms   : v7,
            balance : v8,
            bidder  : _,
        } = 0x2::table::remove<u64, Bid<T1>>(&mut arg0.bids, arg1);
        let v10 = 0x2::coin::from_balance<T1>(v8, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v10, v1);
        let v11 = RemoveBid<T1>{
            signer    : v1,
            bid_index : arg1,
            balance   : 0x2::coin::value<T1>(&v10),
            ts_ms     : v7,
        };
        0x2::event::emit<RemoveBid<T1>>(v11);
    }

    public fun switch_remove_bid_ability<T0, T1>(arg0: &T0, arg1: &mut Auction<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        arg1.able_to_remove_bid = !arg1.able_to_remove_bid;
        let v0 = SwitchRemoveBidAbility<T1>{
            signer             : 0x2::tx_context::sender(arg2),
            able_to_remove_bid : arg1.able_to_remove_bid,
        };
        0x2::event::emit<SwitchRemoveBidAbility<T1>>(v0);
    }

    public fun total_bid_size<T0, T1>(arg0: &Auction<T0, T1>) : u64 {
        arg0.total_bid_size
    }

    // decompiled from Move bytecode v6
}

