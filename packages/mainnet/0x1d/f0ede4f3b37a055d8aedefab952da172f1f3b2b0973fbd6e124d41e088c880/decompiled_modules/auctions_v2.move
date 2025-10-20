module 0x1df0ede4f3b37a055d8aedefab952da172f1f3b2b0973fbd6e124d41e088c880::auctions_v2 {
    struct House has store, key {
        id: 0x2::object::UID,
        kiosk_id: 0x2::object::ID,
        kiosk_owner_cap: 0x2::kiosk::KioskOwnerCap,
    }

    struct Auction has store, key {
        id: 0x2::object::UID,
        creator: address,
        nft_id: 0x2::object::ID,
        nft_type: 0x1::type_name::TypeName,
        minimum_bid: u64,
        highest_bid: u64,
        highest_bidder: address,
        end_time: u64,
        active: bool,
        highest_bidder_deposit: 0x2::balance::Balance<0x2::sui::SUI>,
        participants: vector<address>,
    }

    public fun bid(arg0: &mut Auction, arg1: &mut 0x1df0ede4f3b37a055d8aedefab952da172f1f3b2b0973fbd6e124d41e088c880::user_stats::UserStatsRegistry, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v2 = 0x2::object::id<Auction>(arg0);
        assert!(arg0.active, 2);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.end_time, 2);
        assert!(v0 != arg0.creator, 4);
        assert!(v1 >= arg0.minimum_bid, 1);
        assert!(v1 > arg0.highest_bid, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v1 * 300 / 10000, arg4), @0xe430edc5ebde04571d3a20c5bbe3f0c42543cfab1e7e249e0d89b7630ada0cf6);
        if (arg0.highest_bidder != arg0.creator && 0x2::balance::value<0x2::sui::SUI>(&arg0.highest_bidder_deposit) > 0) {
            0x1df0ede4f3b37a055d8aedefab952da172f1f3b2b0973fbd6e124d41e088c880::user_stats::record_outbid(arg1, arg0.highest_bidder, v2, arg0.highest_bid, v1, arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.highest_bidder_deposit), arg4), arg0.highest_bidder);
        };
        arg0.highest_bid = v1;
        arg0.highest_bidder = v0;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.highest_bidder_deposit, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        if (!0x1::vector::contains<address>(&arg0.participants, &v0)) {
            0x1::vector::push_back<address>(&mut arg0.participants, v0);
        };
        0x1df0ede4f3b37a055d8aedefab952da172f1f3b2b0973fbd6e124d41e088c880::user_stats::record_bid(arg1, v0, v2, v1, arg4);
    }

    public fun cancel<T0: store + key>(arg0: &House, arg1: &mut Auction, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: &mut 0x1df0ede4f3b37a055d8aedefab952da172f1f3b2b0973fbd6e124d41e088c880::dashboard::Dashboard, arg5: &mut 0x1df0ede4f3b37a055d8aedefab952da172f1f3b2b0973fbd6e124d41e088c880::user_stats::UserStatsRegistry, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg1.creator, 0);
        assert!(arg1.highest_bid == 0, 6);
        assert!(arg1.active, 2);
        0x2::kiosk::list<T0>(arg2, &arg0.kiosk_owner_cap, arg1.nft_id, 0);
        let (v0, v1) = 0x2::kiosk::purchase<T0>(arg2, arg1.nft_id, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v1);
        0x2::transfer::public_transfer<T0>(v0, arg1.creator);
        arg1.active = false;
        0x1df0ede4f3b37a055d8aedefab952da172f1f3b2b0973fbd6e124d41e088c880::dashboard::remove_auction(arg4, 0x2::object::id<Auction>(arg1), 0, @0x0, arg6);
    }

    public fun close_auction<T0: store + key>(arg0: &House, arg1: &mut Auction, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: &mut 0x1df0ede4f3b37a055d8aedefab952da172f1f3b2b0973fbd6e124d41e088c880::dashboard::Dashboard, arg5: &mut 0x1df0ede4f3b37a055d8aedefab952da172f1f3b2b0973fbd6e124d41e088c880::user_stats::UserStatsRegistry, arg6: &mut 0x1df0ede4f3b37a055d8aedefab952da172f1f3b2b0973fbd6e124d41e088c880::leaderboard::Leaderboard, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Auction>(arg1);
        assert!(0x2::clock::timestamp_ms(arg7) >= arg1.end_time, 5);
        assert!(arg1.active, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == arg0.kiosk_id, 0);
        let v1 = arg1.highest_bid;
        let v2 = arg1.highest_bidder;
        if (arg1.highest_bid > 0) {
            0x2::kiosk::list<T0>(arg2, &arg0.kiosk_owner_cap, arg1.nft_id, 0);
            let (v3, v4) = 0x2::kiosk::purchase<T0>(arg2, arg1.nft_id, 0x2::coin::zero<0x2::sui::SUI>(arg8));
            let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v4);
            0x2::transfer::public_transfer<T0>(v3, v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.highest_bidder_deposit), arg8), arg1.creator);
            0x1df0ede4f3b37a055d8aedefab952da172f1f3b2b0973fbd6e124d41e088c880::user_stats::record_auction_won(arg5, v2, v0, v1, arg8);
            0x1df0ede4f3b37a055d8aedefab952da172f1f3b2b0973fbd6e124d41e088c880::leaderboard::update_leaderboard(arg6, arg5, v2, arg8);
        } else {
            0x2::kiosk::list<T0>(arg2, &arg0.kiosk_owner_cap, arg1.nft_id, 0);
            let (v8, v9) = 0x2::kiosk::purchase<T0>(arg2, arg1.nft_id, 0x2::coin::zero<0x2::sui::SUI>(arg8));
            let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v9);
            0x2::transfer::public_transfer<T0>(v8, arg1.creator);
        };
        let v13 = 0;
        while (v13 < 0x1::vector::length<address>(&arg1.participants)) {
            let v14 = *0x1::vector::borrow<address>(&arg1.participants, v13);
            if (v14 != v2) {
                0x1df0ede4f3b37a055d8aedefab952da172f1f3b2b0973fbd6e124d41e088c880::user_stats::remove_active_bid(arg5, v14, v0);
            };
            v13 = v13 + 1;
        };
        arg1.active = false;
        0x1df0ede4f3b37a055d8aedefab952da172f1f3b2b0973fbd6e124d41e088c880::dashboard::remove_auction(arg4, v0, v1, v2, arg8);
    }

    public fun create<T0: store + key>(arg0: &House, arg1: &mut 0x1df0ede4f3b37a055d8aedefab952da172f1f3b2b0973fbd6e124d41e088c880::dashboard::Dashboard, arg2: &mut 0x1df0ede4f3b37a055d8aedefab952da172f1f3b2b0973fbd6e124d41e088c880::user_stats::UserStatsRegistry, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &0x2::transfer_policy::TransferPolicy<T0>, arg7: 0x2::object::ID, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg3) == arg0.kiosk_id, 0);
        let v1 = if (0x2::kiosk::is_locked(arg4, arg7)) {
            0x2::kiosk::list<T0>(arg4, arg5, arg7, 0);
            let (v2, v3) = 0x2::kiosk::purchase<T0>(arg4, arg7, 0x2::coin::zero<0x2::sui::SUI>(arg10));
            let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg6, v3);
            v2
        } else {
            0x2::kiosk::take<T0>(arg4, arg5, arg7)
        };
        0x2::kiosk::lock<T0>(arg3, &arg0.kiosk_owner_cap, arg6, v1);
        let v7 = Auction{
            id                     : 0x2::object::new(arg10),
            creator                : v0,
            nft_id                 : arg7,
            nft_type               : 0x1::type_name::get<T0>(),
            minimum_bid            : arg8,
            highest_bid            : 0,
            highest_bidder         : v0,
            end_time               : arg9,
            active                 : true,
            highest_bidder_deposit : 0x2::balance::zero<0x2::sui::SUI>(),
            participants           : 0x1::vector::empty<address>(),
        };
        let v8 = 0x2::object::id<Auction>(&v7);
        0x1df0ede4f3b37a055d8aedefab952da172f1f3b2b0973fbd6e124d41e088c880::dashboard::add_auction(arg1, v8, arg10);
        0x1df0ede4f3b37a055d8aedefab952da172f1f3b2b0973fbd6e124d41e088c880::user_stats::record_auction_created(arg2, v0, v8, arg10);
        0x2::transfer::share_object<Auction>(v7);
        v8
    }

    public fun get_auction_info(arg0: &Auction) : (address, 0x2::object::ID, u64, u64, address, u64, bool) {
        (arg0.creator, arg0.nft_id, arg0.minimum_bid, arg0.highest_bid, arg0.highest_bidder, arg0.end_time, arg0.active)
    }

    public fun get_kiosk_id(arg0: &House) : 0x2::object::ID {
        arg0.kiosk_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        let v2 = v0;
        let v3 = House{
            id              : 0x2::object::new(arg0),
            kiosk_id        : 0x2::object::id<0x2::kiosk::Kiosk>(&v2),
            kiosk_owner_cap : v1,
        };
        0x2::transfer::public_share_object<House>(v3);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    // decompiled from Move bytecode v6
}

