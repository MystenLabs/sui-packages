module 0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::marketplace {
    struct MarketplaceAdminCap has key {
        id: 0x2::object::UID,
    }

    struct MarketplaceConfig has store, key {
        id: 0x2::object::UID,
        pub_key: vector<u8>,
        nonce: u128,
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

    public fun accept_bid<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferRequest<T0>, 0x2::transfer_policy::TransferRequest<0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::Marketplace>, TradeInfo<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::kiosk_extension::is_installed<0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::Extension>(arg0), 9223374175748620291);
        assert!(0x2::kiosk_extension::is_installed<0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::Extension>(arg1), 9223374180043587587);
        let v0 = ListItem{id: arg2};
        assert!(0x2::bag::contains_with_type<ListItem, Listing<T0, T1>>(0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::bag_mut(arg0), v0), 9223374184338685957);
        let v1 = BidItem{id: arg2};
        assert!(0x2::bag::contains_with_type<BidItem, Bidding<T0, T1>>(0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::bag_mut(arg1), v1), 9223374188634046475);
        let v2 = ListItem{id: arg2};
        let Listing {
            seller       : v3,
            price        : _,
            purchase_cap : v5,
            timestamp    : v6,
        } = 0x2::bag::remove<ListItem, Listing<T0, T1>>(0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::bag_mut(arg0), v2);
        assert!(0x2::tx_context::sender(arg7) == v3, 9223374201518292993);
        assert!(0x2::clock::timestamp_ms(arg5) <= v6, 9223374205814308881);
        let v7 = BidItem{id: arg2};
        let Bidding {
            buyer     : v8,
            seller    : _,
            price     : v10,
            funds     : v11,
            timestamp : v12,
        } = 0x2::bag::remove<BidItem, Bidding<T0, T1>>(0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::bag_mut(arg1), v7);
        assert!(0x2::clock::timestamp_ms(arg5) <= v12, 9223374218699079695);
        let v13 = 0x2::coin::from_balance<T1>(v11, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v13, 0x2::tx_context::sender(arg7));
        let v14 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v15 = BiddingAcceptedEvent{
            item_id   : arg2,
            coin_type : v14,
            price     : v10,
            seller    : v3,
            buyer     : v8,
        };
        0x2::event::emit<BiddingAcceptedEvent>(v15);
        let (v16, v17) = 0x2::kiosk::purchase_with_cap<T0>(arg0, v5, 0x2::coin::zero<0x2::sui::SUI>(arg7));
        let v18 = v17;
        let v19 = Purchase{dummy_field: false};
        0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::witness_rule_marketplace::confirm<T0, Purchase>(v19, arg3, &mut v18);
        0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::lock<T0>(arg1, v16, arg3);
        let v20 = TradeInfo<T0>{
            item_id   : arg2,
            coin_type : v14,
            price     : v10,
            seller    : v3,
            buyer     : v8,
            salt      : arg4,
        };
        (v18, 0x2::transfer_policy::new_request<0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::Marketplace>(arg2, v10, 0x2::object::id<0x2::kiosk::Kiosk>(arg0)), v20, 0x2::coin::split<T1>(&mut v13, arg6, arg7))
    }

    public fun accept_collection_bid<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut Collection, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferRequest<T0>, 0x2::transfer_policy::TransferRequest<0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::Marketplace>, TradeInfo<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::kiosk_extension::is_installed<0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::Extension>(arg0), 9223374381907050499);
        assert!(0x2::kiosk_extension::is_installed<0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::Extension>(arg1), 9223374386202017795);
        let v0 = ListItem{id: arg2};
        assert!(0x2::bag::contains_with_type<ListItem, Listing<T0, T1>>(0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::bag_mut(arg0), v0), 9223374390497116165);
        let v1 = CollectionBidItem{id: 0x2::object::uid_to_inner(&arg3.id)};
        assert!(0x2::bag::contains_with_type<CollectionBidItem, CollectionBid<T0, T1>>(0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::bag_mut(arg1), v1), 9223374394792476683);
        let v2 = ListItem{id: arg2};
        let Listing {
            seller       : v3,
            price        : _,
            purchase_cap : v5,
            timestamp    : v6,
        } = 0x2::bag::remove<ListItem, Listing<T0, T1>>(0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::bag_mut(arg0), v2);
        assert!(0x2::tx_context::sender(arg8) == v3, 9223374407676723201);
        assert!(0x2::clock::timestamp_ms(arg6) <= v6, 9223374411972739089);
        let v7 = CollectionBidItem{id: 0x2::object::uid_to_inner(&arg3.id)};
        let CollectionBid {
            bidder    : v8,
            funds     : v9,
            timestamp : v10,
        } = 0x2::bag::remove<CollectionBidItem, CollectionBid<T0, T1>>(0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::bag_mut(arg1), v7);
        let v11 = v9;
        assert!(0x2::clock::timestamp_ms(arg6) <= v10, 9223374424857509903);
        let v12 = 0x2::balance::value<T1>(&v11);
        let v13 = 0x2::coin::from_balance<T1>(v11, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v13, 0x2::tx_context::sender(arg8));
        let v14 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v15 = CollectionBiddingAcceptedEvent{
            coin_type       : v14,
            price           : v12,
            bidder          : v8,
            seller          : v3,
            collection_type : arg3.collection_type,
        };
        0x2::event::emit<CollectionBiddingAcceptedEvent>(v15);
        0x2::dynamic_field::remove<address, u64>(&mut arg3.id, v8);
        let (v16, v17) = 0x2::kiosk::purchase_with_cap<T0>(arg0, v5, 0x2::coin::zero<0x2::sui::SUI>(arg8));
        let v18 = v17;
        let v19 = Purchase{dummy_field: false};
        0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::witness_rule_marketplace::confirm<T0, Purchase>(v19, arg4, &mut v18);
        0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::lock<T0>(arg1, v16, arg4);
        let v20 = TradeInfo<T0>{
            item_id   : arg2,
            coin_type : v14,
            price     : v12,
            seller    : v3,
            buyer     : v8,
            salt      : arg5,
        };
        (v18, 0x2::transfer_policy::new_request<0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::Marketplace>(arg2, v12, 0x2::object::id<0x2::kiosk::Kiosk>(arg0)), v20, 0x2::coin::split<T1>(&mut v13, arg7, arg8))
    }

    public fun buyer<T0>(arg0: &TradeInfo<T0>) : address {
        arg0.buyer
    }

    public fun cancel_bid<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &mut MarketplaceConfig, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg0, arg1), 9223373892280647681);
        assert!(0x2::kiosk_extension::is_installed<0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::Extension>(arg0), 9223373896575746051);
        let v0 = BidItem{id: arg2};
        assert!(0x2::bag::contains_with_type<BidItem, Bidding<T0, T1>>(0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::bag_mut(arg0), v0), 9223373900871237643);
        let v1 = 0x2::object::uid_to_inner(0x2::kiosk::uid(arg0));
        let v2 = 0x1::bcs::to_bytes<0x2::object::ID>(&v1);
        let v3 = 0x2::kiosk::owner(arg0);
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<address>(&v3));
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<0x2::object::ID>(&arg2));
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<u128>(&arg4.nonce));
        let v4 = 0x2::hash::blake2b256(&v2);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg4.pub_key, &v4) == true, 9223373935231500307);
        arg4.nonce = arg4.nonce + 1;
        let v5 = BidItem{id: arg2};
        let Bidding {
            buyer     : _,
            seller    : v7,
            price     : _,
            funds     : v9,
            timestamp : _,
        } = 0x2::bag::remove<BidItem, Bidding<T0, T1>>(0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::bag_mut(arg0), v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v9, arg5), 0x2::tx_context::sender(arg5));
        let v11 = BiddingCancelledEvent{
            item_id : arg2,
            seller  : v7,
            buyer   : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<BiddingCancelledEvent>(v11);
    }

    public fun cancel_collection_bid<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut Collection, arg3: vector<u8>, arg4: &mut MarketplaceConfig, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg0, arg1), 9223374029719601153);
        assert!(0x2::kiosk_extension::is_installed<0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::Extension>(arg0), 9223374034014699523);
        let v0 = CollectionBidItem{id: 0x2::object::uid_to_inner(&arg2.id)};
        assert!(0x2::bag::contains_with_type<CollectionBidItem, CollectionBid<T0, T1>>(0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::bag_mut(arg0), v0), 9223374038310191115);
        let v1 = 0x2::object::uid_to_inner(0x2::kiosk::uid(arg0));
        let v2 = 0x1::bcs::to_bytes<0x2::object::ID>(&v1);
        let v3 = 0x2::kiosk::owner(arg0);
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<address>(&v3));
        let v4 = 0x2::object::uid_to_inner(&arg2.id);
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<u128>(&arg4.nonce));
        let v5 = 0x2::hash::blake2b256(&v2);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg4.pub_key, &v5) == true, 9223374072670453779);
        arg4.nonce = arg4.nonce + 1;
        let v6 = CollectionBidItem{id: 0x2::object::uid_to_inner(&arg2.id)};
        let CollectionBid {
            bidder    : _,
            funds     : v8,
            timestamp : _,
        } = 0x2::bag::remove<CollectionBidItem, CollectionBid<T0, T1>>(0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::bag_mut(arg0), v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v8, arg5), 0x2::tx_context::sender(arg5));
        0x2::dynamic_field::remove<address, u64>(&mut arg2.id, 0x2::tx_context::sender(arg5));
        let v10 = CollectionBiddingCancelledEvent{
            bidder          : 0x2::tx_context::sender(arg5),
            collection_type : arg2.collection_type,
        };
        0x2::event::emit<CollectionBiddingCancelledEvent>(v10);
    }

    public fun coin_type<T0>(arg0: &TradeInfo<T0>) : 0x1::string::String {
        arg0.coin_type
    }

    public fun configure_marketplace(arg0: &MarketplaceAdminCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketplaceConfig{
            id      : 0x2::object::new(arg2),
            pub_key : arg1,
            nonce   : 0,
        };
        0x2::transfer::share_object<MarketplaceConfig>(v0);
    }

    public fun create_collection(arg0: &MarketplaceAdminCap, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Collection{
            id              : 0x2::object::new(arg2),
            collection_type : arg1,
        };
        0x2::transfer::share_object<Collection>(v0);
    }

    public fun delist<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: &mut MarketplaceConfig, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk_extension::is_installed<0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::Extension>(arg0), 9223373179316207619);
        let v0 = 0x2::object::uid_to_inner(0x2::kiosk::uid(arg0));
        let v1 = 0x1::bcs::to_bytes<0x2::object::ID>(&v0);
        let v2 = 0x2::kiosk::owner(arg0);
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<address>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<0x2::object::ID>(&arg1));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u128>(&arg3.nonce));
        let v3 = 0x2::hash::blake2b256(&v1);
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg3.pub_key, &v3) == true, 9223373213676994579);
        arg3.nonce = arg3.nonce + 1;
        let v4 = ListItem{id: arg1};
        let Listing {
            seller       : v5,
            price        : _,
            purchase_cap : v7,
            timestamp    : _,
        } = 0x2::bag::remove<ListItem, Listing<T0, T1>>(0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::bag_mut(arg0), v4);
        assert!(0x2::tx_context::sender(arg4) == v5, 9223373230855684097);
        0x2::kiosk::return_purchase_cap<T0>(arg0, v7);
        let v9 = DelistingEvent{
            item_id  : arg1,
            seller   : v5,
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
        };
        0x2::event::emit<DelistingEvent>(v9);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketplaceAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MarketplaceAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun item_id<T0>(arg0: &TradeInfo<T0>) : 0x2::object::ID {
        arg0.item_id
    }

    public fun list<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &mut MarketplaceConfig, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg0, arg1), 9223372998927450113);
        assert!(0x2::kiosk_extension::is_installed<0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::Extension>(arg0), 9223373003222548483);
        let v0 = 0x2::object::uid_to_inner(0x2::kiosk::uid(arg0));
        let v1 = 0x1::bcs::to_bytes<0x2::object::ID>(&v0);
        let v2 = 0x2::kiosk::owner(arg0);
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<address>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<0x2::object::ID>(&arg2));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u128>(&arg6.nonce));
        let v3 = 0x2::hash::blake2b256(&v1);
        assert!(0x2::ed25519::ed25519_verify(&arg5, &arg6.pub_key, &v3) == true, 9223373041878302739);
        arg6.nonce = arg6.nonce + 1;
        assert!(0x26320c0877dd180160e75366e06133c66eced446b04f204a2b2aa4bfde9bf1aa::build_slot_test::is_active(0x2::kiosk::borrow<0x26320c0877dd180160e75366e06133c66eced446b04f204a2b2aa4bfde9bf1aa::build_slot_test::BuildSlot>(arg0, arg1, arg2)), 9223373059057778701);
        let v4 = ListItem{id: arg2};
        let v5 = Listing<T0, T1>{
            seller       : 0x2::tx_context::sender(arg7),
            price        : arg3,
            purchase_cap : 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg2, 0, arg7),
            timestamp    : arg4,
        };
        0x2::bag::add<ListItem, Listing<T0, T1>>(0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::bag_mut(arg0), v4, v5);
        let v6 = ListingEvent{
            item_id   : arg2,
            coin_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())),
            price     : arg3,
            seller    : 0x2::tx_context::sender(arg7),
            kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            timestamp : arg4,
        };
        0x2::event::emit<ListingEvent>(v6);
    }

    public fun place_bid<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: vector<u8>, arg9: &mut MarketplaceConfig, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg0, arg1), 9223373531503394817);
        assert!(0x2::kiosk_extension::is_installed<0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::Extension>(arg0), 9223373535798493187);
        let v0 = ListItem{id: arg3};
        assert!(0x2::bag::contains_with_type<ListItem, Listing<T0, T1>>(0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::bag_mut(arg2), v0), 9223373540093591557);
        let v1 = BidItem{id: arg3};
        assert!(!0x2::bag::contains_with_type<BidItem, Bidding<T0, T1>>(0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::bag_mut(arg0), v1), 9223373544388821001);
        assert!(0x2::coin::value<T1>(&arg5) == arg4, 9223373548683657223);
        let v2 = 0x2::object::uid_to_inner(0x2::kiosk::uid(arg0));
        let v3 = 0x1::bcs::to_bytes<0x2::object::ID>(&v2);
        let v4 = 0x2::kiosk::owner(arg0);
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<address>(&v4));
        let v5 = 0x2::kiosk::owner(arg2);
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<address>(&v5));
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<0x2::object::ID>(&arg3));
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<u128>(&arg9.nonce));
        let v6 = 0x2::hash::blake2b256(&v3);
        assert!(0x2::ed25519::ed25519_verify(&arg8, &arg9.pub_key, &v6) == true, 9223373591634116627);
        arg9.nonce = arg9.nonce + 1;
        let v7 = ListItem{id: arg3};
        let v8 = 0x2::bag::borrow<ListItem, Listing<T0, T1>>(0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::bag_mut(arg2), v7);
        let v9 = &v8.seller;
        assert!(0x2::clock::timestamp_ms(arg7) <= v8.timestamp, 9223373634583658513);
        let v10 = BidItem{id: arg3};
        let v11 = Bidding<T0, T1>{
            buyer     : 0x2::tx_context::sender(arg10),
            seller    : *v9,
            price     : arg4,
            funds     : 0x2::coin::into_balance<T1>(arg5),
            timestamp : arg6,
        };
        0x2::bag::add<BidItem, Bidding<T0, T1>>(0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::bag_mut(arg0), v10, v11);
        let v12 = BiddingPlacedEvent{
            item_id   : arg3,
            coin_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())),
            price     : arg4,
            seller    : *v9,
            buyer     : 0x2::tx_context::sender(arg10),
            timestamp : arg6,
        };
        0x2::event::emit<BiddingPlacedEvent>(v12);
    }

    public fun place_collection_bid<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut Collection, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: vector<u8>, arg6: &mut MarketplaceConfig, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg0, arg1), 9223373737661825025);
        assert!(0x2::kiosk_extension::is_installed<0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::Extension>(arg0), 9223373741956923395);
        let v0 = CollectionBidItem{id: 0x2::object::uid_to_inner(&arg2.id)};
        assert!(!0x2::bag::contains_with_type<CollectionBidItem, CollectionBid<T0, T1>>(0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::bag_mut(arg0), v0), 9223373746252283913);
        let v1 = 0x2::object::uid_to_inner(0x2::kiosk::uid(arg0));
        let v2 = 0x1::bcs::to_bytes<0x2::object::ID>(&v1);
        let v3 = 0x2::kiosk::owner(arg0);
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<address>(&v3));
        let v4 = 0x2::object::uid_to_inner(&arg2.id);
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<u128>(&arg6.nonce));
        let v5 = 0x2::hash::blake2b256(&v2);
        assert!(0x2::ed25519::ed25519_verify(&arg5, &arg6.pub_key, &v5) == true, 9223373780612677651);
        arg6.nonce = arg6.nonce + 1;
        let v6 = 0x2::coin::value<T1>(&arg3);
        let v7 = CollectionBidItem{id: 0x2::object::uid_to_inner(&arg2.id)};
        let v8 = CollectionBid<T0, T1>{
            bidder    : 0x2::tx_context::sender(arg7),
            funds     : 0x2::coin::into_balance<T1>(arg3),
            timestamp : arg4,
        };
        0x2::bag::add<CollectionBidItem, CollectionBid<T0, T1>>(0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::bag_mut(arg0), v7, v8);
        0x2::dynamic_field::add<address, u64>(&mut arg2.id, 0x2::tx_context::sender(arg7), v6);
        let v9 = CollectionBiddingPlacedEvent{
            coin_type       : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())),
            price           : v6,
            bidder          : 0x2::tx_context::sender(arg7),
            collection_type : arg2.collection_type,
            timestamp       : arg4,
        };
        0x2::event::emit<CollectionBiddingPlacedEvent>(v9);
    }

    public fun price<T0>(arg0: &TradeInfo<T0>) : u64 {
        arg0.price
    }

    public fun purchase<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>, 0x2::transfer_policy::TransferRequest<0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::Marketplace>, TradeInfo<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::kiosk_extension::is_installed<0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::Extension>(arg0), 9223373338229997571);
        let v0 = ListItem{id: arg1};
        assert!(0x2::bag::contains_with_type<ListItem, Listing<T0, T1>>(0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::bag_mut(arg0), v0), 9223373342525095941);
        let v1 = ListItem{id: arg1};
        let Listing {
            seller       : v2,
            price        : v3,
            purchase_cap : v4,
            timestamp    : v5,
        } = 0x2::bag::remove<ListItem, Listing<T0, T1>>(0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::bag_mut(arg0), v1);
        assert!(0x2::clock::timestamp_ms(arg5) <= v5, 9223373355410784273);
        assert!(0x2::coin::value<T1>(&arg2) == v3, 9223373368295030791);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, v2);
        let v6 = 0x2::tx_context::sender(arg7);
        let v7 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v8 = PurchasingEvent{
            item_id   : arg1,
            coin_type : v7,
            price     : v3,
            seller    : v2,
            buyer     : v6,
        };
        0x2::event::emit<PurchasingEvent>(v8);
        let (v9, v10) = 0x2::kiosk::purchase_with_cap<T0>(arg0, v4, 0x2::coin::zero<0x2::sui::SUI>(arg7));
        let v11 = v10;
        let v12 = Purchase{dummy_field: false};
        0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::witness_rule_marketplace::confirm<T0, Purchase>(v12, arg3, &mut v11);
        let v13 = TradeInfo<T0>{
            item_id   : arg1,
            coin_type : v7,
            price     : v3,
            seller    : v2,
            buyer     : v6,
            salt      : arg4,
        };
        (v9, v11, 0x2::transfer_policy::new_request<0xe9bac3a247d9e23bb072875a67df75e68ad23b28d0e4ddbfbbb96e0405638b42::extension::Marketplace>(arg1, v3, 0x2::object::id<0x2::kiosk::Kiosk>(arg0)), v13, 0x2::coin::split<T1>(&mut arg2, arg6, arg7))
    }

    public fun salt<T0>(arg0: &TradeInfo<T0>) : u64 {
        arg0.salt
    }

    public fun seller<T0>(arg0: &TradeInfo<T0>) : address {
        arg0.seller
    }

    // decompiled from Move bytecode v6
}

