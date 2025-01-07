module 0xc51203fb802e09f7bdb87e8433ea2fa4a19068164040f5fac284a032ee433e7a::kiosk_trade {
    struct Market has store, key {
        id: 0x2::object::UID,
        size: u64,
        market_fee: u64,
        fund: address,
    }

    struct ListingItem<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        owner: address,
        price: u64,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
    }

    struct ItemListed has copy, drop, store {
        kiosk: 0x2::object::ID,
        id: 0x2::object::ID,
        price: u64,
        seller_kiosk_cap: 0x2::object::ID,
        transfer_policy: 0x2::object::ID,
        seller: address,
        nft_type: 0x1::string::String,
    }

    struct ItemDelisted has copy, drop, store {
        kiosk: 0x2::object::ID,
        id: 0x2::object::ID,
        seller: address,
        nft_type: 0x1::string::String,
    }

    struct ItemPurchased has copy, drop, store {
        kiosk: 0x2::object::ID,
        id: 0x2::object::ID,
        price: u64,
        buyer_kiosk: 0x2::object::ID,
        transfer_policy: 0x2::object::ID,
        seller: address,
        buyer: address,
        nft_type: 0x1::string::String,
    }

    public fun get_market_fee(arg0: &mut Market, arg1: u64) : (u64, address) {
        (arg1 * arg0.market_fee / 10000, arg0.fund)
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

    public fun is_listing<T0: store + key>(arg0: &mut Market, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, ListingItem<T0>>(&mut arg0.id, arg1)
    }

    public entry fun kiosk_buy_direct<T0: store + key>(arg0: &mut Market, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: u64, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let ListingItem {
            id           : v1,
            owner        : v2,
            price        : v3,
            purchase_cap : v4,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, ListingItem<T0>>(&mut arg0.id, arg5);
        assert!(v0 != v2, 2);
        assert!(arg6 == v3, 0);
        let v5 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg2, arg6);
        assert!(arg6 + arg6 * arg0.market_fee / 10000 + v5 == 0x2::coin::value<0x2::sui::SUI>(&arg7), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg7, arg0.fund);
        let (v6, v7) = 0x2::kiosk::purchase_with_cap<T0>(arg1, v4, 0x2::coin::split<0x2::sui::SUI>(&mut arg7, arg6, arg8));
        let v8 = v7;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg2, &mut v8, 0x2::coin::split<0x2::sui::SUI>(&mut arg7, v5, arg8));
        0x2::kiosk::lock<T0>(arg3, arg4, arg2, v6);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v8, arg3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg2, v8);
        arg0.size = arg0.size - 1;
        0x2::object::delete(v1);
        let v12 = ItemPurchased{
            kiosk           : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            id              : arg5,
            price           : arg6,
            buyer_kiosk     : 0x2::object::id<0x2::kiosk::Kiosk>(arg3),
            transfer_policy : 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg2),
            seller          : 0x2::kiosk::owner(arg1),
            buyer           : v0,
            nft_type        : 0xc51203fb802e09f7bdb87e8433ea2fa4a19068164040f5fac284a032ee433e7a::utils::get_token_name<T0>(),
        };
        0x2::event::emit<ItemPurchased>(v12);
    }

    public entry fun kiosk_delist<T0: store + key>(arg0: &mut Market, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let ListingItem {
            id           : v1,
            owner        : v2,
            price        : _,
            purchase_cap : v4,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, ListingItem<T0>>(&mut arg0.id, arg2);
        assert!(v0 == v2, 1);
        0x2::kiosk::return_purchase_cap<T0>(arg1, v4);
        arg0.size = arg0.size - 1;
        0x2::object::delete(v1);
        let v5 = ItemDelisted{
            kiosk    : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            id       : arg2,
            seller   : v0,
            nft_type : 0xc51203fb802e09f7bdb87e8433ea2fa4a19068164040f5fac284a032ee433e7a::utils::get_token_name<T0>(),
        };
        0x2::event::emit<ItemDelisted>(v5);
    }

    public entry fun kiosk_list<T0: store + key>(arg0: &mut Market, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: 0x2::object::ID, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = ListingItem<T0>{
            id           : 0x2::object::new(arg6),
            owner        : v0,
            price        : arg5,
            purchase_cap : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg4, arg5, arg6),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, ListingItem<T0>>(&mut arg0.id, arg4, v1);
        arg0.size = arg0.size + 1;
        let v2 = ItemListed{
            kiosk            : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            id               : arg4,
            price            : arg5,
            seller_kiosk_cap : 0x2::object::id<0x2::kiosk::KioskOwnerCap>(arg2),
            transfer_policy  : 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg3),
            seller           : v0,
            nft_type         : 0xc51203fb802e09f7bdb87e8433ea2fa4a19068164040f5fac284a032ee433e7a::utils::get_token_name<T0>(),
        };
        0x2::event::emit<ItemListed>(v2);
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

