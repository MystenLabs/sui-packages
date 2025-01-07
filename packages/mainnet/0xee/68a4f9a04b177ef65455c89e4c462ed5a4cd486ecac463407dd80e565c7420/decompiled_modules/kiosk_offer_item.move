module 0xc51203fb802e09f7bdb87e8433ea2fa4a19068164040f5fac284a032ee433e7a::kiosk_offer_item {
    struct OfferData has store, key {
        id: 0x2::object::UID,
        current_id: u64,
    }

    struct OfferItem<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        offerer: address,
        offer_id: u64,
        nft_type: 0x1::string::String,
        price_per_item: u64,
        paids: 0x2::coin::Coin<0x2::sui::SUI>,
        nft_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct OfferEvent has copy, drop, store {
        offer_id: u64,
        nft_type: 0x1::string::String,
        offerer: address,
        price_per_item: u64,
        amount_paid: u64,
    }

    struct CancelOfferEvent has copy, drop, store {
        offer_id: u64,
        nft_type: 0x1::string::String,
        offerer: address,
        price_per_item: u64,
        amount_recived: u64,
    }

    struct AcceptOfferEvent has copy, drop, store {
        offer_id: u64,
        nft_id: 0x2::object::ID,
        nft_type: 0x1::string::String,
        accepter: address,
        accepter_kiosk: 0x2::object::ID,
        price_per_item: u64,
    }

    struct ClaimNFTEvent has copy, drop, store {
        offer_id: u64,
        nft_id: 0x2::object::ID,
        nft_type: 0x1::string::String,
    }

    public entry fun accept_offer_item<T0: store + key>(arg0: &mut 0xc51203fb802e09f7bdb87e8433ea2fa4a19068164040f5fac284a032ee433e7a::kiosk_trade::Market, arg1: &mut OfferData, arg2: u64, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0xc51203fb802e09f7bdb87e8433ea2fa4a19068164040f5fac284a032ee433e7a::utils::get_token_name<T0>();
        let v2 = 0x2::dynamic_object_field::borrow_mut<u64, OfferItem<T0>>(&mut arg1.id, arg2);
        assert!(v1 == v2.nft_type, 2);
        if (0xc51203fb802e09f7bdb87e8433ea2fa4a19068164040f5fac284a032ee433e7a::kiosk_trade::is_listing<T0>(arg0, arg5)) {
            0xc51203fb802e09f7bdb87e8433ea2fa4a19068164040f5fac284a032ee433e7a::kiosk_trade::kiosk_delist<T0>(arg0, arg3, arg5, arg6);
        };
        let (v3, v4) = 0xc51203fb802e09f7bdb87e8433ea2fa4a19068164040f5fac284a032ee433e7a::kiosk_trade::get_market_fee(arg0, v2.price_per_item);
        let v5 = 0x2::coin::split<0x2::sui::SUI>(&mut v2.paids, v2.price_per_item, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v5, v3, arg6), v4);
        0x2::dynamic_object_field::add<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut v2.id, arg5, 0x2::kiosk::list_with_purchase_cap<T0>(arg3, arg4, arg5, 0, arg6));
        v2.nft_id = 0x1::option::some<0x2::object::ID>(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v5, v0);
        let v6 = AcceptOfferEvent{
            offer_id       : arg2,
            nft_id         : arg5,
            nft_type       : v1,
            accepter       : v0,
            accepter_kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg3),
            price_per_item : v2.price_per_item,
        };
        0x2::event::emit<AcceptOfferEvent>(v6);
    }

    public entry fun cancel_offer_item<T0: store + key>(arg0: &mut OfferData, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0xc51203fb802e09f7bdb87e8433ea2fa4a19068164040f5fac284a032ee433e7a::utils::get_token_name<T0>();
        let OfferItem {
            id             : v1,
            offerer        : v2,
            offer_id       : _,
            nft_type       : v4,
            price_per_item : v5,
            paids          : v6,
            nft_id         : v7,
        } = 0x2::dynamic_object_field::remove<u64, OfferItem<T0>>(&mut arg0.id, arg1);
        let v8 = v7;
        let v9 = v6;
        assert!(v0 == v2, 3);
        assert!(0x1::option::is_none<0x2::object::ID>(&v8), 4);
        0x2::pay::join<0x2::sui::SUI>(&mut v9, arg2);
        0x2::pay::keep<0x2::sui::SUI>(v9, arg3);
        0x1::option::destroy_none<0x2::object::ID>(v8);
        0x2::object::delete(v1);
        let v10 = CancelOfferEvent{
            offer_id       : arg1,
            nft_type       : v4,
            offerer        : v0,
            price_per_item : v5,
            amount_recived : 0x2::coin::value<0x2::sui::SUI>(&v9),
        };
        0x2::event::emit<CancelOfferEvent>(v10);
    }

    public entry fun claim_nft<T0: store + key>(arg0: &mut OfferData, arg1: u64, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::object::ID, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc51203fb802e09f7bdb87e8433ea2fa4a19068164040f5fac284a032ee433e7a::utils::get_token_name<T0>();
        let OfferItem {
            id             : v1,
            offerer        : v2,
            offer_id       : v3,
            nft_type       : v4,
            price_per_item : _,
            paids          : v6,
            nft_id         : v7,
        } = 0x2::dynamic_object_field::remove<u64, OfferItem<T0>>(&mut arg0.id, arg1);
        let v8 = v7;
        let v9 = v1;
        assert!(v0 == v4, 2);
        assert!(0x2::tx_context::sender(arg8) == v2, 3);
        0x1::option::extract<0x2::object::ID>(&mut v8);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg2, 0) == 0x2::coin::value<0x2::sui::SUI>(&arg7), 1);
        let (v10, v11) = 0x2::kiosk::purchase_with_cap<T0>(arg3, 0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut v9, arg6), 0x2::coin::zero<0x2::sui::SUI>(arg8));
        let v12 = v11;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg2, &mut v12, arg7);
        0x2::kiosk::lock<T0>(arg4, arg5, arg2, v10);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v12, arg4);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg2, v12);
        0x1::option::destroy_none<0x2::object::ID>(v8);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v6);
        0x2::object::delete(v9);
        let v16 = ClaimNFTEvent{
            offer_id : v3,
            nft_id   : arg6,
            nft_type : v0,
        };
        0x2::event::emit<ClaimNFTEvent>(v16);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OfferData{
            id         : 0x2::object::new(arg0),
            current_id : 0,
        };
        0x2::transfer::public_share_object<OfferData>(v0);
    }

    public entry fun offer_item<T0: store + key>(arg0: &mut OfferData, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0xc51203fb802e09f7bdb87e8433ea2fa4a19068164040f5fac284a032ee433e7a::utils::get_token_name<T0>();
        assert!(arg1 == 0x2::coin::value<0x2::sui::SUI>(&arg2), 1);
        let v2 = arg0.current_id + 1;
        let v3 = OfferItem<T0>{
            id             : 0x2::object::new(arg3),
            offerer        : v0,
            offer_id       : v2,
            nft_type       : v1,
            price_per_item : arg1,
            paids          : arg2,
            nft_id         : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::dynamic_object_field::add<u64, OfferItem<T0>>(&mut arg0.id, v2, v3);
        arg0.current_id = v2;
        let v4 = OfferEvent{
            offer_id       : v2,
            nft_type       : v1,
            offerer        : v0,
            price_per_item : arg1,
            amount_paid    : arg1,
        };
        0x2::event::emit<OfferEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

