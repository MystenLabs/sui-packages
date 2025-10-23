module 0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction {
    struct Auction<phantom T0: store + key, phantom T1> has store, key {
        id: 0x2::object::UID,
        item_id: 0x2::object::ID,
        creator: address,
        creator_kiosk_id: 0x2::object::ID,
        highest_bidder: 0x1::option::Option<address>,
        highest_bid: 0x2::balance::Balance<T1>,
        expiry_time: u64,
        is_active: bool,
        title: 0x1::string::String,
    }

    struct AuctionCreated has copy, drop {
        auction_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        creator: address,
        expiry_time: u64,
        title: 0x1::string::String,
    }

    struct BidPlaced has copy, drop {
        auction_id: 0x2::object::ID,
        bidder: address,
        bid_amount: u64,
        previous_bidder: 0x1::option::Option<address>,
    }

    struct AuctionFinalized has copy, drop {
        auction_id: 0x2::object::ID,
        winner: 0x1::option::Option<address>,
        final_bid: u64,
        creator_received: u64,
        fee_collected: u64,
    }

    public fun create_auction<T0: store + key, T1>(arg0: &0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::AuctionHouse, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: T0, arg4: u64, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : Auction<T0, T1> {
        let v0 = 0x2::object::id<T0>(&arg3);
        0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::deposit_item<T0>(arg0, arg1, arg3);
        let v1 = 0x2::object::new(arg7);
        let v2 = AuctionCreated{
            auction_id  : 0x2::object::uid_to_inner(&v1),
            item_id     : v0,
            creator     : 0x2::tx_context::sender(arg7),
            expiry_time : arg4,
            title       : arg5,
        };
        0x2::event::emit<AuctionCreated>(v2);
        Auction<T0, T1>{
            id               : v1,
            item_id          : v0,
            creator          : 0x2::tx_context::sender(arg7),
            creator_kiosk_id : arg2,
            highest_bidder   : 0x1::option::none<address>(),
            highest_bid      : 0x2::balance::zero<T1>(),
            expiry_time      : arg4,
            is_active        : true,
            title            : arg5,
        }
    }

    public entry fun create_auction_from_kiosk<T0: store + key, T1>(arg0: &0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::AuctionHouse, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::kiosk::Kiosk, arg4: 0x2::object::ID, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = create_auction<T0, T1>(arg0, arg3, 0x2::object::id<0x2::kiosk::Kiosk>(arg1), 0x2::kiosk::take<T0>(arg1, &arg2, arg4), arg5, 0x1::string::utf8(arg6), arg7, arg8);
        0x2::transfer::public_share_object<Auction<T0, T1>>(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(arg2, 0x2::tx_context::sender(arg8));
    }

    public entry fun create_auction_from_kiosk_with_lock<T0: store + key, T1>(arg0: &0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::AuctionHouse, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x2::kiosk::is_locked(arg1, arg5)) {
            0x2::kiosk::list<T0>(arg1, &arg2, arg5, 0);
            let (v1, v2) = 0x2::kiosk::purchase<T0>(arg1, arg5, 0x2::coin::zero<0x2::sui::SUI>(arg9));
            let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v2);
            v1
        } else {
            0x2::kiosk::take<T0>(arg1, &arg2, arg5)
        };
        let v6 = create_auction_with_lock<T0, T1>(arg0, arg3, 0x2::object::id<0x2::kiosk::Kiosk>(arg1), arg4, v0, arg6, 0x1::string::utf8(arg7), arg8, arg9);
        0x2::transfer::public_share_object<Auction<T0, T1>>(v6);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(arg2, 0x2::tx_context::sender(arg9));
    }

    public fun create_auction_with_lock<T0: store + key, T1>(arg0: &0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::AuctionHouse, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: T0, arg5: u64, arg6: 0x1::string::String, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : Auction<T0, T1> {
        let v0 = 0x2::object::id<T0>(&arg4);
        0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::deposit_item_with_lock<T0>(arg0, arg1, arg3, arg4);
        let v1 = 0x2::object::new(arg8);
        let v2 = AuctionCreated{
            auction_id  : 0x2::object::uid_to_inner(&v1),
            item_id     : v0,
            creator     : 0x2::tx_context::sender(arg8),
            expiry_time : arg5,
            title       : arg6,
        };
        0x2::event::emit<AuctionCreated>(v2);
        Auction<T0, T1>{
            id               : v1,
            item_id          : v0,
            creator          : 0x2::tx_context::sender(arg8),
            creator_kiosk_id : arg2,
            highest_bidder   : 0x1::option::none<address>(),
            highest_bid      : 0x2::balance::zero<T1>(),
            expiry_time      : arg5,
            is_active        : true,
            title            : arg6,
        }
    }

    public entry fun finalize_and_create_kiosk<T0: store + key, T1>(arg0: &mut 0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::AuctionHouse, arg1: &mut 0x2::kiosk::Kiosk, arg2: Auction<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) >= arg2.expiry_time, 1);
        let Auction {
            id               : v0,
            item_id          : v1,
            creator          : v2,
            creator_kiosk_id : _,
            highest_bidder   : v4,
            highest_bid      : v5,
            expiry_time      : _,
            is_active        : _,
            title            : _,
        } = arg2;
        let v9 = v5;
        let v10 = v4;
        let v11 = v0;
        let v12 = 0x2::balance::value<T1>(&v9);
        if (0x1::option::is_some<address>(&v10)) {
            let v13 = *0x1::option::borrow<address>(&v10);
            let v14 = 0x2::coin::from_balance<T1>(v9, arg4);
            0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::get_fee_from_payment<T1>(arg0, &mut v14, arg4);
            let v15 = 0x2::coin::value<T1>(&v14);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v14, v2);
            let (v16, v17) = 0x2::kiosk::new(arg4);
            let v18 = v17;
            let v19 = v16;
            0x2::kiosk::place<T0>(&mut v19, &v18, 0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::withdraw_item<T0>(arg0, arg1, v1));
            0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v19);
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v18, v13);
            let v20 = AuctionFinalized{
                auction_id       : 0x2::object::uid_to_inner(&v11),
                winner           : 0x1::option::some<address>(v13),
                final_bid        : v12,
                creator_received : v15,
                fee_collected    : v12 - v15,
            };
            0x2::event::emit<AuctionFinalized>(v20);
        } else {
            0x2::balance::destroy_zero<T1>(v9);
            0x2::transfer::public_transfer<T0>(0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::withdraw_item<T0>(arg0, arg1, v1), v2);
            let v21 = AuctionFinalized{
                auction_id       : 0x2::object::uid_to_inner(&v11),
                winner           : 0x1::option::none<address>(),
                final_bid        : 0,
                creator_received : 0,
                fee_collected    : 0,
            };
            0x2::event::emit<AuctionFinalized>(v21);
        };
        0x2::object::delete(v11);
    }

    public entry fun finalize_and_create_kiosk_with_lock<T0: store + key, T1>(arg0: &mut 0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::AuctionHouse, arg1: &mut 0x2::kiosk::Kiosk, arg2: Auction<T0, T1>, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) >= arg2.expiry_time, 1);
        let Auction {
            id               : v0,
            item_id          : v1,
            creator          : v2,
            creator_kiosk_id : _,
            highest_bidder   : v4,
            highest_bid      : v5,
            expiry_time      : _,
            is_active        : _,
            title            : _,
        } = arg2;
        let v9 = v5;
        let v10 = v4;
        let v11 = v0;
        let v12 = 0x2::balance::value<T1>(&v9);
        if (0x1::option::is_some<address>(&v10)) {
            let v13 = *0x1::option::borrow<address>(&v10);
            let v14 = 0x2::coin::from_balance<T1>(v9, arg5);
            0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::get_fee_from_payment<T1>(arg0, &mut v14, arg5);
            let v15 = 0x2::coin::value<T1>(&v14);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v14, v2);
            let (v16, v17) = 0x2::kiosk::new(arg5);
            let v18 = v17;
            let v19 = v16;
            let (v20, v21) = 0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::withdraw_item_with_lock<T0>(arg0, arg1, v1, arg5);
            let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v21);
            0x2::kiosk::lock<T0>(&mut v19, &v18, arg3, v20);
            0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v19);
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v18, v13);
            let v25 = AuctionFinalized{
                auction_id       : 0x2::object::uid_to_inner(&v11),
                winner           : 0x1::option::some<address>(v13),
                final_bid        : v12,
                creator_received : v15,
                fee_collected    : v12 - v15,
            };
            0x2::event::emit<AuctionFinalized>(v25);
        } else {
            0x2::balance::destroy_zero<T1>(v9);
            let (v26, v27) = 0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::withdraw_item_with_lock<T0>(arg0, arg1, v1, arg5);
            let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v27);
            0x2::transfer::public_transfer<T0>(v26, v2);
            let v31 = AuctionFinalized{
                auction_id       : 0x2::object::uid_to_inner(&v11),
                winner           : 0x1::option::none<address>(),
                final_bid        : 0,
                creator_received : 0,
                fee_collected    : 0,
            };
            0x2::event::emit<AuctionFinalized>(v31);
        };
        0x2::object::delete(v11);
    }

    public fun finalize_auction<T0: store + key, T1>(arg0: &mut 0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::AuctionHouse, arg1: &mut 0x2::kiosk::Kiosk, arg2: Auction<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        finalize_to_wallet<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun finalize_auction_with_lock<T0: store + key, T1>(arg0: &mut 0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::AuctionHouse, arg1: &mut 0x2::kiosk::Kiosk, arg2: Auction<T0, T1>, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        finalize_to_wallet_with_lock<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun finalize_to_kiosk<T0: store + key, T1>(arg0: &mut 0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::AuctionHouse, arg1: &mut 0x2::kiosk::Kiosk, arg2: Auction<T0, T1>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) >= arg2.expiry_time, 1);
        let Auction {
            id               : v0,
            item_id          : v1,
            creator          : v2,
            creator_kiosk_id : v3,
            highest_bidder   : v4,
            highest_bid      : v5,
            expiry_time      : _,
            is_active        : _,
            title            : _,
        } = arg2;
        let v9 = v5;
        let v10 = v4;
        let v11 = v0;
        let v12 = 0x2::balance::value<T1>(&v9);
        if (0x1::option::is_some<address>(&v10)) {
            let v13 = *0x1::option::borrow<address>(&v10);
            assert!(0x2::kiosk::owner(arg3) == v13, 1001);
            let v14 = 0x2::coin::from_balance<T1>(v9, arg6);
            0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::get_fee_from_payment<T1>(arg0, &mut v14, arg6);
            let v15 = 0x2::coin::value<T1>(&v14);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v14, v2);
            0x2::kiosk::place<T0>(arg3, arg4, 0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::withdraw_item<T0>(arg0, arg1, v1));
            let v16 = AuctionFinalized{
                auction_id       : 0x2::object::uid_to_inner(&v11),
                winner           : 0x1::option::some<address>(v13),
                final_bid        : v12,
                creator_received : v15,
                fee_collected    : v12 - v15,
            };
            0x2::event::emit<AuctionFinalized>(v16);
        } else {
            0x2::balance::destroy_zero<T1>(v9);
            assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg3) == v3, 1002);
            assert!(0x2::kiosk::owner(arg3) == v2, 1001);
            0x2::kiosk::place<T0>(arg3, arg4, 0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::withdraw_item<T0>(arg0, arg1, v1));
            let v17 = AuctionFinalized{
                auction_id       : 0x2::object::uid_to_inner(&v11),
                winner           : 0x1::option::none<address>(),
                final_bid        : 0,
                creator_received : 0,
                fee_collected    : 0,
            };
            0x2::event::emit<AuctionFinalized>(v17);
        };
        0x2::object::delete(v11);
    }

    public entry fun finalize_to_kiosk_with_lock<T0: store + key, T1>(arg0: &mut 0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::AuctionHouse, arg1: &mut 0x2::kiosk::Kiosk, arg2: Auction<T0, T1>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg6) >= arg2.expiry_time, 1);
        let Auction {
            id               : v0,
            item_id          : v1,
            creator          : v2,
            creator_kiosk_id : v3,
            highest_bidder   : v4,
            highest_bid      : v5,
            expiry_time      : _,
            is_active        : _,
            title            : _,
        } = arg2;
        let v9 = v5;
        let v10 = v4;
        let v11 = v0;
        let v12 = 0x2::balance::value<T1>(&v9);
        if (0x1::option::is_some<address>(&v10)) {
            let v13 = *0x1::option::borrow<address>(&v10);
            assert!(0x2::kiosk::owner(arg3) == v13, 1001);
            let v14 = 0x2::coin::from_balance<T1>(v9, arg7);
            0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::get_fee_from_payment<T1>(arg0, &mut v14, arg7);
            let v15 = 0x2::coin::value<T1>(&v14);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v14, v2);
            let (v16, v17) = 0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::withdraw_item_with_lock<T0>(arg0, arg1, v1, arg7);
            let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg5, v17);
            0x2::kiosk::lock<T0>(arg3, arg4, arg5, v16);
            let v21 = AuctionFinalized{
                auction_id       : 0x2::object::uid_to_inner(&v11),
                winner           : 0x1::option::some<address>(v13),
                final_bid        : v12,
                creator_received : v15,
                fee_collected    : v12 - v15,
            };
            0x2::event::emit<AuctionFinalized>(v21);
        } else {
            0x2::balance::destroy_zero<T1>(v9);
            assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg3) == v3, 1002);
            assert!(0x2::kiosk::owner(arg3) == v2, 1001);
            let (v22, v23) = 0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::withdraw_item_with_lock<T0>(arg0, arg1, v1, arg7);
            let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg5, v23);
            0x2::kiosk::lock<T0>(arg3, arg4, arg5, v22);
            let v27 = AuctionFinalized{
                auction_id       : 0x2::object::uid_to_inner(&v11),
                winner           : 0x1::option::none<address>(),
                final_bid        : 0,
                creator_received : 0,
                fee_collected    : 0,
            };
            0x2::event::emit<AuctionFinalized>(v27);
        };
        0x2::object::delete(v11);
    }

    public entry fun finalize_to_wallet<T0: store + key, T1>(arg0: &mut 0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::AuctionHouse, arg1: &mut 0x2::kiosk::Kiosk, arg2: Auction<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) >= arg2.expiry_time, 1);
        let Auction {
            id               : v0,
            item_id          : v1,
            creator          : v2,
            creator_kiosk_id : _,
            highest_bidder   : v4,
            highest_bid      : v5,
            expiry_time      : _,
            is_active        : _,
            title            : _,
        } = arg2;
        let v9 = v5;
        let v10 = v4;
        let v11 = v0;
        let v12 = 0x2::balance::value<T1>(&v9);
        if (0x1::option::is_some<address>(&v10)) {
            let v13 = *0x1::option::borrow<address>(&v10);
            let v14 = 0x2::coin::from_balance<T1>(v9, arg4);
            0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::get_fee_from_payment<T1>(arg0, &mut v14, arg4);
            let v15 = 0x2::coin::value<T1>(&v14);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v14, v2);
            0x2::transfer::public_transfer<T0>(0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::withdraw_item<T0>(arg0, arg1, v1), v13);
            let v16 = AuctionFinalized{
                auction_id       : 0x2::object::uid_to_inner(&v11),
                winner           : 0x1::option::some<address>(v13),
                final_bid        : v12,
                creator_received : v15,
                fee_collected    : v12 - v15,
            };
            0x2::event::emit<AuctionFinalized>(v16);
        } else {
            0x2::balance::destroy_zero<T1>(v9);
            0x2::transfer::public_transfer<T0>(0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::withdraw_item<T0>(arg0, arg1, v1), v2);
            let v17 = AuctionFinalized{
                auction_id       : 0x2::object::uid_to_inner(&v11),
                winner           : 0x1::option::none<address>(),
                final_bid        : 0,
                creator_received : 0,
                fee_collected    : 0,
            };
            0x2::event::emit<AuctionFinalized>(v17);
        };
        0x2::object::delete(v11);
    }

    public entry fun finalize_to_wallet_with_lock<T0: store + key, T1>(arg0: &mut 0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::AuctionHouse, arg1: &mut 0x2::kiosk::Kiosk, arg2: Auction<T0, T1>, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) >= arg2.expiry_time, 1);
        let Auction {
            id               : v0,
            item_id          : v1,
            creator          : v2,
            creator_kiosk_id : _,
            highest_bidder   : v4,
            highest_bid      : v5,
            expiry_time      : _,
            is_active        : _,
            title            : _,
        } = arg2;
        let v9 = v5;
        let v10 = v4;
        let v11 = v0;
        let v12 = 0x2::balance::value<T1>(&v9);
        if (0x1::option::is_some<address>(&v10)) {
            let v13 = *0x1::option::borrow<address>(&v10);
            let v14 = 0x2::coin::from_balance<T1>(v9, arg5);
            0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::get_fee_from_payment<T1>(arg0, &mut v14, arg5);
            let v15 = 0x2::coin::value<T1>(&v14);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v14, v2);
            let (v16, v17) = 0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::withdraw_item_with_lock<T0>(arg0, arg1, v1, arg5);
            let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v17);
            0x2::transfer::public_transfer<T0>(v16, v13);
            let v21 = AuctionFinalized{
                auction_id       : 0x2::object::uid_to_inner(&v11),
                winner           : 0x1::option::some<address>(v13),
                final_bid        : v12,
                creator_received : v15,
                fee_collected    : v12 - v15,
            };
            0x2::event::emit<AuctionFinalized>(v21);
        } else {
            0x2::balance::destroy_zero<T1>(v9);
            let (v22, v23) = 0x64270bf23b9c3c6e3f43fe7d25415868c1b60bf990d9993842382aff685f13ce::auction_house::withdraw_item_with_lock<T0>(arg0, arg1, v1, arg5);
            let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v23);
            0x2::transfer::public_transfer<T0>(v22, v2);
            let v27 = AuctionFinalized{
                auction_id       : 0x2::object::uid_to_inner(&v11),
                winner           : 0x1::option::none<address>(),
                final_bid        : 0,
                creator_received : 0,
                fee_collected    : 0,
            };
            0x2::event::emit<AuctionFinalized>(v27);
        };
        0x2::object::delete(v11);
    }

    public fun get_creator<T0: store + key, T1>(arg0: &Auction<T0, T1>) : address {
        arg0.creator
    }

    public fun get_expiry_time<T0: store + key, T1>(arg0: &Auction<T0, T1>) : u64 {
        arg0.expiry_time
    }

    public fun get_highest_bid<T0: store + key, T1>(arg0: &Auction<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.highest_bid)
    }

    public fun get_highest_bidder<T0: store + key, T1>(arg0: &Auction<T0, T1>) : 0x1::option::Option<address> {
        arg0.highest_bidder
    }

    public fun get_item_id<T0: store + key, T1>(arg0: &Auction<T0, T1>) : 0x2::object::ID {
        arg0.item_id
    }

    public fun is_active<T0: store + key, T1>(arg0: &Auction<T0, T1>) : bool {
        arg0.is_active
    }

    public fun place_bid<T0: store + key, T1>(arg0: &mut Auction<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 2);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.expiry_time, 2);
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0x2::balance::value<T1>(&arg0.highest_bid), 3);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = arg0.highest_bidder;
        if (0x1::option::is_some<address>(&v2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.highest_bid), arg3), *0x1::option::borrow<address>(&v2));
        };
        0x2::balance::join<T1>(&mut arg0.highest_bid, 0x2::coin::into_balance<T1>(arg1));
        arg0.highest_bidder = 0x1::option::some<address>(v1);
        let v3 = BidPlaced{
            auction_id      : 0x2::object::uid_to_inner(&arg0.id),
            bidder          : v1,
            bid_amount      : v0,
            previous_bidder : v2,
        };
        0x2::event::emit<BidPlaced>(v3);
    }

    // decompiled from Move bytecode v6
}

