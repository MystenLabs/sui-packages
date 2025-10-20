module 0xb3657ac859878d072cce1d1085ce3eea0d363d832ec304e8745a97d7075ae41b::auction {
    struct Auction<phantom T0: store + key, phantom T1> has store, key {
        id: 0x2::object::UID,
        item_id: 0x2::object::ID,
        creator: address,
        highest_bidder: 0x1::option::Option<address>,
        highest_bid: 0x2::balance::Balance<T1>,
        expiry_time: u64,
        is_active: bool,
    }

    struct AuctionCreated has copy, drop {
        auction_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        creator: address,
        expiry_time: u64,
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

    public fun create_auction<T0: store + key, T1>(arg0: &0xb3657ac859878d072cce1d1085ce3eea0d363d832ec304e8745a97d7075ae41b::auction_house::AuctionHouse, arg1: &mut 0x2::kiosk::Kiosk, arg2: T0, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Auction<T0, T1> {
        let v0 = 0x2::object::id<T0>(&arg2);
        0xb3657ac859878d072cce1d1085ce3eea0d363d832ec304e8745a97d7075ae41b::auction_house::deposit_item<T0>(arg0, arg1, arg2);
        let v1 = 0x2::object::new(arg5);
        let v2 = AuctionCreated{
            auction_id  : 0x2::object::uid_to_inner(&v1),
            item_id     : v0,
            creator     : 0x2::tx_context::sender(arg5),
            expiry_time : arg3,
        };
        0x2::event::emit<AuctionCreated>(v2);
        Auction<T0, T1>{
            id             : v1,
            item_id        : v0,
            creator        : 0x2::tx_context::sender(arg5),
            highest_bidder : 0x1::option::none<address>(),
            highest_bid    : 0x2::balance::zero<T1>(),
            expiry_time    : arg3,
            is_active      : true,
        }
    }

    public entry fun create_auction_from_kiosk<T0: store + key, T1>(arg0: &0xb3657ac859878d072cce1d1085ce3eea0d363d832ec304e8745a97d7075ae41b::auction_house::AuctionHouse, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::kiosk::Kiosk, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<Auction<T0, T1>>(create_auction<T0, T1>(arg0, arg3, 0x2::kiosk::take<T0>(arg1, arg2, arg4), arg5, arg6, arg7));
    }

    public entry fun create_auction_from_kiosk_with_lock<T0: store + key, T1>(arg0: &0xb3657ac859878d072cce1d1085ce3eea0d363d832ec304e8745a97d7075ae41b::auction_house::AuctionHouse, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::list<T0>(arg1, arg2, arg5, 0);
        let (v0, v1) = 0x2::kiosk::purchase<T0>(arg1, arg5, 0x2::coin::zero<0x2::sui::SUI>(arg8));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v1);
        0x2::transfer::public_share_object<Auction<T0, T1>>(create_auction_with_lock<T0, T1>(arg0, arg3, arg4, v0, arg6, arg7, arg8));
    }

    public fun create_auction_with_lock<T0: store + key, T1>(arg0: &0xb3657ac859878d072cce1d1085ce3eea0d363d832ec304e8745a97d7075ae41b::auction_house::AuctionHouse, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::transfer_policy::TransferPolicy<T0>, arg3: T0, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Auction<T0, T1> {
        let v0 = 0x2::object::id<T0>(&arg3);
        0xb3657ac859878d072cce1d1085ce3eea0d363d832ec304e8745a97d7075ae41b::auction_house::deposit_item_with_lock<T0>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::new(arg6);
        let v2 = AuctionCreated{
            auction_id  : 0x2::object::uid_to_inner(&v1),
            item_id     : v0,
            creator     : 0x2::tx_context::sender(arg6),
            expiry_time : arg4,
        };
        0x2::event::emit<AuctionCreated>(v2);
        Auction<T0, T1>{
            id             : v1,
            item_id        : v0,
            creator        : 0x2::tx_context::sender(arg6),
            highest_bidder : 0x1::option::none<address>(),
            highest_bid    : 0x2::balance::zero<T1>(),
            expiry_time    : arg4,
            is_active      : true,
        }
    }

    public fun finalize_auction<T0: store + key, T1>(arg0: &mut 0xb3657ac859878d072cce1d1085ce3eea0d363d832ec304e8745a97d7075ae41b::auction_house::AuctionHouse, arg1: &mut 0x2::kiosk::Kiosk, arg2: Auction<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) >= arg2.expiry_time, 1);
        let Auction {
            id             : v0,
            item_id        : v1,
            creator        : v2,
            highest_bidder : v3,
            highest_bid    : v4,
            expiry_time    : _,
            is_active      : _,
        } = arg2;
        let v7 = v4;
        let v8 = v3;
        let v9 = v0;
        let v10 = 0x2::balance::value<T1>(&v7);
        if (0x1::option::is_some<address>(&v8)) {
            let v11 = *0x1::option::borrow<address>(&v8);
            let v12 = 0x2::coin::from_balance<T1>(v7, arg4);
            0xb3657ac859878d072cce1d1085ce3eea0d363d832ec304e8745a97d7075ae41b::auction_house::get_fee_from_payment<T1>(arg0, &mut v12, arg4);
            let v13 = 0x2::coin::value<T1>(&v12);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, v2);
            0x2::transfer::public_transfer<T0>(0xb3657ac859878d072cce1d1085ce3eea0d363d832ec304e8745a97d7075ae41b::auction_house::withdraw_item<T0>(arg0, arg1, v1), v11);
            let v14 = AuctionFinalized{
                auction_id       : 0x2::object::uid_to_inner(&v9),
                winner           : 0x1::option::some<address>(v11),
                final_bid        : v10,
                creator_received : v13,
                fee_collected    : v10 - v13,
            };
            0x2::event::emit<AuctionFinalized>(v14);
        } else {
            0x2::balance::destroy_zero<T1>(v7);
            0x2::transfer::public_transfer<T0>(0xb3657ac859878d072cce1d1085ce3eea0d363d832ec304e8745a97d7075ae41b::auction_house::withdraw_item<T0>(arg0, arg1, v1), v2);
            let v15 = AuctionFinalized{
                auction_id       : 0x2::object::uid_to_inner(&v9),
                winner           : 0x1::option::none<address>(),
                final_bid        : 0,
                creator_received : 0,
                fee_collected    : 0,
            };
            0x2::event::emit<AuctionFinalized>(v15);
        };
        0x2::object::delete(v9);
    }

    public fun finalize_auction_with_lock<T0: store + key, T1>(arg0: &mut 0xb3657ac859878d072cce1d1085ce3eea0d363d832ec304e8745a97d7075ae41b::auction_house::AuctionHouse, arg1: &mut 0x2::kiosk::Kiosk, arg2: Auction<T0, T1>, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) >= arg2.expiry_time, 1);
        let Auction {
            id             : v0,
            item_id        : v1,
            creator        : v2,
            highest_bidder : v3,
            highest_bid    : v4,
            expiry_time    : _,
            is_active      : _,
        } = arg2;
        let v7 = v4;
        let v8 = v3;
        let v9 = v0;
        let v10 = 0x2::balance::value<T1>(&v7);
        if (0x1::option::is_some<address>(&v8)) {
            let v11 = *0x1::option::borrow<address>(&v8);
            let v12 = 0x2::coin::from_balance<T1>(v7, arg5);
            0xb3657ac859878d072cce1d1085ce3eea0d363d832ec304e8745a97d7075ae41b::auction_house::get_fee_from_payment<T1>(arg0, &mut v12, arg5);
            let v13 = 0x2::coin::value<T1>(&v12);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, v2);
            let (v14, v15) = 0xb3657ac859878d072cce1d1085ce3eea0d363d832ec304e8745a97d7075ae41b::auction_house::withdraw_item_with_lock<T0>(arg0, arg1, v1, arg5);
            let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v15);
            0x2::transfer::public_transfer<T0>(v14, v11);
            let v19 = AuctionFinalized{
                auction_id       : 0x2::object::uid_to_inner(&v9),
                winner           : 0x1::option::some<address>(v11),
                final_bid        : v10,
                creator_received : v13,
                fee_collected    : v10 - v13,
            };
            0x2::event::emit<AuctionFinalized>(v19);
        } else {
            0x2::balance::destroy_zero<T1>(v7);
            let (v20, v21) = 0xb3657ac859878d072cce1d1085ce3eea0d363d832ec304e8745a97d7075ae41b::auction_house::withdraw_item_with_lock<T0>(arg0, arg1, v1, arg5);
            let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v21);
            0x2::transfer::public_transfer<T0>(v20, v2);
            let v25 = AuctionFinalized{
                auction_id       : 0x2::object::uid_to_inner(&v9),
                winner           : 0x1::option::none<address>(),
                final_bid        : 0,
                creator_received : 0,
                fee_collected    : 0,
            };
            0x2::event::emit<AuctionFinalized>(v25);
        };
        0x2::object::delete(v9);
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

