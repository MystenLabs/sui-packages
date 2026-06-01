module 0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::marketplace {
    struct MarketplaceCap has key {
        id: 0x2::object::UID,
    }

    struct Offer has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        name_cap_id: 0x2::object::ID,
        bidder: address,
        payment: 0x2::coin::Coin<0x2::sui::SUI>,
        expiry: u64,
    }

    struct NameListed has copy, drop {
        name: 0x1::string::String,
        name_cap_id: 0x2::object::ID,
        seller: address,
        price: u64,
    }

    struct NameSold has copy, drop {
        name: 0x1::string::String,
        name_cap_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
        fee: u64,
    }

    struct NameDelisted has copy, drop {
        name: 0x1::string::String,
        name_cap_id: 0x2::object::ID,
        seller: address,
    }

    struct OfferPlaced has copy, drop {
        name: 0x1::string::String,
        name_cap_id: 0x2::object::ID,
        bidder: address,
        amount: u64,
    }

    struct OfferAccepted has copy, drop {
        name: 0x1::string::String,
        name_cap_id: 0x2::object::ID,
        seller: address,
        bidder: address,
        amount: u64,
        fee: u64,
    }

    struct OfferCancelled has copy, drop {
        name: 0x1::string::String,
        name_cap_id: 0x2::object::ID,
        bidder: address,
    }

    public fun accept_offer(arg0: Offer, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::transfer_policy::TransferPolicy<0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::NameCap>, arg4: &mut 0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::Registry, arg5: &mut 0x2::tx_context::TxContext) {
        let Offer {
            id          : v0,
            name        : v1,
            name_cap_id : v2,
            bidder      : v3,
            payment     : v4,
            expiry      : _,
        } = arg0;
        let v6 = v4;
        0x2::object::delete(v0);
        let v7 = 0x2::tx_context::sender(arg5);
        assert!(v7 != v3, 100);
        assert!(0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::owner_of(arg4, v1) == v7, 103);
        0x2::kiosk::delist<0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::NameCap>(arg1, arg2, v2);
        let v8 = 0x2::kiosk::take<0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::NameCap>(arg1, arg2, v2);
        assert!(0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::name_of(&v8) == v1, 106);
        let v9 = 0x2::coin::value<0x2::sui::SUI>(&v6);
        let v10 = ((((v9 as u128) * (0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::royalty_rule::fee_bps(arg3) as u128) + 9999) / 10000) as u64);
        0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::royalty_rule::deposit(arg3, 0x2::coin::split<0x2::sui::SUI>(&mut v6, v10, arg5));
        if (0x2::coin::value<0x2::sui::SUI>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v6, v7);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v6);
        };
        let v11 = OfferAccepted{
            name        : v1,
            name_cap_id : v2,
            seller      : v7,
            bidder      : v3,
            amount      : v9,
            fee         : v10,
        };
        0x2::event::emit<OfferAccepted>(v11);
        0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::transfer_name(arg4, v8, v3, arg5);
    }

    public fun buy_name(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::NameCap>, arg2: &mut 0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::Registry, arg3: 0x2::object::ID, arg4: u64, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::kiosk::owner(arg0);
        assert!(v0 != v1, 100);
        let v2 = ((((arg4 as u128) * (0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::royalty_rule::fee_bps(arg1) as u128) + 9999) / 10000) as u64);
        let v3 = arg4 + v2;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= v3, 101);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg5) - v3;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg5, v4, arg6), v0);
        };
        let (v5, v6) = 0x2::kiosk::purchase<0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::NameCap>(arg0, arg3, 0x2::coin::split<0x2::sui::SUI>(&mut arg5, arg4, arg6));
        let v7 = v6;
        let v8 = v5;
        let v9 = 0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::name_of(&v8);
        assert!(0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::owner_of(arg2, v9) == v1, 103);
        0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::royalty_rule::pay(arg1, &mut v7, &mut arg5, arg6);
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg5);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::NameCap>(arg1, v7);
        let v13 = NameSold{
            name        : v9,
            name_cap_id : arg3,
            seller      : v1,
            buyer       : v0,
            price       : arg4,
            fee         : v2,
        };
        0x2::event::emit<NameSold>(v13);
        0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::transfer_name(arg2, v8, v0, arg6);
    }

    public fun cancel_offer(arg0: Offer, arg1: &mut 0x2::tx_context::TxContext) {
        let Offer {
            id          : v0,
            name        : v1,
            name_cap_id : v2,
            bidder      : v3,
            payment     : v4,
            expiry      : _,
        } = arg0;
        0x2::object::delete(v0);
        assert!(0x2::tx_context::sender(arg1) == v3, 105);
        let v6 = OfferCancelled{
            name        : v1,
            name_cap_id : v2,
            bidder      : v3,
        };
        0x2::event::emit<OfferCancelled>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v3);
    }

    public fun delist_name(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::kiosk::delist<0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::NameCap>(arg0, arg1, arg2);
        let v1 = 0x2::kiosk::take<0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::NameCap>(arg0, arg1, arg2);
        let v2 = NameDelisted{
            name        : 0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::name_of(&v1),
            name_cap_id : arg2,
            seller      : v0,
        };
        0x2::event::emit<NameDelisted>(v2);
        0x2::transfer::public_transfer<0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::NameCap>(v1, v0);
    }

    public fun fee_bps(arg0: &0x2::transfer_policy::TransferPolicy<0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::NameCap>) : u64 {
        0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::royalty_rule::fee_bps(arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketplaceCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MarketplaceCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun init_policy(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::NameCap>(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::royalty_rule::add(&mut v3, &v2, 100);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::NameCap>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::NameCap>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun list_name(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::Registry, arg3: 0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::NameCap, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 102);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::id<0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::NameCap>(&arg3);
        let v2 = 0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::name_of(&arg3);
        assert!(0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::owner_of(arg2, v2) == v0, 103);
        0x2::kiosk::place<0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::NameCap>(arg0, arg1, arg3);
        0x2::kiosk::list<0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::NameCap>(arg0, arg1, v1, arg4);
        let v3 = NameListed{
            name        : v2,
            name_cap_id : v1,
            seller      : v0,
            price       : arg4,
        };
        0x2::event::emit<NameListed>(v3);
    }

    public fun place_offer(arg0: &0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::Registry, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::is_available(arg0, arg2), 107);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(v1 > 0, 102);
        let v2 = Offer{
            id          : 0x2::object::new(arg5),
            name        : arg2,
            name_cap_id : arg1,
            bidder      : v0,
            payment     : arg4,
            expiry      : arg3,
        };
        let v3 = OfferPlaced{
            name        : v2.name,
            name_cap_id : arg1,
            bidder      : v0,
            amount      : v1,
        };
        0x2::event::emit<OfferPlaced>(v3);
        0x2::transfer::share_object<Offer>(v2);
    }

    public fun reclaim_expired_offer(arg0: Offer, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let Offer {
            id          : v0,
            name        : v1,
            name_cap_id : v2,
            bidder      : v3,
            payment     : v4,
            expiry      : v5,
        } = arg0;
        0x2::object::delete(v0);
        assert!(v5 > 0 && 0x2::clock::timestamp_ms(arg1) >= v5, 108);
        let v6 = OfferCancelled{
            name        : v1,
            name_cap_id : v2,
            bidder      : v3,
        };
        0x2::event::emit<OfferCancelled>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v3);
    }

    public fun transfer_marketplace_cap(arg0: MarketplaceCap, arg1: address) {
        0x2::transfer::transfer<MarketplaceCap>(arg0, arg1);
    }

    public fun update_policy_fee(arg0: &MarketplaceCap, arg1: &mut 0x2::transfer_policy::TransferPolicy<0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::NameCap>, arg2: &0x2::transfer_policy::TransferPolicyCap<0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::NameCap>, arg3: u64) {
        assert!(arg3 <= 1000, 104);
        0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::royalty_rule::update_fee(arg1, arg2, arg3);
    }

    public fun withdraw_royalties(arg0: &mut 0x2::transfer_policy::TransferPolicy<0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::NameCap>, arg1: &0x2::transfer_policy::TransferPolicyCap<0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::NameCap>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::transfer_policy::withdraw<0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::walrus_names::NameCap>(arg0, arg1, 0x1::option::none<u64>(), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

