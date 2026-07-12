module 0x8d9001008ac9dc2e17ea4fce78cbde300d14cb857cdb8b8cbc69c60ff8332385::market {
    struct BidBook has key {
        id: 0x2::object::UID,
        bids: 0x2::table::Table<0x2::object::ID, Bid>,
    }

    struct Bid has store, key {
        id: 0x2::object::UID,
        bidder: address,
        item_id: 0x1::option::Option<0x2::object::ID>,
        amount: u64,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
        expires_at_ms: 0x1::option::Option<u64>,
    }

    struct BidPlaced has copy, drop {
        bid_id: 0x2::object::ID,
        bidder: address,
        item_id: 0x1::option::Option<0x2::object::ID>,
        amount: u64,
    }

    struct BidCancelled has copy, drop {
        bid_id: 0x2::object::ID,
        bidder: address,
    }

    struct BidAccepted has copy, drop {
        bid_id: 0x2::object::ID,
        bidder: address,
        seller: address,
        item_id: 0x2::object::ID,
        amount: u64,
    }

    public fun accept_bid(arg0: &mut BidBook, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::transfer_policy::TransferPolicy<0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::Punk>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let Bid {
            id            : v0,
            bidder        : v1,
            item_id       : v2,
            amount        : v3,
            funds         : v4,
            expires_at_ms : v5,
        } = 0x2::table::remove<0x2::object::ID, Bid>(&mut arg0.bids, arg1);
        let v6 = v5;
        let v7 = v2;
        0x2::object::delete(v0);
        assert!(v1 != 0x2::tx_context::sender(arg7), 3);
        if (0x1::option::is_some<u64>(&v6)) {
            assert!(0x2::clock::timestamp_ms(arg6) <= *0x1::option::borrow<u64>(&v6), 4);
        };
        if (0x1::option::is_some<0x2::object::ID>(&v7)) {
            assert!(*0x1::option::borrow<0x2::object::ID>(&v7) == arg4, 5);
        };
        0x2::kiosk::list<0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::Punk>(arg2, arg3, arg4, v3);
        let v8 = 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg7);
        let (v9, v10) = 0x2::kiosk::purchase<0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::Punk>(arg2, arg4, 0x2::coin::split<0x2::sui::SUI>(&mut v8, v3, arg7));
        let v11 = v10;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::Punk>(arg5, &mut v11, v8);
        let (v12, v13) = 0x2::kiosk::new(arg7);
        let v14 = v13;
        let v15 = v12;
        0x2::kiosk::lock<0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::Punk>(&mut v15, &v14, arg5, v9);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::Punk>(&mut v11, &v15);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::Punk>(arg5, v11);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v15);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v14, v1);
        let v19 = BidAccepted{
            bid_id  : arg1,
            bidder  : v1,
            seller  : 0x2::tx_context::sender(arg7),
            item_id : arg4,
            amount  : v3,
        };
        0x2::event::emit<BidAccepted>(v19);
    }

    public entry fun cancel_bid(arg0: &mut BidBook, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let Bid {
            id            : v0,
            bidder        : v1,
            item_id       : _,
            amount        : _,
            funds         : v4,
            expires_at_ms : _,
        } = 0x2::table::remove<0x2::object::ID, Bid>(&mut arg0.bids, arg1);
        assert!(v1 == 0x2::tx_context::sender(arg2), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v4, arg2), v1);
        0x2::object::delete(v0);
        let v6 = BidCancelled{
            bid_id : arg1,
            bidder : v1,
        };
        0x2::event::emit<BidCancelled>(v6);
    }

    public fun escrow_for(arg0: u64) : u64 {
        arg0 + royalty_of(arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BidBook{
            id   : 0x2::object::new(arg0),
            bids : 0x2::table::new<0x2::object::ID, Bid>(arg0),
        };
        0x2::transfer::share_object<BidBook>(v0);
    }

    public fun place_bid(arg0: &mut BidBook, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg2 > 0 && arg2 <= 1000000000000, 0);
        let v0 = escrow_for(arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v0, 1);
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg5));
        };
        let v1 = 0x2::object::new(arg5);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x2::tx_context::sender(arg5);
        let v4 = Bid{
            id            : v1,
            bidder        : v3,
            item_id       : arg1,
            amount        : arg2,
            funds         : 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v0, arg5)),
            expires_at_ms : arg4,
        };
        0x2::table::add<0x2::object::ID, Bid>(&mut arg0.bids, v2, v4);
        let v5 = BidPlaced{
            bid_id  : v2,
            bidder  : v3,
            item_id : arg1,
            amount  : arg2,
        };
        0x2::event::emit<BidPlaced>(v5);
        v2
    }

    public fun royalty_of(arg0: u64) : u64 {
        let v0 = arg0 * 500 / 10000;
        if (v0 > 125000000) {
            v0
        } else {
            125000000
        }
    }

    // decompiled from Move bytecode v7
}

