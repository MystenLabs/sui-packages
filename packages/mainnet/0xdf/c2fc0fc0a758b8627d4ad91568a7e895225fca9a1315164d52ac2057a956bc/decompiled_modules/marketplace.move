module 0xdfc2fc0fc0a758b8627d4ad91568a7e895225fca9a1315164d52ac2057a956bc::marketplace {
    struct MarketplaceCap has key {
        id: 0x2::object::UID,
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

