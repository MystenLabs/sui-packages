module 0x8de4a5d2173e5d479fd252b2992eca70aad9b717e97d5af4f67c52c17011ee57::oracle {
    struct FeedRegistry has key {
        id: 0x2::object::UID,
        prices: 0x2::table::Table<0x1::ascii::String, SourceConfig>,
        version: u8,
    }

    struct SourceConfig has store {
        owner: address,
        provider: address,
        status: u8,
        consumer_a: address,
        consumer_b: address,
        fee_split: u8,
        prices: 0x2::table::Table<0x2::object::ID, PriceMeta>,
    }

    struct PriceMeta has copy, drop, store {
        asset_pair: 0x1::ascii::String,
        value: u64,
        consumed: bool,
    }

    struct FeedCreated has copy, drop {
        feed_id: 0x1::ascii::String,
        owner: address,
    }

    struct PricePosted has copy, drop {
        feed_id: 0x1::ascii::String,
        price_id: 0x2::object::ID,
        asset_pair: 0x1::ascii::String,
        value: u64,
    }

    struct ConsumptionCompleted has copy, drop {
        feed_id: 0x1::ascii::String,
        price_id: 0x2::object::ID,
        result_value: u64,
    }

    public entry fun activate_feed(arg0: &mut FeedRegistry, arg1: 0x1::ascii::String, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, SourceConfig>(&arg0.prices, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, SourceConfig>(&mut arg0.prices, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.owner, 100);
        if (arg2) {
            v0.status = v0.status | 1;
        } else {
            v0.status = v0.status & (255 ^ 1);
        };
    }

    public fun archive_price(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut FeedRegistry, arg2: 0x1::ascii::String, arg3: 0x2::object::ID, arg4: 0x3::staking_pool::StakedSui, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, SourceConfig>(&arg1.prices, arg2), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, SourceConfig>(&mut arg1.prices, arg2);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.provider, 100);
        if (!(v0.status & 1 != 0)) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, PriceMeta>(&v0.prices, arg3)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, PriceMeta>(&v0.prices, arg3);
            !v3.consumed && v3.value > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, PriceMeta>(&v0.prices, arg3)) {
            0x2::table::borrow_mut<0x2::object::ID, PriceMeta>(&mut v0.prices, arg3).consumed = true;
        };
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg0, arg4, arg5), arg5);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&v4);
        let v6 = v5 * (v0.fee_split as u64) / 100;
        if (v6 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.consumer_b);
        } else if (v6 == v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.consumer_a);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v4, v6, arg5), v0.consumer_a);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.consumer_b);
        };
        let v7 = ConsumptionCompleted{
            feed_id      : arg2,
            price_id     : arg3,
            result_value : v5,
        };
        0x2::event::emit<ConsumptionCompleted>(v7);
    }

    public fun consume_batch<T0>(arg0: &mut FeedRegistry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, SourceConfig>(&arg0.prices, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, SourceConfig>(&mut arg0.prices, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.provider, 100);
        let v2 = 0x2::coin::value<T0>(&arg3);
        if (v2 == 0 || !(v0.status & 1 != 0)) {
            if (v2 == 0) {
                0x2::coin::destroy_zero<T0>(arg3);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v1);
            };
            return
        };
        if (0x2::table::contains<0x2::object::ID, PriceMeta>(&v0.prices, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, PriceMeta>(&mut v0.prices, arg2).consumed = true;
        };
        let v3 = v2 * (v0.fee_split as u64) / 100;
        if (v3 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.consumer_b);
        } else if (v3 == v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.consumer_a);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v3, arg4), v0.consumer_a);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.consumer_b);
        };
        let v4 = ConsumptionCompleted{
            feed_id      : arg1,
            price_id     : arg2,
            result_value : v2,
        };
        0x2::event::emit<ConsumptionCompleted>(v4);
    }

    public entry fun create_feed(arg0: &mut FeedRegistry, arg1: 0x1::ascii::String, arg2: address, arg3: address, arg4: address, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 <= 100, 106);
        let v0 = SourceConfig{
            owner      : 0x2::tx_context::sender(arg6),
            provider   : arg2,
            status     : 0,
            consumer_a : arg3,
            consumer_b : arg4,
            fee_split  : arg5,
            prices     : 0x2::table::new<0x2::object::ID, PriceMeta>(arg6),
        };
        0x2::table::add<0x1::ascii::String, SourceConfig>(&mut arg0.prices, arg1, v0);
        let v1 = FeedCreated{
            feed_id : arg1,
            owner   : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<FeedCreated>(v1);
    }

    public fun get_feed_info(arg0: &FeedRegistry, arg1: 0x1::ascii::String) : (address, address, bool, address, address, u8) {
        assert!(0x2::table::contains<0x1::ascii::String, SourceConfig>(&arg0.prices, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, SourceConfig>(&arg0.prices, arg1);
        (v0.owner, v0.provider, v0.status & 1 != 0, v0.consumer_a, v0.consumer_b, v0.fee_split)
    }

    public fun get_price_info(arg0: &FeedRegistry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : (0x1::ascii::String, u64, bool) {
        assert!(0x2::table::contains<0x1::ascii::String, SourceConfig>(&arg0.prices, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, SourceConfig>(&arg0.prices, arg1);
        assert!(0x2::table::contains<0x2::object::ID, PriceMeta>(&v0.prices, arg2), 102);
        let v1 = 0x2::table::borrow<0x2::object::ID, PriceMeta>(&v0.prices, arg2);
        (v1.asset_pair, v1.value, v1.consumed)
    }

    public fun get_price_value(arg0: &FeedRegistry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : u64 {
        assert!(0x2::table::contains<0x1::ascii::String, SourceConfig>(&arg0.prices, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, SourceConfig>(&arg0.prices, arg1);
        if (v0.status & 1 == 0) {
            return 0
        };
        if (!0x2::table::contains<0x2::object::ID, PriceMeta>(&v0.prices, arg2)) {
            return 0
        };
        let v1 = 0x2::table::borrow<0x2::object::ID, PriceMeta>(&v0.prices, arg2);
        if (v1.consumed) {
            return 0
        };
        v1.value
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeedRegistry{
            id      : 0x2::object::new(arg0),
            prices  : 0x2::table::new<0x1::ascii::String, SourceConfig>(arg0),
            version : 1,
        };
        0x2::transfer::share_object<FeedRegistry>(v0);
    }

    public entry fun post_price(arg0: &mut FeedRegistry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x1::ascii::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, SourceConfig>(&arg0.prices, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, SourceConfig>(&mut arg0.prices, arg1);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.owner || v1 == v0.provider, 100);
        let v2 = PriceMeta{
            asset_pair : arg3,
            value      : arg4,
            consumed   : false,
        };
        if (0x2::table::contains<0x2::object::ID, PriceMeta>(&v0.prices, arg2)) {
            *0x2::table::borrow_mut<0x2::object::ID, PriceMeta>(&mut v0.prices, arg2) = v2;
        } else {
            0x2::table::add<0x2::object::ID, PriceMeta>(&mut v0.prices, arg2, v2);
        };
        let v3 = PricePosted{
            feed_id    : arg1,
            price_id   : arg2,
            asset_pair : arg3,
            value      : arg4,
        };
        0x2::event::emit<PricePosted>(v3);
    }

    public fun settle_price<T0: store + key>(arg0: &mut FeedRegistry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, SourceConfig>(&arg0.prices, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, SourceConfig>(&mut arg0.prices, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.provider, 100);
        if (!(v0.status & 1 != 0)) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, PriceMeta>(&v0.prices, arg2)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, PriceMeta>(&v0.prices, arg2);
            !v3.consumed && v3.value > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, PriceMeta>(&v0.prices, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, PriceMeta>(&mut v0.prices, arg2).consumed = true;
        };
        0x2::transfer::public_transfer<T0>(arg3, v0.consumer_a);
        let v4 = ConsumptionCompleted{
            feed_id      : arg1,
            price_id     : arg2,
            result_value : 1,
        };
        0x2::event::emit<ConsumptionCompleted>(v4);
    }

    public fun should_consume(arg0: &FeedRegistry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : bool {
        get_price_value(arg0, arg1, arg2) > 0
    }

    public entry fun update_value(arg0: &mut FeedRegistry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, SourceConfig>(&arg0.prices, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, SourceConfig>(&mut arg0.prices, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.owner || v1 == v0.provider, 100);
        assert!(0x2::table::contains<0x2::object::ID, PriceMeta>(&v0.prices, arg2), 102);
        0x2::table::borrow_mut<0x2::object::ID, PriceMeta>(&mut v0.prices, arg2).value = arg3;
    }

    // decompiled from Move bytecode v6
}

