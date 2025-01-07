module 0x716d1a16a0906669e8d91e1e4acc4fd48f4c97e2ed7d66703736bbb4e2b5d2c0::marketplace {
    struct MARKETPLACE has drop {
        dummy_field: bool,
    }

    struct KoiMarketplace has store, key {
        id: 0x2::object::UID,
        caps: 0x2::bag::Bag,
        profits: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct KoiListing<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        amount: u64,
        fee: u64,
        owner: address,
        cap: 0x2::kiosk::PurchaseCap<T0>,
    }

    struct KoiMarketplaceOwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct ProfitsWithdrawedMarketplace has copy, drop {
        amount: u64,
        owner: address,
        marketplace_id: 0x2::object::ID,
    }

    struct ItemListed<phantom T0> has copy, drop {
        kiosk_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        price: u64,
        seller: address,
    }

    struct ItemDelisted<phantom T0> has copy, drop {
        kiosk_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        seller: address,
    }

    struct ItemPurchased<phantom T0> has copy, drop {
        kiosk_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        buyer: address,
        price: u64,
    }

    struct ProfitsWithdrawedKiosk has copy, drop {
        kiosk_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct MarketplaceCreated has copy, drop {
        marketplace_id: 0x2::object::ID,
        owner: address,
    }

    fun calculate_fee(arg0: u64) : (u64, u64) {
        let v0 = 20000000 * arg0 / 100000000000;
        (v0, arg0 - v0)
    }

    public entry fun delist<T0: store + key>(arg0: &mut KoiMarketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == 0x2::bag::borrow<0x2::object::ID, KoiListing<T0>>(&arg0.caps, arg3).owner, 0);
        let KoiListing {
            id     : v0,
            amount : _,
            fee    : _,
            owner  : _,
            cap    : v4,
        } = 0x2::bag::remove<0x2::object::ID, KoiListing<T0>>(&mut arg0.caps, arg3);
        0x2::kiosk::return_purchase_cap<T0>(arg1, v4);
        0x2::object::delete(v0);
        let v5 = ItemDelisted<T0>{
            kiosk_id : 0x2::object::uid_to_inner(0x2::kiosk::uid(arg1)),
            item_id  : arg3,
            seller   : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<ItemDelisted<T0>>(v5);
        0x2::transfer::public_transfer<T0>(0x2::kiosk::take<T0>(arg1, arg2, arg3), 0x2::tx_context::sender(arg4));
    }

    fun init(arg0: MARKETPLACE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = KoiMarketplace{
            id      : 0x2::object::new(arg1),
            caps    : 0x2::bag::new(arg1),
            profits : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v1 = KoiMarketplaceOwnerCap{id: 0x2::object::new(arg1)};
        let v2 = MarketplaceCreated{
            marketplace_id : 0x2::object::id<KoiMarketplace>(&v0),
            owner          : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<MarketplaceCreated>(v2);
        0x2::transfer::public_share_object<KoiMarketplace>(v0);
        0x2::transfer::public_transfer<KoiMarketplaceOwnerCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<MARKETPLACE>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun list<T0: store + key>(arg0: &mut KoiMarketplace, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = calculate_fee(arg2);
        let (v2, v3) = 0x2::kiosk::new(arg3);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::object::id<T0>(&arg1);
        0x2::kiosk::place<T0>(&mut v5, &v4, arg1);
        let v7 = 0x2::kiosk::list_with_purchase_cap<T0>(&mut v5, &v4, v6, v1, arg3);
        let v8 = 0x2::tx_context::sender(arg3);
        list_purchase_cap<T0>(arg0, v6, v7, v1, v0, v8, arg3);
        let v9 = ItemListed<T0>{
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(&v5),
            item_id  : v6,
            price    : arg2,
            seller   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ItemListed<T0>>(v9);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v5);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v4, 0x2::tx_context::sender(arg3));
    }

    fun list_purchase_cap<T0: store + key>(arg0: &mut KoiMarketplace, arg1: 0x2::object::ID, arg2: 0x2::kiosk::PurchaseCap<T0>, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = KoiListing<T0>{
            id     : 0x2::object::new(arg6),
            amount : arg3,
            fee    : arg4,
            owner  : arg5,
            cap    : arg2,
        };
        0x2::bag::add<0x2::object::ID, KoiListing<T0>>(&mut arg0.caps, arg1, v0);
    }

    public entry fun purchase<T0: store + key>(arg0: &mut KoiMarketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::transfer_policy::TransferPolicy<T0>, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = calculate_fee(0x2::coin::value<0x2::sui::SUI>(&arg4));
        let v2 = 0x2::coin::split<0x2::sui::SUI>(&mut arg4, v0, arg5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v2) == 0x2::bag::borrow<0x2::object::ID, KoiListing<T0>>(&arg0.caps, arg3).fee, 0);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.profits, v2);
        let KoiListing {
            id     : v3,
            amount : _,
            fee    : _,
            owner  : _,
            cap    : v7,
        } = 0x2::bag::remove<0x2::object::ID, KoiListing<T0>>(&mut arg0.caps, arg3);
        let (v8, v9) = 0x2::kiosk::purchase_with_cap<T0>(arg1, v7, arg4);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg2, v9);
        let v13 = ItemPurchased<T0>{
            kiosk_id : 0x2::object::uid_to_inner(0x2::kiosk::uid(arg1)),
            item_id  : arg3,
            buyer    : 0x2::tx_context::sender(arg5),
            price    : v1,
        };
        0x2::event::emit<ItemPurchased<T0>>(v13);
        0x2::object::delete(v3);
        0x2::transfer::public_transfer<T0>(v8, 0x2::tx_context::sender(arg5));
    }

    public entry fun withdraw_profits_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ProfitsWithdrawedKiosk{
            kiosk_id : 0x2::object::uid_to_inner(0x2::kiosk::uid(arg0)),
            owner    : 0x2::tx_context::sender(arg2),
            amount   : 0x2::kiosk::profits_amount(arg0),
        };
        0x2::event::emit<ProfitsWithdrawedKiosk>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::kiosk::withdraw(arg0, arg1, 0x1::option::none<u64>(), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_profits_marketplace(arg0: &KoiMarketplaceOwnerCap, arg1: &mut KoiMarketplace, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.profits);
        let v1 = ProfitsWithdrawedMarketplace{
            amount         : v0,
            owner          : 0x2::tx_context::sender(arg2),
            marketplace_id : 0x2::object::id<KoiMarketplace>(arg1),
        };
        0x2::event::emit<ProfitsWithdrawedMarketplace>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.profits, v0, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

