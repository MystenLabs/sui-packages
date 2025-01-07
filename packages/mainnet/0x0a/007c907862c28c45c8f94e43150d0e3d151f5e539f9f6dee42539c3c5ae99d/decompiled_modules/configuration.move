module 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration {
    struct Configuration has store, key {
        id: 0x2::object::UID,
        lender_fee_percent: u64,
        borrower_fee_percent: u64,
        max_offer_interest: u64,
        min_health_ratio: u64,
        hot_wallet: address,
        max_price_age_seconds: u64,
        price_feed_ids: 0x2::table::Table<0x1::string::String, 0x1::string::String>,
    }

    public(friend) fun borrow<T0: copy + drop + store, T1: store>(arg0: &Configuration, arg1: T0) : &T1 {
        0x2::dynamic_field::borrow<T0, T1>(&arg0.id, arg1)
    }

    public(friend) fun borrow_mut<T0: copy + drop + store, T1: store>(arg0: &mut Configuration, arg1: T0) : &mut T1 {
        0x2::dynamic_field::borrow_mut<T0, T1>(&mut arg0.id, arg1)
    }

    public(friend) fun add<T0: copy + drop + store, T1: store>(arg0: &mut Configuration, arg1: T0, arg2: T1) {
        0x2::dynamic_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
    }

    public(friend) fun remove<T0: copy + drop + store, T1: store>(arg0: &mut Configuration, arg1: T0) : T1 {
        0x2::dynamic_field::remove<T0, T1>(&mut arg0.id, arg1)
    }

    public(friend) fun new(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Configuration{
            id                    : 0x2::object::new(arg6),
            lender_fee_percent    : arg0,
            borrower_fee_percent  : arg1,
            max_offer_interest    : arg2,
            min_health_ratio      : arg3,
            hot_wallet            : arg4,
            max_price_age_seconds : arg5,
            price_feed_ids        : 0x2::table::new<0x1::string::String, 0x1::string::String>(arg6),
        };
        0x2::transfer::public_share_object<Configuration>(v0);
    }

    public(friend) fun add_price_feed_id(arg0: &mut Configuration, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        assert!(!0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg0.price_feed_ids, arg1), 1);
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg0.price_feed_ids, arg1, arg2);
    }

    public(friend) fun add_token<T0>(arg0: &mut Configuration, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: bool) {
        let v0 = 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::utils::get_type<T0>();
        assert!(!contain<0x1::string::String, 0x1::string::String>(arg0, v0), 3);
        if (arg3) {
            add<0x1::string::String, 0x1::string::String>(arg0, v0, 0x1::string::utf8(b"Lend"));
        } else {
            add<0x1::string::String, 0x1::string::String>(arg0, v0, 0x1::string::utf8(b"Collateral"));
        };
        add_price_feed_id(arg0, arg1, arg2);
    }

    public fun borrower_fee_percent(arg0: &Configuration) : u64 {
        arg0.borrower_fee_percent
    }

    public(friend) fun contain<T0: copy + drop + store, T1: store>(arg0: &Configuration, arg1: T0) : bool {
        0x2::dynamic_field::exists_with_type<T0, T1>(&arg0.id, arg1)
    }

    public fun contains_price_feed_id(arg0: &Configuration, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg0.price_feed_ids, arg1)
    }

    public fun hot_wallet(arg0: &Configuration) : address {
        arg0.hot_wallet
    }

    public fun is_valid_collateral_coin<T0>(arg0: &Configuration) : bool {
        let v0 = 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::utils::get_type<T0>();
        if (!contain<0x1::string::String, 0x1::string::String>(arg0, v0)) {
            return false
        };
        *borrow<0x1::string::String, 0x1::string::String>(arg0, v0) == 0x1::string::utf8(b"Collateral")
    }

    public fun is_valid_lend_coin<T0>(arg0: &Configuration) : bool {
        let v0 = 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::utils::get_type<T0>();
        if (!contain<0x1::string::String, 0x1::string::String>(arg0, v0)) {
            return false
        };
        *borrow<0x1::string::String, 0x1::string::String>(arg0, v0) == 0x1::string::utf8(b"Lend")
    }

    public fun lender_fee_percent(arg0: &Configuration) : u64 {
        arg0.lender_fee_percent
    }

    public fun max_offer_interest(arg0: &Configuration) : u64 {
        arg0.max_offer_interest
    }

    public fun max_price_age_seconds(arg0: &Configuration) : u64 {
        arg0.max_price_age_seconds
    }

    public fun min_health_ratio(arg0: &Configuration) : u64 {
        arg0.min_health_ratio
    }

    public fun price_feed_id(arg0: &Configuration, arg1: 0x1::string::String) : 0x1::string::String {
        assert!(0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg0.price_feed_ids, arg1), 2);
        *0x2::table::borrow<0x1::string::String, 0x1::string::String>(&arg0.price_feed_ids, arg1)
    }

    public(friend) fun remove_price_feed_id(arg0: &mut Configuration, arg1: 0x1::string::String) {
        assert!(0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg0.price_feed_ids, arg1), 2);
        0x2::table::remove<0x1::string::String, 0x1::string::String>(&mut arg0.price_feed_ids, arg1);
    }

    public(friend) fun remove_token<T0>(arg0: &mut Configuration, arg1: 0x1::string::String) {
        remove<0x1::string::String, 0x1::string::String>(arg0, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::utils::get_type<T0>());
        remove_price_feed_id(arg0, arg1);
    }

    public(friend) fun update(arg0: &mut Configuration, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: u64) {
        arg0.lender_fee_percent = arg1;
        arg0.borrower_fee_percent = arg2;
        arg0.max_offer_interest = arg3;
        arg0.min_health_ratio = arg4;
        arg0.hot_wallet = arg5;
        arg0.max_price_age_seconds = arg6;
    }

    public(friend) fun update_price_feed_id(arg0: &mut Configuration, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        assert!(0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg0.price_feed_ids, arg1), 2);
        *0x2::table::borrow_mut<0x1::string::String, 0x1::string::String>(&mut arg0.price_feed_ids, arg1) = arg2;
    }

    // decompiled from Move bytecode v6
}

