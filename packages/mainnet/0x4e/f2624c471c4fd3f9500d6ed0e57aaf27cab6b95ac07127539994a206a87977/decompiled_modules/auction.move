module 0x601a9f900ee01f6458809a881bef6115cc65762e2bd1fa022ea6bb6111862268::auction {
    struct AUCTION has drop {
        dummy_field: bool,
    }

    struct VERSION has drop {
        dummy_field: bool,
    }

    struct Auction has store, key {
        id: 0x2::object::UID,
        whitelist_ts_ms: u64,
        start_ts_ms: u64,
        end_ts_ms: u64,
        max_size: u64,
        lot_size: u64,
        min_bid_size: u64,
        max_bid_size: u64,
        decay_speed: u64,
        initial_price: u64,
        final_price: u64,
        deliver_price: u64,
        token_decimal: u64,
        size_decimal: u64,
        total_bid_size: u64,
        bid_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        deliver_balance: 0x2::balance::Balance<0xf82dc05634970553615eef6112a1ac4fb7bf10272bf6cbe0f80ef44a6c489385::typus::TYPUS>,
        whitelists: 0x2::table::Table<address, WhiteList>,
        bids: 0x2::table::Table<address, Bid>,
        claims: 0x2::table::Table<address, bool>,
        records: 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::BigVector,
    }

    struct WhiteList has drop, store {
        max_bid_size: u64,
        total_bid_size: u64,
    }

    struct Bid has drop, store {
        total_bid_size: u64,
        total_balance: u64,
    }

    struct Record has drop, store {
        bidder: address,
        price: u64,
        size: u64,
        balance: u64,
        ts_ms: u64,
    }

    struct BidEvent has copy, drop {
        price: u64,
        size: u64,
        balance: u64,
    }

    struct ClaimEvent has copy, drop {
        price: u64,
        size: u64,
        balance: u64,
    }

    entry fun new(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: 0x2::coin::Coin<0xf82dc05634970553615eef6112a1ac4fb7bf10272bf6cbe0f80ef44a6c489385::typus::TYPUS>, arg11: &mut 0x2::tx_context::TxContext) {
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg11);
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        assert!(arg3 >= arg2, 1);
        assert!(arg4 > 0 && arg4 == 0x2::coin::value<0xf82dc05634970553615eef6112a1ac4fb7bf10272bf6cbe0f80ef44a6c489385::typus::TYPUS>(&arg10), 2);
        assert!(arg8 >= arg9 && arg9 > 0, 3);
        let v1 = Auction{
            id              : 0x2::object::new(arg11),
            whitelist_ts_ms : arg1,
            start_ts_ms     : arg2,
            end_ts_ms       : arg3,
            max_size        : arg4,
            lot_size        : arg5,
            min_bid_size    : arg6,
            max_bid_size    : arg7,
            decay_speed     : 1,
            initial_price   : arg8,
            final_price     : arg9,
            deliver_price   : arg8,
            token_decimal   : 9,
            size_decimal    : 9,
            total_bid_size  : 0,
            bid_balance     : 0x2::balance::zero<0x2::sui::SUI>(),
            deliver_balance : 0x2::coin::into_balance<0xf82dc05634970553615eef6112a1ac4fb7bf10272bf6cbe0f80ef44a6c489385::typus::TYPUS>(arg10),
            whitelists      : 0x2::table::new<address, WhiteList>(arg11),
            bids            : 0x2::table::new<address, Bid>(arg11),
            claims          : 0x2::table::new<address, bool>(arg11),
            records         : 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::new<Record>(1000, arg11),
        };
        0x2::transfer::share_object<Auction>(v1);
    }

    entry fun bid(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Auction, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = 0x2::tx_context::sender(arg5);
        assert!(v1 >= arg1.start_ts_ms || 0x2::table::contains<address, WhiteList>(&arg1.whitelists, v2) && v1 >= arg1.whitelist_ts_ms, 11);
        assert!(v1 <= arg1.end_ts_ms, 14);
        assert!(arg2 > 0, 10);
        assert!(arg1.total_bid_size < arg1.max_size, 7);
        assert!(arg2 >= arg1.min_bid_size, 6);
        assert!(arg2 % arg1.lot_size == 0, 5);
        let v3 = 0x1::u64::min(arg2, arg1.max_size - arg1.total_bid_size);
        let (v4, v5) = get_bid_info(arg1, v3, v1);
        assert!(v5 > 0, 10);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v5, 4);
        if (!0x2::table::contains<address, Bid>(&arg1.bids, v2)) {
            let v6 = Bid{
                total_bid_size : 0,
                total_balance  : 0,
            };
            0x2::table::add<address, Bid>(&mut arg1.bids, v2, v6);
        };
        let v7 = 0x2::table::borrow_mut<address, Bid>(&mut arg1.bids, v2);
        if (v1 < arg1.start_ts_ms) {
            assert!(0x2::table::contains<address, WhiteList>(&arg1.whitelists, v2), 0);
            let v8 = 0x2::table::borrow_mut<address, WhiteList>(&mut arg1.whitelists, v2);
            v8.total_bid_size = v8.total_bid_size + v3;
            assert!(v8.total_bid_size <= v8.max_bid_size, 8);
        } else if (0x2::table::contains<address, WhiteList>(&arg1.whitelists, v2)) {
            assert!(v7.total_bid_size - 0x2::table::borrow_mut<address, WhiteList>(&mut arg1.whitelists, v2).total_bid_size + v3 <= arg1.max_bid_size, 9);
        } else {
            assert!(v7.total_bid_size + v3 <= arg1.max_bid_size, 9);
        };
        v7.total_bid_size = v7.total_bid_size + v3;
        v7.total_balance = v7.total_balance + v5;
        arg1.deliver_price = v4;
        arg1.total_bid_size = arg1.total_bid_size + v3;
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.bid_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v5, arg5)));
        let v9 = Record{
            bidder  : v2,
            price   : v4,
            size    : v3,
            balance : v5,
            ts_ms   : v1,
        };
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::push_back<Record>(&mut arg1.records, v9);
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v2);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        let v10 = BidEvent{
            price   : v4,
            size    : v3,
            balance : v5,
        };
        0x2::event::emit<BidEvent>(v10);
    }

    public fun calculate_bid_value(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::utility::multiplier(arg0);
        ((((((arg2 as u128) * (arg3 as u128) / (v0 as u128)) as u64) as u128) * (v0 as u128) / (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::utility::multiplier(arg1) as u128)) as u64)
    }

    entry fun claim(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Auction, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x2::clock::timestamp_ms(arg2) > arg1.end_ts_ms || arg1.max_size == arg1.total_bid_size, 13);
        assert!(0x2::table::contains<address, Bid>(&arg1.bids, v1), 10);
        let v2 = 0x2::table::borrow_mut<address, Bid>(&mut arg1.bids, v1);
        assert!(!0x2::table::contains<address, bool>(&arg1.claims, v1), 15);
        0x2::table::add<address, bool>(&mut arg1.claims, v1, true);
        let v3 = if (arg1.max_size == arg1.total_bid_size) {
            arg1.deliver_price
        } else {
            arg1.final_price
        };
        let v4 = v2.total_balance - calculate_bid_value(arg1.token_decimal, arg1.size_decimal, v3, v2.total_bid_size);
        let v5 = v4;
        if (v4 > 0) {
            if (v4 > 0x2::balance::value<0x2::sui::SUI>(&arg1.bid_balance)) {
                v5 = 0x2::balance::value<0x2::sui::SUI>(&arg1.bid_balance);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.bid_balance, v5), arg3), v1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf82dc05634970553615eef6112a1ac4fb7bf10272bf6cbe0f80ef44a6c489385::typus::TYPUS>>(0x2::coin::from_balance<0xf82dc05634970553615eef6112a1ac4fb7bf10272bf6cbe0f80ef44a6c489385::typus::TYPUS>(0x2::balance::split<0xf82dc05634970553615eef6112a1ac4fb7bf10272bf6cbe0f80ef44a6c489385::typus::TYPUS>(&mut arg1.deliver_balance, v2.total_bid_size), arg3), v1);
        let v6 = ClaimEvent{
            price   : v3,
            size    : v2.total_bid_size,
            balance : v5,
        };
        0x2::event::emit<ClaimEvent>(v6);
    }

    fun decay_formula(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        if (arg5 <= arg3) {
            return arg0
        };
        let v0 = arg0 - arg1;
        while (arg2 > 0) {
            let v1 = (v0 as u128) * ((arg5 - arg3) as u128) / ((arg4 - arg3) as u128);
            v0 = (v1 as u64);
            arg2 = arg2 - 1;
        };
        arg0 - v0
    }

    public fun get_bid_info(arg0: &Auction, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = decay_formula(arg0.initial_price, arg0.final_price, arg0.decay_speed, arg0.start_ts_ms, arg0.end_ts_ms, arg2);
        (v0, calculate_bid_value(arg0.token_decimal, arg0.size_decimal, v0, arg1))
    }

    public(friend) fun get_bidder_info(arg0: &Auction, arg1: address) : vector<u64> {
        let v0 = vector[];
        if (0x2::table::contains<address, WhiteList>(&arg0.whitelists, arg1)) {
            let v1 = 0x2::table::borrow<address, WhiteList>(&arg0.whitelists, arg1);
            0x1::vector::push_back<u64>(&mut v0, v1.max_bid_size);
            0x1::vector::push_back<u64>(&mut v0, v1.total_bid_size);
        } else {
            0x1::vector::push_back<u64>(&mut v0, 0);
            0x1::vector::push_back<u64>(&mut v0, 0);
        };
        if (0x2::table::contains<address, Bid>(&arg0.bids, arg1)) {
            let v2 = 0x2::table::borrow<address, Bid>(&arg0.bids, arg1);
            let v3 = if (arg0.max_size == arg0.total_bid_size) {
                arg0.deliver_price
            } else {
                arg0.final_price
            };
            0x1::vector::push_back<u64>(&mut v0, v2.total_bid_size);
            0x1::vector::push_back<u64>(&mut v0, v2.total_balance);
            0x1::vector::push_back<u64>(&mut v0, v2.total_balance - calculate_bid_value(arg0.token_decimal, arg0.size_decimal, v3, v2.total_bid_size));
        } else {
            0x1::vector::push_back<u64>(&mut v0, 0);
            0x1::vector::push_back<u64>(&mut v0, 0);
            0x1::vector::push_back<u64>(&mut v0, 0);
        };
        if (0x2::table::contains<address, bool>(&arg0.claims, arg1)) {
            0x1::vector::push_back<u64>(&mut v0, 1);
        } else {
            0x1::vector::push_back<u64>(&mut v0, 0);
        };
        v0
    }

    public(friend) fun get_records_bcs(arg0: &Auction) : vector<vector<u8>> {
        let v0 = vector[];
        let v1 = 0;
        let v2 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&arg0.records);
        if (v2 > 0) {
            let v3 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&arg0.records) as u64);
            let v4 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice<Record>(&arg0.records, 0);
            while (v1 < v2) {
                0x1::vector::push_back<vector<u8>>(&mut v0, 0x1::bcs::to_bytes<Record>(0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice<Record>(v4, v1 % v3)));
                if (v1 + 1 < v2 && (v1 + 1) % v3 == 0) {
                    let v5 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<Record>(v4) + 1;
                    v4 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice<Record>(&arg0.records, v5);
                };
                v1 = v1 + 1;
            };
        };
        v0
    }

    fun init(arg0: AUCTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::issue_version<AUCTION, VERSION>(&arg0, v0, arg1);
    }

    entry fun update_auction_config(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Auction, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &0x2::tx_context::TxContext) {
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg14);
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        assert!(arg4 >= arg3, 1);
        let v1 = if (arg10 >= arg11) {
            if (arg11 > 0) {
                arg9 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 3);
        arg1.whitelist_ts_ms = arg2;
        arg1.start_ts_ms = arg3;
        arg1.end_ts_ms = arg4;
        arg1.max_size = arg5;
        arg1.lot_size = arg6;
        arg1.min_bid_size = arg7;
        arg1.max_bid_size = arg8;
        arg1.decay_speed = arg9;
        arg1.initial_price = arg10;
        arg1.final_price = arg11;
        arg1.token_decimal = arg12;
        arg1.size_decimal = arg13;
    }

    entry fun update_whitelist(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Auction, arg2: address, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg6);
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        assert!(0x2::clock::timestamp_ms(arg5) < arg1.start_ts_ms, 12);
        if (0x2::table::contains<address, WhiteList>(&arg1.whitelists, arg2)) {
            0x2::table::remove<address, WhiteList>(&mut arg1.whitelists, arg2);
        };
        let v1 = WhiteList{
            max_bid_size   : arg3,
            total_bid_size : arg4,
        };
        0x2::table::add<address, WhiteList>(&mut arg1.whitelists, arg2, v1);
    }

    entry fun whitelist(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Auction, arg2: vector<address>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg5);
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 2);
        assert!(0x2::clock::timestamp_ms(arg4) < arg1.start_ts_ms, 12);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (0x2::table::contains<address, WhiteList>(&arg1.whitelists, v1)) {
                0x2::table::remove<address, WhiteList>(&mut arg1.whitelists, v1);
            };
            let v2 = WhiteList{
                max_bid_size   : 0x1::vector::pop_back<u64>(&mut arg3),
                total_bid_size : 0,
            };
            0x2::table::add<address, WhiteList>(&mut arg1.whitelists, v1, v2);
        };
    }

    entry fun withdraw(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Auction, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg4);
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        assert!(0x2::clock::timestamp_ms(arg3) > arg1.end_ts_ms || arg1.max_size == arg1.total_bid_size, 13);
        let v1 = if (arg1.max_size == arg1.total_bid_size) {
            arg1.deliver_price
        } else {
            arg1.final_price
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.bid_balance, calculate_bid_value(arg1.token_decimal, arg1.size_decimal, v1, arg1.total_bid_size)), arg4), arg2);
        if (arg1.max_size > arg1.total_bid_size) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf82dc05634970553615eef6112a1ac4fb7bf10272bf6cbe0f80ef44a6c489385::typus::TYPUS>>(0x2::coin::from_balance<0xf82dc05634970553615eef6112a1ac4fb7bf10272bf6cbe0f80ef44a6c489385::typus::TYPUS>(0x2::balance::split<0xf82dc05634970553615eef6112a1ac4fb7bf10272bf6cbe0f80ef44a6c489385::typus::TYPUS>(&mut arg1.deliver_balance, arg1.max_size - arg1.total_bid_size), arg4), arg2);
        };
    }

    // decompiled from Move bytecode v6
}

