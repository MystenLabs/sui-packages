module 0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::auctions {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Auction has store, key {
        id: 0x2::object::UID,
        creator: address,
        creator_kiosk_id: 0x2::object::ID,
        minimum_bid: u64,
        highest_bid: u64,
        highest_bidder: address,
        highest_bidder_deposit: 0x2::balance::Balance<0x2::sui::SUI>,
        participants: vector<address>,
        active: bool,
        nft_type: 0x1::string::String,
        nft_id: 0x2::object::ID,
        item_type: 0x1::type_name::TypeName,
        transfer_policy_id: 0x2::object::ID,
        end_time: u64,
    }

    public fun auto_close_auction<T0: store + key>(arg0: &mut Auction, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: &mut 0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::dashboard::Dashboard, arg4: &mut 0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::user_stats::UserStatsRegistry, arg5: &mut 0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::leaderboard::Leaderboard, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Auction>(arg0);
        assert!(0x2::clock::timestamp_ms(arg6) >= arg0.end_time, 5);
        assert!(arg0.active, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == arg0.creator_kiosk_id, 8);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg2) == arg0.transfer_policy_id, 3);
        let v1 = arg0.highest_bid;
        let v2 = arg0.highest_bidder;
        if (arg0.highest_bid > 0) {
            let (v3, v4) = 0x2::kiosk::purchase_with_cap<T0>(arg1, 0x2::dynamic_object_field::remove<0x1::type_name::TypeName, 0x2::kiosk::PurchaseCap<T0>>(&mut arg0.id, arg0.item_type), 0x2::coin::zero<0x2::sui::SUI>(arg7));
            let (v5, v6) = 0x2::kiosk::new(arg7);
            let v7 = v6;
            let v8 = v5;
            0x2::kiosk::lock<T0>(&mut v8, &v7, arg2, v3);
            let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg2, v4);
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v7, arg0.highest_bidder);
            0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v8);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.highest_bidder_deposit), arg7), arg0.creator);
            0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::user_stats::record_auction_won(arg4, arg0.highest_bidder, v0, v1, arg7);
            0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::leaderboard::update_leaderboard(arg5, arg4, arg0.highest_bidder, arg7);
        };
        let v12 = 0;
        while (v12 < 0x1::vector::length<address>(&arg0.participants)) {
            let v13 = *0x1::vector::borrow<address>(&arg0.participants, v12);
            if (v13 != v2) {
                0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::user_stats::remove_active_bid(arg4, v13, v0);
            };
            v12 = v12 + 1;
        };
        arg0.active = false;
        0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::dashboard::remove_auction(arg3, v0, v1, v2, arg7);
    }

    public fun bid(arg0: &mut Auction, arg1: &mut 0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::user_stats::UserStatsRegistry, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
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
            0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::user_stats::record_outbid(arg1, arg0.highest_bidder, v2, arg0.highest_bid, v1, arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.highest_bidder_deposit), arg4), arg0.highest_bidder);
        };
        0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::user_stats::record_bid(arg1, v0, v2, v1, arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.highest_bidder_deposit, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg0.highest_bid = v1;
        arg0.highest_bidder = v0;
        if (!0x1::vector::contains<address>(&arg0.participants, &v0)) {
            0x1::vector::push_back<address>(&mut arg0.participants, v0);
        };
    }

    public fun cancel_auction<T0: store + key>(arg0: &mut Auction, arg1: &mut 0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::dashboard::Dashboard, arg2: &mut 0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::user_stats::UserStatsRegistry, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::kiosk::PurchaseCap<T0> {
        assert!(0x2::tx_context::sender(arg4) == arg0.creator, 3);
        assert!(arg0.highest_bid == 0, 6);
        assert!(arg0.active, 2);
        arg0.active = false;
        0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::dashboard::remove_auction(arg1, 0x2::object::id<Auction>(arg0), 0, arg0.creator, arg4);
        0x2::dynamic_object_field::remove<0x1::type_name::TypeName, 0x2::kiosk::PurchaseCap<T0>>(&mut arg0.id, arg0.item_type)
    }

    public fun close_auction<T0: store + key>(arg0: &AdminCap, arg1: &mut Auction, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: &mut 0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::dashboard::Dashboard, arg5: &mut 0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::user_stats::UserStatsRegistry, arg6: &mut 0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::leaderboard::Leaderboard, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Auction>(arg1);
        assert!(0x2::clock::timestamp_ms(arg7) >= arg1.end_time, 5);
        assert!(arg1.active, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == arg1.creator_kiosk_id, 8);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg3) == arg1.transfer_policy_id, 3);
        let v1 = arg1.highest_bid;
        let v2 = arg1.highest_bidder;
        if (arg1.highest_bid > 0) {
            let (v3, v4) = 0x2::kiosk::purchase_with_cap<T0>(arg2, 0x2::dynamic_object_field::remove<0x1::type_name::TypeName, 0x2::kiosk::PurchaseCap<T0>>(&mut arg1.id, arg1.item_type), 0x2::coin::zero<0x2::sui::SUI>(arg8));
            let (v5, v6) = 0x2::kiosk::new(arg8);
            let v7 = v6;
            let v8 = v5;
            0x2::kiosk::lock<T0>(&mut v8, &v7, arg3, v3);
            let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v4);
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v7, arg1.highest_bidder);
            0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v8);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.highest_bidder_deposit), arg8), arg1.creator);
            0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::user_stats::record_auction_won(arg5, arg1.highest_bidder, v0, v1, arg8);
            0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::leaderboard::update_leaderboard(arg6, arg5, arg1.highest_bidder, arg8);
        };
        let v12 = 0;
        while (v12 < 0x1::vector::length<address>(&arg1.participants)) {
            let v13 = *0x1::vector::borrow<address>(&arg1.participants, v12);
            if (v13 != v2) {
                0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::user_stats::remove_active_bid(arg5, v13, v0);
            };
            v12 = v12 + 1;
        };
        arg1.active = false;
        0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::dashboard::remove_auction(arg4, v0, v1, v2, arg8);
    }

    public fun close_auction_no_policy<T0: store + key>(arg0: &AdminCap, arg1: &mut Auction, arg2: T0, arg3: &mut 0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::dashboard::Dashboard, arg4: &mut 0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::user_stats::UserStatsRegistry, arg5: &mut 0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::leaderboard::Leaderboard, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Auction>(arg1);
        assert!(0x2::clock::timestamp_ms(arg6) >= arg1.end_time, 5);
        assert!(arg1.active, 2);
        assert!(0x2::object::id<T0>(&arg2) == arg1.nft_id, 8);
        let v1 = arg1.highest_bid;
        let v2 = arg1.highest_bidder;
        if (arg1.highest_bid > 0) {
            0x2::transfer::public_transfer<T0>(arg2, arg1.highest_bidder);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.highest_bidder_deposit), arg7), arg1.creator);
            0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::user_stats::record_auction_won(arg4, arg1.highest_bidder, v0, v1, arg7);
            0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::leaderboard::update_leaderboard(arg5, arg4, arg1.highest_bidder, arg7);
        } else {
            0x2::transfer::public_transfer<T0>(arg2, arg1.creator);
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg1.participants)) {
            let v4 = *0x1::vector::borrow<address>(&arg1.participants, v3);
            if (v4 != v2) {
                0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::user_stats::remove_active_bid(arg4, v4, v0);
            };
            v3 = v3 + 1;
        };
        arg1.active = false;
        0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::dashboard::remove_auction(arg3, v0, v1, v2, arg7);
    }

    public fun create<T0: store + key>(arg0: &mut 0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::dashboard::Dashboard, arg1: &mut 0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::user_stats::UserStatsRegistry, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0x2::kiosk::has_access(arg2, arg3), 8);
        let v1 = 0x1::type_name::with_original_ids<T0>();
        let v2 = Auction{
            id                     : 0x2::object::new(arg8),
            creator                : v0,
            creator_kiosk_id       : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            minimum_bid            : arg6,
            highest_bid            : 0,
            highest_bidder         : v0,
            highest_bidder_deposit : 0x2::balance::zero<0x2::sui::SUI>(),
            participants           : 0x1::vector::empty<address>(),
            active                 : true,
            nft_type               : 0x1::string::from_ascii(0x1::type_name::into_string(v1)),
            nft_id                 : arg5,
            item_type              : v1,
            transfer_policy_id     : 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg4),
            end_time               : arg7,
        };
        0x2::dynamic_object_field::add<0x1::type_name::TypeName, 0x2::kiosk::PurchaseCap<T0>>(&mut v2.id, v1, 0x2::kiosk::list_with_purchase_cap<T0>(arg2, arg3, arg5, 0, arg8));
        let v3 = 0x2::object::id<Auction>(&v2);
        0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::dashboard::add_auction(arg0, v3, arg8);
        0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::user_stats::record_auction_created(arg1, v0, v3, arg8);
        0x2::transfer::share_object<Auction>(v2);
        v3
    }

    public fun creator(arg0: &Auction) : address {
        arg0.creator
    }

    public fun end_time(arg0: &Auction) : u64 {
        arg0.end_time
    }

    public fun get_id(arg0: &Auction) : 0x2::object::ID {
        0x2::object::id<Auction>(arg0)
    }

    public fun get_participants(arg0: &Auction) : &vector<address> {
        &arg0.participants
    }

    public fun has_ended(arg0: &Auction, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.end_time
    }

    public fun highest_bid(arg0: &Auction) : u64 {
        arg0.highest_bid
    }

    public fun highest_bidder(arg0: &Auction) : address {
        arg0.highest_bidder
    }

    public fun info(arg0: &Auction) : (address, u64, u64, address, bool, u64, 0x1::string::String) {
        (arg0.creator, arg0.minimum_bid, arg0.highest_bid, arg0.highest_bidder, arg0.active, arg0.end_time, arg0.nft_type)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_participant(arg0: &Auction, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.participants, &arg1)
    }

    public fun nft_type(arg0: &Auction) : 0x1::string::String {
        arg0.nft_type
    }

    public fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

