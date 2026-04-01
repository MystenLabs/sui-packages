module 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::offer_registry {
    struct OfferInfo has copy, drop, store {
        offer_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        offerer: address,
        amount: u64,
        expires_at: u64,
        created_at: u64,
        active: bool,
    }

    struct OfferRegistry has store {
        offers: 0x2::table::Table<0x2::object::ID, OfferInfo>,
        offer_payments: 0x2::object_bag::ObjectBag,
        offers_by_listing: 0x2::table::Table<0x2::object::ID, vector<0x2::object::ID>>,
        offers_by_nft: 0x2::table::Table<0x2::object::ID, vector<0x2::object::ID>>,
        offers_by_offerer: 0x2::table::Table<address, vector<0x2::object::ID>>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : OfferRegistry {
        OfferRegistry{
            offers            : 0x2::table::new<0x2::object::ID, OfferInfo>(arg0),
            offer_payments    : 0x2::object_bag::new(arg0),
            offers_by_listing : 0x2::table::new<0x2::object::ID, vector<0x2::object::ID>>(arg0),
            offers_by_nft     : 0x2::table::new<0x2::object::ID, vector<0x2::object::ID>>(arg0),
            offers_by_offerer : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
        }
    }

    public(friend) fun accept_offer(arg0: &mut OfferRegistry, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : (0x2::coin::Coin<0x2::sui::SUI>, OfferInfo) {
        assert!(0x2::table::contains<0x2::object::ID, OfferInfo>(&arg0.offers, arg1), 0);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, OfferInfo>(&mut arg0.offers, arg1);
        assert!(v0.active, 0);
        assert!(0x2::clock::timestamp_ms(arg2) < v0.expires_at, 1);
        v0.active = false;
        (0x2::object_bag::remove<0x2::object::ID, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.offer_payments, arg1), *v0)
    }

    public fun amount(arg0: &OfferInfo) : u64 {
        arg0.amount
    }

    public fun can_cleanup_expired_offer(arg0: &OfferRegistry, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : bool {
        if (!0x2::table::contains<0x2::object::ID, OfferInfo>(&arg0.offers, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<0x2::object::ID, OfferInfo>(&arg0.offers, arg1);
        v0.active && 0x2::clock::timestamp_ms(arg2) >= v0.expires_at
    }

    public(friend) fun cancel_offer(arg0: &mut OfferRegistry, arg1: 0x2::object::ID, arg2: address, arg3: &0x2::clock::Clock) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::table::contains<0x2::object::ID, OfferInfo>(&arg0.offers, arg1), 0);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, OfferInfo>(&mut arg0.offers, arg1);
        assert!(v0.offerer == arg2, 2);
        assert!(v0.active, 0);
        v0.active = false;
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::marketplace_events::emit_offer_cancelled(arg1, v0.listing_id, arg2, 0x2::clock::timestamp_ms(arg3));
        0x2::object_bag::remove<0x2::object::ID, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.offer_payments, arg1)
    }

    public(friend) fun cleanup_expired_offer(arg0: &mut OfferRegistry, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::table::contains<0x2::object::ID, OfferInfo>(&arg0.offers, arg1), 0);
        let v0 = 0x2::table::borrow<0x2::object::ID, OfferInfo>(&arg0.offers, arg1);
        assert!(0x2::clock::timestamp_ms(arg2) >= v0.expires_at, 1);
        assert!(v0.active, 0);
        let v1 = v0.offerer;
        let v2 = v0.listing_id;
        let v3 = v0.nft_id;
        0x2::table::borrow_mut<0x2::object::ID, OfferInfo>(&mut arg0.offers, arg1).active = false;
        0x2::table::remove<0x2::object::ID, OfferInfo>(&mut arg0.offers, arg1);
        if (0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg0.offers_by_listing, v2)) {
            let v4 = 0x2::table::borrow_mut<0x2::object::ID, vector<0x2::object::ID>>(&mut arg0.offers_by_listing, v2);
            let (v5, v6) = 0x1::vector::index_of<0x2::object::ID>(v4, &arg1);
            if (v5) {
                0x1::vector::remove<0x2::object::ID>(v4, v6);
            };
        };
        if (0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg0.offers_by_nft, v3)) {
            let v7 = 0x2::table::borrow_mut<0x2::object::ID, vector<0x2::object::ID>>(&mut arg0.offers_by_nft, v3);
            let (v8, v9) = 0x1::vector::index_of<0x2::object::ID>(v7, &arg1);
            if (v8) {
                0x1::vector::remove<0x2::object::ID>(v7, v9);
            };
        };
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.offers_by_offerer, v1)) {
            let v10 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.offers_by_offerer, v1);
            let (v11, v12) = 0x1::vector::index_of<0x2::object::ID>(v10, &arg1);
            if (v11) {
                0x1::vector::remove<0x2::object::ID>(v10, v12);
            };
        };
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::marketplace_events::emit_offer_expired_cleanup(arg1, v1, v0.amount, v0.expires_at, 0x2::clock::timestamp_ms(arg2));
        0x2::object_bag::remove<0x2::object::ID, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.offer_payments, arg1)
    }

    public(friend) fun create_offer(arg0: &mut OfferRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(v0 > 0, 3);
        let v1 = 0x2::object::id_from_address(0x2::tx_context::fresh_object_address(arg7));
        let v2 = 0x2::clock::timestamp_ms(arg6);
        let v3 = v2 + arg5;
        let v4 = OfferInfo{
            offer_id   : v1,
            listing_id : arg1,
            nft_id     : arg2,
            offerer    : arg3,
            amount     : v0,
            expires_at : v3,
            created_at : v2,
            active     : true,
        };
        0x2::object_bag::add<0x2::object::ID, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.offer_payments, v1, arg4);
        0x2::table::add<0x2::object::ID, OfferInfo>(&mut arg0.offers, v1, v4);
        if (!0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg0.offers_by_listing, arg1)) {
            0x2::table::add<0x2::object::ID, vector<0x2::object::ID>>(&mut arg0.offers_by_listing, arg1, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<0x2::object::ID, vector<0x2::object::ID>>(&mut arg0.offers_by_listing, arg1), v1);
        if (!0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg0.offers_by_nft, arg2)) {
            0x2::table::add<0x2::object::ID, vector<0x2::object::ID>>(&mut arg0.offers_by_nft, arg2, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<0x2::object::ID, vector<0x2::object::ID>>(&mut arg0.offers_by_nft, arg2), v1);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.offers_by_offerer, arg3)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.offers_by_offerer, arg3, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.offers_by_offerer, arg3), v1);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::marketplace_events::emit_offer_made(v1, arg1, arg2, arg3, v0, v3, v2);
        v1
    }

    public fun created_at(arg0: &OfferInfo) : u64 {
        arg0.created_at
    }

    public fun expires_at(arg0: &OfferInfo) : u64 {
        arg0.expires_at
    }

    public fun get_offer(arg0: &OfferRegistry, arg1: 0x2::object::ID) : OfferInfo {
        assert!(0x2::table::contains<0x2::object::ID, OfferInfo>(&arg0.offers, arg1), 0);
        *0x2::table::borrow<0x2::object::ID, OfferInfo>(&arg0.offers, arg1)
    }

    public fun get_offers_for_listing(arg0: &OfferRegistry, arg1: 0x2::object::ID) : vector<0x2::object::ID> {
        if (!0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg0.offers_by_listing, arg1)) {
            return 0x1::vector::empty<0x2::object::ID>()
        };
        *0x2::table::borrow<0x2::object::ID, vector<0x2::object::ID>>(&arg0.offers_by_listing, arg1)
    }

    public fun get_offers_for_nft(arg0: &OfferRegistry, arg1: 0x2::object::ID) : vector<0x2::object::ID> {
        if (!0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg0.offers_by_nft, arg1)) {
            return 0x1::vector::empty<0x2::object::ID>()
        };
        *0x2::table::borrow<0x2::object::ID, vector<0x2::object::ID>>(&arg0.offers_by_nft, arg1)
    }

    public fun is_active(arg0: &OfferInfo) : bool {
        arg0.active
    }

    public fun is_offer_active(arg0: &OfferRegistry, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : bool {
        if (!0x2::table::contains<0x2::object::ID, OfferInfo>(&arg0.offers, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<0x2::object::ID, OfferInfo>(&arg0.offers, arg1);
        v0.active && 0x2::clock::timestamp_ms(arg2) < v0.expires_at
    }

    public fun listing_id(arg0: &OfferInfo) : 0x2::object::ID {
        arg0.listing_id
    }

    public fun nft_id(arg0: &OfferInfo) : 0x2::object::ID {
        arg0.nft_id
    }

    public fun offer_id(arg0: &OfferInfo) : 0x2::object::ID {
        arg0.offer_id
    }

    public fun offerer(arg0: &OfferInfo) : address {
        arg0.offerer
    }

    // decompiled from Move bytecode v6
}

