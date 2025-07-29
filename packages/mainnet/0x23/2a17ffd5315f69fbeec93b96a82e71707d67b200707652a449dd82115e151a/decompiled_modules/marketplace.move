module 0x232a17ffd5315f69fbeec93b96a82e71707d67b200707652a449dd82115e151a::marketplace {
    struct CollectorCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LaunchpadCap has store, key {
        id: 0x2::object::UID,
    }

    struct TraitBidsAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TraitBidsPotato {
        id: 0x2::object::ID,
    }

    struct MarketPlaceStore has key {
        id: 0x2::object::UID,
        points_admin_cap: 0x235ff29f0b8073f4cc3f0c27011138dadac81dd71b1e2ecbf9520ef3af50ad11::ions::PointsAdminCap,
        is_permissionless: bool,
        new_collection_fee: u64,
        commission_pct: u64,
        available_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        user_activity: 0x2::linked_table::LinkedTable<address, UserInfo>,
        active_collections: 0x2::linked_table::LinkedTable<0x1::ascii::String, bool>,
        referrals: 0x2::linked_table::LinkedTable<address, u64>,
        kiosk_id: 0x2::object::ID,
        escrow_kiosk_cap: 0x2::kiosk::KioskOwnerCap,
        pending_claims: 0x2::linked_table::LinkedTable<address, PendingClaims>,
        version: u64,
    }

    struct PendingClaims has store {
        pending_claims: 0x2::linked_table::LinkedTable<0x2::object::ID, PendingClaim>,
    }

    struct PendingClaim has store {
        buyer: address,
        nft_type: 0x1::ascii::String,
        price: u64,
        commission: u64,
        royalty: u64,
    }

    struct UserInfo has store, key {
        id: 0x2::object::UID,
        listings: 0x2::linked_table::LinkedTable<0x2::object::ID, ListingInfo>,
        bids: 0x2::linked_table::LinkedTable<0x2::object::ID, BidInfo>,
        collection_bids: 0x2::linked_table::LinkedTable<0x1::ascii::String, vector<BidInfo>>,
        trait_bids: 0x2::linked_table::LinkedTable<0x1::ascii::String, vector<TraitBidInfo>>,
        claimable_points: u64,
    }

    struct ListingInfo has drop, store {
        nft_type: 0x1::ascii::String,
        price: u64,
        commission: u64,
        royalty: u64,
        listed_at: u64,
        last_points_claimed_at: u64,
    }

    struct BidInfo has drop, store {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        bid_price: u64,
        commission: u64,
        royalty: u64,
        is_collection_bid: bool,
        bid_at: u64,
        last_points_claimed_at: u64,
    }

    struct TraitBidInfo has drop, store {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        bid_price: u64,
        commission: u64,
        royalty: u64,
        trait_key1: 0x1::option::Option<0x1::ascii::String>,
        trait_value1: 0x1::option::Option<vector<0x1::ascii::String>>,
        trait_key2: 0x1::option::Option<0x1::ascii::String>,
        trait_value2: 0x1::option::Option<vector<0x1::ascii::String>>,
        trait_key3: 0x1::option::Option<0x1::ascii::String>,
        trait_value3: 0x1::option::Option<vector<0x1::ascii::String>>,
        bid_at: u64,
        last_points_claimed_at: u64,
    }

    struct CollectionMarketPlace<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        listings: 0x2::linked_table::LinkedTable<0x2::object::ID, Listing<T0>>,
        bids: 0x2::linked_table::LinkedTable<0x2::object::ID, ActiveBids>,
        collection_bids: 0x2::linked_table::LinkedTable<address, vector<ActiveBid>>,
        sui_trait_bids_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        are_trait_bids_enabled: bool,
        lifetime_volume: u128,
        ion_points_enabled: bool,
        ion_collection_multiplier: u64,
        avg_sale_price: u64,
        recent_sale_prices: vector<u64>,
    }

    struct Listing<phantom T0: store + key> has store {
        seller: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        cap: 0x2::kiosk::PurchaseCap<T0>,
        price: u64,
        royalty: u64,
        commission: u64,
        listed_at: u64,
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
        bid_at: u64,
        commission: u64,
        royalty: u64,
    }

    struct ActiveTraitBid has store, key {
        id: 0x2::object::UID,
        bidder: address,
        bid_price: u64,
        bid_at: u64,
        trait_key1: 0x1::option::Option<0x1::ascii::String>,
        trait_value1: 0x1::option::Option<vector<0x1::ascii::String>>,
        trait_key2: 0x1::option::Option<0x1::ascii::String>,
        trait_value2: 0x1::option::Option<vector<0x1::ascii::String>>,
        trait_key3: 0x1::option::Option<0x1::ascii::String>,
        trait_value3: 0x1::option::Option<vector<0x1::ascii::String>>,
        commission: u64,
        royalty: u64,
    }

    struct UpdateActiveCollectionsEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        boolean: bool,
    }

    struct CollectCommissionsEvent has copy, drop {
        recepient: address,
        amount: u64,
    }

    struct UpdateIONMultiplierEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        is_ion_points_enabled: bool,
        ion_collection_multiplier: u64,
    }

    struct UpdatePermissionlessStatusEvent has copy, drop {
        is_permissionless: bool,
    }

    struct ListEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        seller: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        price: u64,
        commission: u64,
        royalty: u64,
        total_cost: u64,
        listed_at: u64,
    }

    struct UnlistEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        seller: address,
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        price: u64,
        unlisted_at: u64,
        ion_points_awarded: u64,
    }

    struct MakeBidEvent has copy, drop {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        buyer: address,
        nft_id: 0x1::option::Option<0x2::object::ID>,
        price: u64,
        commission: u64,
        royalty: u64,
        total_cost: u64,
        is_collection_bid: bool,
        bid_at: u64,
    }

    struct CancelBidEvent has copy, drop {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        bidder: address,
        nft_id: 0x1::option::Option<0x2::object::ID>,
        is_collection_bid: bool,
        cancelled_at: u64,
        ion_points_awarded: u64,
    }

    struct BuyEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        seller_kiosk: 0x2::object::ID,
        price: u64,
        commission: u64,
        buyer_ion_points: u64,
        seller_ion_points: u64,
    }

    struct AwardIonPointsEvent has copy, drop {
        user_address: address,
        points_earned: u64,
        referrer_address: 0x1::option::Option<address>,
        referral_points: u64,
        bonus_points: u64,
        total_points: u64,
    }

    struct ReferralPointsClaimedEvent has copy, drop {
        user_address: address,
        claimable_points: u64,
        referral_points: u64,
        bonus_points: u64,
        total_points: u64,
    }

    struct TraitBidMadeEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        bidder: address,
        bid_id: 0x2::object::ID,
        bid_price: u64,
        commission: u64,
        royalty: u64,
        total_cost: u64,
        trait_key1: 0x1::option::Option<0x1::ascii::String>,
        trait_value1: 0x1::option::Option<vector<0x1::ascii::String>>,
        trait_key2: 0x1::option::Option<0x1::ascii::String>,
        trait_value2: 0x1::option::Option<vector<0x1::ascii::String>>,
        trait_key3: 0x1::option::Option<0x1::ascii::String>,
        trait_value3: 0x1::option::Option<vector<0x1::ascii::String>>,
        bid_at: u64,
    }

    struct TraitBidAcceptedEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
        commission: u64,
        royalty: u64,
        total_cost: u64,
    }

    struct TraitBidCancelledEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        bidder: address,
        bid_id: 0x2::object::ID,
        refund_amount: u64,
        ion_points_awarded: u64,
        cancelled_at: u64,
    }

    struct BidAcceptedEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        is_collection_bid: bool,
        price: u64,
        commission: u64,
        escrow_kiosk: 0x2::object::ID,
        buyer_ion_points: u64,
        seller_ion_points: u64,
    }

    struct NFTClaimedEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        buyer: address,
        buyer_kiosk: 0x2::object::ID,
        claimed_at: u64,
    }

    struct UpdateTraitBiddingSupportEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        are_trait_bids_enabled: bool,
    }

    fun add_pending_claim(arg0: &mut MarketPlaceStore, arg1: address, arg2: 0x2::object::ID, arg3: 0x1::ascii::String, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = PendingClaim{
            buyer      : arg1,
            nft_type   : arg3,
            price      : arg4,
            commission : arg5,
            royalty    : arg6,
        };
        if (0x2::linked_table::contains<address, PendingClaims>(&arg0.pending_claims, arg1)) {
            0x2::linked_table::push_back<0x2::object::ID, PendingClaim>(&mut 0x2::linked_table::borrow_mut<address, PendingClaims>(&mut arg0.pending_claims, arg1).pending_claims, arg2, v0);
        } else {
            let v1 = PendingClaims{pending_claims: 0x2::linked_table::new<0x2::object::ID, PendingClaim>(arg7)};
            0x2::linked_table::push_back<0x2::object::ID, PendingClaim>(&mut v1.pending_claims, arg2, v0);
            0x2::linked_table::push_back<address, PendingClaims>(&mut arg0.pending_claims, arg1, v1);
        };
    }

    public fun add_trait_bidding_support<T0: store + key, T1: store + key>(arg0: &mut MarketPlaceStore, arg1: &TraitBidsAdminCap, arg2: T1, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v0), 774);
        assert!(0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0), 774);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v0);
        0x2::dynamic_object_field::add<vector<u8>, T1>(&mut v1.id, b"trait_bids", arg2);
        v1.are_trait_bids_enabled = true;
        let v2 = UpdateTraitBiddingSupportEvent{
            nft_type               : v0,
            are_trait_bids_enabled : true,
        };
        0x2::event::emit<UpdateTraitBiddingSupportEvent>(v2);
    }

    fun award_ion_points_with_referral(arg0: address, arg1: &mut MarketPlaceStore, arg2: &mut 0x235ff29f0b8073f4cc3f0c27011138dadac81dd71b1e2ecbf9520ef3af50ad11::ions::AnimaIONs, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x235ff29f0b8073f4cc3f0c27011138dadac81dd71b1e2ecbf9520ef3af50ad11::ions::AnimaChef) {
        if (arg3 == 0) {
            return
        };
        let v0 = 0x1::option::none<address>();
        let v1 = 0;
        let v2 = 0;
        if (0x235ff29f0b8073f4cc3f0c27011138dadac81dd71b1e2ecbf9520ef3af50ad11::ions::has_referrer(arg2)) {
            let v3 = 0x235ff29f0b8073f4cc3f0c27011138dadac81dd71b1e2ecbf9520ef3af50ad11::ions::get_referrer(arg2);
            if (0x1::option::is_some<address>(&v3)) {
                0x1::option::fill<address>(&mut v0, *0x1::option::borrow<address>(&v3));
                let v4 = 0x235ff29f0b8073f4cc3f0c27011138dadac81dd71b1e2ecbf9520ef3af50ad11::math::mul_div_u128((arg3 as u128), (15 as u128), 100);
                v1 = v4;
                v2 = 0x235ff29f0b8073f4cc3f0c27011138dadac81dd71b1e2ecbf9520ef3af50ad11::math::mul_div_u128((arg3 as u128), (10 as u128), 100);
                if (0x2::linked_table::contains<address, u64>(&arg1.referrals, *0x1::option::borrow<address>(&v0))) {
                    let v5 = 0x2::linked_table::borrow_mut<address, u64>(&mut arg1.referrals, *0x1::option::borrow<address>(&v0));
                    *v5 = *v5 + v4;
                } else {
                    0x2::linked_table::push_back<address, u64>(&mut arg1.referrals, *0x1::option::borrow<address>(&v0), v4);
                };
            };
        };
        0x235ff29f0b8073f4cc3f0c27011138dadac81dd71b1e2ecbf9520ef3af50ad11::ions::award_ion_points(&arg1.points_admin_cap, arg4, arg5, arg2, arg3 + v2);
        let v6 = AwardIonPointsEvent{
            user_address     : arg0,
            points_earned    : arg3 + v2,
            referrer_address : v0,
            referral_points  : v1,
            bonus_points     : v2,
            total_points     : arg3 + v2,
        };
        0x2::event::emit<AwardIonPointsEvent>(v6);
    }

    public fun collect_commissions(arg0: &mut MarketPlaceStore, arg1: &CollectorCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = CollectCommissionsEvent{
            recepient : arg2,
            amount    : 0x2::balance::value<0x2::sui::SUI>(&arg0.available_sui),
        };
        0x2::event::emit<CollectCommissionsEvent>(v0);
        0x232a17ffd5315f69fbeec93b96a82e71707d67b200707652a449dd82115e151a::helpers::destroy_or_transfer_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.available_sui), arg2, arg3);
    }

    fun create_trait_summary(arg0: 0x1::option::Option<0x1::ascii::String>, arg1: 0x1::option::Option<0x1::ascii::String>, arg2: 0x1::option::Option<0x1::ascii::String>) : 0x1::ascii::String {
        let v0 = 0x1::ascii::string(b"");
        let v1 = true;
        let v2 = v1;
        if (0x1::option::is_some<0x1::ascii::String>(&arg0)) {
            if (!v1) {
                0x1::ascii::append(&mut v0, 0x1::ascii::string(b","));
            };
            0x1::ascii::append(&mut v0, *0x1::option::borrow<0x1::ascii::String>(&arg0));
            v2 = false;
        };
        if (0x1::option::is_some<0x1::ascii::String>(&arg1)) {
            if (!v2) {
                0x1::ascii::append(&mut v0, 0x1::ascii::string(b","));
            };
            0x1::ascii::append(&mut v0, *0x1::option::borrow<0x1::ascii::String>(&arg1));
            v2 = false;
        };
        if (0x1::option::is_some<0x1::ascii::String>(&arg2)) {
            if (!v2) {
                0x1::ascii::append(&mut v0, 0x1::ascii::string(b","));
            };
            0x1::ascii::append(&mut v0, *0x1::option::borrow<0x1::ascii::String>(&arg2));
        };
        v0
    }

    fun destroy_active_bid(arg0: ActiveBid) : 0x2::balance::Balance<0x2::sui::SUI> {
        let ActiveBid {
            id         : v0,
            bidder     : _,
            bid_price  : _,
            balance    : v3,
            bid_at     : _,
            commission : _,
            royalty    : _,
        } = arg0;
        0x2::object::delete(v0);
        v3
    }

    fun destroy_active_trait_bid(arg0: ActiveTraitBid) : u64 {
        let ActiveTraitBid {
            id           : v0,
            bidder       : _,
            bid_price    : v2,
            bid_at       : _,
            trait_key1   : _,
            trait_value1 : _,
            trait_key2   : _,
            trait_value2 : _,
            trait_key3   : _,
            trait_value3 : _,
            commission   : v10,
            royalty      : v11,
        } = arg0;
        0x2::object::delete(v0);
        v2 + v10 + v11
    }

    fun destroy_listing<T0: store + key>(arg0: Listing<T0>) : (0x2::kiosk::PurchaseCap<T0>, 0x2::object::ID, u64, u64) {
        let Listing {
            seller     : _,
            kiosk_id   : v1,
            nft_id     : _,
            cap        : v3,
            price      : v4,
            royalty    : _,
            commission : v6,
            listed_at  : _,
        } = arg0;
        (v3, v1, v4, v6)
    }

    fun ensure_user_activity_exists(arg0: &mut 0x2::linked_table::LinkedTable<address, UserInfo>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::linked_table::contains<address, UserInfo>(arg0, arg1)) {
            let v0 = UserInfo{
                id               : 0x2::object::new(arg2),
                listings         : 0x2::linked_table::new<0x2::object::ID, ListingInfo>(arg2),
                bids             : 0x2::linked_table::new<0x2::object::ID, BidInfo>(arg2),
                collection_bids  : 0x2::linked_table::new<0x1::ascii::String, vector<BidInfo>>(arg2),
                trait_bids       : 0x2::linked_table::new<0x1::ascii::String, vector<TraitBidInfo>>(arg2),
                claimable_points : 0,
            };
            0x2::linked_table::push_back<address, UserInfo>(arg0, arg1, v0);
        };
    }

    public fun get_active_bid_balance(arg0: &ActiveBid) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_active_bid_info(arg0: &ActiveTraitBid) : (address, u64, u64, 0x1::option::Option<0x1::ascii::String>, 0x1::option::Option<vector<0x1::ascii::String>>, 0x1::option::Option<0x1::ascii::String>, 0x1::option::Option<vector<0x1::ascii::String>>, 0x1::option::Option<0x1::ascii::String>, 0x1::option::Option<vector<0x1::ascii::String>>, u64, u64) {
        (arg0.bidder, arg0.bid_price, arg0.bid_at, arg0.trait_key1, arg0.trait_value1, arg0.trait_key2, arg0.trait_value2, arg0.trait_key3, arg0.trait_value3, arg0.commission, arg0.royalty)
    }

    public fun get_bids_for_any_nft<T0: store + key>(arg0: &MarketPlaceStore, arg1: 0x2::object::ID, arg2: 0x1::option::Option<address>, arg3: u64) : (vector<address>, vector<0x2::object::ID>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64, bool) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u64>();
        if (!0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
            return (v1, v2, v3, v4, v5, v6, 0, false)
        };
        let v7 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, CollectionMarketPlace<T0>>(&arg0.id, v0);
        if (!0x2::linked_table::contains<0x2::object::ID, ActiveBids>(&v7.bids, arg1)) {
            return (v1, v2, v3, v4, v5, v6, 0, 0x2::linked_table::contains<0x2::object::ID, Listing<T0>>(&v7.listings, arg1))
        };
        let v8 = 0x2::linked_table::borrow<0x2::object::ID, ActiveBids>(&v7.bids, arg1);
        let v9 = if (0x1::option::is_some<address>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<address, ActiveBid>(&v8.bids)
        };
        let v10 = v9;
        let v11 = 0;
        while (0x1::option::is_some<address>(&v10) && v11 < arg3) {
            let v12 = 0x1::option::borrow<address>(&v10);
            let v13 = 0x2::linked_table::borrow<address, ActiveBid>(&v8.bids, *v12);
            0x1::vector::push_back<address>(&mut v1, *v12);
            0x1::vector::push_back<0x2::object::ID>(&mut v2, 0x2::object::uid_to_inner(&v13.id));
            0x1::vector::push_back<u64>(&mut v3, v13.bid_price);
            0x1::vector::push_back<u64>(&mut v4, v13.commission);
            0x1::vector::push_back<u64>(&mut v5, v13.royalty);
            0x1::vector::push_back<u64>(&mut v6, 0x2::balance::value<0x2::sui::SUI>(&v13.balance));
            v10 = *0x2::linked_table::next<address, ActiveBid>(&v8.bids, *v12);
            v11 = v11 + 1;
        };
        (v1, v2, v3, v4, v5, v6, 0x2::linked_table::length<address, ActiveBid>(&v8.bids), 0x2::linked_table::contains<0x2::object::ID, Listing<T0>>(&v7.listings, arg1))
    }

    public fun get_bids_for_listing<T0: store + key>(arg0: &MarketPlaceStore, arg1: 0x2::object::ID, arg2: 0x1::option::Option<address>, arg3: u64) : (vector<address>, vector<0x2::object::ID>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u64>();
        if (!0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
            return (v1, v2, v3, v4, v5, v6, 0)
        };
        let v7 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, CollectionMarketPlace<T0>>(&arg0.id, v0);
        if (!0x2::linked_table::contains<0x2::object::ID, ActiveBids>(&v7.bids, arg1)) {
            return (v1, v2, v3, v4, v5, v6, 0)
        };
        let v8 = 0x2::linked_table::borrow<0x2::object::ID, ActiveBids>(&v7.bids, arg1);
        let v9 = if (0x1::option::is_some<address>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<address, ActiveBid>(&v8.bids)
        };
        let v10 = v9;
        let v11 = 0;
        while (0x1::option::is_some<address>(&v10) && v11 < arg3) {
            let v12 = 0x1::option::borrow<address>(&v10);
            let v13 = 0x2::linked_table::borrow<address, ActiveBid>(&v8.bids, *v12);
            0x1::vector::push_back<address>(&mut v1, *v12);
            0x1::vector::push_back<0x2::object::ID>(&mut v2, 0x2::object::uid_to_inner(&v13.id));
            0x1::vector::push_back<u64>(&mut v3, v13.bid_price);
            0x1::vector::push_back<u64>(&mut v6, 0x2::balance::value<0x2::sui::SUI>(&v13.balance));
            0x1::vector::push_back<u64>(&mut v4, v13.commission);
            0x1::vector::push_back<u64>(&mut v5, v13.royalty);
            v10 = *0x2::linked_table::next<address, ActiveBid>(&v8.bids, *v12);
            v11 = v11 + 1;
        };
        (v1, v2, v3, v4, v5, v6, 0x2::linked_table::length<address, ActiveBid>(&v8.bids))
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

    public fun get_collection_bids_by_user_for_collection<T0: store + key>(arg0: &MarketPlaceStore, arg1: address, arg2: u64, arg3: u64) : (vector<0x2::object::ID>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        if (!0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
            return (v1, v2, v3, v4, 0)
        };
        let v5 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, CollectionMarketPlace<T0>>(&arg0.id, v0);
        if (!0x2::linked_table::contains<address, vector<ActiveBid>>(&v5.collection_bids, arg1)) {
            return (v1, v2, v3, v4, 0)
        };
        let v6 = 0x2::linked_table::borrow<address, vector<ActiveBid>>(&v5.collection_bids, arg1);
        while (arg2 < 0x1::vector::length<ActiveBid>(v6) && arg2 < arg3) {
            let v7 = 0x1::vector::borrow<ActiveBid>(v6, arg2);
            0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x2::object::uid_to_inner(&v7.id));
            0x1::vector::push_back<u64>(&mut v2, v7.bid_price);
            0x1::vector::push_back<u64>(&mut v3, 0x2::balance::value<0x2::sui::SUI>(&v7.balance));
            0x1::vector::push_back<u64>(&mut v4, v7.bid_at);
            arg2 = arg2 + 1;
        };
        (v1, v2, v3, v4, 0x1::vector::length<ActiveBid>(v6))
    }

    public fun get_collection_fee(arg0: &MarketPlaceStore) : u64 {
        arg0.new_collection_fee
    }

    public fun get_collection_marketplace_info<T0: store + key>(arg0: &MarketPlaceStore) : (u64, u64, u64, u128, bool, u64, u64) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (!0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
            return (0, 0, 0, 0, false, 0, 0)
        };
        let v1 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, CollectionMarketPlace<T0>>(&arg0.id, v0);
        (0x2::linked_table::length<0x2::object::ID, Listing<T0>>(&v1.listings), 0x2::linked_table::length<0x2::object::ID, ActiveBids>(&v1.bids), 0x2::linked_table::length<address, vector<ActiveBid>>(&v1.collection_bids), v1.lifetime_volume, v1.ion_points_enabled, v1.ion_collection_multiplier, v1.avg_sale_price)
    }

    fun get_ion_points(arg0: bool, arg1: bool, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: u64) : u64 {
        if (!arg1) {
            return 0
        };
        let v0 = if (arg2 == 0) {
            1000
        } else {
            arg2
        };
        let v1 = if (arg0) {
            0x232a17ffd5315f69fbeec93b96a82e71707d67b200707652a449dd82115e151a::helpers::calculate_listing_proximity_multiplier(arg5, arg6)
        } else {
            0x232a17ffd5315f69fbeec93b96a82e71707d67b200707652a449dd82115e151a::helpers::calculate_bid_proximity_multiplier(arg5, arg6)
        };
        0x232a17ffd5315f69fbeec93b96a82e71707d67b200707652a449dd82115e151a::helpers::calculate_ion_points(0x232a17ffd5315f69fbeec93b96a82e71707d67b200707652a449dd82115e151a::helpers::integer_sqrt(arg5), v0, v1, 0x232a17ffd5315f69fbeec93b96a82e71707d67b200707652a449dd82115e151a::helpers::calculate_time_multiplier(arg3, arg4))
    }

    public fun get_listings_for_marketplace<T0: store + key>(arg0: &MarketPlaceStore, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u64) : (vector<address>, vector<0x2::object::ID>, vector<0x2::object::ID>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u64>();
        if (!0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
            return (v1, v2, v3, v4, v5, v6, 0)
        };
        let v7 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, CollectionMarketPlace<T0>>(&arg0.id, v0);
        let v8 = if (0x1::option::is_some<0x2::object::ID>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<0x2::object::ID, Listing<T0>>(&v7.listings)
        };
        let v9 = v8;
        let v10 = 0;
        while (0x1::option::is_some<0x2::object::ID>(&v9) && v10 < arg2) {
            let v11 = 0x1::option::borrow<0x2::object::ID>(&v9);
            let v12 = 0x2::linked_table::borrow<0x2::object::ID, Listing<T0>>(&v7.listings, *v11);
            0x1::vector::push_back<0x2::object::ID>(&mut v3, *v11);
            0x1::vector::push_back<address>(&mut v1, v12.seller);
            0x1::vector::push_back<0x2::object::ID>(&mut v2, v12.kiosk_id);
            0x1::vector::push_back<u64>(&mut v4, v12.price);
            0x1::vector::push_back<u64>(&mut v5, v12.commission);
            0x1::vector::push_back<u64>(&mut v6, v12.royalty);
            v9 = *0x2::linked_table::next<0x2::object::ID, Listing<T0>>(&v7.listings, *v11);
            v10 = v10 + 1;
        };
        (v1, v2, v3, v4, v5, v6, 0x2::linked_table::length<0x2::object::ID, Listing<T0>>(&v7.listings))
    }

    public fun get_marketplace_info(arg0: &MarketPlaceStore) : (address, bool, u64, u64, u64, u64, u64, 0x2::object::ID, u64, u64) {
        (0x2::object::uid_to_address(&arg0.id), arg0.is_permissionless, arg0.new_collection_fee, arg0.commission_pct, 0x2::balance::value<0x2::sui::SUI>(&arg0.available_sui), 0x2::linked_table::length<address, UserInfo>(&arg0.user_activity), 0x2::linked_table::length<0x1::ascii::String, bool>(&arg0.active_collections), arg0.kiosk_id, 0x2::linked_table::length<address, u64>(&arg0.referrals), arg0.version)
    }

    public fun get_referral_points_balance(arg0: &MarketPlaceStore, arg1: address) : u64 {
        if (0x2::linked_table::contains<address, u64>(&arg0.referrals, arg1)) {
            *0x2::linked_table::borrow<address, u64>(&arg0.referrals, arg1)
        } else {
            0
        }
    }

    fun get_royalty_and_commission<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg0)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg0, arg2)
        } else {
            0
        };
        (v0, arg2 * arg1 / 100)
    }

    public fun get_trait_bid_details(arg0: &MarketPlaceStore, arg1: address, arg2: 0x2::object::ID) : (0x1::ascii::String, u64, u64, u64, 0x1::option::Option<0x1::ascii::String>, 0x1::option::Option<vector<0x1::ascii::String>>, 0x1::option::Option<0x1::ascii::String>, 0x1::option::Option<vector<0x1::ascii::String>>, 0x1::option::Option<0x1::ascii::String>, 0x1::option::Option<vector<0x1::ascii::String>>, u64, u64) {
        if (!0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, arg1)) {
            return (0x1::ascii::string(b""), 0, 0, 0, 0x1::option::none<0x1::ascii::String>(), 0x1::option::none<vector<0x1::ascii::String>>(), 0x1::option::none<0x1::ascii::String>(), 0x1::option::none<vector<0x1::ascii::String>>(), 0x1::option::none<0x1::ascii::String>(), 0x1::option::none<vector<0x1::ascii::String>>(), 0, 0)
        };
        let v0 = 0x2::linked_table::borrow<address, UserInfo>(&arg0.user_activity, arg1);
        let v1 = *0x2::linked_table::front<0x1::ascii::String, vector<TraitBidInfo>>(&v0.trait_bids);
        while (0x1::option::is_some<0x1::ascii::String>(&v1)) {
            let v2 = 0x1::option::borrow<0x1::ascii::String>(&v1);
            let v3 = 0x2::linked_table::borrow<0x1::ascii::String, vector<TraitBidInfo>>(&v0.trait_bids, *v2);
            let v4 = 0;
            while (v4 < 0x1::vector::length<TraitBidInfo>(v3)) {
                let v5 = 0x1::vector::borrow<TraitBidInfo>(v3, v4);
                if (v5.bid_id == arg2) {
                    return (v5.nft_type, v5.bid_price, v5.commission, v5.royalty, v5.trait_key1, v5.trait_value1, v5.trait_key2, v5.trait_value2, v5.trait_key3, v5.trait_value3, v5.bid_at, v5.last_points_claimed_at)
                };
                v4 = v4 + 1;
            };
            v1 = *0x2::linked_table::next<0x1::ascii::String, vector<TraitBidInfo>>(&v0.trait_bids, *v2);
        };
        (0x1::ascii::string(b""), 0, 0, 0, 0x1::option::none<0x1::ascii::String>(), 0x1::option::none<vector<0x1::ascii::String>>(), 0x1::option::none<0x1::ascii::String>(), 0x1::option::none<vector<0x1::ascii::String>>(), 0x1::option::none<0x1::ascii::String>(), 0x1::option::none<vector<0x1::ascii::String>>(), 0, 0)
    }

    public fun get_user_activity_overview(arg0: &MarketPlaceStore, arg1: address) : (u64, u64, u64, u64, u64) {
        if (!0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, arg1)) {
            (0, 0, 0, 0, 0)
        } else {
            let v5 = 0x2::linked_table::borrow<address, UserInfo>(&arg0.user_activity, arg1);
            (0x2::linked_table::length<0x2::object::ID, ListingInfo>(&v5.listings), 0x2::linked_table::length<0x2::object::ID, BidInfo>(&v5.bids), 0x2::linked_table::length<0x1::ascii::String, vector<BidInfo>>(&v5.collection_bids), 0x2::linked_table::length<0x1::ascii::String, vector<TraitBidInfo>>(&v5.trait_bids), v5.claimable_points)
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

    public fun get_user_bids_info(arg0: &MarketPlaceStore, arg1: address, arg2: 0x1::option::Option<0x2::object::ID>, arg3: u64) : (vector<0x2::object::ID>, vector<0x1::ascii::String>, vector<0x2::object::ID>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0x1::vector::empty<u64>();
        if (!0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, arg1)) {
            return (v0, v1, v2, v3, v4, v5, v6, v7, 0)
        };
        let v8 = 0x2::linked_table::borrow<address, UserInfo>(&arg0.user_activity, arg1);
        let v9 = if (0x1::option::is_some<0x2::object::ID>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<0x2::object::ID, BidInfo>(&v8.bids)
        };
        let v10 = v9;
        let v11 = 0;
        while (0x1::option::is_some<0x2::object::ID>(&v10) && v11 < arg3) {
            let v12 = 0x1::option::borrow<0x2::object::ID>(&v10);
            let v13 = 0x2::linked_table::borrow<0x2::object::ID, BidInfo>(&v8.bids, *v12);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, *v12);
            0x1::vector::push_back<0x1::ascii::String>(&mut v1, v13.nft_type);
            0x1::vector::push_back<0x2::object::ID>(&mut v2, v13.bid_id);
            0x1::vector::push_back<u64>(&mut v3, v13.bid_price);
            0x1::vector::push_back<u64>(&mut v4, v13.commission);
            0x1::vector::push_back<u64>(&mut v5, v13.royalty);
            0x1::vector::push_back<u64>(&mut v6, v13.bid_at);
            0x1::vector::push_back<u64>(&mut v7, v13.last_points_claimed_at);
            v10 = *0x2::linked_table::next<0x2::object::ID, BidInfo>(&v8.bids, *v12);
            v11 = v11 + 1;
        };
        (v0, v1, v2, v3, v4, v5, v6, v7, 0x2::linked_table::length<0x2::object::ID, BidInfo>(&v8.bids))
    }

    public fun get_user_collection_bids_for_type(arg0: &MarketPlaceStore, arg1: address, arg2: 0x1::ascii::String, arg3: u64, arg4: u64) : (vector<0x2::object::ID>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        if (!0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, arg1)) {
            return (v0, v1, v2, v3, v4, v5, 0)
        };
        let v6 = 0x2::linked_table::borrow<address, UserInfo>(&arg0.user_activity, arg1);
        if (!0x2::linked_table::contains<0x1::ascii::String, vector<BidInfo>>(&v6.collection_bids, arg2)) {
            return (v0, v1, v2, v3, v4, v5, 0)
        };
        let v7 = 0x2::linked_table::borrow<0x1::ascii::String, vector<BidInfo>>(&v6.collection_bids, arg2);
        let v8 = 0x1::vector::length<BidInfo>(v7);
        while (arg3 < v8 && arg3 < arg4) {
            let v9 = 0x1::vector::borrow<BidInfo>(v7, arg3);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, v9.bid_id);
            0x1::vector::push_back<u64>(&mut v1, v9.bid_price);
            0x1::vector::push_back<u64>(&mut v2, v9.commission);
            0x1::vector::push_back<u64>(&mut v3, v9.royalty);
            0x1::vector::push_back<u64>(&mut v4, v9.bid_at);
            0x1::vector::push_back<u64>(&mut v5, v9.last_points_claimed_at);
            arg3 = arg3 + 1;
        };
        (v0, v1, v2, v3, v4, v5, v8)
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

    public fun get_user_listings_info(arg0: &MarketPlaceStore, arg1: address, arg2: 0x1::option::Option<0x2::object::ID>, arg3: u64) : (vector<0x2::object::ID>, vector<0x1::ascii::String>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        if (!0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, arg1)) {
            return (v0, v1, v2, v3, v4, v5, 0)
        };
        let v6 = 0x2::linked_table::borrow<address, UserInfo>(&arg0.user_activity, arg1);
        let v7 = if (0x1::option::is_some<0x2::object::ID>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<0x2::object::ID, ListingInfo>(&v6.listings)
        };
        let v8 = v7;
        let v9 = 0;
        while (0x1::option::is_some<0x2::object::ID>(&v8) && v9 < arg3) {
            let v10 = 0x1::option::borrow<0x2::object::ID>(&v8);
            let v11 = 0x2::linked_table::borrow<0x2::object::ID, ListingInfo>(&v6.listings, *v10);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, *v10);
            0x1::vector::push_back<0x1::ascii::String>(&mut v1, v11.nft_type);
            0x1::vector::push_back<u64>(&mut v2, v11.price);
            0x1::vector::push_back<u64>(&mut v3, v11.commission);
            0x1::vector::push_back<u64>(&mut v4, v11.royalty);
            0x1::vector::push_back<u64>(&mut v5, v11.last_points_claimed_at);
            v8 = *0x2::linked_table::next<0x2::object::ID, ListingInfo>(&v6.listings, *v10);
            v9 = v9 + 1;
        };
        (v0, v1, v2, v3, v4, v5, 0x2::linked_table::length<0x2::object::ID, ListingInfo>(&v6.listings))
    }

    public fun get_user_pending_claims(arg0: &MarketPlaceStore, arg1: address, arg2: 0x1::option::Option<0x2::object::ID>, arg3: u64) : (vector<0x2::object::ID>, vector<0x1::ascii::String>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        if (!0x2::linked_table::contains<address, PendingClaims>(&arg0.pending_claims, arg1)) {
            return (v0, v1, v2, v3, v4, 0)
        };
        let v5 = 0x2::linked_table::borrow<address, PendingClaims>(&arg0.pending_claims, arg1);
        let v6 = if (0x1::option::is_some<0x2::object::ID>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<0x2::object::ID, PendingClaim>(&v5.pending_claims)
        };
        let v7 = v6;
        let v8 = 0;
        while (0x1::option::is_some<0x2::object::ID>(&v7) && v8 < arg3) {
            let v9 = 0x1::option::borrow<0x2::object::ID>(&v7);
            let v10 = 0x2::linked_table::borrow<0x2::object::ID, PendingClaim>(&v5.pending_claims, *v9);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, *v9);
            0x1::vector::push_back<0x1::ascii::String>(&mut v1, v10.nft_type);
            0x1::vector::push_back<u64>(&mut v2, v10.price);
            0x1::vector::push_back<u64>(&mut v3, v10.commission);
            0x1::vector::push_back<u64>(&mut v4, v10.royalty);
            v7 = *0x2::linked_table::next<0x2::object::ID, PendingClaim>(&v5.pending_claims, *v9);
            v8 = v8 + 1;
        };
        (v0, v1, v2, v3, v4, v8)
    }

    public fun get_user_trait_bids_info(arg0: &MarketPlaceStore, arg1: address, arg2: 0x1::option::Option<0x1::ascii::String>, arg3: u64) : (vector<0x2::object::ID>, vector<0x1::ascii::String>, vector<u64>, vector<u64>, vector<u64>, vector<0x1::ascii::String>, u64) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<0x1::ascii::String>();
        let v6 = 0;
        if (!0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, arg1)) {
            return (v0, v1, v2, v3, v4, v5, 0)
        };
        let v7 = 0x2::linked_table::borrow<address, UserInfo>(&arg0.user_activity, arg1);
        let v8 = if (0x1::option::is_some<0x1::ascii::String>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<0x1::ascii::String, vector<TraitBidInfo>>(&v7.trait_bids)
        };
        let v9 = v8;
        let v10 = 0;
        while (0x1::option::is_some<0x1::ascii::String>(&v9) && v10 < arg3) {
            let v11 = 0x1::option::borrow<0x1::ascii::String>(&v9);
            let v12 = 0x2::linked_table::borrow<0x1::ascii::String, vector<TraitBidInfo>>(&v7.trait_bids, *v11);
            let v13 = 0;
            while (v13 < 0x1::vector::length<TraitBidInfo>(v12) && v10 < arg3) {
                let v14 = 0x1::vector::borrow<TraitBidInfo>(v12, v13);
                0x1::vector::push_back<0x2::object::ID>(&mut v0, v14.bid_id);
                0x1::vector::push_back<0x1::ascii::String>(&mut v1, v14.nft_type);
                0x1::vector::push_back<u64>(&mut v2, v14.bid_price);
                0x1::vector::push_back<u64>(&mut v3, v14.commission);
                0x1::vector::push_back<u64>(&mut v4, v14.royalty);
                0x1::vector::push_back<0x1::ascii::String>(&mut v5, create_trait_summary(v14.trait_key1, v14.trait_key2, v14.trait_key3));
                v13 = v13 + 1;
                v10 = v10 + 1;
                v6 = v6 + 1;
            };
            v9 = *0x2::linked_table::next<0x1::ascii::String, vector<TraitBidInfo>>(&v7.trait_bids, *v11);
        };
        let v15 = 0;
        let v16 = *0x2::linked_table::front<0x1::ascii::String, vector<TraitBidInfo>>(&v7.trait_bids);
        while (0x1::option::is_some<0x1::ascii::String>(&v16)) {
            let v17 = 0x1::option::borrow<0x1::ascii::String>(&v16);
            v15 = v15 + 0x1::vector::length<TraitBidInfo>(0x2::linked_table::borrow<0x1::ascii::String, vector<TraitBidInfo>>(&v7.trait_bids, *v17));
            v16 = *0x2::linked_table::next<0x1::ascii::String, vector<TraitBidInfo>>(&v7.trait_bids, *v17);
        };
        (v0, v1, v2, v3, v4, v5, v15)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CollectorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<CollectorCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = LaunchpadCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<LaunchpadCap>(v2, 0x2::tx_context::sender(arg0));
        let v3 = TraitBidsAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<TraitBidsAdminCap>(v3, 0x2::tx_context::sender(arg0));
    }

    public fun init_marketplace(arg0: &AdminCap, arg1: 0x235ff29f0b8073f4cc3f0c27011138dadac81dd71b1e2ecbf9520ef3af50ad11::ions::PointsAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg2);
        let v2 = v1;
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        let v3 = MarketPlaceStore{
            id                 : 0x2::object::new(arg2),
            points_admin_cap   : arg1,
            is_permissionless  : false,
            new_collection_fee : 100000000000,
            commission_pct     : 2,
            available_sui      : 0x2::balance::zero<0x2::sui::SUI>(),
            user_activity      : 0x2::linked_table::new<address, UserInfo>(arg2),
            active_collections : 0x2::linked_table::new<0x1::ascii::String, bool>(arg2),
            referrals          : 0x2::linked_table::new<address, u64>(arg2),
            kiosk_id           : 0x2::kiosk::kiosk_owner_cap_for(&v2),
            escrow_kiosk_cap   : v2,
            pending_claims     : 0x2::linked_table::new<address, PendingClaims>(arg2),
            version            : 0,
        };
        0x2::transfer::share_object<MarketPlaceStore>(v3);
    }

    public fun is_permissionless(arg0: &MarketPlaceStore) : bool {
        arg0.is_permissionless
    }

    public fun launchpad_add_collection<T0: store + key>(arg0: &mut MarketPlaceStore, arg1: &LaunchpadCap, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        assert!(arg3 <= 10000, 781);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(!0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v0), 774);
        0x2::linked_table::push_back<0x1::ascii::String, bool>(&mut arg0.active_collections, v0, true);
        let v1 = CollectionMarketPlace<T0>{
            id                        : 0x2::object::new(arg4),
            listings                  : 0x2::linked_table::new<0x2::object::ID, Listing<T0>>(arg4),
            bids                      : 0x2::linked_table::new<0x2::object::ID, ActiveBids>(arg4),
            collection_bids           : 0x2::linked_table::new<address, vector<ActiveBid>>(arg4),
            sui_trait_bids_pool       : 0x2::balance::zero<0x2::sui::SUI>(),
            are_trait_bids_enabled    : false,
            lifetime_volume           : 0,
            ion_points_enabled        : arg2,
            ion_collection_multiplier : arg3,
            avg_sale_price            : 0,
            recent_sale_prices        : 0x1::vector::empty<u64>(),
        };
        0x2::dynamic_object_field::add<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v0, v1);
        let v2 = UpdateActiveCollectionsEvent{
            nft_type : v0,
            boolean  : true,
        };
        0x2::event::emit<UpdateActiveCollectionsEvent>(v2);
        let v3 = UpdateIONMultiplierEvent{
            nft_type                  : v0,
            is_ion_points_enabled     : arg2,
            ion_collection_multiplier : arg3,
        };
        0x2::event::emit<UpdateIONMultiplierEvent>(v3);
    }

    public entry fun list<T0: store + key>(arg0: &mut MarketPlaceStore, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"=== LISTING NFT ===");
        0x1::debug::print<0x1::string::String>(&v0);
        validation_check(arg0);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = 0x2::object::id<0x2::kiosk::Kiosk>(arg2);
        let v3 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v4 = 0x2::clock::timestamp_ms(arg6);
        validate_collection_exists<T0>(arg0);
        let (v5, v6) = get_royalty_and_commission<T0>(arg1, arg0.commission_pct, arg5);
        let v7 = Listing<T0>{
            seller     : v1,
            kiosk_id   : v2,
            nft_id     : arg4,
            cap        : 0x2::kiosk::list_with_purchase_cap<T0>(arg2, arg3, arg4, arg5, arg7),
            price      : arg5,
            royalty    : v5,
            commission : v6,
            listed_at  : v4,
        };
        0x2::linked_table::push_back<0x2::object::ID, Listing<T0>>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v3).listings, arg4, v7);
        let v8 = &mut arg0.user_activity;
        ensure_user_activity_exists(v8, v1, arg7);
        let v9 = ListingInfo{
            nft_type               : v3,
            price                  : arg5,
            commission             : v6,
            royalty                : v5,
            listed_at              : v4,
            last_points_claimed_at : v4,
        };
        0x2::linked_table::push_back<0x2::object::ID, ListingInfo>(&mut 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg0.user_activity, v1).listings, arg4, v9);
        let v10 = 0x1::string::utf8(b"NFT listed successfully");
        0x1::debug::print<0x1::string::String>(&v10);
        let v11 = ListEvent{
            nft_type   : v3,
            seller     : v1,
            kiosk_id   : v2,
            nft_id     : arg4,
            price      : arg5,
            commission : v6,
            royalty    : v5,
            total_cost : arg5 + v6,
            listed_at  : v4,
        };
        0x2::event::emit<ListEvent>(v11);
    }

    public entry fun make_bid<T0: store + key>(arg0: &mut MarketPlaceStore, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v2 = !0x1::option::is_some<0x2::object::ID>(&arg1);
        let v3 = 0x2::clock::timestamp_ms(arg4);
        let v4 = 0x1::string::utf8(b"=== MAKING BID ===");
        0x1::debug::print<0x1::string::String>(&v4);
        0x1::debug::print<address>(&v0);
        0x1::debug::print<0x1::option::Option<0x2::object::ID>>(&arg1);
        0x1::debug::print<u64>(&arg2);
        0x1::debug::print<bool>(&v2);
        0x1::debug::print<0x1::ascii::String>(&v1);
        validate_collection_exists<T0>(arg0);
        let (v5, v6) = get_royalty_and_commission<T0>(arg5, arg0.commission_pct, arg2);
        let v7 = arg2 + v6 + v5;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v7, 772);
        let v8 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        let v9 = ActiveBid{
            id         : 0x2::object::new(arg6),
            bidder     : v0,
            bid_price  : arg2,
            balance    : 0x2::balance::split<0x2::sui::SUI>(&mut v8, v7),
            bid_at     : v3,
            commission : v6,
            royalty    : v5,
        };
        let v10 = 0x2::object::id<ActiveBid>(&v9);
        let v11 = 0x1::string::utf8(b"Created bid with ID:");
        0x1::debug::print<0x1::string::String>(&v11);
        0x1::debug::print<0x2::object::ID>(&v10);
        let (v12, _, _, _) = manage_bids_for_collection<T0>(arg0, v1, v0, arg1, v2, 0x1::option::some<ActiveBid>(v9), 0x1::option::none<0x2::object::ID>(), arg6);
        0x2::balance::join<0x2::sui::SUI>(&mut v8, v12);
        let v16 = BidInfo{
            bid_id                 : v10,
            nft_type               : v1,
            bid_price              : arg2,
            commission             : v6,
            royalty                : v5,
            is_collection_bid      : v2,
            bid_at                 : v3,
            last_points_claimed_at : v3,
        };
        let (_, _) = manage_bid_record_for_user(arg0, v1, v0, true, arg1, v2, 0x1::option::some<BidInfo>(v16), 0x1::option::none<0x2::object::ID>(), arg6);
        let v19 = 0x1::string::utf8(b"Bid created successfully");
        0x1::debug::print<0x1::string::String>(&v19);
        let v20 = MakeBidEvent{
            bid_id            : v10,
            nft_type          : v1,
            buyer             : v0,
            nft_id            : arg1,
            price             : arg2,
            commission        : v6,
            royalty           : v5,
            total_cost        : v7,
            is_collection_bid : v2,
            bid_at            : v3,
        };
        0x2::event::emit<MakeBidEvent>(v20);
        0x232a17ffd5315f69fbeec93b96a82e71707d67b200707652a449dd82115e151a::helpers::destroy_or_transfer_balance<0x2::sui::SUI>(v8, v0, arg6);
    }

    fun manage_bid_record_for_user(arg0: &mut MarketPlaceStore, arg1: 0x1::ascii::String, arg2: address, arg3: bool, arg4: 0x1::option::Option<0x2::object::ID>, arg5: bool, arg6: 0x1::option::Option<BidInfo>, arg7: 0x1::option::Option<0x2::object::ID>, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = &mut arg0.user_activity;
        ensure_user_activity_exists(v0, arg2, arg8);
        let v1 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg0.user_activity, arg2);
        let v2 = 0;
        let v3 = 0;
        if (arg3) {
            if (arg5) {
                if (0x2::linked_table::contains<0x1::ascii::String, vector<BidInfo>>(&v1.collection_bids, arg1)) {
                    0x1::vector::push_back<BidInfo>(0x2::linked_table::borrow_mut<0x1::ascii::String, vector<BidInfo>>(&mut v1.collection_bids, arg1), 0x1::option::destroy_some<BidInfo>(arg6));
                } else {
                    let v4 = 0x1::vector::empty<BidInfo>();
                    0x1::vector::push_back<BidInfo>(&mut v4, 0x1::option::destroy_some<BidInfo>(arg6));
                    0x2::linked_table::push_back<0x1::ascii::String, vector<BidInfo>>(&mut v1.collection_bids, arg1, v4);
                };
            } else {
                let v5 = *0x1::option::borrow<0x2::object::ID>(&arg4);
                assert!(!0x2::linked_table::contains<0x2::object::ID, BidInfo>(&v1.bids, v5), 775);
                0x2::linked_table::push_back<0x2::object::ID, BidInfo>(&mut v1.bids, v5, 0x1::option::destroy_some<BidInfo>(arg6));
            };
        } else {
            0x1::option::destroy_none<BidInfo>(arg6);
            if (arg5) {
                assert!(0x2::linked_table::contains<0x1::ascii::String, vector<BidInfo>>(&v1.collection_bids, arg1), 776);
                let v6 = 0x2::linked_table::borrow_mut<0x1::ascii::String, vector<BidInfo>>(&mut v1.collection_bids, arg1);
                let v7 = 0;
                while (v7 < 0x1::vector::length<BidInfo>(v6)) {
                    if (0x1::vector::borrow<BidInfo>(v6, v7).bid_id == *0x1::option::borrow<0x2::object::ID>(&arg7)) {
                        let v8 = 0x1::vector::remove<BidInfo>(v6, v7);
                        v2 = v8.bid_price;
                        v3 = v8.last_points_claimed_at;
                        break
                    };
                    v7 = v7 + 1;
                };
                if (0x1::vector::length<BidInfo>(v6) == 0) {
                    0x2::linked_table::remove<0x1::ascii::String, vector<BidInfo>>(&mut v1.collection_bids, arg1);
                };
            } else {
                let v9 = *0x1::option::borrow<0x2::object::ID>(&arg4);
                assert!(0x2::linked_table::contains<0x2::object::ID, BidInfo>(&v1.bids, v9), 776);
                let v10 = 0x2::linked_table::remove<0x2::object::ID, BidInfo>(&mut v1.bids, v9);
                v2 = v10.bid_price;
                v3 = v10.last_points_claimed_at;
            };
        };
        (v2, v3)
    }

    fun manage_bids_for_collection<T0: store + key>(arg0: &mut MarketPlaceStore, arg1: 0x1::ascii::String, arg2: address, arg3: 0x1::option::Option<0x2::object::ID>, arg4: bool, arg5: 0x1::option::Option<ActiveBid>, arg6: 0x1::option::Option<0x2::object::ID>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, u64, u64, u64) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, arg1);
        let v1 = 0x2::balance::zero<0x2::sui::SUI>();
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        if (0x1::option::is_some<ActiveBid>(&arg5)) {
            if (!arg4) {
                let v5 = *0x1::option::borrow<0x2::object::ID>(&arg3);
                if (0x2::linked_table::contains<0x2::object::ID, ActiveBids>(&v0.bids, v5)) {
                    let v6 = 0x2::linked_table::borrow_mut<0x2::object::ID, ActiveBids>(&mut v0.bids, v5);
                    assert!(!0x2::linked_table::contains<address, ActiveBid>(&v6.bids, arg2), 775);
                    0x2::linked_table::push_back<address, ActiveBid>(&mut v6.bids, arg2, 0x1::option::destroy_some<ActiveBid>(arg5));
                } else {
                    let v7 = ActiveBids{
                        id   : 0x2::object::new(arg7),
                        bids : 0x2::linked_table::new<address, ActiveBid>(arg7),
                    };
                    0x2::linked_table::push_back<address, ActiveBid>(&mut v7.bids, arg2, 0x1::option::destroy_some<ActiveBid>(arg5));
                    0x2::linked_table::push_back<0x2::object::ID, ActiveBids>(&mut v0.bids, v5, v7);
                };
            } else if (0x2::linked_table::contains<address, vector<ActiveBid>>(&v0.collection_bids, arg2)) {
                0x1::vector::push_back<ActiveBid>(0x2::linked_table::borrow_mut<address, vector<ActiveBid>>(&mut v0.collection_bids, arg2), 0x1::option::destroy_some<ActiveBid>(arg5));
            } else {
                let v8 = 0x1::vector::empty<ActiveBid>();
                0x1::vector::push_back<ActiveBid>(&mut v8, 0x1::option::destroy_some<ActiveBid>(arg5));
                0x2::linked_table::push_back<address, vector<ActiveBid>>(&mut v0.collection_bids, arg2, v8);
            };
        } else {
            0x1::option::destroy_none<ActiveBid>(arg5);
            if (!arg4) {
                let v9 = *0x1::option::borrow<0x2::object::ID>(&arg3);
                assert!(0x2::linked_table::contains<0x2::object::ID, ActiveBids>(&v0.bids, v9), 776);
                let v10 = 0x2::linked_table::remove<address, ActiveBid>(&mut 0x2::linked_table::borrow_mut<0x2::object::ID, ActiveBids>(&mut v0.bids, v9).bids, arg2);
                v4 = v10.bid_price;
                v3 = v10.commission;
                v2 = v10.royalty;
                0x2::balance::join<0x2::sui::SUI>(&mut v1, destroy_active_bid(v10));
            } else {
                assert!(0x2::linked_table::contains<address, vector<ActiveBid>>(&v0.collection_bids, arg2), 776);
                let v11 = 0x2::linked_table::borrow_mut<address, vector<ActiveBid>>(&mut v0.collection_bids, arg2);
                let v12 = 0;
                while (v12 < 0x1::vector::length<ActiveBid>(v11)) {
                    if (0x2::object::uid_to_inner(&0x1::vector::borrow<ActiveBid>(v11, v12).id) == *0x1::option::borrow<0x2::object::ID>(&arg6)) {
                        let v13 = 0x1::vector::remove<ActiveBid>(v11, v12);
                        v4 = v13.bid_price;
                        v3 = v13.commission;
                        v2 = v13.royalty;
                        0x2::balance::join<0x2::sui::SUI>(&mut v1, destroy_active_bid(v13));
                        break
                    };
                    v12 = v12 + 1;
                };
                if (0x1::vector::length<ActiveBid>(v11) == 0) {
                    0x1::vector::destroy_empty<ActiveBid>(0x2::linked_table::remove<address, vector<ActiveBid>>(&mut v0.collection_bids, arg2));
                };
            };
        };
        (v1, v4, v3, v2)
    }

    public fun permissionless_add_collection<T0: store + key>(arg0: &mut MarketPlaceStore, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        assert!(arg0.is_permissionless, 774);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(!0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v0), 774);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.new_collection_fee, 772);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.available_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v1, arg0.new_collection_fee));
        0x232a17ffd5315f69fbeec93b96a82e71707d67b200707652a449dd82115e151a::helpers::destroy_or_transfer_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg2), arg2);
        0x2::linked_table::push_back<0x1::ascii::String, bool>(&mut arg0.active_collections, v0, true);
        let v2 = CollectionMarketPlace<T0>{
            id                        : 0x2::object::new(arg2),
            listings                  : 0x2::linked_table::new<0x2::object::ID, Listing<T0>>(arg2),
            bids                      : 0x2::linked_table::new<0x2::object::ID, ActiveBids>(arg2),
            collection_bids           : 0x2::linked_table::new<address, vector<ActiveBid>>(arg2),
            sui_trait_bids_pool       : 0x2::balance::zero<0x2::sui::SUI>(),
            are_trait_bids_enabled    : false,
            lifetime_volume           : 0,
            ion_points_enabled        : false,
            ion_collection_multiplier : 0,
            avg_sale_price            : 0,
            recent_sale_prices        : 0x1::vector::empty<u64>(),
        };
        0x2::dynamic_object_field::add<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v0, v2);
        let v3 = UpdateActiveCollectionsEvent{
            nft_type : v0,
            boolean  : true,
        };
        0x2::event::emit<UpdateActiveCollectionsEvent>(v3);
    }

    public fun remove_trait_bidding_support<T0: store + key, T1: store + key>(arg0: &mut MarketPlaceStore, arg1: &TraitBidsAdminCap, arg2: &mut 0x2::tx_context::TxContext) : T1 {
        validation_check(arg0);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v0), 774);
        assert!(0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0), 774);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v0);
        v1.are_trait_bids_enabled = false;
        let v2 = UpdateTraitBiddingSupportEvent{
            nft_type               : v0,
            are_trait_bids_enabled : false,
        };
        0x2::event::emit<UpdateTraitBiddingSupportEvent>(v2);
        0x2::dynamic_object_field::remove<vector<u8>, T1>(&mut v1.id, b"trait_bids")
    }

    public fun switch_trait_bidding_support<T0: store + key>(arg0: &mut MarketPlaceStore, arg1: &TraitBidsAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v0), 774);
        assert!(0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0), 774);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v0);
        v1.are_trait_bids_enabled = !v1.are_trait_bids_enabled;
        let v2 = UpdateTraitBiddingSupportEvent{
            nft_type               : v0,
            are_trait_bids_enabled : v1.are_trait_bids_enabled,
        };
        0x2::event::emit<UpdateTraitBiddingSupportEvent>(v2);
    }

    public fun unlist<T0: store + key>(arg0: &mut MarketPlaceStore, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x235ff29f0b8073f4cc3f0c27011138dadac81dd71b1e2ecbf9520ef3af50ad11::ions::AnimaIONs, arg4: &0x2::clock::Clock, arg5: &mut 0x235ff29f0b8073f4cc3f0c27011138dadac81dd71b1e2ecbf9520ef3af50ad11::ions::AnimaChef, arg6: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v2 = 0x2::clock::timestamp_ms(arg4);
        let v3 = 0x1::string::utf8(b"=== UNLISTING NFT ===");
        0x1::debug::print<0x1::string::String>(&v3);
        assert!(0x2::linked_table::contains<address, UserInfo>(&arg0.user_activity, v0), 769);
        let v4 = 0x2::linked_table::borrow_mut<address, UserInfo>(&mut arg0.user_activity, v0);
        assert!(0x2::linked_table::contains<0x2::object::ID, ListingInfo>(&v4.listings, arg2), 770);
        let v5 = 0x2::linked_table::remove<0x2::object::ID, ListingInfo>(&mut v4.listings, arg2);
        let v6 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v1);
        assert!(0x2::linked_table::contains<0x2::object::ID, Listing<T0>>(&v6.listings, arg2), 770);
        let v7 = 0x2::linked_table::remove<0x2::object::ID, Listing<T0>>(&mut v6.listings, arg2);
        let v8 = v2 - v5.last_points_claimed_at;
        let v9 = 0x1::string::utf8(b"Time active:");
        0x1::debug::print<0x1::string::String>(&v9);
        0x1::debug::print<u64>(&v8);
        let v10 = get_ion_points(true, v6.ion_points_enabled, v6.ion_collection_multiplier, v8, false, v7.price, v6.avg_sale_price);
        award_ion_points_with_referral(v0, arg0, arg3, v10, arg4, arg5);
        let v11 = 0x1::string::utf8(b"=== ION POINTS ===");
        0x1::debug::print<0x1::string::String>(&v11);
        0x1::debug::print<u64>(&v10);
        let v12 = UnlistEvent{
            nft_type           : v1,
            seller             : v0,
            nft_id             : arg2,
            kiosk_id           : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            price              : v7.price,
            unlisted_at        : v2,
            ion_points_awarded : v10,
        };
        0x2::event::emit<UnlistEvent>(v12);
        let (v13, _, _, _) = destroy_listing<T0>(v7);
        0x2::kiosk::return_purchase_cap<T0>(arg1, v13);
        let v17 = 0x1::string::utf8(b"NFT unlisted successfully");
        0x1::debug::print<0x1::string::String>(&v17);
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
                    id                        : 0x2::object::new(arg3),
                    listings                  : 0x2::linked_table::new<0x2::object::ID, Listing<T0>>(arg3),
                    bids                      : 0x2::linked_table::new<0x2::object::ID, ActiveBids>(arg3),
                    collection_bids           : 0x2::linked_table::new<address, vector<ActiveBid>>(arg3),
                    sui_trait_bids_pool       : 0x2::balance::zero<0x2::sui::SUI>(),
                    are_trait_bids_enabled    : false,
                    lifetime_volume           : 0,
                    ion_points_enabled        : false,
                    ion_collection_multiplier : 0,
                    avg_sale_price            : 0,
                    recent_sale_prices        : 0x1::vector::empty<u64>(),
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

    fun update_collection_avg_price<T0: store + key>(arg0: &mut CollectionMarketPlace<T0>, arg1: u64) {
        if (0x1::vector::length<u64>(&arg0.recent_sale_prices) >= 10) {
            0x1::vector::remove<u64>(&mut arg0.recent_sale_prices, 0);
        };
        0x1::vector::push_back<u64>(&mut arg0.recent_sale_prices, arg1);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0.recent_sale_prices)) {
            v0 = v0 + *0x1::vector::borrow<u64>(&arg0.recent_sale_prices, v1);
            v1 = v1 + 1;
        };
        arg0.avg_sale_price = v0 / 0x1::vector::length<u64>(&arg0.recent_sale_prices);
    }

    public fun update_collection_fee(arg0: &mut MarketPlaceStore, arg1: &AdminCap, arg2: u64) {
        validation_check(arg0);
        arg0.new_collection_fee = arg2;
    }

    public fun update_commission_pct(arg0: &mut MarketPlaceStore, arg1: &AdminCap, arg2: u64) {
        validation_check(arg0);
        assert!(arg2 <= 10, 771);
        arg0.commission_pct = arg2;
    }

    public fun update_ion_point_multiplier<T0: store + key>(arg0: &mut MarketPlaceStore, arg1: &AdminCap, arg2: bool, arg3: u64) {
        validation_check(arg0);
        assert!(arg3 <= 10000, 781);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionMarketPlace<T0>>(&mut arg0.id, v0);
        v1.ion_points_enabled = arg2;
        v1.ion_collection_multiplier = arg3;
        let v2 = UpdateIONMultiplierEvent{
            nft_type                  : v0,
            is_ion_points_enabled     : arg2,
            ion_collection_multiplier : arg3,
        };
        0x2::event::emit<UpdateIONMultiplierEvent>(v2);
    }

    public fun update_module_version(arg0: &mut MarketPlaceStore) {
        assert!(arg0.version < 0, 773);
        arg0.version = 0;
    }

    public fun update_permissionless_status(arg0: &mut MarketPlaceStore, arg1: &AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg0);
        arg0.is_permissionless = arg2;
        let v0 = UpdatePermissionlessStatusEvent{is_permissionless: arg2};
        0x2::event::emit<UpdatePermissionlessStatusEvent>(v0);
    }

    fun validate_collection_exists<T0: store + key>(arg0: &MarketPlaceStore) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.active_collections, v0), 774);
        assert!(*0x2::linked_table::borrow<0x1::ascii::String, bool>(&arg0.active_collections, v0), 774);
        assert!(0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0), 774);
    }

    fun validation_check(arg0: &MarketPlaceStore) {
        assert!(arg0.version == 0, 7684);
    }

    // decompiled from Move bytecode v6
}

