module 0x97421c9e52f240bdb575c422cd037d355bc25867c74a72cdd477ed2471f1392e::marketplace_usdc_ext {
    struct UsdcExt has drop {
        dummy_field: bool,
    }

    struct BalanceKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ListKey has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct Listing<phantom T0: store + key> has store {
        price: u64,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
    }

    struct ItemListed<phantom T0> has copy, drop {
        kiosk: 0x2::object::ID,
        id: 0x2::object::ID,
        coin: vector<u8>,
        price: u64,
    }

    struct ItemDelisted<phantom T0> has copy, drop {
        kiosk: 0x2::object::ID,
        id: 0x2::object::ID,
    }

    struct ItemPurchased<phantom T0> has copy, drop {
        kiosk: 0x2::object::ID,
        id: 0x2::object::ID,
        coin: vector<u8>,
        price: u64,
        buyer: address,
    }

    public fun balance(arg0: &0x2::kiosk::Kiosk) : u64 {
        let v0 = UsdcExt{dummy_field: false};
        let v1 = BalanceKey{dummy_field: false};
        0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::bag::borrow<BalanceKey, 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::kiosk_extension::storage<UsdcExt>(v0, arg0), v1))
    }

    public fun delist<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg0, arg1), 13906834676854554625);
        assert!(is_ext_installed(arg0), 13906834681149784069);
        let v0 = UsdcExt{dummy_field: false};
        let v1 = ListKey{id: arg2};
        let Listing {
            price        : _,
            purchase_cap : v3,
        } = 0x2::bag::remove<ListKey, Listing<T0>>(0x2::kiosk_extension::storage_mut<UsdcExt>(v0, arg0), v1);
        0x2::kiosk::return_purchase_cap<T0>(arg0, v3);
        let v4 = ItemDelisted<T0>{
            kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            id    : arg2,
        };
        0x2::event::emit<ItemDelisted<T0>>(v4);
    }

    public fun install(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!is_ext_installed(arg0), 13906834492171091971);
        let v0 = UsdcExt{dummy_field: false};
        0x2::kiosk_extension::add<UsdcExt>(v0, arg0, arg1, 0x45f7707bfcb8a6135490324e20abc2b80a326df1f4bc86da2cff5da0d2eb7abe::config::ext_permission(), arg2);
        let v1 = UsdcExt{dummy_field: false};
        let v2 = BalanceKey{dummy_field: false};
        0x2::bag::add<BalanceKey, 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::kiosk_extension::storage_mut<UsdcExt>(v1, arg0), v2, 0x2::coin::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2));
    }

    public fun is_ext_installed(arg0: &0x2::kiosk::Kiosk) : bool {
        0x2::kiosk_extension::is_installed<UsdcExt>(arg0)
    }

    public fun list<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg0, arg1), 13906834565185404929);
        assert!(is_ext_installed(arg0), 13906834569480634373);
        let v0 = UsdcExt{dummy_field: false};
        let v1 = ListKey{id: arg2};
        let v2 = Listing<T0>{
            price        : arg3,
            purchase_cap : 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg2, 0, arg4),
        };
        0x2::bag::add<ListKey, Listing<T0>>(0x2::kiosk_extension::storage_mut<UsdcExt>(v0, arg0), v1, v2);
        let v3 = ItemListed<T0>{
            kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            id    : arg2,
            coin  : 0x45f7707bfcb8a6135490324e20abc2b80a326df1f4bc86da2cff5da0d2eb7abe::config::token_usdc(),
            price : arg3,
        };
        0x2::event::emit<ItemListed<T0>>(v3);
    }

    public fun purchase<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        assert!(is_ext_installed(arg0), 13906834767049129989);
        let v0 = UsdcExt{dummy_field: false};
        let v1 = ListKey{id: arg1};
        assert!(0x2::bag::contains<ListKey>(0x2::kiosk_extension::storage<UsdcExt>(v0, arg0), v1), 13906834788524097543);
        let v2 = UsdcExt{dummy_field: false};
        let v3 = ListKey{id: arg1};
        let Listing {
            price        : v4,
            purchase_cap : v5,
        } = 0x2::bag::remove<ListKey, Listing<T0>>(0x2::kiosk_extension::storage_mut<UsdcExt>(v2, arg0), v3);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg2) == v4, 13906834822883966985);
        let v6 = UsdcExt{dummy_field: false};
        let v7 = BalanceKey{dummy_field: false};
        0x2::coin::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::bag::borrow_mut<BalanceKey, 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::kiosk_extension::storage_mut<UsdcExt>(v6, arg0), v7), arg2);
        let (v8, v9) = 0x2::kiosk::purchase_with_cap<T0>(arg0, v5, 0x2::coin::zero<0x2::sui::SUI>(arg3));
        let v10 = ItemPurchased<T0>{
            kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            id    : arg1,
            coin  : 0x45f7707bfcb8a6135490324e20abc2b80a326df1f4bc86da2cff5da0d2eb7abe::config::token_usdc(),
            price : v4,
            buyer : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ItemPurchased<T0>>(v10);
        (v8, v9)
    }

    public fun withdraw(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        assert!(0x2::kiosk::has_access(arg0, arg1), 13906834947437494273);
        assert!(is_ext_installed(arg0), 13906834951732723717);
        let v0 = UsdcExt{dummy_field: false};
        let v1 = BalanceKey{dummy_field: false};
        let v2 = 0x2::bag::borrow_mut<BalanceKey, 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::kiosk_extension::storage_mut<UsdcExt>(v0, arg0), v1);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v2) >= arg2, 13906834977502920715);
        0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v2, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

