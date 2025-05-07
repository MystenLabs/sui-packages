module 0x524ab529e90663de0f0f85de65405d2b2dfc0c341417eee58a0cc98cc681257d::MARKET {
    struct LedgerKey has copy, drop, store {
        collection_id: 0x2::object::ID,
        currency_type: 0x1::type_name::TypeName,
    }

    struct LedgerRegistry has key {
        id: 0x2::object::UID,
        ledgers: 0x2::table::Table<LedgerKey, 0x2::object::ID>,
    }

    struct MARKET has drop {
        dummy_field: bool,
    }

    struct TradeLedgerCreated has copy, drop, store {
        collection_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        uri: 0x2::url::Url,
        logo_uri: 0x2::url::Url,
        current_supply: u64,
        max_supply: u64,
        is_mutable: bool,
        has_deny_list_authority: bool,
        deny_list_size: u64,
        currency_type: 0x1::type_name::TypeName,
        ledger_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct TradeOffer has store, key {
        id: 0x2::object::UID,
        offerer: address,
        collection_id: 0x2::object::ID,
        offered_asset_ids: vector<u64>,
        requested_currency: 0x1::type_name::TypeName,
        requested_amount: u64,
        status: u8,
        timestamp: u64,
        trade_ledger_id: 0x2::object::ID,
    }

    struct TradeLedger has key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        collection_creator: address,
        collection_name: 0x1::string::String,
        collection_description: 0x1::string::String,
        collection_uri: 0x2::url::Url,
        collection_logo_uri: 0x2::url::Url,
        current_supply: u64,
        max_supply: u64,
        is_mutable: bool,
        has_deny_list_authority: bool,
        deny_list_size: u64,
        currency_type: 0x1::type_name::TypeName,
        offers: 0x2::table::Table<0x2::object::ID, TradeOffer>,
        user_offers: 0x2::table::Table<address, vector<0x2::object::ID>>,
        price_index: 0x2::table::Table<u64, vector<0x2::object::ID>>,
        sorted_prices: vector<u64>,
        total_active_offers: u64,
        buy_offers: 0x2::table::Table<0x2::object::ID, BuyOffer>,
        user_buy_offers: 0x2::table::Table<address, vector<0x2::object::ID>>,
        buy_price_index: 0x2::table::Table<u64, vector<0x2::object::ID>>,
        sorted_buy_prices: vector<u64>,
        total_active_buy_offers: u64,
        timestamp: u64,
    }

    struct BuyOffer has store, key {
        id: 0x2::object::UID,
        buyer: address,
        collection_id: 0x2::object::ID,
        requested_asset_count: u64,
        offered_currency: 0x1::type_name::TypeName,
        offered_amount: u64,
        status: u8,
        timestamp: u64,
        ledger_id: 0x2::object::ID,
    }

    struct BuyOfferCreated has copy, drop, store {
        offer_id: 0x2::object::ID,
        buyer: address,
        collection_id: 0x2::object::ID,
        requested_asset_count: u64,
        offered_currency: 0x1::type_name::TypeName,
        offered_amount: u64,
        timestamp: u64,
        ledger_id: 0x2::object::ID,
    }

    struct NFTFieldKey<phantom T0> has copy, drop, store {
        asset_id: u64,
    }

    struct OfferCreated has copy, drop, store {
        offer_id: 0x2::object::ID,
        offerer: address,
        collection_id: 0x2::object::ID,
        offered_asset_ids: vector<u64>,
        requested_currency: 0x1::type_name::TypeName,
        requested_amount: u64,
        timestamp: u64,
        ledger_id: 0x2::object::ID,
    }

    struct OfferAccepted has copy, drop, store {
        offer_id: 0x2::object::ID,
        offerer: address,
        accepter: address,
        collection_id: 0x2::object::ID,
        offered_asset_ids: vector<u64>,
        requested_currency: 0x1::type_name::TypeName,
        requested_amount: u64,
        timestamp: u64,
        ledger_id: 0x2::object::ID,
    }

    struct BuyOfferAccepted has copy, drop, store {
        offer_id: 0x2::object::ID,
        buyer: address,
        collection_id: 0x2::object::ID,
        requested_asset_count: u64,
        offered_currency: 0x1::type_name::TypeName,
        offered_amount: u64,
        timestamp: u64,
        ledger_id: 0x2::object::ID,
    }

    struct BatchBuyOffersAccepted has copy, drop, store {
        accepter: address,
        total_filled: u64,
        total_cost: u64,
        timestamp: u64,
        ledger_id: 0x2::object::ID,
        offers: vector<BuyOfferAccepted>,
    }

    struct OfferCancelled has copy, drop, store {
        offer_id: 0x2::object::ID,
        offerer: address,
        collection_id: 0x2::object::ID,
        offered_asset_ids: vector<u64>,
        requested_currency: 0x1::type_name::TypeName,
        requested_amount: u64,
        timestamp: u64,
    }

    struct BuyOfferCancelled has copy, drop, store {
        offer_id: 0x2::object::ID,
        buyer: address,
        collection_id: 0x2::object::ID,
        requested_asset_count: u64,
        offered_currency: 0x1::type_name::TypeName,
        offered_amount: u64,
        timestamp: u64,
        ledger_id: 0x2::object::ID,
    }

    struct BatchOffersAccepted has copy, drop, store {
        accepter: address,
        total_filled: u64,
        total_cost: u64,
        timestamp: u64,
        ledger_id: 0x2::object::ID,
        offers: vector<OfferAccepted>,
    }

    public fun accept_buy_offer<T0>(arg0: &mut TradeLedger, arg1: 0x2::object::ID, arg2: vector<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>, arg3: vector<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::UserBalance>, arg4: &0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::CollectionCap, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(!0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::is_denied(arg4, v0), 3);
        let v1 = 0x2::table::borrow<0x2::object::ID, BuyOffer>(&arg0.buy_offers, arg1);
        assert!(v1.status == 0, 4);
        assert!(arg5 <= v1.requested_asset_count, 4);
        let v2 = v1.buyer;
        let v3 = v1.offered_amount;
        let v4 = v1.requested_asset_count;
        let v5 = 0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::coin::Coin<T0>>(&mut arg0.id, arg1);
        let v6 = arg5 * v3;
        let v7 = 0x2::coin::value<T0>(&v5);
        assert!(v7 >= v6, 3);
        if (arg5 < v4) {
            0x2::dynamic_object_field::add<0x2::object::ID, 0x2::coin::Coin<T0>>(&mut arg0.id, arg1, 0x2::coin::split<T0>(&mut v5, v7 - v6, arg7));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v0);
        let v8 = 0;
        while (v8 < arg5) {
            0x2::transfer::public_transfer<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>(0x1::vector::pop_back<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>(&mut arg2), v2);
            v8 = v8 + 1;
        };
        if (arg5 == v4) {
            0x2::table::borrow_mut<0x2::object::ID, BuyOffer>(&mut arg0.buy_offers, arg1).status = 1;
            remove_from_buy_price_index(arg0, v3, arg1);
        } else {
            0x2::table::borrow_mut<0x2::object::ID, BuyOffer>(&mut arg0.buy_offers, arg1).requested_asset_count = v4 - arg5;
        };
        while (!0x1::vector::is_empty<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>(&arg2)) {
            0x2::transfer::public_transfer<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>(0x1::vector::pop_back<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>(&mut arg2), v0);
        };
        0x1::vector::destroy_empty<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>(arg2);
        while (!0x1::vector::is_empty<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::UserBalance>(&arg3)) {
            0x2::transfer::public_transfer<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::UserBalance>(0x1::vector::pop_back<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::UserBalance>(&mut arg3), v0);
        };
        0x1::vector::destroy_empty<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::UserBalance>(arg3);
        let v9 = BuyOfferAccepted{
            offer_id              : arg1,
            buyer                 : v2,
            collection_id         : arg0.collection_id,
            requested_asset_count : arg5,
            offered_currency      : 0x1::type_name::get<T0>(),
            offered_amount        : v3,
            timestamp             : 0x2::clock::timestamp_ms(arg6),
            ledger_id             : 0x2::object::uid_to_inner(&arg0.id),
        };
        0x2::event::emit<BuyOfferAccepted>(v9);
    }

    public fun accept_offer<T0>(arg0: &mut TradeLedger, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: &0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::CollectionCap, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(!0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::is_denied(arg3, v0), 3);
        let v1 = 0x2::table::borrow<0x2::object::ID, TradeOffer>(&arg0.offers, arg1);
        assert!(v1.status == 0, 4);
        let v2 = 0x1::vector::length<u64>(&v1.offered_asset_ids);
        assert!(arg4 > 0 && arg4 <= v2, 4);
        let v3 = v1.requested_amount;
        let v4 = v1.offerer;
        let v5 = v1.collection_id;
        let v6 = v1.offered_asset_ids;
        let v7 = arg4 * v3;
        assert!(0x2::coin::value<T0>(&arg2) >= v7, 3);
        let v8 = 0x2::coin::value<T0>(&arg2) - v7;
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v8, arg6), v0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v4);
        let v9 = 0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::create_user_balance(v5, arg4, arg6);
        assert!(0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::get_user_balance_amount(&v9) == arg4, 5);
        0x2::transfer::public_transfer<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::UserBalance>(v9, v0);
        let v10 = 0x1::vector::empty<u64>();
        let v11 = 0;
        while (v11 < arg4) {
            let v12 = *0x1::vector::borrow<u64>(&v6, v11);
            let v13 = NFTFieldKey<T0>{asset_id: v12};
            0x1::vector::push_back<u64>(&mut v10, v12);
            0x2::transfer::public_transfer<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>(0x2::dynamic_object_field::remove<NFTFieldKey<T0>, 0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>(&mut arg0.id, v13), v0);
            v11 = v11 + 1;
        };
        let v14 = 0x2::table::borrow_mut<0x2::object::ID, TradeOffer>(&mut arg0.offers, arg1);
        if (arg4 == v2) {
            v14.status = 1;
            remove_from_price_index(arg0, v3, arg1);
        } else {
            let v15 = 0;
            while (v15 < arg4) {
                0x1::vector::remove<u64>(&mut v14.offered_asset_ids, 0);
                v15 = v15 + 1;
            };
        };
        let v16 = OfferAccepted{
            offer_id           : arg1,
            offerer            : v4,
            accepter           : v0,
            collection_id      : v5,
            offered_asset_ids  : v10,
            requested_currency : 0x1::type_name::get<T0>(),
            requested_amount   : v7,
            timestamp          : 0x2::clock::timestamp_ms(arg5),
            ledger_id          : 0x2::object::uid_to_inner(&arg0.id),
        };
        0x2::event::emit<OfferAccepted>(v16);
    }

    fun add_to_price_index(arg0: &mut TradeLedger, arg1: u64, arg2: 0x2::object::ID) {
        if (!0x1::vector::contains<u64>(&arg0.sorted_prices, &arg1)) {
            let v0 = &mut arg0.sorted_prices;
            insert_sorted_price(v0, arg1);
        };
        if (!0x2::table::contains<u64, vector<0x2::object::ID>>(&arg0.price_index, arg1)) {
            0x2::table::add<u64, vector<0x2::object::ID>>(&mut arg0.price_index, arg1, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<u64, vector<0x2::object::ID>>(&mut arg0.price_index, arg1), arg2);
        arg0.total_active_offers = arg0.total_active_offers + 1;
    }

    public fun batch_accept_buy_offers<T0>(arg0: &mut TradeLedger, arg1: vector<0x2::object::ID>, arg2: vector<u64>, arg3: vector<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>, arg4: vector<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::UserBalance>, arg5: &0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::CollectionCap, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(!0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::is_denied(arg5, v0), 3);
        let v1 = 0x1::vector::length<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>(&arg3);
        assert!(v1 > 0, 4);
        let v2 = 0x1::vector::length<0x2::object::ID>(&arg1);
        assert!(v2 > 0, 4);
        assert!(v2 == 0x1::vector::length<u64>(&arg2), 4);
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v5 < v2) {
            let v6 = *0x1::vector::borrow<0x2::object::ID>(&arg1, v5);
            let v7 = *0x1::vector::borrow<u64>(&arg2, v5);
            assert!(0x2::table::contains<0x2::object::ID, BuyOffer>(&arg0.buy_offers, v6), 2);
            let v8 = 0x2::table::borrow<0x2::object::ID, BuyOffer>(&arg0.buy_offers, v6);
            assert!(v8.status == 0, 3);
            assert!(v7 > 0 && v7 <= v8.requested_asset_count, 4);
            assert!(18446744073709551615 - v3 >= v7, 1);
            v3 = v3 + v7;
            let v9 = safe_mul(v8.offered_amount, v7);
            assert!(18446744073709551615 - v4 >= v9, 1);
            v4 = v4 + v9;
            v5 = v5 + 1;
        };
        assert!(v1 >= v3, 4);
        let v10 = 0;
        let v11 = 0;
        while (v11 < v2 && v10 < v1) {
            let v12 = *0x1::vector::borrow<u64>(&arg2, v11);
            let v13 = 0x1::vector::empty<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>();
            let v14 = 0;
            while (v14 < v12) {
                0x1::vector::push_back<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>(&mut v13, 0x1::vector::pop_back<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>(&mut arg3));
                v14 = v14 + 1;
            };
            let v15 = 0x1::vector::empty<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::UserBalance>();
            if (!0x1::vector::is_empty<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::UserBalance>(&arg4)) {
                0x1::vector::push_back<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::UserBalance>(&mut v15, 0x1::vector::pop_back<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::UserBalance>(&mut arg4));
            };
            accept_buy_offer<T0>(arg0, *0x1::vector::borrow<0x2::object::ID>(&arg1, v11), v13, v15, arg5, v12, arg6, arg7);
            v10 = v10 + v12;
            v11 = v11 + 1;
        };
        while (!0x1::vector::is_empty<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>(&arg3)) {
            0x2::transfer::public_transfer<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>(0x1::vector::pop_back<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>(&mut arg3), v0);
        };
        0x1::vector::destroy_empty<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>(arg3);
        while (!0x1::vector::is_empty<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::UserBalance>(&arg4)) {
            0x2::transfer::public_transfer<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::UserBalance>(0x1::vector::pop_back<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::UserBalance>(&mut arg4), v0);
        };
        0x1::vector::destroy_empty<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::UserBalance>(arg4);
        let v16 = BatchBuyOffersAccepted{
            accepter     : v0,
            total_filled : v10,
            total_cost   : v4,
            timestamp    : 0x2::clock::timestamp_ms(arg6),
            ledger_id    : 0x2::object::uid_to_inner(&arg0.id),
            offers       : 0x1::vector::empty<BuyOfferAccepted>(),
        };
        0x2::event::emit<BatchBuyOffersAccepted>(v16);
        v10
    }

    public fun batch_accept_offers<T0>(arg0: &mut TradeLedger, arg1: 0x2::coin::Coin<T0>, arg2: vector<0x2::object::ID>, arg3: vector<u64>, arg4: &0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::CollectionCap, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(!0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::is_denied(arg4, v0), 3);
        let v1 = 0x1::vector::length<0x2::object::ID>(&arg2);
        assert!(v1 > 0, 4);
        assert!(v1 == 0x1::vector::length<u64>(&arg3), 4);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            let v4 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v3);
            let v5 = *0x1::vector::borrow<u64>(&arg3, v3);
            assert!(0x2::table::contains<0x2::object::ID, TradeOffer>(&arg0.offers, v4), 2);
            let v6 = 0x2::table::borrow<0x2::object::ID, TradeOffer>(&arg0.offers, v4);
            assert!(v6.status == 0, 3);
            assert!(v5 > 0 && v5 <= 0x1::vector::length<u64>(&v6.offered_asset_ids), 4);
            let v7 = safe_mul(v6.requested_amount, v5);
            assert!(18446744073709551615 - v2 >= v7, 1);
            v2 = v2 + v7;
            v3 = v3 + 1;
        };
        assert!(0x2::coin::value<T0>(&arg1) >= v2, 3);
        let v8 = 0;
        let v9 = 0;
        while (v9 < v1) {
            let v10 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v9);
            let v11 = *0x1::vector::borrow<u64>(&arg3, v9);
            let v12 = 0x2::coin::split<T0>(&mut arg1, safe_mul(0x2::table::borrow<0x2::object::ID, TradeOffer>(&arg0.offers, v10).requested_amount, v11), arg6);
            accept_offer<T0>(arg0, v10, v12, arg4, v11, arg5, arg6);
            v8 = v8 + v11;
            v9 = v9 + 1;
        };
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
        let v13 = BatchOffersAccepted{
            accepter     : v0,
            total_filled : v8,
            total_cost   : v2,
            timestamp    : 0x2::clock::timestamp_ms(arg5),
            ledger_id    : 0x2::object::uid_to_inner(&arg0.id),
            offers       : 0x1::vector::empty<OfferAccepted>(),
        };
        0x2::event::emit<BatchOffersAccepted>(v13);
        v8
    }

    public fun cancel_buy_offer<T0>(arg0: &mut TradeLedger, arg1: 0x2::object::ID, arg2: &0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::CollectionCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::table::borrow<0x2::object::ID, BuyOffer>(&arg0.buy_offers, arg1);
        assert!(v1.buyer == v0, 2);
        assert!(v1.status == 0, 4);
        assert!(!0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::is_denied(arg2, v0), 3);
        let v2 = v1.offered_amount;
        let v3 = v1.collection_id;
        remove_from_buy_price_index(arg0, v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::coin::Coin<T0>>(&mut arg0.id, arg1), v0);
        let v4 = 0x2::table::borrow_mut<0x2::object::ID, BuyOffer>(&mut arg0.buy_offers, arg1);
        v4.status = 2;
        let v5 = BuyOfferCancelled{
            offer_id              : arg1,
            buyer                 : v0,
            collection_id         : v3,
            requested_asset_count : v4.requested_asset_count,
            offered_currency      : 0x1::type_name::get<T0>(),
            offered_amount        : v2,
            timestamp             : 0x2::clock::timestamp_ms(arg3),
            ledger_id             : 0x2::object::uid_to_inner(&arg0.id),
        };
        0x2::event::emit<BuyOfferCancelled>(v5);
    }

    public fun cancel_offer<T0>(arg0: &mut TradeLedger, arg1: 0x2::object::ID, arg2: &0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::CollectionCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::table::borrow<0x2::object::ID, TradeOffer>(&arg0.offers, arg1);
        assert!(v1.offerer == v0, 2);
        assert!(v1.status == 0, 4);
        assert!(!0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::is_denied(arg2, v0), 3);
        let v2 = v1.requested_amount;
        let v3 = v1.collection_id;
        let v4 = v1.offered_asset_ids;
        remove_from_price_index(arg0, v2, arg1);
        let v5 = 0x1::vector::length<u64>(&v4);
        let v6 = 0;
        while (v6 < v5) {
            let v7 = NFTFieldKey<T0>{asset_id: *0x1::vector::borrow<u64>(&v4, v6)};
            0x2::transfer::public_transfer<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>(0x2::dynamic_object_field::remove<NFTFieldKey<T0>, 0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>(&mut arg0.id, v7), v0);
            v6 = v6 + 1;
        };
        0x2::transfer::public_transfer<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::UserBalance>(0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::create_user_balance(v3, v5, arg4), v0);
        0x2::table::borrow_mut<0x2::object::ID, TradeOffer>(&mut arg0.offers, arg1).status = 2;
        let v8 = OfferCancelled{
            offer_id           : arg1,
            offerer            : v0,
            collection_id      : v3,
            offered_asset_ids  : v4,
            requested_currency : 0x1::type_name::get<T0>(),
            requested_amount   : v2,
            timestamp          : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<OfferCancelled>(v8);
    }

    public entry fun create_buy_offer<T0>(arg0: &LedgerRegistry, arg1: &mut TradeLedger, arg2: &0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::CollectionCap, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::get_collection_cap_id(arg2);
        let v2 = LedgerKey{
            collection_id : v1,
            currency_type : 0x1::type_name::get<T0>(),
        };
        assert!(0x2::table::contains<LedgerKey, 0x2::object::ID>(&arg0.ledgers, v2), 31);
        let v3 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(0x2::table::borrow<LedgerKey, 0x2::object::ID>(&arg0.ledgers, v2) == &v3, 6);
        assert!(arg1.currency_type == 0x1::type_name::get<T0>(), 7);
        assert!(!0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::is_denied(arg2, v0), 3);
        assert!(arg4 > 0 && arg4 <= 200, 2);
        let v4 = 0x2::coin::value<T0>(&arg3) / arg4;
        assert!(v4 > 0, 4);
        let v5 = BuyOffer{
            id                    : 0x2::object::new(arg6),
            buyer                 : v0,
            collection_id         : v1,
            requested_asset_count : arg4,
            offered_currency      : 0x1::type_name::get<T0>(),
            offered_amount        : v4,
            status                : 0,
            timestamp             : 0x2::clock::timestamp_ms(arg5),
            ledger_id             : 0x2::object::uid_to_inner(&arg1.id),
        };
        let v6 = 0x2::object::uid_to_inner(&v5.id);
        0x2::dynamic_object_field::add<0x2::object::ID, 0x2::coin::Coin<T0>>(&mut arg1.id, v6, arg3);
        0x2::table::add<0x2::object::ID, BuyOffer>(&mut arg1.buy_offers, v6, v5);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg1.user_buy_offers, v0)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg1.user_buy_offers, v0, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg1.user_buy_offers, v0), v6);
        if (!0x1::vector::contains<u64>(&arg1.sorted_buy_prices, &v4)) {
            let v7 = &mut arg1.sorted_buy_prices;
            insert_sorted_price(v7, v4);
        };
        if (!0x2::table::contains<u64, vector<0x2::object::ID>>(&arg1.buy_price_index, v4)) {
            0x2::table::add<u64, vector<0x2::object::ID>>(&mut arg1.buy_price_index, v4, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<u64, vector<0x2::object::ID>>(&mut arg1.buy_price_index, v4), v6);
        arg1.total_active_buy_offers = arg1.total_active_buy_offers + 1;
        let v8 = BuyOfferCreated{
            offer_id              : v6,
            buyer                 : v0,
            collection_id         : v1,
            requested_asset_count : arg4,
            offered_currency      : 0x1::type_name::get<T0>(),
            offered_amount        : v4,
            timestamp             : 0x2::clock::timestamp_ms(arg5),
            ledger_id             : 0x2::object::uid_to_inner(&arg1.id),
        };
        0x2::event::emit<BuyOfferCreated>(v8);
    }

    public entry fun create_sell_offer<T0>(arg0: &LedgerRegistry, arg1: &mut TradeLedger, arg2: &0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::CollectionCap, arg3: vector<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>, arg4: vector<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::UserBalance>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::get_collection_cap_id(arg2);
        assert!(arg1.collection_id == v1, 6);
        assert!(arg1.currency_type == 0x1::type_name::get<T0>(), 7);
        assert!(!0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::is_denied(arg2, v0), 3);
        assert!(arg6 > 0 && arg6 <= 200, 2);
        assert!(arg5 > 0, 4);
        assert!(0x1::vector::length<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>(&arg3) >= arg6, 4);
        let v2 = LedgerKey{
            collection_id : v1,
            currency_type : 0x1::type_name::get<T0>(),
        };
        assert!(0x2::table::contains<LedgerKey, 0x2::object::ID>(&arg0.ledgers, v2), 31);
        let v3 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(0x2::table::borrow<LedgerKey, 0x2::object::ID>(&arg0.ledgers, v2) == &v3, 6);
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::UserBalance>(&arg4)) {
            v4 = safe_add(v4, 0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::get_user_balance_amount(0x1::vector::borrow<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::UserBalance>(&arg4, v5)));
            v5 = v5 + 1;
        };
        assert!(v4 >= arg6, 3);
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0;
        while (v7 < arg6) {
            let v8 = 0x1::vector::borrow<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>(&arg3, v7);
            assert!(0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::get_nft_collection_id(v8) == v1, 6);
            0x1::vector::push_back<u64>(&mut v6, 0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::get_nft_asset_id(v8));
            v7 = v7 + 1;
        };
        let v9 = TradeOffer{
            id                 : 0x2::object::new(arg8),
            offerer            : v0,
            collection_id      : v1,
            offered_asset_ids  : v6,
            requested_currency : 0x1::type_name::get<T0>(),
            requested_amount   : arg5,
            status             : 0,
            timestamp          : 0x2::clock::timestamp_ms(arg7),
            trade_ledger_id    : 0x2::object::uid_to_inner(&arg1.id),
        };
        let v10 = 0x2::object::uid_to_inner(&v9.id);
        0x2::table::add<0x2::object::ID, TradeOffer>(&mut arg1.offers, v10, v9);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg1.user_offers, v0)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg1.user_offers, v0, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg1.user_offers, v0), v10);
        add_to_price_index(arg1, arg5, v10);
        let v11 = 0;
        while (v11 < arg6) {
            let v12 = 0x1::vector::remove<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>(&mut arg3, 0);
            let v13 = NFTFieldKey<T0>{asset_id: 0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::get_nft_asset_id(&v12)};
            0x2::dynamic_object_field::add<NFTFieldKey<T0>, 0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>(&mut arg1.id, v13, v12);
            v11 = v11 + 1;
        };
        while (!0x1::vector::is_empty<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>(&arg3)) {
            0x2::transfer::public_transfer<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>(0x1::vector::pop_back<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>(&mut arg3), v0);
        };
        0x1::vector::destroy_empty<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::NFT>(arg3);
        let v14 = 0;
        while (v14 < 0x1::vector::length<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::UserBalance>(&arg4) && arg6 > 0) {
            let v15 = 0x1::vector::borrow_mut<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::UserBalance>(&mut arg4, v14);
            let v16 = 0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::get_user_balance_amount(v15);
            if (v16 > 0) {
                if (v16 <= arg6) {
                    arg6 = arg6 - v16;
                    0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::set_user_balance_amount(v15, 0);
                } else {
                    0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::set_user_balance_amount(v15, v16 - arg6);
                    arg6 = 0;
                };
            };
            v14 = v14 + 1;
        };
        while (!0x1::vector::is_empty<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::UserBalance>(&arg4)) {
            let v17 = 0x1::vector::pop_back<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::UserBalance>(&mut arg4);
            if (0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::get_user_balance_amount(&v17) > 0) {
                0x2::transfer::public_transfer<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::UserBalance>(v17, v0);
                continue
            };
            0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::cleanup_empty_balance(v17);
        };
        0x1::vector::destroy_empty<0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::UserBalance>(arg4);
        let v18 = OfferCreated{
            offer_id           : v10,
            offerer            : v0,
            collection_id      : v1,
            offered_asset_ids  : v6,
            requested_currency : 0x1::type_name::get<T0>(),
            requested_amount   : arg5,
            timestamp          : 0x2::clock::timestamp_ms(arg7),
            ledger_id          : 0x2::object::uid_to_inner(&arg1.id),
        };
        0x2::event::emit<OfferCreated>(v18);
    }

    public fun create_trade_ledger<T0>(arg0: &mut LedgerRegistry, arg1: &0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::CollectionCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10) = 0xffec77bdbb001fb7d9770bfdee1d3d1e5f48598d77c6ba793d8452e166ccb0d4::ART20::get_collection_details(arg1);
        assert!(v1 == 0x2::tx_context::sender(arg3), 8);
        let v11 = TradeLedger{
            id                      : 0x2::object::new(arg3),
            collection_id           : v0,
            collection_creator      : v1,
            collection_name         : v2,
            collection_description  : v3,
            collection_uri          : v4,
            collection_logo_uri     : v5,
            current_supply          : v6,
            max_supply              : v7,
            is_mutable              : v8,
            has_deny_list_authority : v9,
            deny_list_size          : v10,
            currency_type           : 0x1::type_name::get<T0>(),
            offers                  : 0x2::table::new<0x2::object::ID, TradeOffer>(arg3),
            user_offers             : 0x2::table::new<address, vector<0x2::object::ID>>(arg3),
            price_index             : 0x2::table::new<u64, vector<0x2::object::ID>>(arg3),
            sorted_prices           : 0x1::vector::empty<u64>(),
            total_active_offers     : 0,
            buy_offers              : 0x2::table::new<0x2::object::ID, BuyOffer>(arg3),
            user_buy_offers         : 0x2::table::new<address, vector<0x2::object::ID>>(arg3),
            buy_price_index         : 0x2::table::new<u64, vector<0x2::object::ID>>(arg3),
            sorted_buy_prices       : 0x1::vector::empty<u64>(),
            total_active_buy_offers : 0,
            timestamp               : 0x2::clock::timestamp_ms(arg2),
        };
        let v12 = 0x2::object::uid_to_inner(&v11.id);
        register_ledger(arg0, v0, 0x1::type_name::get<T0>(), v12);
        0x2::transfer::share_object<TradeLedger>(v11);
        let v13 = TradeLedgerCreated{
            collection_id           : v0,
            creator                 : v1,
            name                    : v2,
            description             : v3,
            uri                     : v4,
            logo_uri                : v5,
            current_supply          : v6,
            max_supply              : v7,
            is_mutable              : v8,
            has_deny_list_authority : v9,
            deny_list_size          : v10,
            currency_type           : 0x1::type_name::get<T0>(),
            ledger_id               : v12,
            timestamp               : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TradeLedgerCreated>(v13);
    }

    public fun get_best_offer_price(arg0: &TradeLedger) : 0x1::option::Option<u64> {
        if (0x1::vector::is_empty<u64>(&arg0.sorted_prices)) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(*0x1::vector::borrow<u64>(&arg0.sorted_prices, 0))
        }
    }

    public fun get_offer_info<T0>(arg0: &LedgerRegistry, arg1: &TradeLedger, arg2: 0x2::object::ID) : (address, u64, u64, vector<u64>, u8) {
        let v0 = LedgerKey{
            collection_id : arg1.collection_id,
            currency_type : 0x1::type_name::get<T0>(),
        };
        assert!(0x2::table::contains<LedgerKey, 0x2::object::ID>(&arg0.ledgers, v0), 31);
        let v1 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(0x2::table::borrow<LedgerKey, 0x2::object::ID>(&arg0.ledgers, v0) == &v1, 6);
        let v2 = 0x2::table::borrow<0x2::object::ID, TradeOffer>(&arg1.offers, arg2);
        (v2.offerer, v2.requested_amount, 0x1::vector::length<u64>(&v2.offered_asset_ids), v2.offered_asset_ids, v2.status)
    }

    public fun get_offer_status(arg0: &TradeLedger, arg1: 0x2::object::ID) : u8 {
        0x2::table::borrow<0x2::object::ID, TradeOffer>(&arg0.offers, arg1).status
    }

    public fun get_offers_at_price(arg0: &TradeLedger, arg1: u64) : vector<0x2::object::ID> {
        if (0x2::table::contains<u64, vector<0x2::object::ID>>(&arg0.price_index, arg1)) {
            *0x2::table::borrow<u64, vector<0x2::object::ID>>(&arg0.price_index, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun get_price_levels(arg0: &TradeLedger) : &vector<u64> {
        &arg0.sorted_prices
    }

    public fun get_total_active_offers(arg0: &TradeLedger) : u64 {
        arg0.total_active_offers
    }

    public fun get_trade_ledger<T0>(arg0: &LedgerRegistry, arg1: 0x2::object::ID) : 0x1::option::Option<0x2::object::ID> {
        let v0 = LedgerKey{
            collection_id : arg1,
            currency_type : 0x1::type_name::get<T0>(),
        };
        if (0x2::table::contains<LedgerKey, 0x2::object::ID>(&arg0.ledgers, v0)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<LedgerKey, 0x2::object::ID>(&arg0.ledgers, v0))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun get_user_offers(arg0: &TradeLedger, arg1: address) : vector<0x2::object::ID> {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.user_offers, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.user_offers, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    fun init(arg0: MARKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LedgerRegistry{
            id      : 0x2::object::new(arg1),
            ledgers : 0x2::table::new<LedgerKey, 0x2::object::ID>(arg1),
        };
        0x2::transfer::share_object<LedgerRegistry>(v0);
    }

    fun insert_sorted_price(arg0: &mut vector<u64>, arg1: u64) {
        let v0 = 0;
        let v1 = 0x1::vector::length<u64>(arg0);
        while (v0 < v1 && *0x1::vector::borrow<u64>(arg0, v0) < arg1) {
            v0 = v0 + 1;
        };
        if (v0 == v1) {
            0x1::vector::push_back<u64>(arg0, arg1);
        } else {
            0x1::vector::insert<u64>(arg0, arg1, v0);
        };
        if (0x1::vector::length<u64>(arg0) > 10) {
            0x1::vector::pop_back<u64>(arg0);
        };
    }

    public fun is_valid_currency<T0>(arg0: &TradeLedger) : bool {
        arg0.currency_type == 0x1::type_name::get<T0>()
    }

    fun register_ledger(arg0: &mut LedgerRegistry, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: 0x2::object::ID) {
        let v0 = LedgerKey{
            collection_id : arg1,
            currency_type : arg2,
        };
        assert!(!0x2::table::contains<LedgerKey, 0x2::object::ID>(&arg0.ledgers, v0), 30);
        0x2::table::add<LedgerKey, 0x2::object::ID>(&mut arg0.ledgers, v0, arg3);
    }

    fun remove_from_buy_price_index(arg0: &mut TradeLedger, arg1: u64, arg2: 0x2::object::ID) {
        if (0x2::table::contains<u64, vector<0x2::object::ID>>(&arg0.buy_price_index, arg1)) {
            let v0 = 0x2::table::borrow_mut<u64, vector<0x2::object::ID>>(&mut arg0.buy_price_index, arg1);
            let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(v0, &arg2);
            if (v1) {
                0x1::vector::remove<0x2::object::ID>(v0, v2);
                arg0.total_active_buy_offers = arg0.total_active_buy_offers - 1;
                if (0x1::vector::is_empty<0x2::object::ID>(v0)) {
                    let (v3, v4) = 0x1::vector::index_of<u64>(&arg0.sorted_buy_prices, &arg1);
                    if (v3) {
                        0x1::vector::remove<u64>(&mut arg0.sorted_buy_prices, v4);
                    };
                };
            };
        };
    }

    fun remove_from_price_index(arg0: &mut TradeLedger, arg1: u64, arg2: 0x2::object::ID) {
        if (0x2::table::contains<u64, vector<0x2::object::ID>>(&arg0.price_index, arg1)) {
            let v0 = 0x2::table::borrow_mut<u64, vector<0x2::object::ID>>(&mut arg0.price_index, arg1);
            let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(v0, &arg2);
            if (v1) {
                0x1::vector::remove<0x2::object::ID>(v0, v2);
                arg0.total_active_offers = arg0.total_active_offers - 1;
                if (0x1::vector::is_empty<0x2::object::ID>(v0)) {
                    0x2::table::remove<u64, vector<0x2::object::ID>>(&mut arg0.price_index, arg1);
                    let (v3, v4) = 0x1::vector::index_of<u64>(&arg0.sorted_prices, &arg1);
                    if (v3) {
                        0x1::vector::remove<u64>(&mut arg0.sorted_prices, v4);
                    };
                };
            };
        };
    }

    fun safe_add(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 1);
        arg0 + arg1
    }

    fun safe_mul(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 == 0 || arg0 <= 18446744073709551615 / arg1, 1);
        arg0 * arg1
    }

    // decompiled from Move bytecode v6
}

