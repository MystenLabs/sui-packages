module 0xb89a07a02ab3f5a01fb86c5e5e50fcc385ecaec21499a947cc61879bb08c143e::marketplace {
    struct CollectorCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MarketPlaceStore has key {
        id: 0x2::object::UID,
        points_admin_cap: 0x74beade4b0041bfbfd327f6f8612ee7c9d1ce4ac31e55bcf3837af0137094567::soulbound::PointsAdminCap,
        commission_pct: u64,
        available_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        user_activity: 0x2::linked_table::LinkedTable<address, UserInfo>,
        active_collections: 0x2::linked_table::LinkedTable<0x1::ascii::String, bool>,
        version: u64,
    }

    struct UserInfo has store, key {
        id: 0x2::object::UID,
        listings: 0x2::linked_table::LinkedTable<0x2::object::ID, 0x1::ascii::String>,
        bids: 0x2::linked_table::LinkedTable<0x2::object::ID, BidInfo>,
        collection_bids: 0x2::linked_table::LinkedTable<0x1::ascii::String, vector<BidInfo>>,
    }

    struct BidInfo has store {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        bid_price: u64,
        is_collection_bid: bool,
    }

    struct CollectionMarketPlace<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        listings: 0x2::linked_table::LinkedTable<0x2::object::ID, Listing<T0>>,
        bids: 0x2::linked_table::LinkedTable<0x2::object::ID, ActiveBids>,
        collection_bids: 0x2::linked_table::LinkedTable<address, vector<ActiveBid>>,
        lifetime_volume: u128,
        sbt_points_enabled: bool,
        sbt_point_multiplier: u64,
        multiplier_valid_till: u64,
    }

    struct Listing<phantom T0: store + key> has store {
        seller: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        cap: 0x2::kiosk::PurchaseCap<T0>,
        price: u64,
        commission: u64,
    }

    struct ActiveBids has store, key {
        id: 0x2::object::UID,
        bids: 0x2::linked_table::LinkedTable<address, ActiveBid>,
    }

    struct ActiveBid has store, key {
        id: 0x2::object::UID,
        bidder: address,
        bid_price: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct UpdateActiveCollectionsEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        boolean: bool,
    }

    struct CollectCommissionsEvent has copy, drop {
        recepient: address,
        amount: u64,
    }

    struct UpdateSBTMultiplierEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        is_sbt_points_enabled: bool,
        sbt_point_multiplier: u64,
        multiplier_valid_till: u64,
    }

    struct ListEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        seller: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        price: u64,
    }

    struct UnlistEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        seller: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        price: u64,
    }

    struct MakeBidEvent has copy, drop {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        buyer: address,
        nft_id: 0x1::option::Option<0x2::object::ID>,
        price: u64,
        is_collection_bid: bool,
    }

    struct CancelBidEvent has copy, drop {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        bidder: address,
        nft_id: 0x1::option::Option<0x2::object::ID>,
        is_collection_bid: bool,
    }

    struct BuyEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        seller_kiosk: 0x2::object::ID,
        price: u64,
        commission: u64,
    }

    struct AcceptBidEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        seller_kiosk: 0x2::object::ID,
        buyer_kiosk: 0x2::object::ID,
        is_collection_bid: bool,
        price: u64,
        commission: u64,
    }

    public fun accept_bid<T0: store + key>(arg0: &mut MarketPlaceStore, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: bool, arg7: &0x2::transfer_policy::TransferPolicy<T0>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        validation_check(arg0);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::kiosk::owner(arg2);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, v0), 9011);
        0x2::linked_table::remove<0x2::object::ID, 0x1::ascii::String>(&mut 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg0.user_activity, v0).listings, arg4);
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, v1), 9012);
        let v3 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg0.user_activity, v1);
        if (arg6) {
            assert!(0x2::linked_table::contains<0x1::ascii::String, vector<BidInfo>>(&v3.collection_bids, v2), 9007);
            let v4 = 0x2::linked_table::borrow_mut<0x1::ascii::String, vector<BidInfo>>(&mut v3.collection_bids, v2);
            let v5 = 0;
            while (v5 < 0x1::vector::length<BidInfo>(v4)) {
                if (0x1::vector::borrow<BidInfo>(v4, v5).bid_id == arg5) {
                    destroy_bid_info(0x1::vector::remove<BidInfo>(v4, v5));
                    break
                };
                v5 = v5 + 1;
            };
        } else {
            assert!(0x2::linked_table::contains<0x2::object::ID, BidInfo>(&v3.bids, arg4), 9007);
            destroy_bid_info(0x2::linked_table::remove<0x2::object::ID, BidInfo>(&mut v3.bids, arg4));
        };
        let v6 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v2);
        assert!(0x2::linked_table::contains<0x2::object::ID, Listing<T0>>(&v6.listings, arg4), 9001);
        let (v7, v8, _, _) = destroy_listing<T0>(0x2::linked_table::remove<0x2::object::ID, Listing<T0>>(&mut v6.listings, arg4));
        assert!(v8 == 0x2::object::id<0x2::kiosk::Kiosk>(arg1), 9009);
        let v11 = 0x2::balance::zero<0x2::sui::SUI>();
        if (arg6) {
            let v12 = 0x2::linked_table::borrow_mut<address, vector<ActiveBid>>(&mut v6.collection_bids, v1);
            let v13 = 0;
            while (v13 < 0x1::vector::length<ActiveBid>(v12)) {
                if (0x2::object::uid_to_inner(&0x1::vector::borrow<ActiveBid>(v12, v13).id) == arg5) {
                    0x2::balance::join<0x2::sui::SUI>(&mut v11, destroy_active_bid(0x1::vector::remove<ActiveBid>(v12, v13)));
                    break
                };
                v13 = v13 + 1;
            };
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut v11, destroy_active_bid(0x2::linked_table::remove<address, ActiveBid>(&mut 0x2::linked_table::borrow_mut<0x2::object::ID, ActiveBids>(&mut v6.bids, arg4).bids, v1)));
        };
        v6.lifetime_volume = v6.lifetime_volume + (0x2::balance::value<0x2::sui::SUI>(&v11) as u128);
        let v14 = 0x2::balance::value<0x2::sui::SUI>(&v11) * arg0.commission_pct / 100;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.available_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v11, v14));
        let (v15, v16) = 0x2::kiosk::purchase_with_cap<T0>(arg1, v7, 0x2::coin::from_balance<0x2::sui::SUI>(v11, arg8));
        0x2::kiosk::lock<T0>(arg2, arg3, arg7, v15);
        let v17 = AcceptBidEvent{
            nft_type          : v2,
            nft_id            : arg4,
            seller            : v0,
            buyer             : v1,
            seller_kiosk      : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            buyer_kiosk       : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            is_collection_bid : arg6,
            price             : 0x2::balance::value<0x2::sui::SUI>(&v11),
            commission        : v14,
        };
        0x2::event::emit<AcceptBidEvent>(v17);
        v16
    }

    public fun buy<T0: store + key>(arg0: &mut MarketPlaceStore, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>, u64) {
        validation_check(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::kiosk::owner(arg1);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, v1), 9000);
        let v3 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg0.user_activity, v1);
        assert!(0x2::linked_table::contains<0x2::object::ID, 0x1::ascii::String>(&v3.listings, arg2), 9001);
        0x2::linked_table::remove<0x2::object::ID, 0x1::ascii::String>(&mut v3.listings, arg2);
        let v4 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v2);
        assert!(0x2::linked_table::contains<0x2::object::ID, Listing<T0>>(&v4.listings, arg2), 9008);
        let v5 = 0x2::linked_table::remove<0x2::object::ID, Listing<T0>>(&mut v4.listings, arg2);
        v4.lifetime_volume = v4.lifetime_volume + (v5.price as u128) + (v5.commission as u128);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v5.price + v5.commission, 9003);
        let v6 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.available_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v6, v5.commission));
        let (v7, v8, v9, v10) = destroy_listing<T0>(v5);
        assert!(v8 == 0x2::object::id<0x2::kiosk::Kiosk>(arg1), 9009);
        let (v11, v12) = 0x2::kiosk::purchase_with_cap<T0>(arg1, v7, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v6, v9), arg4));
        let v13 = v11;
        let v14 = BuyEvent{
            nft_type     : v2,
            nft_id       : 0x2::object::id<T0>(&v13),
            buyer        : v0,
            seller       : v1,
            seller_kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            price        : v9,
            commission   : v10,
        };
        0x2::event::emit<BuyEvent>(v14);
        0xb89a07a02ab3f5a01fb86c5e5e50fcc385ecaec21499a947cc61879bb08c143e::helpers::destroy_or_transfer_balance<0x2::sui::SUI>(v6, v0, arg4);
        (v13, v12, v9)
    }

    public fun cancel_bid<T0: store + key>(arg0: &mut MarketPlaceStore, arg1: 0x1::option::Option<0x2::object::ID>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v2 = !0x1::option::is_some<0x2::object::ID>(&arg1);
        assert!(0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v1), 9005);
        let v3 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v1);
        let v4 = 0x2::balance::zero<0x2::sui::SUI>();
        if (!v2) {
            let v5 = *0x1::option::borrow<0x2::object::ID>(&arg1);
            assert!(0x2::linked_table::contains<0x2::object::ID, ActiveBids>(&v3.bids, v5), 9007);
            0x2::balance::join<0x2::sui::SUI>(&mut v4, destroy_active_bid(0x2::linked_table::remove<address, ActiveBid>(&mut 0x2::linked_table::borrow_mut<0x2::object::ID, ActiveBids>(&mut v3.bids, v5).bids, v0)));
        } else {
            assert!(0x2::linked_table::contains<address, vector<ActiveBid>>(&v3.collection_bids, v0), 9007);
            let v6 = 0x2::linked_table::borrow_mut<address, vector<ActiveBid>>(&mut v3.collection_bids, v0);
            let v7 = 0;
            while (v7 < 0x1::vector::length<ActiveBid>(v6)) {
                if (0x2::object::uid_to_inner(&0x1::vector::borrow<ActiveBid>(v6, v7).id) == arg2) {
                    0x2::balance::join<0x2::sui::SUI>(&mut v4, destroy_active_bid(0x1::vector::remove<ActiveBid>(v6, v7)));
                    break
                };
                v7 = v7 + 1;
            };
        };
        0xb89a07a02ab3f5a01fb86c5e5e50fcc385ecaec21499a947cc61879bb08c143e::helpers::destroy_or_transfer_balance<0x2::sui::SUI>(v4, v0, arg3);
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, v0), 9000);
        let v8 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg0.user_activity, v0);
        if (v2) {
            assert!(0x2::linked_table::contains<0x1::ascii::String, vector<BidInfo>>(&v8.collection_bids, v1), 9007);
            let v9 = 0x2::linked_table::borrow_mut<0x1::ascii::String, vector<BidInfo>>(&mut v8.collection_bids, v1);
            let v10 = 0;
            while (v10 < 0x1::vector::length<BidInfo>(v9)) {
                if (0x1::vector::borrow<BidInfo>(v9, v10).bid_id == arg2) {
                    destroy_bid_info(0x1::vector::remove<BidInfo>(v9, v10));
                    break
                };
                v10 = v10 + 1;
            };
        } else {
            let v11 = *0x1::option::borrow<0x2::object::ID>(&arg1);
            assert!(0x2::linked_table::contains<0x2::object::ID, BidInfo>(&v8.bids, v11), 9007);
            destroy_bid_info(0x2::linked_table::remove<0x2::object::ID, BidInfo>(&mut v8.bids, v11));
        };
        let v12 = CancelBidEvent{
            bid_id            : arg2,
            nft_type          : v1,
            bidder            : v0,
            nft_id            : arg1,
            is_collection_bid : v2,
        };
        0x2::event::emit<CancelBidEvent>(v12);
    }

    public fun collect_commissions(arg0: &mut MarketPlaceStore, arg1: &CollectorCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = CollectCommissionsEvent{
            recepient : arg2,
            amount    : 0x2::balance::value<0x2::sui::SUI>(&arg0.available_sui),
        };
        0x2::event::emit<CollectCommissionsEvent>(v0);
        0xb89a07a02ab3f5a01fb86c5e5e50fcc385ecaec21499a947cc61879bb08c143e::helpers::destroy_or_transfer_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.available_sui), arg2, arg3);
    }

    fun destroy_active_bid(arg0: ActiveBid) : 0x2::balance::Balance<0x2::sui::SUI> {
        let ActiveBid {
            id        : v0,
            bidder    : _,
            bid_price : _,
            balance   : v3,
        } = arg0;
        0x2::object::delete(v0);
        v3
    }

    fun destroy_bid_info(arg0: BidInfo) {
        let BidInfo {
            bid_id            : _,
            nft_type          : _,
            bid_price         : _,
            is_collection_bid : _,
        } = arg0;
    }

    fun destroy_listing<T0: store + key>(arg0: Listing<T0>) : (0x2::kiosk::PurchaseCap<T0>, 0x2::object::ID, u64, u64) {
        let Listing {
            seller     : _,
            kiosk_id   : v1,
            nft_id     : _,
            cap        : v3,
            price      : v4,
            commission : v5,
        } = arg0;
        (v3, v1, v4, v5)
    }

    public fun get_bids_for_listing<T0: store + key>(arg0: &MarketPlaceStore, arg1: 0x2::object::ID, arg2: 0x1::option::Option<address>, arg3: u64) : (vector<address>, vector<0x2::object::ID>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        if (!0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
            return (v1, v2, v3, v4, 0)
        };
        let v5 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, CollectionMarketPlace<T0>>(&arg0.id, v0);
        if (!0x2::linked_table::contains<0x2::object::ID, ActiveBids>(&v5.bids, arg1)) {
            return (v1, v2, v3, v4, 0)
        };
        let v6 = 0x2::linked_table::borrow<0x2::object::ID, ActiveBids>(&v5.bids, arg1);
        let v7 = if (0x1::option::is_some<address>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<address, ActiveBid>(&v6.bids)
        };
        let v8 = v7;
        let v9 = 0;
        while (0x1::option::is_some<address>(&v8) && v9 < arg3) {
            let v10 = 0x1::option::borrow<address>(&v8);
            let v11 = 0x2::linked_table::borrow<address, ActiveBid>(&v6.bids, *v10);
            0x1::vector::push_back<address>(&mut v1, *v10);
            0x1::vector::push_back<0x2::object::ID>(&mut v2, 0x2::object::uid_to_inner(&v11.id));
            0x1::vector::push_back<u64>(&mut v3, v11.bid_price);
            0x1::vector::push_back<u64>(&mut v4, 0x2::balance::value<0x2::sui::SUI>(&v11.balance));
            v8 = *0x2::linked_table::next<address, ActiveBid>(&v6.bids, *v10);
            v9 = v9 + 1;
        };
        (v1, v2, v3, v4, 0x2::linked_table::length<address, ActiveBid>(&v6.bids))
    }

    public fun get_collection_bidders_for_collection<T0: store + key>(arg0: &MarketPlaceStore, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<address>, vector<u64>, u64) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x1::vector::empty<u64>();
        if (!0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
            return (v1, v2, 0)
        };
        let v3 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, CollectionMarketPlace<T0>>(&arg0.id, v0);
        let v4 = if (0x1::option::is_some<address>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<address, vector<ActiveBid>>(&v3.collection_bids)
        };
        let v5 = v4;
        let v6 = 0;
        while (0x1::option::is_some<address>(&v5) && v6 < arg2) {
            let v7 = 0x1::option::borrow<address>(&v5);
            0x1::vector::push_back<address>(&mut v1, *v7);
            0x1::vector::push_back<u64>(&mut v2, 0x1::vector::length<ActiveBid>(0x2::linked_table::borrow<address, vector<ActiveBid>>(&v3.collection_bids, *v7)));
            v5 = *0x2::linked_table::next<address, vector<ActiveBid>>(&v3.collection_bids, *v7);
            v6 = v6 + 1;
        };
        (v1, v2, 0x2::linked_table::length<address, vector<ActiveBid>>(&v3.collection_bids))
    }

    public fun get_collection_bids_by_user_for_collection<T0: store + key>(arg0: &MarketPlaceStore, arg1: address) : (vector<0x2::object::ID>, vector<u64>, vector<u64>) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        if (!0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
            return (v1, v2, v3)
        };
        let v4 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, CollectionMarketPlace<T0>>(&arg0.id, v0);
        if (!0x2::linked_table::contains<address, vector<ActiveBid>>(&v4.collection_bids, arg1)) {
            return (v1, v2, v3)
        };
        let v5 = 0x2::linked_table::borrow<address, vector<ActiveBid>>(&v4.collection_bids, arg1);
        let v6 = 0;
        while (v6 < 0x1::vector::length<ActiveBid>(v5)) {
            let v7 = 0x1::vector::borrow<ActiveBid>(v5, v6);
            0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x2::object::uid_to_inner(&v7.id));
            0x1::vector::push_back<u64>(&mut v2, v7.bid_price);
            0x1::vector::push_back<u64>(&mut v3, 0x2::balance::value<0x2::sui::SUI>(&v7.balance));
            v6 = v6 + 1;
        };
        (v1, v2, v3)
    }

    public fun get_collection_marketplace_info<T0: store + key>(arg0: &MarketPlaceStore) : (u64, u64, u64, u128, bool, u64, u64) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (!0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
            return (0, 0, 0, 0, false, 0, 0)
        };
        let v1 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, CollectionMarketPlace<T0>>(&arg0.id, v0);
        (0x2::linked_table::length<0x2::object::ID, Listing<T0>>(&v1.listings), 0x2::linked_table::length<0x2::object::ID, ActiveBids>(&v1.bids), 0x2::linked_table::length<address, vector<ActiveBid>>(&v1.collection_bids), v1.lifetime_volume, v1.sbt_points_enabled, v1.sbt_point_multiplier, v1.multiplier_valid_till)
    }

    public fun get_listings_for_marketplace<T0: store + key>(arg0: &MarketPlaceStore, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u64) : (vector<address>, vector<0x2::object::ID>, vector<0x2::object::ID>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        if (!0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
            return (v1, v2, v3, v4, v5, 0)
        };
        let v6 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, CollectionMarketPlace<T0>>(&arg0.id, v0);
        let v7 = if (0x1::option::is_some<0x2::object::ID>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<0x2::object::ID, Listing<T0>>(&v6.listings)
        };
        let v8 = v7;
        let v9 = 0;
        while (0x1::option::is_some<0x2::object::ID>(&v8) && v9 < arg2) {
            let v10 = 0x1::option::borrow<0x2::object::ID>(&v8);
            let v11 = 0x2::linked_table::borrow<0x2::object::ID, Listing<T0>>(&v6.listings, *v10);
            0x1::vector::push_back<0x2::object::ID>(&mut v3, *v10);
            0x1::vector::push_back<address>(&mut v1, v11.seller);
            0x1::vector::push_back<0x2::object::ID>(&mut v2, v11.kiosk_id);
            0x1::vector::push_back<0x2::object::ID>(&mut v3, v11.nft_id);
            0x1::vector::push_back<u64>(&mut v4, v11.price);
            0x1::vector::push_back<u64>(&mut v5, v11.commission);
            v8 = *0x2::linked_table::next<0x2::object::ID, Listing<T0>>(&v6.listings, *v10);
            v9 = v9 + 1;
        };
        (v1, v2, v3, v4, v5, 0x2::linked_table::length<0x2::object::ID, Listing<T0>>(&v6.listings))
    }

    public fun get_marketplace_info(arg0: &MarketPlaceStore) : (address, u64, u64, u64, u64, u64) {
        (0x2::object::uid_to_address(&arg0.id), arg0.commission_pct, 0x2::balance::value<0x2::sui::SUI>(&arg0.available_sui), 0x2::linked_table::length<address, UserInfo>(&arg0.user_activity), 0x2::linked_table::length<0x1::ascii::String, bool>(&arg0.active_collections), arg0.version)
    }

    public fun get_user_activity_info(arg0: &MarketPlaceStore, arg1: address) : (u64, u64, u64) {
        if (!0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, arg1)) {
            (0, 0, 0)
        } else {
            let v3 = 0x2::linked_table::borrow<address, UserInfo>(&arg0.user_activity, arg1);
            (0x2::linked_table::length<0x2::object::ID, 0x1::ascii::String>(&v3.listings), 0x2::linked_table::length<0x2::object::ID, BidInfo>(&v3.bids), 0x2::linked_table::length<0x1::ascii::String, vector<BidInfo>>(&v3.collection_bids))
        }
    }

    public fun get_user_addresses_list(arg0: &MarketPlaceStore, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<address>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = if (0x1::option::is_some<address>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<address, UserInfo>(&arg0.user_activity)
        };
        let v2 = v1;
        let v3 = 0;
        while (0x1::option::is_some<address>(&v2) && v3 < arg2) {
            let v4 = 0x1::option::borrow<address>(&v2);
            0x1::vector::push_back<address>(&mut v0, *v4);
            v2 = *0x2::linked_table::next<address, UserInfo>(&arg0.user_activity, *v4);
            v3 = v3 + 1;
        };
        (v0, 0x2::linked_table::length<address, UserInfo>(&arg0.user_activity))
    }

    public fun get_user_bids_info(arg0: &MarketPlaceStore, arg1: address, arg2: 0x1::option::Option<0x2::object::ID>, arg3: u64) : (vector<0x2::object::ID>, vector<0x1::ascii::String>, vector<0x2::object::ID>, vector<u64>, vector<bool>, u64) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<bool>();
        if (!0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, arg1)) {
            return (v0, v1, v2, v3, v4, 0)
        };
        let v5 = 0x2::linked_table::borrow<address, UserInfo>(&arg0.user_activity, arg1);
        let v6 = if (0x1::option::is_some<0x2::object::ID>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<0x2::object::ID, BidInfo>(&v5.bids)
        };
        let v7 = v6;
        let v8 = 0;
        while (0x1::option::is_some<0x2::object::ID>(&v7) && v8 < arg3) {
            let v9 = 0x1::option::borrow<0x2::object::ID>(&v7);
            let v10 = 0x2::linked_table::borrow<0x2::object::ID, BidInfo>(&v5.bids, *v9);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, *v9);
            0x1::vector::push_back<0x1::ascii::String>(&mut v1, v10.nft_type);
            0x1::vector::push_back<0x2::object::ID>(&mut v2, v10.bid_id);
            0x1::vector::push_back<u64>(&mut v3, v10.bid_price);
            0x1::vector::push_back<bool>(&mut v4, v10.is_collection_bid);
            v7 = *0x2::linked_table::next<0x2::object::ID, BidInfo>(&v5.bids, *v9);
            v8 = v8 + 1;
        };
        (v0, v1, v2, v3, v4, 0x2::linked_table::length<0x2::object::ID, BidInfo>(&v5.bids))
    }

    public fun get_user_collection_bids_for_type(arg0: &MarketPlaceStore, arg1: address, arg2: 0x1::ascii::String) : (vector<0x2::object::ID>, vector<u64>) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::empty<u64>();
        if (!0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, arg1)) {
            return (v0, v1)
        };
        let v2 = 0x2::linked_table::borrow<0x1::ascii::String, vector<BidInfo>>(&0x2::linked_table::borrow<address, UserInfo>(&arg0.user_activity, arg1).collection_bids, arg2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<BidInfo>(v2)) {
            let v4 = 0x1::vector::borrow<BidInfo>(v2, v3);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, v4.bid_id);
            0x1::vector::push_back<u64>(&mut v1, v4.bid_price);
            v3 = v3 + 1;
        };
        (v0, v1)
    }

    public fun get_user_collection_bids_info(arg0: &MarketPlaceStore, arg1: address, arg2: 0x1::option::Option<0x1::ascii::String>, arg3: u64) : (vector<0x1::ascii::String>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0x1::vector::empty<u64>();
        if (!0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, arg1)) {
            return (v0, v1, 0)
        };
        let v2 = 0x2::linked_table::borrow<address, UserInfo>(&arg0.user_activity, arg1);
        let v3 = if (0x1::option::is_some<0x1::ascii::String>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<0x1::ascii::String, vector<BidInfo>>(&v2.collection_bids)
        };
        let v4 = v3;
        let v5 = 0;
        while (0x1::option::is_some<0x1::ascii::String>(&v4) && v5 < arg3) {
            let v6 = 0x1::option::borrow<0x1::ascii::String>(&v4);
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, *v6);
            0x1::vector::push_back<u64>(&mut v1, 0x1::vector::length<BidInfo>(0x2::linked_table::borrow<0x1::ascii::String, vector<BidInfo>>(&v2.collection_bids, *v6)));
            v4 = *0x2::linked_table::next<0x1::ascii::String, vector<BidInfo>>(&v2.collection_bids, *v6);
            v5 = v5 + 1;
        };
        (v0, v1, 0x2::linked_table::length<0x1::ascii::String, vector<BidInfo>>(&v2.collection_bids))
    }

    public fun get_user_listings_info(arg0: &MarketPlaceStore, arg1: address, arg2: 0x1::option::Option<0x2::object::ID>, arg3: u64) : (vector<0x2::object::ID>, vector<0x1::ascii::String>, u64) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        if (!0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, arg1)) {
            return (v0, v1, 0)
        };
        let v2 = 0x2::linked_table::borrow<address, UserInfo>(&arg0.user_activity, arg1);
        let v3 = if (0x1::option::is_some<0x2::object::ID>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<0x2::object::ID, 0x1::ascii::String>(&v2.listings)
        };
        let v4 = v3;
        let v5 = 0;
        while (0x1::option::is_some<0x2::object::ID>(&v4) && v5 < arg3) {
            let v6 = 0x1::option::borrow<0x2::object::ID>(&v4);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, *v6);
            0x1::vector::push_back<0x1::ascii::String>(&mut v1, *0x2::linked_table::borrow<0x2::object::ID, 0x1::ascii::String>(&v2.listings, *v6));
            v4 = *0x2::linked_table::next<0x2::object::ID, 0x1::ascii::String>(&v2.listings, *v6);
            v5 = v5 + 1;
        };
        (v0, v1, 0x2::linked_table::length<0x2::object::ID, 0x1::ascii::String>(&v2.listings))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CollectorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<CollectorCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun init_marketplace(arg0: &AdminCap, arg1: 0x74beade4b0041bfbfd327f6f8612ee7c9d1ce4ac31e55bcf3837af0137094567::soulbound::PointsAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketPlaceStore{
            id                 : 0x2::object::new(arg2),
            points_admin_cap   : arg1,
            commission_pct     : 0,
            available_sui      : 0x2::balance::zero<0x2::sui::SUI>(),
            user_activity      : 0x2::linked_table::new<address, UserInfo>(arg2),
            active_collections : 0x2::linked_table::new<0x1::ascii::String, bool>(arg2),
            version            : 0,
        };
        0x2::transfer::share_object<MarketPlaceStore>(v0);
    }

    public entry fun list<T0: store + key>(arg0: &mut MarketPlaceStore, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v2), 9005);
        let v3 = arg4 * arg0.commission_pct / 100;
        let v4 = Listing<T0>{
            seller     : v0,
            kiosk_id   : v1,
            nft_id     : arg3,
            cap        : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, arg4 - v3, arg5),
            price      : arg4,
            commission : v3,
        };
        0x2::linked_table::push_back<0x2::object::ID, Listing<T0>>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v2).listings, arg3, v4);
        if (!0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, v0)) {
            let v5 = UserInfo{
                id              : 0x2::object::new(arg5),
                listings        : 0x2::linked_table::new<0x2::object::ID, 0x1::ascii::String>(arg5),
                bids            : 0x2::linked_table::new<0x2::object::ID, BidInfo>(arg5),
                collection_bids : 0x2::linked_table::new<0x1::ascii::String, vector<BidInfo>>(arg5),
            };
            0x2::linked_table::push_back<address, UserInfo>(&mut arg0.user_activity, v0, v5);
        };
        0x2::linked_table::push_back<0x2::object::ID, 0x1::ascii::String>(&mut 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg0.user_activity, v0).listings, arg3, v2);
        let v6 = ListEvent{
            nft_type : v2,
            seller   : v0,
            kiosk_id : v1,
            nft_id   : arg3,
            price    : arg4,
        };
        0x2::event::emit<ListEvent>(v6);
    }

    public entry fun make_bid<T0: store + key>(arg0: &mut MarketPlaceStore, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v2 = !0x1::option::is_some<0x2::object::ID>(&arg1);
        assert!(0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v1), 9005);
        let v3 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v1);
        let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        let v5 = ActiveBid{
            id        : 0x2::object::new(arg4),
            bidder    : v0,
            bid_price : arg2,
            balance   : 0x2::balance::split<0x2::sui::SUI>(&mut v4, arg2),
        };
        let v6 = 0x2::object::id<ActiveBid>(&v5);
        if (!v2) {
            let v7 = *0x1::option::borrow<0x2::object::ID>(&arg1);
            assert!(0x2::linked_table::contains<0x2::object::ID, Listing<T0>>(&v3.listings, v7), 9001);
            if (0x2::linked_table::contains<0x2::object::ID, ActiveBids>(&v3.bids, v7)) {
                let v8 = 0x2::linked_table::borrow_mut<0x2::object::ID, ActiveBids>(&mut v3.bids, v7);
                assert!(!0x2::linked_table::contains<address, ActiveBid>(&v8.bids, v0), 9006);
                0x2::linked_table::push_back<address, ActiveBid>(&mut v8.bids, v0, v5);
            } else {
                let v9 = ActiveBids{
                    id   : 0x2::object::new(arg4),
                    bids : 0x2::linked_table::new<address, ActiveBid>(arg4),
                };
                0x2::linked_table::push_back<address, ActiveBid>(&mut v9.bids, v0, v5);
                0x2::linked_table::push_back<0x2::object::ID, ActiveBids>(&mut v3.bids, v7, v9);
            };
        } else if (0x2::linked_table::contains<address, vector<ActiveBid>>(&v3.collection_bids, v0)) {
            0x1::vector::push_back<ActiveBid>(0x2::linked_table::borrow_mut<address, vector<ActiveBid>>(&mut v3.collection_bids, v0), v5);
        } else {
            let v10 = 0x1::vector::empty<ActiveBid>();
            0x1::vector::push_back<ActiveBid>(&mut v10, v5);
            0x2::linked_table::push_back<address, vector<ActiveBid>>(&mut v3.collection_bids, v0, v10);
        };
        let v11 = BidInfo{
            bid_id            : v6,
            nft_type          : v1,
            bid_price         : arg2,
            is_collection_bid : v2,
        };
        if (!0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, v0)) {
            let v12 = UserInfo{
                id              : 0x2::object::new(arg4),
                listings        : 0x2::linked_table::new<0x2::object::ID, 0x1::ascii::String>(arg4),
                bids            : 0x2::linked_table::new<0x2::object::ID, BidInfo>(arg4),
                collection_bids : 0x2::linked_table::new<0x1::ascii::String, vector<BidInfo>>(arg4),
            };
            0x2::linked_table::push_back<address, UserInfo>(&mut arg0.user_activity, v0, v12);
        };
        let v13 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg0.user_activity, v0);
        if (v2) {
            if (0x2::linked_table::contains<0x1::ascii::String, vector<BidInfo>>(&v13.collection_bids, v1)) {
                0x1::vector::push_back<BidInfo>(0x2::linked_table::borrow_mut<0x1::ascii::String, vector<BidInfo>>(&mut v13.collection_bids, v1), v11);
            } else {
                let v14 = 0x1::vector::empty<BidInfo>();
                0x1::vector::push_back<BidInfo>(&mut v14, v11);
                0x2::linked_table::push_back<0x1::ascii::String, vector<BidInfo>>(&mut v13.collection_bids, v1, v14);
            };
        } else {
            let v15 = *0x1::option::borrow<0x2::object::ID>(&arg1);
            assert!(0x2::linked_table::contains<0x2::object::ID, BidInfo>(&v13.bids, v15), 9006);
            0x2::linked_table::push_back<0x2::object::ID, BidInfo>(&mut v13.bids, v15, v11);
        };
        let v16 = MakeBidEvent{
            bid_id            : v6,
            nft_type          : v1,
            buyer             : v0,
            nft_id            : arg1,
            price             : arg2,
            is_collection_bid : v2,
        };
        0x2::event::emit<MakeBidEvent>(v16);
        0xb89a07a02ab3f5a01fb86c5e5e50fcc385ecaec21499a947cc61879bb08c143e::helpers::destroy_or_transfer_balance<0x2::sui::SUI>(v4, v0, arg4);
    }

    public fun unlist<T0: store + key>(arg0: &mut MarketPlaceStore, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, v0), 9000);
        let v2 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg0.user_activity, v0);
        assert!(0x2::linked_table::contains<0x2::object::ID, 0x1::ascii::String>(&v2.listings, arg2), 9001);
        0x2::linked_table::remove<0x2::object::ID, 0x1::ascii::String>(&mut v2.listings, arg2);
        let v3 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v1);
        assert!(0x2::linked_table::contains<0x2::object::ID, Listing<T0>>(&v3.listings, arg2), 9001);
        let v4 = 0x2::linked_table::remove<0x2::object::ID, Listing<T0>>(&mut v3.listings, arg2);
        let v5 = UnlistEvent{
            nft_type : v1,
            seller   : v0,
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            nft_id   : arg2,
            price    : v4.price,
        };
        0x2::event::emit<UnlistEvent>(v5);
        let Listing {
            seller     : _,
            kiosk_id   : _,
            nft_id     : _,
            cap        : v9,
            price      : _,
            commission : _,
        } = v4;
        0x2::kiosk::return_purchase_cap<T0>(arg1, v9);
    }

    public fun update_active_collections<T0: store + key>(arg0: &mut MarketPlaceStore, arg1: &AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (arg2) {
            if (!0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v0)) {
                0x2::linked_table::push_back<0x1::ascii::String, bool>(&mut arg0.active_collections, v0, true);
            } else {
                *0x2::linked_table::borrow_mut<0x1::ascii::String, bool>(&mut arg0.active_collections, v0) = true;
            };
            if (!0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
                let v1 = CollectionMarketPlace<T0>{
                    id                    : 0x2::object::new(arg3),
                    listings              : 0x2::linked_table::new<0x2::object::ID, Listing<T0>>(arg3),
                    bids                  : 0x2::linked_table::new<0x2::object::ID, ActiveBids>(arg3),
                    collection_bids       : 0x2::linked_table::new<address, vector<ActiveBid>>(arg3),
                    lifetime_volume       : 0,
                    sbt_points_enabled    : false,
                    sbt_point_multiplier  : 0,
                    multiplier_valid_till : 0,
                };
                0x2::dynamic_object_field::add<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v0, v1);
            };
        } else {
            *0x2::linked_table::borrow_mut<0x1::ascii::String, bool>(&mut arg0.active_collections, v0) = false;
        };
        let v2 = UpdateActiveCollectionsEvent{
            nft_type : v0,
            boolean  : arg2,
        };
        0x2::event::emit<UpdateActiveCollectionsEvent>(v2);
    }

    public fun update_commission_pct(arg0: &mut MarketPlaceStore, arg1: &AdminCap, arg2: u64) {
        validation_check(arg0);
        assert!(arg2 <= 10, 9002);
        arg0.commission_pct = arg2;
    }

    public fun update_module_version(arg0: &mut MarketPlaceStore) {
        assert!(arg0.version < 0, 9004);
        arg0.version = 0;
    }

    public fun update_sbt_point_multiplier<T0: store + key>(arg0: &mut MarketPlaceStore, arg1: &AdminCap, arg2: bool, arg3: u64, arg4: u64) {
        validation_check(arg0);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v0);
        v1.sbt_points_enabled = arg2;
        v1.sbt_point_multiplier = arg3;
        v1.multiplier_valid_till = arg4;
        let v2 = UpdateSBTMultiplierEvent{
            nft_type              : v0,
            is_sbt_points_enabled : arg2,
            sbt_point_multiplier  : arg3,
            multiplier_valid_till : arg4,
        };
        0x2::event::emit<UpdateSBTMultiplierEvent>(v2);
    }

    fun validation_check(arg0: &MarketPlaceStore) {
        assert!(arg0.version == 0, 8000);
    }

    // decompiled from Move bytecode v6
}

