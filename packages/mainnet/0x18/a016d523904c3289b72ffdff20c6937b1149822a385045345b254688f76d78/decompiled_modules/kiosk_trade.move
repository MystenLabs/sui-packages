module 0x18a016d523904c3289b72ffdff20c6937b1149822a385045345b254688f76d78::kiosk_trade {
    struct Market has store, key {
        id: 0x2::object::UID,
        size: u64,
        market_fee: u64,
        fund: address,
    }

    struct KioskListEvent has copy, drop, store {
        nft_id: 0x2::object::ID,
        seller_kiosk: 0x2::object::ID,
        seller_kiosk_cap: 0x2::object::ID,
        transfer_policy: 0x2::object::ID,
        seller: address,
        price: u64,
        nft_type: 0x1::string::String,
    }

    struct KioskDelistEvent has copy, drop, store {
        nft_id: 0x2::object::ID,
        seller_kiosk: 0x2::object::ID,
        seller: address,
        nft_type: 0x1::string::String,
    }

    struct KiosKBuyEvent has copy, drop, store {
        nft_id: 0x2::object::ID,
        seller_kiosk: 0x2::object::ID,
        buyer_kiosk: 0x2::object::ID,
        transfer_policy: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
        nft_type: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Market{
            id         : 0x2::object::new(arg0),
            size       : 0,
            market_fee : 250,
            fund       : @0x8084455a96bdde21edd8fe48ec3f15dbe1c82b2ee2e0e963d800f3d7d8fbbcd5,
        };
        0x2::transfer::public_share_object<Market>(v0);
    }

    public entry fun kiosk_buy_direct<T0: store + key>(arg0: &mut Market, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: u64, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg2, arg6);
        assert!(arg6 + arg6 * arg0.market_fee / 10000 + v0 == 0x2::coin::value<0x2::sui::SUI>(&arg7), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg7, arg0.fund);
        let (v1, v2) = 0x2::kiosk::purchase_with_cap<T0>(arg1, 0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut arg0.id, arg5), 0x2::coin::split<0x2::sui::SUI>(&mut arg7, arg6, arg8));
        let v3 = v2;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg2, &mut v3, 0x2::coin::split<0x2::sui::SUI>(&mut arg7, v0, arg8));
        0x2::kiosk::lock<T0>(arg3, arg4, arg2, v1);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v3, arg3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg2, v3);
        arg0.size = arg0.size - 1;
        let v7 = KiosKBuyEvent{
            nft_id          : arg5,
            seller_kiosk    : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            buyer_kiosk     : 0x2::object::id<0x2::kiosk::Kiosk>(arg3),
            transfer_policy : 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg2),
            seller          : 0x2::kiosk::owner(arg1),
            buyer           : 0x2::tx_context::sender(arg8),
            price           : arg6,
            nft_type        : 0x18a016d523904c3289b72ffdff20c6937b1149822a385045345b254688f76d78::utils::get_token_name<T0>(),
        };
        0x2::event::emit<KiosKBuyEvent>(v7);
    }

    public entry fun kiosk_delist<T0: store + key>(arg0: &mut Market, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::return_purchase_cap<T0>(arg1, 0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut arg0.id, arg2));
        arg0.size = arg0.size - 1;
        let v0 = KioskDelistEvent{
            nft_id       : arg2,
            seller_kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            seller       : 0x2::tx_context::sender(arg3),
            nft_type     : 0x18a016d523904c3289b72ffdff20c6937b1149822a385045345b254688f76d78::utils::get_token_name<T0>(),
        };
        0x2::event::emit<KioskDelistEvent>(v0);
    }

    public entry fun kiosk_list<T0: store + key>(arg0: &mut Market, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: 0x2::object::ID, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_object_field::add<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut arg0.id, arg4, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg4, arg5, arg6));
        arg0.size = arg0.size + 1;
        let v0 = KioskListEvent{
            nft_id           : arg4,
            seller_kiosk     : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            seller_kiosk_cap : 0x2::object::id<0x2::kiosk::KioskOwnerCap>(arg2),
            transfer_policy  : 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg3),
            seller           : 0x2::tx_context::sender(arg6),
            price            : arg5,
            nft_type         : 0x18a016d523904c3289b72ffdff20c6937b1149822a385045345b254688f76d78::utils::get_token_name<T0>(),
        };
        0x2::event::emit<KioskListEvent>(v0);
    }

    public entry fun update_fund_address(arg0: &mut Market, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 1);
        arg0.fund = arg1;
    }

    public entry fun update_market_fee(arg0: &mut Market, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 1);
        arg0.market_fee = arg1;
    }

    // decompiled from Move bytecode v6
}

