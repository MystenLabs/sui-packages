module 0xdd36d21d7c85028b8651b1f6d4f94b5367c89ba0ead759f16cad9bcf436a93df::suins_auction {
    struct AuctionData has store {
        domain: 0x1::option::Option<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>,
        seller: address,
        highest_bidder: address,
        current_bid: u64,
        min_bid: u64,
        end_time: u64,
        currency_type: u8,
        ns_balance: 0x1::option::Option<0x2::balance::Balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>>,
        sui_balance: 0x1::option::Option<0x2::balance::Balance<0x2::sui::SUI>>,
        auction_ended: bool,
    }

    struct AuctionRegistry has key {
        id: 0x2::object::UID,
        total_auctions: u64,
        active_auctions: u64,
        admin_address: address,
    }

    struct AuctionCreated has copy, drop {
        auction_id: 0x2::object::ID,
        domain_id: 0x2::object::ID,
        domain_name: 0x1::string::String,
        seller: address,
        start_price: u64,
        end_time: u64,
        expiration_time: u64,
        currency_type: u8,
    }

    struct BidPlaced has copy, drop {
        auction_id: 0x2::object::ID,
        domain_name: 0x1::string::String,
        bidder: address,
        amount: u64,
        currency_type: u8,
    }

    struct AuctionCancelled has copy, drop {
        auction_id: 0x2::object::ID,
        domain_name: 0x1::string::String,
        seller: address,
        currency_type: u8,
        initiated_by: address,
    }

    struct AuctionEnded has copy, drop {
        auction_id: 0x2::object::ID,
        domain_name: 0x1::string::String,
        winner: address,
        final_price: u64,
        currency_type: u8,
        initiated_by: address,
    }

    struct DomainClaimed has copy, drop {
        auction_id: 0x2::object::ID,
        domain_name: 0x1::string::String,
        winner: address,
        currency_type: u8,
        initiated_by: address,
    }

    struct AuctionEndedNoBids has copy, drop {
        auction_id: 0x2::object::ID,
        domain_name: 0x1::string::String,
        seller: address,
        currency_type: u8,
    }

    struct RegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        admin_address: address,
    }

    fun calculate_min_required_bid(arg0: &AuctionData) : u64 {
        if (arg0.highest_bidder == arg0.seller) {
            arg0.min_bid
        } else {
            arg0.current_bid + arg0.current_bid * 5 / 100
        }
    }

    public entry fun cancel_auction(arg0: &mut AuctionRegistry, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, AuctionData>(&mut arg0.id, arg1);
        assert!(v0 == v1.seller || v0 == arg0.admin_address, 8);
        assert!(!v1.auction_ended, 11);
        assert!(v1.highest_bidder == v1.seller, 10);
        assert!(0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&v1.domain), 4);
        let v2 = v1.seller;
        v1.auction_ended = true;
        let v3 = AuctionCancelled{
            auction_id    : arg1,
            domain_name   : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(0x1::option::borrow<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&v1.domain)),
            seller        : v2,
            currency_type : v1.currency_type,
            initiated_by  : v0,
        };
        0x2::event::emit<AuctionCancelled>(v3);
        arg0.active_auctions = arg0.active_auctions - 1;
        let AuctionData {
            domain         : v4,
            seller         : _,
            highest_bidder : _,
            current_bid    : _,
            min_bid        : _,
            end_time       : _,
            currency_type  : _,
            ns_balance     : v11,
            sui_balance    : v12,
            auction_ended  : _,
        } = 0x2::dynamic_field::remove<0x2::object::ID, AuctionData>(&mut arg0.id, arg1);
        0x2::transfer::public_transfer<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(0x1::option::destroy_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(v4), v2);
        destroy_balances(v11, v12);
    }

    public entry fun claim_domain(arg0: &mut AuctionRegistry, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, AuctionData>(&mut arg0.id, arg1);
        assert!(0x2::clock::timestamp_ms(arg2) >= v0.end_time, 2);
        assert!(!v0.auction_ended, 11);
        assert!(0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&v0.domain), 4);
        assert!(0x2::clock::timestamp_ms(arg2) < 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::expiration_timestamp_ms(0x1::option::borrow<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&v0.domain)), 7);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = v0.highest_bidder != v0.seller;
        let v3 = if (v1 == v0.highest_bidder) {
            true
        } else if (v1 == v0.seller) {
            true
        } else {
            v1 == arg0.admin_address
        };
        assert!(v3, 8);
        let v4 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(0x1::option::borrow<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&v0.domain));
        let v5 = v0.seller;
        v0.auction_ended = true;
        if (v2) {
            let v6 = v0.current_bid;
            if (v0.currency_type == 1) {
                let v7 = 0x1::option::borrow_mut<0x2::balance::Balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>>(&mut v0.ns_balance);
                transfer_auction_proceeds<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(v7, v6, v5, arg0.admin_address, 1, arg3);
            } else {
                let v8 = 0x1::option::borrow_mut<0x2::balance::Balance<0x2::sui::SUI>>(&mut v0.sui_balance);
                transfer_auction_proceeds<0x2::sui::SUI>(v8, v6, v5, arg0.admin_address, 0, arg3);
            };
            let v9 = AuctionEnded{
                auction_id    : arg1,
                domain_name   : v4,
                winner        : v0.highest_bidder,
                final_price   : v6,
                currency_type : v0.currency_type,
                initiated_by  : v1,
            };
            0x2::event::emit<AuctionEnded>(v9);
            let v10 = DomainClaimed{
                auction_id    : arg1,
                domain_name   : v4,
                winner        : v0.highest_bidder,
                currency_type : v0.currency_type,
                initiated_by  : v1,
            };
            0x2::event::emit<DomainClaimed>(v10);
        } else {
            let v11 = AuctionEndedNoBids{
                auction_id    : arg1,
                domain_name   : v4,
                seller        : v5,
                currency_type : v0.currency_type,
            };
            0x2::event::emit<AuctionEndedNoBids>(v11);
        };
        arg0.active_auctions = arg0.active_auctions - 1;
        let AuctionData {
            domain         : v12,
            seller         : _,
            highest_bidder : v14,
            current_bid    : _,
            min_bid        : _,
            end_time       : _,
            currency_type  : _,
            ns_balance     : v19,
            sui_balance    : v20,
            auction_ended  : _,
        } = 0x2::dynamic_field::remove<0x2::object::ID, AuctionData>(&mut arg0.id, arg1);
        if (v2) {
            0x2::transfer::public_transfer<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(0x1::option::destroy_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(v12), v14);
        } else {
            0x2::transfer::public_transfer<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(0x1::option::destroy_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(v12), v5);
        };
        destroy_balances(v19, v20);
    }

    public entry fun create_auction(arg0: &mut AuctionRegistry, arg1: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: u64, arg3: u64, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 6);
        assert!(arg3 >= 3600000 && arg3 <= 604800000, 5);
        assert!(arg4 == 0 || arg4 == 1, 8);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::expiration_timestamp_ms(&arg1);
        assert!(v0 < v1, 7);
        assert!(v0 + 2592000000 < v1, 12);
        let v2 = 0x2::tx_context::sender(arg6);
        let v3 = v0 + arg3;
        let v4 = if (arg4 == 1) {
            0x1::option::some<0x2::balance::Balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>>(0x2::balance::zero<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>())
        } else {
            0x1::option::none<0x2::balance::Balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>>()
        };
        let v5 = if (arg4 == 0) {
            0x1::option::some<0x2::balance::Balance<0x2::sui::SUI>>(0x2::balance::zero<0x2::sui::SUI>())
        } else {
            0x1::option::none<0x2::balance::Balance<0x2::sui::SUI>>()
        };
        let v6 = AuctionData{
            domain         : 0x1::option::some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(arg1),
            seller         : v2,
            highest_bidder : v2,
            current_bid    : arg2,
            min_bid        : arg2,
            end_time       : v3,
            currency_type  : arg4,
            ns_balance     : v4,
            sui_balance    : v5,
            auction_ended  : false,
        };
        let v7 = 0x2::object::new(arg6);
        let v8 = 0x2::object::uid_to_inner(&v7);
        0x2::dynamic_field::add<0x2::object::ID, AuctionData>(&mut arg0.id, v8, v6);
        arg0.total_auctions = arg0.total_auctions + 1;
        arg0.active_auctions = arg0.active_auctions + 1;
        let v9 = AuctionCreated{
            auction_id      : v8,
            domain_id       : 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg1),
            domain_name     : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(&arg1),
            seller          : v2,
            start_price     : arg2,
            end_time        : v3,
            expiration_time : v1,
            currency_type   : arg4,
        };
        0x2::event::emit<AuctionCreated>(v9);
        0x2::object::delete(v7);
    }

    fun destroy_balances(arg0: 0x1::option::Option<0x2::balance::Balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>>, arg1: 0x1::option::Option<0x2::balance::Balance<0x2::sui::SUI>>) {
        if (0x1::option::is_some<0x2::balance::Balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>>(&arg0)) {
            0x2::balance::destroy_zero<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(0x1::option::destroy_some<0x2::balance::Balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>>(arg0));
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>>(arg0);
        };
        if (0x1::option::is_some<0x2::balance::Balance<0x2::sui::SUI>>(&arg1)) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(0x1::option::destroy_some<0x2::balance::Balance<0x2::sui::SUI>>(arg1));
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<0x2::sui::SUI>>(arg1);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0x322e3d3e1b9a4a7488dd3a225b225b725cbd0c68caf1547aaf72087b795b6fe6;
        let v1 = AuctionRegistry{
            id              : 0x2::object::new(arg0),
            total_auctions  : 0,
            active_auctions : 0,
            admin_address   : v0,
        };
        let v2 = RegistryCreated{
            registry_id   : 0x2::object::id<AuctionRegistry>(&v1),
            admin_address : v0,
        };
        0x2::event::emit<RegistryCreated>(v2);
        0x2::transfer::share_object<AuctionRegistry>(v1);
    }

    fun place_bid_internal(arg0: &mut AuctionData, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: &0x2::clock::Clock) : (address, u64) {
        assert!(arg2 > 0, 6);
        assert!(0x2::clock::timestamp_ms(arg4) < arg0.end_time, 0);
        assert!(!arg0.auction_ended, 11);
        assert!(arg3 != arg0.seller, 8);
        assert!(arg2 >= calculate_min_required_bid(arg0), 9);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        if (arg0.end_time - v0 < 3600000) {
            arg0.end_time = v0 + 3600000;
        };
        arg0.current_bid = arg2;
        arg0.highest_bidder = arg3;
        let v1 = BidPlaced{
            auction_id    : arg1,
            domain_name   : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(0x1::option::borrow<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.domain)),
            bidder        : arg3,
            amount        : arg2,
            currency_type : arg0.currency_type,
        };
        0x2::event::emit<BidPlaced>(v1);
        (arg0.highest_bidder, arg0.current_bid)
    }

    public entry fun place_bid_ns(arg0: &mut AuctionRegistry, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(arg2);
        let v1 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, AuctionData>(&mut arg0.id, arg1);
        assert!(v1.currency_type == 1, 8);
        let (v2, v3) = place_bid_internal(v1, arg1, v0, 0x2::tx_context::sender(arg4), arg3);
        let v4 = 0x1::option::borrow_mut<0x2::balance::Balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>>(&mut v1.ns_balance);
        0x2::balance::join<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(v4, 0x2::coin::into_balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(0x2::coin::split<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(arg2, v0, arg4)));
        refund_previous_bidder<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(v4, v2, v3, v1.seller, arg4);
    }

    public entry fun place_bid_sui(arg0: &mut AuctionRegistry, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg2);
        let v1 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, AuctionData>(&mut arg0.id, arg1);
        assert!(v1.currency_type == 0, 8);
        let (v2, v3) = place_bid_internal(v1, arg1, v0, 0x2::tx_context::sender(arg4), arg3);
        let v4 = 0x1::option::borrow_mut<0x2::balance::Balance<0x2::sui::SUI>>(&mut v1.sui_balance);
        0x2::balance::join<0x2::sui::SUI>(v4, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, v0, arg4)));
        refund_previous_bidder<0x2::sui::SUI>(v4, v2, v3, v1.seller, arg4);
    }

    fun refund_previous_bidder<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: address, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg1 != arg3 && arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(arg0, arg2, arg4), arg1);
        };
    }

    fun transfer_auction_proceeds<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: address, arg3: address, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4 == 1) {
            0
        } else {
            arg1 / 20
        };
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(arg0, v0, arg5), arg3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(arg0, arg1 - v0, arg5), arg2);
    }

    // decompiled from Move bytecode v6
}

