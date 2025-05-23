module 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::dutch {
    struct DUTCH has drop {
        dummy_field: bool,
    }

    struct Auction has store, key {
        id: 0x2::object::UID,
        index: u64,
        token: 0x1::type_name::TypeName,
        start_ts_ms: u64,
        end_ts_ms: u64,
        size: u64,
        decay_speed: u64,
        initial_price: u64,
        final_price: u64,
        fee_bp: u64,
        incentive_bp: u64,
        token_decimal: u64,
        size_decimal: u64,
        total_bid_size: u64,
        able_to_remove_bid: bool,
        bids: 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::big_vector::BigVector<Bid>,
        bid_index: u64,
    }

    struct Bid has store {
        index: u64,
        bidder: address,
        price: u64,
        size: u64,
        bidder_balance: u64,
        incentive_balance: u64,
        fee_discount: u64,
        ts_ms: u64,
    }

    struct NewBid has copy, drop {
        signer: address,
        index: u64,
        token: 0x1::type_name::TypeName,
        bid_index: u64,
        price: u64,
        size: u64,
        bidder_balance: u64,
        incentive_balance: u64,
        ts_ms: u64,
    }

    struct RemoveBid has copy, drop {
        signer: address,
        index: u64,
        token: 0x1::type_name::TypeName,
        bid_index: u64,
        price: u64,
        size: u64,
        bidder_balance: u64,
        incentive_balance: u64,
        fee_discount: u64,
        ts_ms: u64,
    }

    struct Delivery has copy, drop {
        signer: address,
        index: u64,
        token: 0x1::type_name::TypeName,
        price: u64,
        size: u64,
        bidder_bid_value: u64,
        bidder_fee: u64,
        incentive_bid_value: u64,
        incentive_fee: u64,
    }

    struct UpdateAuctionConfig has copy, drop {
        signer: address,
        index: u64,
        prev_start_ts_ms: u64,
        prev_end_ts_ms: u64,
        prev_decay_speed: u64,
        prev_initial_price: u64,
        prev_final_price: u64,
        prev_fee_bp: u64,
        prev_incentive_bp: u64,
        prev_token_decimal: u64,
        prev_size_decimal: u64,
        prev_able_to_remove_bid: bool,
        start_ts_ms: u64,
        end_ts_ms: u64,
        decay_speed: u64,
        initial_price: u64,
        final_price: u64,
        fee_bp: u64,
        incentive_bp: u64,
        token_decimal: u64,
        size_decimal: u64,
        able_to_remove_bid: bool,
    }

    struct Terminate has copy, drop {
        signer: address,
        index: u64,
        token: 0x1::type_name::TypeName,
    }

    public fun new<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: bool, arg12: &mut 0x2::tx_context::TxContext) : Auction {
        assert!(arg2 >= arg1, 0);
        assert!(arg3 > 0, 1);
        assert!(arg4 > 0, 2);
        assert!(arg5 >= arg6 && arg6 > 0, 3);
        let v0 = 0x2::object::new(arg12);
        0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut v0, b"bidder_balance", 0x2::balance::zero<T0>());
        0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut v0, b"incentive_balance", 0x2::balance::zero<T0>());
        Auction{
            id                 : v0,
            index              : arg0,
            token              : 0x1::type_name::get<T0>(),
            start_ts_ms        : arg1,
            end_ts_ms          : arg2,
            size               : arg3,
            decay_speed        : arg4,
            initial_price      : arg5,
            final_price        : arg6,
            fee_bp             : arg7,
            incentive_bp       : arg8,
            token_decimal      : arg9,
            size_decimal       : arg10,
            total_bid_size     : 0,
            able_to_remove_bid : arg11,
            bids               : 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::big_vector::new<Bid>(3000, arg12),
            bid_index          : 0,
        }
    }

    public fun bid_index(arg0: &Auction) : u64 {
        arg0.bid_index
    }

    public fun calculate_bid_value(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64) {
        let v0 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::utils::multiplier(arg1);
        let v1 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::utils::multiplier(arg2);
        let v2 = 10000;
        let v3 = (((arg3 as u128) * (arg4 as u128) / (v0 as u128)) as u64);
        ((((v3 as u128) * (v0 as u128) / (v1 as u128)) as u64), ((((((v3 as u128) * (arg0 as u128) * ((v2 - arg5) as u128) / (v2 as u128) / (v2 as u128)) as u64) as u128) * (v0 as u128) / (v1 as u128)) as u64))
    }

    fun decay_formula(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = arg0 - arg1;
        let v1 = if (arg5 < arg3) {
            0
        } else {
            arg5 - arg3
        };
        while (arg2 > 0) {
            let v2 = (v0 as u128) * (v1 as u128) / ((arg4 - arg3) as u128);
            v0 = (v2 as u64);
            arg2 = arg2 - 1;
        };
        arg0 - v0
    }

    public fun delivery<T0>(arg0: &mut 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::balance_pool::BalancePool, arg1: &mut 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::RefundVault, arg2: Auction, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, u64, u64, u64, u64, u64, u64) {
        assert!(0x2::clock::timestamp_ms(arg3) > arg2.start_ts_ms, 10);
        assert!(arg2.token == 0x1::type_name::get<T0>(), 4);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = if (arg2.total_bid_size < arg2.size) {
            arg2.final_price
        } else {
            0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::big_vector::borrow<Bid>(&arg2.bids, 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::big_vector::length<Bid>(&arg2.bids) - 1).price
        };
        while (!0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::big_vector::is_empty<Bid>(&arg2.bids)) {
            let Bid {
                index             : _,
                bidder            : v5,
                price             : _,
                size              : v7,
                bidder_balance    : v8,
                incentive_balance : v9,
                fee_discount      : v10,
                ts_ms             : _,
            } = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::big_vector::pop_back<Bid>(&mut arg2.bids);
            let (v12, v13) = calculate_bid_value(arg2.fee_bp, arg2.token_decimal, arg2.size_decimal, v3, v7, v10);
            let v14 = (((v12 as u128) * (arg2.incentive_bp as u128) / 10000) as u64);
            let v15 = v14;
            let v16 = (((v13 as u128) * (arg2.incentive_bp as u128) / 10000) as u64);
            let v17 = v16;
            if (v16 > v9) {
                v17 = v9;
            };
            v1 = v1 + v17;
            let v18 = v9 - v17;
            let v19 = v13 - v17;
            let v20 = v19;
            if (v14 > v18) {
                v15 = v18;
            };
            v0 = v0 + v15;
            let v21 = v12 - v15;
            if (v19 > v8) {
                v20 = v8;
            };
            v2 = v2 + v20;
            let v22 = v8 - v20;
            if (v21 < v22) {
                0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::put_refund<T0>(arg1, 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg2.id, b"bidder_balance"), v22 - v21), v5);
            };
        };
        let v23 = 0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg2.id, b"bidder_balance");
        let v24 = 0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg2.id, b"incentive_balance");
        let v25 = 0x2::balance::split<T0>(&mut v23, v2);
        let v26 = 0x2::balance::value<T0>(&v23);
        0x2::balance::join<T0>(&mut v25, 0x2::balance::split<T0>(&mut v24, v1));
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::balance_pool::put<T0>(arg0, v25);
        0x2::balance::join<T0>(&mut v23, 0x2::balance::split<T0>(&mut v24, v0));
        let Auction {
            id                 : v27,
            index              : v28,
            token              : _,
            start_ts_ms        : _,
            end_ts_ms          : _,
            size               : _,
            decay_speed        : _,
            initial_price      : _,
            final_price        : _,
            fee_bp             : _,
            incentive_bp       : _,
            token_decimal      : _,
            size_decimal       : _,
            total_bid_size     : v40,
            able_to_remove_bid : _,
            bids               : v42,
            bid_index          : _,
        } = arg2;
        0x2::object::delete(v27);
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::big_vector::destroy_empty<Bid>(v42);
        let v44 = Delivery{
            signer              : 0x2::tx_context::sender(arg4),
            index               : v28,
            token               : 0x1::type_name::get<T0>(),
            price               : v3,
            size                : v40,
            bidder_bid_value    : v26,
            bidder_fee          : v2,
            incentive_bid_value : v0,
            incentive_fee       : v1,
        };
        0x2::event::emit<Delivery>(v44);
        (v23, v24, v3, v40, v26, v2, v0, v1)
    }

    public fun get_bid_info(arg0: &Auction, arg1: u64, arg2: u64, arg3: u64) : (u64, u64, u64, u64) {
        let v0 = decay_formula(arg0.initial_price, arg0.final_price, arg0.decay_speed, arg0.start_ts_ms, arg0.end_ts_ms, arg3);
        if (arg0.size - arg0.total_bid_size < arg1) {
            arg1 = arg0.size - arg0.total_bid_size;
        };
        let (v1, v2) = calculate_bid_value(arg0.fee_bp, arg0.token_decimal, arg0.size_decimal, v0, arg1, arg2);
        (v0, arg1, v1, v2)
    }

    public fun get_decayed_price(arg0: &Auction, arg1: &0x2::clock::Clock) : u64 {
        decay_formula(arg0.initial_price, arg0.final_price, arg0.decay_speed, arg0.start_ts_ms, arg0.end_ts_ms, 0x2::clock::timestamp_ms(arg1))
    }

    public fun get_user_bid_info(arg0: &Auction, arg1: u64) : (u64, address, u64, u64, u64, u64, u64, u64) {
        let v0 = 0;
        while (v0 < 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::big_vector::length<Bid>(&arg0.bids)) {
            let v1 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::big_vector::borrow<Bid>(&arg0.bids, v0);
            if (v1.index == arg1) {
                return (v1.index, v1.bidder, v1.price, v1.size, v1.bidder_balance, v1.incentive_balance, v1.fee_discount, v1.ts_ms)
            };
            v0 = v0 + 1;
        };
        (0, @0x1, 0, 0, 0, 0, 0, 0)
    }

    public fun incentive_bp(arg0: &Auction) : u64 {
        arg0.incentive_bp
    }

    fun init(arg0: DUTCH, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<DUTCH>(arg0, arg1);
    }

    public fun new_bid<T0>(arg0: &mut Auction, arg1: u64, arg2: vector<0x2::coin::Coin<T0>>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64, u64, address) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 >= arg0.start_ts_ms, 8);
        assert!(v0 <= arg0.end_ts_ms, 11);
        assert!(arg1 > 0, 6);
        assert!(arg0.total_bid_size < arg0.size, 5);
        assert!(arg0.token == 0x1::type_name::get<T0>(), 4);
        let (v1, v2, v3, v4) = get_bid_info(arg0, arg1, arg4, v0);
        let v5 = v3 + v4;
        assert!(v5 > 0, 12);
        let v6 = 0x2::balance::value<T0>(&arg3);
        let v7 = arg0.bid_index;
        let v8 = 0x2::tx_context::sender(arg6);
        arg0.bid_index = arg0.bid_index + 1;
        arg0.total_bid_size = arg0.total_bid_size + v2;
        let v9 = if (v5 > v6) {
            v5 - v6
        } else {
            0
        };
        let v10 = Bid{
            index             : v7,
            bidder            : v8,
            price             : v1,
            size              : v2,
            bidder_balance    : v9,
            incentive_balance : v6,
            fee_discount      : arg4,
            ts_ms             : v0,
        };
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::big_vector::push_back<Bid>(&mut arg0.bids, v10);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"bidder_balance"), 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::utils::extract_balance<T0>(arg2, v5 - v6, arg6));
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"incentive_balance"), arg3);
        let v11 = NewBid{
            signer            : v8,
            index             : arg0.index,
            token             : 0x1::type_name::get<T0>(),
            bid_index         : v7,
            price             : v1,
            size              : v2,
            bidder_balance    : v9,
            incentive_balance : v6,
            ts_ms             : v0,
        };
        0x2::event::emit<NewBid>(v11);
        (v7, v1, v2, v9, v6, v0, v8)
    }

    public fun remove_bid<T0>(arg0: &mut Auction, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(arg0.able_to_remove_bid, 13);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.start_ts_ms, 8);
        assert!(v0 <= arg0.end_ts_ms, 11);
        assert!(arg0.token == 0x1::type_name::get<T0>(), 4);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::big_vector::length<Bid>(&arg0.bids);
        let v3 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::big_vector::slice_size<Bid>(&arg0.bids);
        let v4 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::big_vector::borrow_slice<Bid>(&arg0.bids, 1);
        let v5 = 0;
        while (v5 < v2) {
            let v6 = 0x1::vector::borrow<Bid>(v4, v5 % v3);
            if (v6.bidder == v1 && v6.index == arg1) {
                break
            };
            if (v5 + 1 < v2 && (v5 + 1) % v3 == 0) {
                v4 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::big_vector::borrow_slice<Bid>(&arg0.bids, 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::big_vector::slice_id<Bid>(&arg0.bids, v5 + 1));
            };
            v5 = v5 + 1;
        };
        if (v5 == v2) {
            abort 7
        };
        let Bid {
            index             : _,
            bidder            : _,
            price             : v9,
            size              : v10,
            bidder_balance    : v11,
            incentive_balance : v12,
            fee_discount      : v13,
            ts_ms             : v14,
        } = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::big_vector::remove<Bid>(&mut arg0.bids, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"bidder_balance"), v11), arg3), v1);
        let v15 = RemoveBid{
            signer            : v1,
            index             : arg0.index,
            token             : 0x1::type_name::get<T0>(),
            bid_index         : arg1,
            price             : v9,
            size              : v10,
            bidder_balance    : v11,
            incentive_balance : v12,
            fee_discount      : v13,
            ts_ms             : v14,
        };
        0x2::event::emit<RemoveBid>(v15);
        0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"bidder_balance"), v12)
    }

    public fun size(arg0: &Auction) : u64 {
        arg0.size
    }

    public fun terminate<T0>(arg0: Auction, arg1: &mut 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::RefundVault, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(arg0.token == 0x1::type_name::get<T0>(), 4);
        let Auction {
            id                 : v0,
            index              : v1,
            token              : v2,
            start_ts_ms        : _,
            end_ts_ms          : _,
            size               : _,
            decay_speed        : _,
            initial_price      : _,
            final_price        : _,
            fee_bp             : _,
            incentive_bp       : _,
            token_decimal      : _,
            size_decimal       : _,
            total_bid_size     : _,
            able_to_remove_bid : _,
            bids               : v15,
            bid_index          : _,
        } = arg0;
        let v17 = v15;
        let v18 = v0;
        while (!0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::big_vector::is_empty<Bid>(&v17)) {
            let Bid {
                index             : _,
                bidder            : v20,
                price             : _,
                size              : _,
                bidder_balance    : v23,
                incentive_balance : _,
                fee_discount      : _,
                ts_ms             : _,
            } = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::big_vector::pop_back<Bid>(&mut v17);
            0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::put_refund<T0>(arg1, 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut v18, b"bidder_balance"), v23), v20);
        };
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::big_vector::destroy_empty<Bid>(v17);
        0x2::balance::destroy_zero<T0>(0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T0>>(&mut v18, b"bidder_balance"));
        0x2::object::delete(v18);
        let v27 = Terminate{
            signer : 0x2::tx_context::sender(arg2),
            index  : v1,
            token  : v2,
        };
        0x2::event::emit<Terminate>(v27);
        0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T0>>(&mut v18, b"incentive_balance")
    }

    public fun token(arg0: &Auction) : 0x1::type_name::TypeName {
        arg0.token
    }

    public fun total_bid_size(arg0: &Auction) : u64 {
        arg0.total_bid_size
    }

    public fun update_auction_config(arg0: &mut Auction, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: &0x2::clock::Clock, arg12: &0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg11) < arg0.start_ts_ms, 9);
        assert!(arg2 >= arg1, 0);
        assert!(arg3 > 0, 2);
        assert!(arg4 >= arg5 && arg5 > 0, 3);
        arg0.start_ts_ms = arg1;
        arg0.end_ts_ms = arg2;
        arg0.decay_speed = arg3;
        arg0.initial_price = arg4;
        arg0.final_price = arg5;
        arg0.fee_bp = arg6;
        arg0.incentive_bp = arg7;
        arg0.token_decimal = arg8;
        arg0.size_decimal = arg9;
        arg0.able_to_remove_bid = arg10;
        let v0 = UpdateAuctionConfig{
            signer                  : 0x2::tx_context::sender(arg12),
            index                   : arg0.index,
            prev_start_ts_ms        : arg0.start_ts_ms,
            prev_end_ts_ms          : arg0.end_ts_ms,
            prev_decay_speed        : arg0.decay_speed,
            prev_initial_price      : arg0.initial_price,
            prev_final_price        : arg0.final_price,
            prev_fee_bp             : arg0.fee_bp,
            prev_incentive_bp       : arg0.incentive_bp,
            prev_token_decimal      : arg0.token_decimal,
            prev_size_decimal       : arg0.size_decimal,
            prev_able_to_remove_bid : arg0.able_to_remove_bid,
            start_ts_ms             : arg1,
            end_ts_ms               : arg2,
            decay_speed             : arg3,
            initial_price           : arg4,
            final_price             : arg5,
            fee_bp                  : arg6,
            incentive_bp            : arg7,
            token_decimal           : arg8,
            size_decimal            : arg9,
            able_to_remove_bid      : arg10,
        };
        0x2::event::emit<UpdateAuctionConfig>(v0);
    }

    // decompiled from Move bytecode v6
}

