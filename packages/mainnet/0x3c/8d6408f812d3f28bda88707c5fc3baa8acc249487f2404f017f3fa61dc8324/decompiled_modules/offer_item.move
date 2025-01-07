module 0x3c8d6408f812d3f28bda88707c5fc3baa8acc249487f2404f017f3fa61dc8324::offer_item {
    struct OfferData has store, key {
        id: 0x2::object::UID,
        current_id: u64,
    }

    struct OfferItem has store, key {
        id: 0x2::object::UID,
        offer_id: u64,
        offer_item: 0x2::object::ID,
        offerer: address,
        amount_per_item: u64,
        coins_locked: 0x2::coin::Coin<0x2::sui::SUI>,
        nft_type: 0x1::string::String,
    }

    struct OfferEvent has copy, drop {
        offer_id: u64,
        offer_item: 0x2::object::ID,
        offerer: address,
        amount_per_item: u64,
        nft_type: 0x1::string::String,
    }

    struct CancelOfferEvent has copy, drop {
        offer_id: u64,
        offer_item: 0x2::object::ID,
        offerer: address,
        amount_per_item: u64,
        nft_type: 0x1::string::String,
        amount_recived: u64,
    }

    struct AcceptOfferEvent has copy, drop {
        offer_id: u64,
        offer_item: 0x2::object::ID,
        offerer: address,
        accepter: address,
        nft_type: 0x1::string::String,
        amount_per_item: u64,
        amount_recived: u64,
    }

    public entry fun accept_offer_nft<T0: store + key>(arg0: &mut 0x3c8d6408f812d3f28bda88707c5fc3baa8acc249487f2404f017f3fa61dc8324::marketplace::MarketplaceConfig, arg1: &mut 0x3c8d6408f812d3f28bda88707c5fc3baa8acc249487f2404f017f3fa61dc8324::creator_bluemove_fee::RoyaltyCollection, arg2: &mut 0x3c8d6408f812d3f28bda88707c5fc3baa8acc249487f2404f017f3fa61dc8324::marketplace::CreatorConfig, arg3: &mut OfferData, arg4: u64, arg5: T0, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let OfferItem {
            id              : v1,
            offer_id        : v2,
            offer_item      : v3,
            offerer         : v4,
            amount_per_item : v5,
            coins_locked    : v6,
            nft_type        : v7,
        } = 0x2::dynamic_object_field::remove<u64, OfferItem>(&mut arg3.id, arg4);
        let v8 = v6;
        assert!(v3 == 0x2::object::id<T0>(&arg5), 1);
        assert!(v7 == 0x3c8d6408f812d3f28bda88707c5fc3baa8acc249487f2404f017f3fa61dc8324::utils::get_token_name<T0>(), 1);
        let v9 = if (0x3c8d6408f812d3f28bda88707c5fc3baa8acc249487f2404f017f3fa61dc8324::creator_bluemove_fee::check_exists_royalty_collection<T0>(arg1, arg6)) {
            let (v10, v11, v12, v13) = 0x3c8d6408f812d3f28bda88707c5fc3baa8acc249487f2404f017f3fa61dc8324::creator_bluemove_fee::caculate_royalty_collection<T0>(arg1, v5, &mut v8, arg6);
            assert!(v7 == v13, 1);
            0x3c8d6408f812d3f28bda88707c5fc3baa8acc249487f2404f017f3fa61dc8324::marketplace::add_creator_fee(arg2, v11, v10, arg6);
            v12
        } else {
            0
        };
        let v14 = v5 * 0x3c8d6408f812d3f28bda88707c5fc3baa8acc249487f2404f017f3fa61dc8324::marketplace::get_market_fee(arg0, arg6) / 10000;
        0x3c8d6408f812d3f28bda88707c5fc3baa8acc249487f2404f017f3fa61dc8324::marketplace::add_market_fee(arg0, 0x2::coin::split<0x2::sui::SUI>(&mut v8, v14, arg6), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v8, v0);
        0x2::transfer::public_transfer<T0>(arg5, v4);
        0x2::object::delete(v1);
        let v15 = AcceptOfferEvent{
            offer_id        : v2,
            offer_item      : v3,
            offerer         : v4,
            accepter        : v0,
            nft_type        : v7,
            amount_per_item : v5,
            amount_recived  : v5 - v14 - v9,
        };
        0x2::event::emit<AcceptOfferEvent>(v15);
    }

    public entry fun accept_offer_nft_standard<T0: store + key>(arg0: &mut 0x3c8d6408f812d3f28bda88707c5fc3baa8acc249487f2404f017f3fa61dc8324::marketplace::MarketplaceConfig, arg1: &mut 0x3c8d6408f812d3f28bda88707c5fc3baa8acc249487f2404f017f3fa61dc8324::marketplace::CreatorConfig, arg2: &mut OfferData, arg3: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::BpsRoyaltyStrategy<T0>, arg4: u64, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<T0>, arg6: T0, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let OfferItem {
            id              : v1,
            offer_id        : v2,
            offer_item      : v3,
            offerer         : v4,
            amount_per_item : v5,
            coins_locked    : v6,
            nft_type        : v7,
        } = 0x2::dynamic_object_field::remove<u64, OfferItem>(&mut arg2.id, arg4);
        let v8 = v6;
        assert!(v3 == 0x2::object::id<T0>(&arg6), 1);
        assert!(0x3c8d6408f812d3f28bda88707c5fc3baa8acc249487f2404f017f3fa61dc8324::utils::get_token_name<T0>() == v7, 3);
        let v9 = 0x2::vec_set::into_keys<address>(*0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::get_Creators(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::borrow_domain<T0, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(arg5)));
        let v10 = v5 * 0x3c8d6408f812d3f28bda88707c5fc3baa8acc249487f2404f017f3fa61dc8324::marketplace::get_market_fee(arg0, arg7) / 10000;
        let v11 = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::calculate<T0>(arg3, v5);
        let v12 = if (0x1::vector::length<address>(&v9) > 0) {
            v5 - v10 - v11
        } else {
            v5 - v10
        };
        0x3c8d6408f812d3f28bda88707c5fc3baa8acc249487f2404f017f3fa61dc8324::marketplace::add_market_fee(arg0, 0x2::coin::split<0x2::sui::SUI>(&mut v8, v10, arg7), arg7);
        if (0x1::vector::length<address>(&v9) > 0 && 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::has_domain<T0, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(arg5) && v11 > 0) {
            let v13 = 0x1::vector::length<address>(&v9);
            let v14 = 0;
            let v15 = 0x2::coin::split<0x2::sui::SUI>(&mut v8, v11, arg7);
            while (v14 < v13) {
                0x3c8d6408f812d3f28bda88707c5fc3baa8acc249487f2404f017f3fa61dc8324::marketplace::add_creator_fee(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut v15, v11 / v13, arg7), 0x1::vector::pop_back<address>(&mut v9), arg7);
                v14 = v14 + 1;
            };
            0x2::coin::join<0x2::sui::SUI>(&mut v8, v15);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v8, v0);
        0x2::transfer::public_transfer<T0>(arg6, v4);
        0x2::object::delete(v1);
        let v16 = AcceptOfferEvent{
            offer_id        : v2,
            offer_item      : v3,
            offerer         : v4,
            accepter        : v0,
            nft_type        : v7,
            amount_per_item : v5,
            amount_recived  : v12,
        };
        0x2::event::emit<AcceptOfferEvent>(v16);
    }

    public entry fun cancel_offer_nft<T0>(arg0: &mut OfferData, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let OfferItem {
            id              : v1,
            offer_id        : v2,
            offer_item      : v3,
            offerer         : v4,
            amount_per_item : v5,
            coins_locked    : v6,
            nft_type        : v7,
        } = 0x2::dynamic_object_field::remove<u64, OfferItem>(&mut arg0.id, arg2);
        assert!(v0 == v4, 1);
        assert!(v3 == arg1, 1);
        assert!(v7 == 0x3c8d6408f812d3f28bda88707c5fc3baa8acc249487f2404f017f3fa61dc8324::utils::get_token_name<T0>(), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v6, v0);
        0x2::object::delete(v1);
        let v8 = CancelOfferEvent{
            offer_id        : v2,
            offer_item      : v3,
            offerer         : v4,
            amount_per_item : v5,
            nft_type        : v7,
            amount_recived  : v5,
        };
        0x2::event::emit<CancelOfferEvent>(v8);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OfferData{
            id         : 0x2::object::new(arg0),
            current_id : 0,
        };
        0x2::transfer::public_share_object<OfferData>(v0);
    }

    public entry fun offer_nft<T0>(arg0: &mut OfferData, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg2 == 0x2::coin::value<0x2::sui::SUI>(&arg3), 4);
        let v1 = 0x3c8d6408f812d3f28bda88707c5fc3baa8acc249487f2404f017f3fa61dc8324::utils::get_token_name<T0>();
        let v2 = OfferItem{
            id              : 0x2::object::new(arg4),
            offer_id        : arg0.current_id + 1,
            offer_item      : arg1,
            offerer         : v0,
            amount_per_item : arg2,
            coins_locked    : arg3,
            nft_type        : v1,
        };
        0x2::dynamic_object_field::add<u64, OfferItem>(&mut arg0.id, arg0.current_id + 1, v2);
        arg0.current_id = arg0.current_id + 1;
        let v3 = OfferEvent{
            offer_id        : arg0.current_id,
            offer_item      : arg1,
            offerer         : v0,
            amount_per_item : arg2,
            nft_type        : v1,
        };
        0x2::event::emit<OfferEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

