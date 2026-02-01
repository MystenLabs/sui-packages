module 0xcda743fad5bb31d3813d5e4b4a69cfd8afd771f0c370e67822de0971bf970feb::pawtato_otc {
    struct OTCCollection has key {
        id: 0x2::object::UID,
        deals: 0x2::table::Table<u64, Deal>,
        user_deals: 0x2::table::Table<address, vector<u64>>,
        creator_fee: u64,
        taker_fee: u64,
        version: u64,
        paused: bool,
        coin_types: vector<0x1::string::String>,
        treasury_address: address,
        deal_ids: vector<u64>,
        user_addresses: vector<address>,
        recent_trades: vector<TradeRecord>,
        deal_counter: u64,
        trade_counter: u64,
        deals_accepted_count: u64,
        deals_cancelled_count: u64,
    }

    struct Deal has store {
        id: u64,
        maker: address,
        offering_type: 0x1::string::String,
        offering_amount: u64,
        remaining_amount: u64,
        requesting_type: 0x1::string::String,
        requesting_amount: u64,
        allow_partial: bool,
        created_at: u64,
        coin_storage: 0x2::bag::Bag,
    }

    struct OTCAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DealInfo has copy, drop, store {
        id: u64,
        maker: address,
        offering_type: 0x1::string::String,
        offering_amount: u64,
        remaining_amount: u64,
        requesting_type: 0x1::string::String,
        requesting_amount: u64,
        allow_partial: bool,
        created_at: u64,
    }

    struct TradeRecord has copy, drop, store {
        trade_id: u64,
        deal_id: u64,
        maker: address,
        taker: address,
        offering_type: 0x1::string::String,
        requesting_type: 0x1::string::String,
        offering_amount_traded: u64,
        requesting_amount_paid: u64,
        deal_completed: bool,
        timestamp: u64,
    }

    struct DealCreated has copy, drop {
        deal_id: u64,
        maker: address,
        offering_type: 0x1::string::String,
        offering_amount: u64,
        requesting_type: 0x1::string::String,
        requesting_amount: u64,
        allow_partial: bool,
    }

    struct DealAccepted has copy, drop {
        deal_id: u64,
        taker: address,
        offering_type: 0x1::string::String,
        offering_amount: u64,
        requesting_type: 0x1::string::String,
        requesting_amount: u64,
        is_partial: bool,
    }

    struct DealAcceptedV2 has copy, drop {
        trade_id: u64,
        deal_id: u64,
        maker: address,
        taker: address,
        offering_type: 0x1::string::String,
        offering_amount: u64,
        requesting_type: 0x1::string::String,
        requesting_amount: u64,
        is_partial: bool,
    }

    struct DealCancelled has copy, drop {
        deal_id: u64,
        maker: address,
        offering_type: 0x1::string::String,
        remaining_amount: u64,
    }

    struct DealEdited has copy, drop {
        deal_id: u64,
        maker: address,
        offering_type: 0x1::string::String,
        offering_amount: u64,
        remaining_amount: u64,
        requesting_type: 0x1::string::String,
        old_requesting_amount: u64,
        new_requesting_amount: u64,
        allow_partial: bool,
    }

    struct PAWTATO_OTC has drop {
        dummy_field: bool,
    }

    public fun accept_deal<T0, T1>(arg0: &mut OTCCollection, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        abort 514
    }

    public fun accept_deal_tato<T0, T1>(arg0: &mut OTCCollection, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, Deal>(&arg0.deals, arg1), 501);
        assert!(0x2::coin::value<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&arg4) >= arg0.taker_fee, 508);
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::table::borrow<u64, Deal>(&arg0.deals, arg1);
        assert!(v1.maker != v0, 502);
        assert!(v1.requesting_type == 0xcda743fad5bb31d3813d5e4b4a69cfd8afd771f0c370e67822de0971bf970feb::helpers::get_coin_type_string_with_0x<T1>(), 509);
        assert!(v1.offering_type == 0xcda743fad5bb31d3813d5e4b4a69cfd8afd771f0c370e67822de0971bf970feb::helpers::get_coin_type_string_with_0x<T0>(), 509);
        assert!(arg3 <= v1.remaining_amount, 503);
        if (arg3 < v1.remaining_amount) {
            assert!(v1.allow_partial, 504);
        };
        let v2 = v1.maker;
        let v3 = v1.requesting_type;
        let v4 = (((arg3 as u128) * (v1.requesting_amount as u128) / (v1.offering_amount as u128)) as u64);
        assert!(0x2::coin::value<T1>(&arg2) >= v4, 505);
        let v5 = 0x2::table::borrow_mut<u64, Deal>(&mut arg0.deals, arg1);
        0x2::coin::join<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&mut arg4, 0x2::bag::remove<vector<u8>, 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(&mut v5.coin_storage, b"creator_fee_tato"));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(arg4, arg0.treasury_address);
        if (0x2::coin::value<T1>(&arg2) > v4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg2, v4, arg6), v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, v2);
        };
        let v6 = 0x2::coin::split<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::coin::Coin<T0>>(&mut v5.coin_storage, v5.offering_type), arg3, arg6);
        v5.remaining_amount = v5.remaining_amount - arg3;
        let v7 = v5.remaining_amount == 0;
        if (v7) {
            0x2::coin::destroy_zero<T0>(0x2::bag::remove<0x1::string::String, 0x2::coin::Coin<T0>>(&mut v5.coin_storage, v5.offering_type));
        };
        let v8 = DealAcceptedV2{
            trade_id          : arg0.trade_counter + 1,
            deal_id           : arg1,
            maker             : v2,
            taker             : v0,
            offering_type     : v5.offering_type,
            offering_amount   : arg3,
            requesting_type   : v5.requesting_type,
            requesting_amount : v4,
            is_partial        : arg3 < v5.offering_amount,
        };
        0x2::event::emit<DealAcceptedV2>(v8);
        if (v5.remaining_amount == 0) {
            let v9 = 0x2::table::remove<u64, Deal>(&mut arg0.deals, arg1);
            arg0.deals_accepted_count = arg0.deals_accepted_count + 1;
            remove_user_deal(arg0, v9.maker, arg1);
            remove_deal_id(arg0, arg1);
            destroy_deal(v9);
        };
        record_trade(arg0, arg1, v2, v0, v1.offering_type, v3, arg3, v4, v7, 0x2::clock::timestamp_ms(arg5), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, v0);
    }

    fun add_user_deal(arg0: &mut OTCCollection, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, vector<u64>>(&arg0.user_deals, arg1)) {
            0x2::table::add<address, vector<u64>>(&mut arg0.user_deals, arg1, 0x1::vector::empty<u64>());
            0x1::vector::push_back<address>(&mut arg0.user_addresses, arg1);
        };
        0x1::vector::push_back<u64>(0x2::table::borrow_mut<address, vector<u64>>(&mut arg0.user_deals, arg1), arg2);
    }

    public fun admin_cancel_deal<T0>(arg0: &OTCAdminCap, arg1: &mut OTCCollection, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, Deal>(&arg1.deals, arg2), 501);
        check_version(arg1);
        let v0 = 0x2::table::remove<u64, Deal>(&mut arg1.deals, arg2);
        let v1 = v0.offering_type;
        let v2 = v0.maker;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::bag::remove<0x1::string::String, 0x2::coin::Coin<T0>>(&mut v0.coin_storage, v1), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(0x2::bag::remove<vector<u8>, 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(&mut v0.coin_storage, b"creator_fee_tato"), v2);
        remove_user_deal(arg1, v2, arg2);
        remove_deal_id(arg1, arg2);
        arg1.deals_cancelled_count = arg1.deals_cancelled_count + 1;
        let v3 = DealCancelled{
            deal_id          : arg2,
            maker            : v2,
            offering_type    : v1,
            remaining_amount : v0.remaining_amount,
        };
        0x2::event::emit<DealCancelled>(v3);
        destroy_deal(v0);
    }

    public fun cancel_deal<T0>(arg0: &mut OTCCollection, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        abort 514
    }

    public fun cancel_deal_tato<T0>(arg0: &mut OTCCollection, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, Deal>(&arg0.deals, arg1), 501);
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::table::remove<u64, Deal>(&mut arg0.deals, arg1);
        assert!(v0.maker == 0x2::tx_context::sender(arg3), 506);
        let v1 = v0.offering_type;
        let v2 = v0.maker;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::bag::remove<0x1::string::String, 0x2::coin::Coin<T0>>(&mut v0.coin_storage, v1), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(0x2::bag::remove<vector<u8>, 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(&mut v0.coin_storage, b"creator_fee_tato"), v2);
        remove_user_deal(arg0, v2, arg1);
        remove_deal_id(arg0, arg1);
        arg0.deals_cancelled_count = arg0.deals_cancelled_count + 1;
        let v3 = DealCancelled{
            deal_id          : arg1,
            maker            : v2,
            offering_type    : v1,
            remaining_amount : v0.remaining_amount,
        };
        0x2::event::emit<DealCancelled>(v3);
        destroy_deal(v0);
    }

    fun check_not_paused(arg0: &OTCCollection) {
        assert!(!arg0.paused, 512);
    }

    fun check_user_deal_limit(arg0: &OTCCollection, arg1: address) {
        if (0x2::table::contains<address, vector<u64>>(&arg0.user_deals, arg1)) {
            assert!(0x1::vector::length<u64>(0x2::table::borrow<address, vector<u64>>(&arg0.user_deals, arg1)) < 10, 507);
        };
    }

    public fun check_version(arg0: &OTCCollection) {
        assert!(arg0.version == 2, 511);
    }

    public fun create_deal<T0>(arg0: &mut OTCCollection, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: u64, arg4: bool, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 514
    }

    public fun create_deal_tato<T0>(arg0: &mut OTCCollection, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: u64, arg4: bool, arg5: 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= 1000000000, 500);
        assert!(arg3 >= 1000000000, 500);
        assert!(0x2::coin::value<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>(&arg5) >= arg0.creator_fee, 508);
        check_version(arg0);
        check_not_paused(arg0);
        let v1 = 0xcda743fad5bb31d3813d5e4b4a69cfd8afd771f0c370e67822de0971bf970feb::helpers::get_coin_type_string_with_0x<T0>();
        validate_coin_type(arg0, v1);
        validate_coin_type(arg0, arg2);
        check_user_deal_limit(arg0, 0x2::tx_context::sender(arg7));
        arg0.deal_counter = arg0.deal_counter + 1;
        let v2 = arg0.deal_counter;
        let v3 = 0x2::bag::new(arg7);
        0x2::bag::add<0x1::string::String, 0x2::coin::Coin<T0>>(&mut v3, v1, arg1);
        0x2::bag::add<vector<u8>, 0x2::coin::Coin<0x4deb377c33bfced1ab81cde96918e2538fe78735777150b0064ccf7df5e1c81::tato::TATO>>(&mut v3, b"creator_fee_tato", arg5);
        let v4 = Deal{
            id                : v2,
            maker             : 0x2::tx_context::sender(arg7),
            offering_type     : v1,
            offering_amount   : v0,
            remaining_amount  : v0,
            requesting_type   : arg2,
            requesting_amount : arg3,
            allow_partial     : arg4,
            created_at        : 0x2::clock::timestamp_ms(arg6),
            coin_storage      : v3,
        };
        0x2::table::add<u64, Deal>(&mut arg0.deals, v2, v4);
        add_user_deal(arg0, 0x2::tx_context::sender(arg7), v2);
        0x1::vector::push_back<u64>(&mut arg0.deal_ids, v2);
        let v5 = DealCreated{
            deal_id           : v2,
            maker             : 0x2::tx_context::sender(arg7),
            offering_type     : v1,
            offering_amount   : v0,
            requesting_type   : arg2,
            requesting_amount : arg3,
            allow_partial     : arg4,
        };
        0x2::event::emit<DealCreated>(v5);
    }

    fun destroy_deal(arg0: Deal) {
        let Deal {
            id                : _,
            maker             : _,
            offering_type     : _,
            offering_amount   : _,
            remaining_amount  : _,
            requesting_type   : _,
            requesting_amount : _,
            allow_partial     : _,
            created_at        : _,
            coin_storage      : v9,
        } = arg0;
        0x2::bag::destroy_empty(v9);
    }

    public entry fun edit_deal(arg0: &mut OTCCollection, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, Deal>(&arg0.deals, arg1), 501);
        assert!(arg2 >= 1000000000, 513);
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::table::borrow_mut<u64, Deal>(&mut arg0.deals, arg1);
        assert!(v1.maker == v0, 506);
        v1.requesting_amount = arg2;
        let v2 = DealEdited{
            deal_id               : arg1,
            maker                 : v0,
            offering_type         : v1.offering_type,
            offering_amount       : v1.offering_amount,
            remaining_amount      : v1.remaining_amount,
            requesting_type       : v1.requesting_type,
            old_requesting_amount : v1.requesting_amount,
            new_requesting_amount : arg2,
            allow_partial         : v1.allow_partial,
        };
        0x2::event::emit<DealEdited>(v2);
    }

    public fun get_deals_paginated_structs(arg0: &OTCCollection, arg1: u64, arg2: u64) : vector<DealInfo> {
        let v0 = &arg0.deal_ids;
        let v1 = 0x1::vector::length<u64>(v0);
        if (arg1 >= v1) {
            return 0x1::vector::empty<DealInfo>()
        };
        let v2 = arg1 + arg2;
        let v3 = v2;
        if (v2 > v1) {
            v3 = v1;
        };
        let v4 = 0x1::vector::empty<DealInfo>();
        while (arg1 < v3) {
            let v5 = 0x2::table::borrow<u64, Deal>(&arg0.deals, *0x1::vector::borrow<u64>(v0, arg1));
            let v6 = DealInfo{
                id                : v5.id,
                maker             : v5.maker,
                offering_type     : v5.offering_type,
                offering_amount   : v5.offering_amount,
                remaining_amount  : v5.remaining_amount,
                requesting_type   : v5.requesting_type,
                requesting_amount : v5.requesting_amount,
                allow_partial     : v5.allow_partial,
                created_at        : v5.created_at,
            };
            0x1::vector::push_back<DealInfo>(&mut v4, v6);
            arg1 = arg1 + 1;
        };
        v4
    }

    public fun get_recent_trades(arg0: &OTCCollection) : vector<TradeRecord> {
        arg0.recent_trades
    }

    fun init(arg0: PAWTATO_OTC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OTCAdminCap{id: 0x2::object::new(arg1)};
        let v1 = OTCCollection{
            id                    : 0x2::object::new(arg1),
            deals                 : 0x2::table::new<u64, Deal>(arg1),
            user_deals            : 0x2::table::new<address, vector<u64>>(arg1),
            creator_fee           : 500000000,
            taker_fee             : 1000000000,
            version               : 2,
            paused                : false,
            coin_types            : 0x1::vector::empty<0x1::string::String>(),
            treasury_address      : @0x51bd8046795ded252dbce1b42971992edccadba9c5d1fa2b2d8ccb1631b92bfd,
            deal_ids              : 0x1::vector::empty<u64>(),
            user_addresses        : 0x1::vector::empty<address>(),
            recent_trades         : 0x1::vector::empty<TradeRecord>(),
            deal_counter          : 0,
            trade_counter         : 0,
            deals_accepted_count  : 0,
            deals_cancelled_count : 0,
        };
        0x2::transfer::share_object<OTCCollection>(v1);
        0x2::transfer::transfer<OTCAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_coin_type_registered(arg0: &OTCCollection, arg1: &0x1::string::String) : bool {
        let (v0, _) = 0x1::vector::index_of<0x1::string::String>(&arg0.coin_types, arg1);
        v0
    }

    fun record_trade(arg0: &mut OTCCollection, arg1: u64, arg2: address, arg3: address, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        arg0.trade_counter = arg0.trade_counter + 1;
        let v0 = TradeRecord{
            trade_id               : arg0.trade_counter,
            deal_id                : arg1,
            maker                  : arg2,
            taker                  : arg3,
            offering_type          : arg4,
            requesting_type        : arg5,
            offering_amount_traded : arg6,
            requesting_amount_paid : arg7,
            deal_completed         : arg8,
            timestamp              : arg9,
        };
        if (0x1::vector::length<TradeRecord>(&arg0.recent_trades) >= 500) {
            0x1::vector::remove<TradeRecord>(&mut arg0.recent_trades, 0);
        };
        0x1::vector::push_back<TradeRecord>(&mut arg0.recent_trades, v0);
    }

    public fun register_coin_type<T0>(arg0: &OTCAdminCap, arg1: &mut OTCCollection) {
        let v0 = 0xcda743fad5bb31d3813d5e4b4a69cfd8afd771f0c370e67822de0971bf970feb::helpers::get_coin_type_string_with_0x<T0>();
        let (v1, _) = 0x1::vector::index_of<0x1::string::String>(&arg1.coin_types, &v0);
        if (!v1) {
            0x1::vector::push_back<0x1::string::String>(&mut arg1.coin_types, v0);
        };
    }

    fun remove_deal_id(arg0: &mut OTCCollection, arg1: u64) {
        let (v0, v1) = 0x1::vector::index_of<u64>(&arg0.deal_ids, &arg1);
        if (v0) {
            0x1::vector::remove<u64>(&mut arg0.deal_ids, v1);
        };
    }

    fun remove_user_deal(arg0: &mut OTCCollection, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, vector<u64>>(&arg0.user_deals, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, vector<u64>>(&mut arg0.user_deals, arg1);
            let (v1, v2) = 0x1::vector::index_of<u64>(v0, &arg2);
            if (v1) {
                0x1::vector::remove<u64>(v0, v2);
                if (0x1::vector::is_empty<u64>(v0)) {
                    let (v3, v4) = 0x1::vector::index_of<address>(&arg0.user_addresses, &arg1);
                    if (v3) {
                        0x1::vector::remove<address>(&mut arg0.user_addresses, v4);
                    };
                };
            };
        };
    }

    public entry fun set_paused(arg0: &OTCAdminCap, arg1: &mut OTCCollection, arg2: bool) {
        arg1.paused = arg2;
    }

    public fun unregister_coin_type(arg0: &OTCAdminCap, arg1: &mut OTCCollection, arg2: 0x1::string::String) {
        let (v0, v1) = 0x1::vector::index_of<0x1::string::String>(&arg1.coin_types, &arg2);
        if (v0) {
            0x1::vector::remove<0x1::string::String>(&mut arg1.coin_types, v1);
        };
    }

    public entry fun update_creator_fee(arg0: &OTCAdminCap, arg1: &mut OTCCollection, arg2: u64) {
        arg1.creator_fee = arg2;
    }

    public entry fun update_taker_fee(arg0: &OTCAdminCap, arg1: &mut OTCCollection, arg2: u64) {
        arg1.taker_fee = arg2;
    }

    public entry fun update_treasury_address(arg0: &OTCAdminCap, arg1: &mut OTCCollection, arg2: address) {
        arg1.treasury_address = arg2;
    }

    public entry fun upgrade_version(arg0: &OTCAdminCap, arg1: &mut OTCCollection) {
        assert!(arg1.version < 2, 511);
        arg1.version = 2;
    }

    fun validate_coin_type(arg0: &OTCCollection, arg1: 0x1::string::String) {
        assert!(is_coin_type_registered(arg0, &arg1), 510);
    }

    // decompiled from Move bytecode v6
}

