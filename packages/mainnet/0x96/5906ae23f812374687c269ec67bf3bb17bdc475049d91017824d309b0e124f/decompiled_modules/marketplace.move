module 0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::marketplace {
    struct MarketplaceAdminCap has key {
        id: 0x2::object::UID,
    }

    struct Listing<phantom T0: store + key, phantom T1> has store {
        seller: address,
        price: u64,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
        timestamp: u64,
    }

    struct Bidding<phantom T0: store + key, phantom T1> has store {
        buyer: address,
        seller: address,
        price: u64,
        funds: 0x2::balance::Balance<T1>,
        timestamp: u64,
    }

    struct CollectionBid<phantom T0: store + key, phantom T1> has store {
        bidder: address,
        funds: 0x2::balance::Balance<T1>,
        timestamp: u64,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        collection_type: 0x1::string::String,
    }

    struct TradeInfo<phantom T0> has drop {
        item_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        price: u64,
        seller: address,
        buyer: address,
        salt: u64,
    }

    struct ListItem has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct BidItem has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct CollectionBidItem has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct Purchase has drop {
        dummy_field: bool,
    }

    struct ListingEvent has copy, drop {
        item_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        price: u64,
        seller: address,
        kiosk_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct DelistingEvent has copy, drop {
        item_id: 0x2::object::ID,
        seller: address,
        kiosk_id: 0x2::object::ID,
    }

    struct PurchasingEvent has copy, drop {
        item_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        price: u64,
        seller: address,
        buyer: address,
    }

    struct BiddingPlacedEvent has copy, drop {
        item_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        price: u64,
        seller: address,
        buyer: address,
        timestamp: u64,
    }

    struct BiddingCancelledEvent has copy, drop {
        item_id: 0x2::object::ID,
        seller: address,
        buyer: address,
    }

    struct BiddingAcceptedEvent has copy, drop {
        item_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        price: u64,
        seller: address,
        buyer: address,
    }

    struct CollectionBiddingPlacedEvent has copy, drop {
        coin_type: 0x1::string::String,
        price: u64,
        bidder: address,
        collection_type: 0x1::string::String,
        timestamp: u64,
    }

    struct CollectionBiddingCancelledEvent has copy, drop {
        bidder: address,
        collection_type: 0x1::string::String,
    }

    struct CollectionBiddingAcceptedEvent has copy, drop {
        coin_type: 0x1::string::String,
        price: u64,
        bidder: address,
        seller: address,
        collection_type: 0x1::string::String,
    }

    public fun accept_bid<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferRequest<T0>, 0x2::transfer_policy::TransferRequest<0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::Marketplace>, TradeInfo<T0>) {
        assert!(0x2::kiosk_extension::is_installed<0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::Extension>(arg0), 9223373793496530947);
        assert!(0x2::kiosk_extension::is_installed<0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::Extension>(arg1), 9223373797791498243);
        let v0 = ListItem{id: arg2};
        assert!(0x2::bag::contains_with_type<ListItem, Listing<T0, T1>>(0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::bag_mut(arg0), v0), 9223373802086596613);
        let v1 = BidItem{id: arg2};
        assert!(0x2::bag::contains_with_type<BidItem, Bidding<T0, T1>>(0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::bag_mut(arg1), v1), 9223373806381957131);
        let v2 = ListItem{id: arg2};
        let Listing {
            seller       : v3,
            price        : _,
            purchase_cap : v5,
            timestamp    : v6,
        } = 0x2::bag::remove<ListItem, Listing<T0, T1>>(0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::bag_mut(arg0), v2);
        assert!(0x2::tx_context::sender(arg6) == v3, 9223373819266203649);
        assert!(0x2::clock::timestamp_ms(arg5) <= v6, 9223373823562219537);
        let v7 = BidItem{id: arg2};
        let Bidding {
            buyer     : v8,
            seller    : _,
            price     : v10,
            funds     : v11,
            timestamp : v12,
        } = 0x2::bag::remove<BidItem, Bidding<T0, T1>>(0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::bag_mut(arg1), v7);
        assert!(0x2::clock::timestamp_ms(arg5) <= v12, 9223373836446990351);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg6), 0x2::tx_context::sender(arg6));
        let v13 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v14 = BiddingAcceptedEvent{
            item_id   : arg2,
            coin_type : v13,
            price     : v10,
            seller    : v3,
            buyer     : v8,
        };
        0x2::event::emit<BiddingAcceptedEvent>(v14);
        let (v15, v16) = 0x2::kiosk::purchase_with_cap<T0>(arg0, v5, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let v17 = v16;
        let v18 = Purchase{dummy_field: false};
        0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::witness_rule_marketplace::confirm<T0, Purchase>(v18, arg3, &mut v17);
        0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::lock<T0>(arg1, v15, arg3);
        let v19 = TradeInfo<T0>{
            item_id   : arg2,
            coin_type : v13,
            price     : v10,
            seller    : v3,
            buyer     : v8,
            salt      : arg4,
        };
        (v17, 0x2::transfer_policy::new_request<0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::Marketplace>(arg2, v10, 0x2::object::id<0x2::kiosk::Kiosk>(arg0)), v19)
    }

    public fun accept_collection_bid<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut Collection, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferRequest<T0>, 0x2::transfer_policy::TransferRequest<0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::Marketplace>, TradeInfo<T0>) {
        assert!(0x2::kiosk_extension::is_installed<0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::Extension>(arg0), 9223373986770059267);
        assert!(0x2::kiosk_extension::is_installed<0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::Extension>(arg1), 9223373991065026563);
        let v0 = ListItem{id: arg2};
        assert!(0x2::bag::contains_with_type<ListItem, Listing<T0, T1>>(0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::bag_mut(arg0), v0), 9223373995360124933);
        let v1 = CollectionBidItem{id: 0x2::object::uid_to_inner(&arg3.id)};
        assert!(0x2::bag::contains_with_type<CollectionBidItem, CollectionBid<T0, T1>>(0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::bag_mut(arg1), v1), 9223373999655485451);
        let v2 = ListItem{id: arg2};
        let Listing {
            seller       : v3,
            price        : _,
            purchase_cap : v5,
            timestamp    : v6,
        } = 0x2::bag::remove<ListItem, Listing<T0, T1>>(0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::bag_mut(arg0), v2);
        assert!(0x2::tx_context::sender(arg7) == v3, 9223374012539731969);
        assert!(0x2::clock::timestamp_ms(arg6) <= v6, 9223374016835747857);
        let v7 = CollectionBidItem{id: 0x2::object::uid_to_inner(&arg3.id)};
        let CollectionBid {
            bidder    : v8,
            funds     : v9,
            timestamp : v10,
        } = 0x2::bag::remove<CollectionBidItem, CollectionBid<T0, T1>>(0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::bag_mut(arg1), v7);
        let v11 = v9;
        assert!(0x2::clock::timestamp_ms(arg6) <= v10, 9223374029720518671);
        let v12 = 0x2::balance::value<T1>(&v11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg7), 0x2::tx_context::sender(arg7));
        let v13 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v14 = CollectionBiddingAcceptedEvent{
            coin_type       : v13,
            price           : v12,
            bidder          : v8,
            seller          : v3,
            collection_type : arg3.collection_type,
        };
        0x2::event::emit<CollectionBiddingAcceptedEvent>(v14);
        0x2::dynamic_field::remove<address, u64>(&mut arg3.id, v8);
        let (v15, v16) = 0x2::kiosk::purchase_with_cap<T0>(arg0, v5, 0x2::coin::zero<0x2::sui::SUI>(arg7));
        let v17 = v16;
        let v18 = Purchase{dummy_field: false};
        0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::witness_rule_marketplace::confirm<T0, Purchase>(v18, arg4, &mut v17);
        0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::lock<T0>(arg1, v15, arg4);
        let v19 = TradeInfo<T0>{
            item_id   : arg2,
            coin_type : v13,
            price     : v12,
            seller    : v3,
            buyer     : v8,
            salt      : arg5,
        };
        (v17, 0x2::transfer_policy::new_request<0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::Marketplace>(arg2, v12, 0x2::object::id<0x2::kiosk::Kiosk>(arg0)), v19)
    }

    public fun buyer<T0>(arg0: &TradeInfo<T0>) : address {
        arg0.buyer
    }

    public fun cancel_bid<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg0, arg1), 9223373595927904257);
        assert!(0x2::kiosk_extension::is_installed<0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::Extension>(arg0), 9223373600223002627);
        let v0 = BidItem{id: arg2};
        assert!(0x2::bag::contains_with_type<BidItem, Bidding<T0, T1>>(0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::bag_mut(arg0), v0), 9223373604518494219);
        let v1 = BidItem{id: arg2};
        let Bidding {
            buyer     : _,
            seller    : v3,
            price     : _,
            funds     : v5,
            timestamp : _,
        } = 0x2::bag::remove<BidItem, Bidding<T0, T1>>(0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::bag_mut(arg0), v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg3), 0x2::tx_context::sender(arg3));
        let v7 = BiddingCancelledEvent{
            item_id : arg2,
            seller  : v3,
            buyer   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<BiddingCancelledEvent>(v7);
    }

    public fun cancel_collection_bid<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut Collection, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg0, arg1), 9223373686122217473);
        assert!(0x2::kiosk_extension::is_installed<0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::Extension>(arg0), 9223373690417315843);
        let v0 = CollectionBidItem{id: 0x2::object::uid_to_inner(&arg2.id)};
        assert!(0x2::bag::contains_with_type<CollectionBidItem, CollectionBid<T0, T1>>(0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::bag_mut(arg0), v0), 9223373694712807435);
        let v1 = CollectionBidItem{id: 0x2::object::uid_to_inner(&arg2.id)};
        let CollectionBid {
            bidder    : _,
            funds     : v3,
            timestamp : _,
        } = 0x2::bag::remove<CollectionBidItem, CollectionBid<T0, T1>>(0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::bag_mut(arg0), v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg3), 0x2::tx_context::sender(arg3));
        0x2::dynamic_field::remove<address, u64>(&mut arg2.id, 0x2::tx_context::sender(arg3));
        let v5 = CollectionBiddingCancelledEvent{
            bidder          : 0x2::tx_context::sender(arg3),
            collection_type : arg2.collection_type,
        };
        0x2::event::emit<CollectionBiddingCancelledEvent>(v5);
    }

    public fun coin_type<T0>(arg0: &TradeInfo<T0>) : 0x1::string::String {
        arg0.coin_type
    }

    public fun create_collection(arg0: &MarketplaceAdminCap, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Collection{
            id              : 0x2::object::new(arg2),
            collection_type : arg1,
        };
        0x2::transfer::share_object<Collection>(v0);
    }

    public fun delist<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk_extension::is_installed<0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::Extension>(arg0), 9223373037582286851);
        let v0 = ListItem{id: arg1};
        let Listing {
            seller       : v1,
            price        : _,
            purchase_cap : v3,
            timestamp    : _,
        } = 0x2::bag::remove<ListItem, Listing<T0, T1>>(0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::bag_mut(arg0), v0);
        assert!(0x2::tx_context::sender(arg2) == v1, 9223373050467057665);
        0x2::kiosk::return_purchase_cap<T0>(arg0, v3);
        let v5 = DelistingEvent{
            item_id  : arg1,
            seller   : v1,
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
        };
        0x2::event::emit<DelistingEvent>(v5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketplaceAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MarketplaceAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun item_id<T0>(arg0: &TradeInfo<T0>) : 0x2::object::ID {
        arg0.item_id
    }

    public fun list<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg0, arg1), 9223372908733136897);
        assert!(0x2::kiosk_extension::is_installed<0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::Extension>(arg0), 9223372913028235267);
        assert!(0xe4a8ea93bf6e8af3d6e8b69593bc9905907d8168efa22d71ecfc3e786a421f90::build_slot_test::is_active(0x2::kiosk::borrow<0xe4a8ea93bf6e8af3d6e8b69593bc9905907d8168efa22d71ecfc3e786a421f90::build_slot_test::BuildSlot>(arg0, arg1, arg2)), 9223372925913792525);
        let v0 = ListItem{id: arg2};
        let v1 = Listing<T0, T1>{
            seller       : 0x2::tx_context::sender(arg5),
            price        : arg3,
            purchase_cap : 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg2, 0, arg5),
            timestamp    : arg4,
        };
        0x2::bag::add<ListItem, Listing<T0, T1>>(0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::bag_mut(arg0), v0, v1);
        let v2 = ListingEvent{
            item_id   : arg2,
            coin_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())),
            price     : arg3,
            seller    : 0x2::tx_context::sender(arg5),
            kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            timestamp : arg4,
        };
        0x2::event::emit<ListingEvent>(v2);
    }

    public fun place_bid<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg0, arg1), 9223373333934899201);
        assert!(0x2::kiosk_extension::is_installed<0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::Extension>(arg0), 9223373338229997571);
        let v0 = ListItem{id: arg3};
        assert!(0x2::bag::contains_with_type<ListItem, Listing<T0, T1>>(0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::bag_mut(arg2), v0), 9223373342525095941);
        let v1 = BidItem{id: arg3};
        assert!(!0x2::bag::contains_with_type<BidItem, Bidding<T0, T1>>(0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::bag_mut(arg0), v1), 9223373346820325385);
        assert!(0x2::coin::value<T1>(&arg5) == arg4, 9223373351115161607);
        let v2 = ListItem{id: arg3};
        let v3 = 0x2::bag::borrow<ListItem, Listing<T0, T1>>(0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::bag_mut(arg2), v2);
        let v4 = &v3.seller;
        assert!(0x2::clock::timestamp_ms(arg7) <= v3.timestamp, 9223373389770522641);
        let v5 = BidItem{id: arg3};
        let v6 = Bidding<T0, T1>{
            buyer     : 0x2::tx_context::sender(arg8),
            seller    : *v4,
            price     : arg4,
            funds     : 0x2::coin::into_balance<T1>(arg5),
            timestamp : arg6,
        };
        0x2::bag::add<BidItem, Bidding<T0, T1>>(0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::bag_mut(arg0), v5, v6);
        let v7 = BiddingPlacedEvent{
            item_id   : arg3,
            coin_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())),
            price     : arg4,
            seller    : *v4,
            buyer     : 0x2::tx_context::sender(arg8),
            timestamp : arg6,
        };
        0x2::event::emit<BiddingPlacedEvent>(v7);
    }

    public fun place_collection_bid<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut Collection, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg0, arg1), 9223373484258754561);
        assert!(0x2::kiosk_extension::is_installed<0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::Extension>(arg0), 9223373488553852931);
        let v0 = CollectionBidItem{id: 0x2::object::uid_to_inner(&arg2.id)};
        assert!(!0x2::bag::contains_with_type<CollectionBidItem, CollectionBid<T0, T1>>(0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::bag_mut(arg0), v0), 9223373492849213449);
        let v1 = 0x2::coin::value<T1>(&arg3);
        let v2 = CollectionBidItem{id: 0x2::object::uid_to_inner(&arg2.id)};
        let v3 = CollectionBid<T0, T1>{
            bidder    : 0x2::tx_context::sender(arg5),
            funds     : 0x2::coin::into_balance<T1>(arg3),
            timestamp : arg4,
        };
        0x2::bag::add<CollectionBidItem, CollectionBid<T0, T1>>(0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::bag_mut(arg0), v2, v3);
        0x2::dynamic_field::add<address, u64>(&mut arg2.id, 0x2::tx_context::sender(arg5), v1);
        let v4 = CollectionBiddingPlacedEvent{
            coin_type       : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())),
            price           : v1,
            bidder          : 0x2::tx_context::sender(arg5),
            collection_type : arg2.collection_type,
            timestamp       : arg4,
        };
        0x2::event::emit<CollectionBiddingPlacedEvent>(v4);
    }

    public fun price<T0>(arg0: &TradeInfo<T0>) : u64 {
        arg0.price
    }

    public fun purchase<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>, 0x2::transfer_policy::TransferRequest<0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::Marketplace>, TradeInfo<T0>) {
        assert!(0x2::kiosk_extension::is_installed<0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::Extension>(arg0), 9223373153546403843);
        let v0 = ListItem{id: arg1};
        assert!(0x2::bag::contains_with_type<ListItem, Listing<T0, T1>>(0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::bag_mut(arg0), v0), 9223373157841502213);
        let v1 = ListItem{id: arg1};
        let Listing {
            seller       : v2,
            price        : v3,
            purchase_cap : v4,
            timestamp    : v5,
        } = 0x2::bag::remove<ListItem, Listing<T0, T1>>(0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::bag_mut(arg0), v1);
        assert!(0x2::clock::timestamp_ms(arg5) <= v5, 9223373170727190545);
        assert!(0x2::coin::value<T1>(&arg2) == v3, 9223373183611437063);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, v2);
        let v6 = 0x2::tx_context::sender(arg6);
        let v7 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v8 = PurchasingEvent{
            item_id   : arg1,
            coin_type : v7,
            price     : v3,
            seller    : v2,
            buyer     : v6,
        };
        0x2::event::emit<PurchasingEvent>(v8);
        let (v9, v10) = 0x2::kiosk::purchase_with_cap<T0>(arg0, v4, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let v11 = v10;
        let v12 = Purchase{dummy_field: false};
        0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::witness_rule_marketplace::confirm<T0, Purchase>(v12, arg3, &mut v11);
        let v13 = TradeInfo<T0>{
            item_id   : arg1,
            coin_type : v7,
            price     : v3,
            seller    : v2,
            buyer     : v6,
            salt      : arg4,
        };
        (v9, v11, 0x2::transfer_policy::new_request<0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::extension::Marketplace>(arg1, v3, 0x2::object::id<0x2::kiosk::Kiosk>(arg0)), v13)
    }

    public fun salt<T0>(arg0: &TradeInfo<T0>) : u64 {
        arg0.salt
    }

    public fun seller<T0>(arg0: &TradeInfo<T0>) : address {
        arg0.seller
    }

    // decompiled from Move bytecode v6
}

