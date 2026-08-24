module 0x16a5fd66e73c2069dd9673615f77506480116c83aabdf4d427a9f85e40ad01cc::ripstation_marketplace {
    struct RIPSTATION_MARKETPLACE has drop {
        dummy_field: bool,
    }

    struct Store has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        fee_bps: u64,
        beneficiary: address,
        sponsor_price: u64,
        max_sponsored_listings: u64,
    }

    struct SimpleListing<phantom T0> has store, key {
        id: 0x2::object::UID,
        type: u64,
        nft_id: 0x2::object::ID,
        price: u64,
        seller: address,
        maybe_seller_kiosk_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct SimpleSponsoredCollection<phantom T0> has store, key {
        id: 0x2::object::UID,
        listings: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
    }

    struct MultiBid has store, key {
        id: 0x2::object::UID,
        buyer: address,
        maybe_name: 0x1::option::Option<0x1::ascii::String>,
        bids: vector<0x2::object::ID>,
        balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
    }

    struct SingleBid has store, key {
        id: 0x2::object::UID,
        type: u64,
        buyer: address,
        maybe_multi_bid_id: 0x1::option::Option<0x2::object::ID>,
        nft_type: 0x1::ascii::String,
        maybe_nft_id: 0x1::option::Option<0x2::object::ID>,
        maybe_nft_bcs: 0x1::option::Option<vector<u8>>,
        attribute_names: vector<0x1::ascii::String>,
        attribute_values: vector<0x1::ascii::String>,
        maybe_expire_at: 0x1::option::Option<u64>,
        price: u64,
        royalty: u64,
        fee: u64,
        balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
    }

    struct CreateSimpleListingEvent has copy, drop {
        type: u64,
        nft_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        price: u64,
        seller: address,
        maybe_seller_kiosk_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct CancelSimpleListingEvent has copy, drop {
        type: u64,
        nft_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        price: u64,
        seller: address,
        maybe_seller_kiosk_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct RelistSimpleListingEvent has copy, drop {
        type: u64,
        nft_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        new_price: u64,
        seller: address,
        maybe_seller_kiosk_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct BuySimpleListingEvent has copy, drop {
        type: u64,
        nft_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        price: u64,
        royalty: u64,
        fee: u64,
        seller: address,
        buyer: address,
        maybe_seller_kiosk_id: 0x1::option::Option<0x2::object::ID>,
        maybe_buyer_kiosk_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct AddSponsoredListingEvent has copy, drop {
        nft_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        nft_type: 0x1::ascii::String,
        period: u64,
        seller: address,
        expire_at: u64,
    }

    struct CreateMultiBidEvent has copy, drop {
        multi_bid_id: 0x2::object::ID,
        buyer: address,
        maybe_name: 0x1::option::Option<0x1::ascii::String>,
        coin_type: 0x1::ascii::String,
        balance: u64,
    }

    struct UpdateMultiBidEvent has copy, drop {
        multi_bid_id: 0x2::object::ID,
        buyer: address,
        maybe_name: 0x1::option::Option<0x1::ascii::String>,
        coin_type: 0x1::ascii::String,
        balance: u64,
    }

    struct CancelMultiBidEvent has copy, drop {
        multi_bid_id: 0x2::object::ID,
        buyer: address,
        maybe_name: 0x1::option::Option<0x1::ascii::String>,
        coin_type: 0x1::ascii::String,
        balance: u64,
    }

    struct CreateSingleBidEvent has copy, drop {
        bid_id: 0x2::object::ID,
        type: u64,
        buyer: address,
        maybe_multi_bid_id: 0x1::option::Option<0x2::object::ID>,
        nft_type: 0x1::ascii::String,
        maybe_nft_id: 0x1::option::Option<0x2::object::ID>,
        maybe_nft_bcs: 0x1::option::Option<vector<u8>>,
        attribute_names: vector<0x1::ascii::String>,
        attribute_values: vector<0x1::ascii::String>,
        maybe_expire_at: 0x1::option::Option<u64>,
        coin_type: 0x1::ascii::String,
        price: u64,
        royalty: u64,
        fee: u64,
    }

    struct CancelSingleBidEvent has copy, drop {
        bid_id: 0x2::object::ID,
        type: u64,
        buyer: address,
        maybe_multi_bid_id: 0x1::option::Option<0x2::object::ID>,
        nft_type: 0x1::ascii::String,
        maybe_nft_id: 0x1::option::Option<0x2::object::ID>,
        maybe_nft_bcs: 0x1::option::Option<vector<u8>>,
        attribute_names: vector<0x1::ascii::String>,
        attribute_values: vector<0x1::ascii::String>,
        maybe_expire_at: 0x1::option::Option<u64>,
        coin_type: 0x1::ascii::String,
        price: u64,
        royalty: u64,
        fee: u64,
    }

    struct MatchSingleBidEvent has copy, drop {
        bid_id: 0x2::object::ID,
        type: u64,
        buyer: address,
        maybe_multi_bid_id: 0x1::option::Option<0x2::object::ID>,
        nft_type: 0x1::ascii::String,
        maybe_nft_id: 0x1::option::Option<0x2::object::ID>,
        maybe_nft_bcs: 0x1::option::Option<vector<u8>>,
        attribute_names: vector<0x1::ascii::String>,
        attribute_values: vector<0x1::ascii::String>,
        maybe_expire_at: 0x1::option::Option<u64>,
        coin_type: 0x1::ascii::String,
        price: u64,
        royalty: u64,
        fee: u64,
        nft_id: 0x2::object::ID,
        maybe_buyer_kiosk_id: 0x1::option::Option<0x2::object::ID>,
    }

    public fun accept_bid<T0>(arg0: &0x2::clock::Clock, arg1: &mut Store, arg2: 0x2::object::ID, arg3: 0x1::option::Option<0x2::object::ID>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::object::ID, arg7: &mut 0x2::transfer_policy::TransferPolicy<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>> {
        verify_version(arg1);
        let v0 = get_bid(arg1, arg2, arg3, true);
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v0.balance) == v0.price + v0.fee + v0.royalty, 4);
        assert!(royalty_amount<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>(arg7, v0.price) <= v0.royalty, 9);
        let v1 = 0x2::kiosk::list_with_purchase_cap<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>(arg4, arg5, arg6, 0, arg8);
        let (v2, v3) = zero_purchase<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>(arg4, v1, arg7, arg8);
        let v4 = v3;
        let v5 = v2;
        assert!(v0.nft_type == type_string<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>(), 11);
        if (0x1::option::is_some<0x2::object::ID>(&v0.maybe_nft_id)) {
            assert!(0x2::object::id<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>(&v5) == *0x1::option::borrow<0x2::object::ID>(&v0.maybe_nft_id), 11);
        };
        if (0x1::option::is_some<vector<u8>>(&v0.maybe_nft_bcs)) {
            assert!(0x1::bcs::to_bytes<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>(&v5) == *0x1::option::borrow<vector<u8>>(&v0.maybe_nft_bcs), 12);
        };
        if (0x1::option::is_some<u64>(&v0.maybe_expire_at)) {
            assert!(0x2::clock::timestamp_ms(arg0) <= *0x1::option::borrow<u64>(&v0.maybe_expire_at), 10);
        };
        if (v0.type == 2) {
            let v6 = 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::attributes<T0>(&v5);
            let v7 = 0;
            while (v7 < 0x1::vector::length<0x1::ascii::String>(&v0.attribute_names)) {
                let v8 = 0x1::string::from_ascii(*0x1::vector::borrow<0x1::ascii::String>(&v0.attribute_names, v7));
                let v9 = 0x1::string::from_ascii(*0x1::vector::borrow<0x1::ascii::String>(&v0.attribute_values, v7));
                assert!(0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v6, &v8), 15);
                assert!(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v6, &v8) == &v9, 15);
                v7 = v7 + 1;
            };
        };
        let SingleBid {
            id                 : v10,
            type               : v11,
            buyer              : v12,
            maybe_multi_bid_id : v13,
            nft_type           : v14,
            maybe_nft_id       : v15,
            maybe_nft_bcs      : v16,
            attribute_names    : v17,
            attribute_values   : v18,
            maybe_expire_at    : v19,
            price              : v20,
            royalty            : v21,
            fee                : v22,
            balance            : v23,
        } = v0;
        let v24 = v23;
        let v25 = v10;
        0x2::balance::send_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v24, v20), 0x2::tx_context::sender(arg8));
        if (0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v24) > 0) {
            0x2::balance::send_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::withdraw_all<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v24), arg1.beneficiary);
        };
        0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v24);
        let v26 = 0x2::transfer_policy::has_rule<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg7);
        let v27 = 0x2::transfer_policy::has_rule<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::Rule>(arg7);
        let v28 = if (!v26 && !v27) {
            0x2::transfer::public_transfer<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>(v5, v12);
            0x1::option::none<0x2::object::ID>()
        } else {
            let (v29, v30) = 0x2::kiosk::new(arg8);
            let v31 = v30;
            let v32 = v29;
            if (v26) {
                0x2::kiosk::lock<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>(&mut v32, &v31, arg7, v5);
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>(&mut v4, &v32);
            } else {
                0x2::kiosk::place<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>(&mut v32, &v31, v5);
            };
            if (v27) {
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::create_for(&mut v32, v31, v12, arg8);
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::prove<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>(&v32, &mut v4);
            } else {
                0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v31, v12);
            };
            0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v32);
            0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::kiosk::Kiosk>(&v32))
        };
        let v33 = MatchSingleBidEvent{
            bid_id               : 0x2::object::uid_to_inner(&v25),
            type                 : v11,
            buyer                : v12,
            maybe_multi_bid_id   : v13,
            nft_type             : v14,
            maybe_nft_id         : v15,
            maybe_nft_bcs        : v16,
            attribute_names      : v17,
            attribute_values     : v18,
            maybe_expire_at      : v19,
            coin_type            : type_string<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            price                : v20,
            royalty              : v21,
            fee                  : v22,
            nft_id               : 0x2::object::id<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>(&v5),
            maybe_buyer_kiosk_id : v28,
        };
        0x2::event::emit<MatchSingleBidEvent>(v33);
        0x2::object::delete(v25);
        v4
    }

    entry fun add_sponsored_listing<T0: store + key>(arg0: &mut Store, arg1: &0x2::clock::Clock, arg2: 0x2::object::ID, arg3: u64, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SimpleListing<T0>>(&arg0.id, arg2), 3);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg4) == arg3 * arg0.sponsor_price, 4);
        let v0 = 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4);
        if (0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v0) > 0) {
            0x2::balance::send_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0, arg0.beneficiary);
        } else {
            0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0);
        };
        let v1 = type_string<T0>();
        if (!0x2::dynamic_object_field::exists_with_type<0x1::ascii::String, SimpleSponsoredCollection<T0>>(&arg0.id, v1)) {
            let v2 = SimpleSponsoredCollection<T0>{
                id       : 0x2::object::new(arg5),
                listings : 0x2::vec_map::empty<0x2::object::ID, u64>(),
            };
            0x2::dynamic_object_field::add<0x1::ascii::String, SimpleSponsoredCollection<T0>>(&mut arg0.id, v1, v2);
        } else {
            let v3 = &mut 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, SimpleSponsoredCollection<T0>>(&mut arg0.id, v1).listings;
            let v4 = 0x2::vec_map::keys<0x2::object::ID, u64>(v3);
            while (!0x1::vector::is_empty<0x2::object::ID>(&v4)) {
                let v5 = 0x1::vector::pop_back<0x2::object::ID>(&mut v4);
                if (*0x2::vec_map::get<0x2::object::ID, u64>(v3, &v5) < 0x2::clock::timestamp_ms(arg1)) {
                    let (_, _) = 0x2::vec_map::remove<0x2::object::ID, u64>(v3, &v5);
                };
            };
        };
        let v8 = &mut 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, SimpleSponsoredCollection<T0>>(&mut arg0.id, v1).listings;
        let v9 = if (0x2::vec_map::contains<0x2::object::ID, u64>(v8, &arg2)) {
            let (_, v11) = 0x2::vec_map::remove<0x2::object::ID, u64>(v8, &arg2);
            let v12 = v11 + arg3 * 86400000;
            0x2::vec_map::insert<0x2::object::ID, u64>(v8, arg2, v12);
            v12
        } else {
            assert!(0x2::vec_map::length<0x2::object::ID, u64>(v8) < arg0.max_sponsored_listings, 5);
            let v13 = 0x2::clock::timestamp_ms(arg1) + arg3 * 86400000;
            0x2::vec_map::insert<0x2::object::ID, u64>(v8, arg2, v13);
            v13
        };
        let v14 = AddSponsoredListingEvent{
            nft_id    : arg2,
            coin_type : type_string<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            nft_type  : v1,
            period    : arg3,
            seller    : 0x2::dynamic_object_field::borrow<0x2::object::ID, SimpleListing<T0>>(&arg0.id, arg2).seller,
            expire_at : v9,
        };
        0x2::event::emit<AddSponsoredListingEvent>(v14);
    }

    fun assert_settleable<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>) {
        let v0 = if (!0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::Rule>(arg0)) {
            let v1 = 0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg0) && 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg0, 0) > 0;
            !v1
        } else {
            false
        };
        assert!(v0, 13);
    }

    public fun buy_listing<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: address, arg5: 0x2::object::ID, arg6: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        verify_version(arg0);
        assert_settleable<T0>(arg7);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SimpleListing<T0>>(&arg0.id, arg5), 3);
        remove_sponsored_listing_if_exists<T0>(arg0, arg5);
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, SimpleListing<T0>>(&mut arg0.id, arg5);
        let SimpleListing {
            id                    : v1,
            type                  : v2,
            nft_id                : v3,
            price                 : v4,
            seller                : v5,
            maybe_seller_kiosk_id : v6,
        } = v0;
        0x2::object::delete(v1);
        let v7 = royalty_amount<T0>(arg7, v4);
        let v8 = market_fee(arg0, v4);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg6) >= v4 + v7 + v8, 4);
        let (v9, v10) = zero_purchase<T0>(arg1, 0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut v0.id, arg5), arg7, arg8);
        let v11 = v10;
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg7)) {
            0x2::kiosk::lock<T0>(arg2, arg3, arg7, v9);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v11, arg2);
        } else {
            0x2::kiosk::place<T0>(arg2, arg3, v9);
        };
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::Rule>(arg7)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::prove<T0>(arg2, &mut v11);
        };
        if (v4 > 0) {
            0x2::coin::send_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg6, v4, arg8), v5);
        };
        if (v7 + v8 > 0) {
            0x2::coin::send_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg6, v7 + v8, arg8), arg0.beneficiary);
        };
        let v12 = BuySimpleListingEvent{
            type                  : v2,
            nft_id                : v3,
            coin_type             : type_string<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            price                 : v4,
            royalty               : v7,
            fee                   : v8,
            seller                : v5,
            buyer                 : arg4,
            maybe_seller_kiosk_id : v6,
            maybe_buyer_kiosk_id  : 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::kiosk::Kiosk>(arg2)),
        };
        0x2::event::emit<BuySimpleListingEvent>(v12);
        v11
    }

    entry fun cancel_bid(arg0: &mut Store, arg1: 0x2::object::ID, arg2: 0x1::option::Option<0x2::object::ID>, arg3: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        let v0 = get_bid(arg0, arg1, arg2, false);
        assert!(v0.buyer == 0x2::tx_context::sender(arg3) || arg0.admin == 0x2::tx_context::sender(arg3), 2);
        let v1 = CancelSingleBidEvent{
            bid_id             : 0x2::object::id<SingleBid>(&v0),
            type               : v0.type,
            buyer              : v0.buyer,
            maybe_multi_bid_id : v0.maybe_multi_bid_id,
            nft_type           : v0.nft_type,
            maybe_nft_id       : v0.maybe_nft_id,
            maybe_nft_bcs      : v0.maybe_nft_bcs,
            attribute_names    : v0.attribute_names,
            attribute_values   : v0.attribute_values,
            maybe_expire_at    : v0.maybe_expire_at,
            coin_type          : type_string<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            price              : v0.price,
            royalty            : v0.royalty,
            fee                : v0.fee,
        };
        0x2::event::emit<CancelSingleBidEvent>(v1);
        let SingleBid {
            id                 : v2,
            type               : _,
            buyer              : v4,
            maybe_multi_bid_id : _,
            nft_type           : _,
            maybe_nft_id       : _,
            maybe_nft_bcs      : _,
            attribute_names    : _,
            attribute_values   : _,
            maybe_expire_at    : _,
            price              : _,
            royalty            : _,
            fee                : _,
            balance            : v15,
        } = v0;
        let v16 = v15;
        0x2::object::delete(v2);
        if (0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v16) > 0) {
            0x2::balance::send_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v16, v4);
        } else {
            0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v16);
        };
    }

    entry fun cancel_listing<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID) {
        verify_version(arg0);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SimpleListing<T0>>(&arg0.id, arg3), 3);
        remove_sponsored_listing_if_exists<T0>(arg0, arg3);
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, SimpleListing<T0>>(&mut arg0.id, arg3);
        assert!(0x2::kiosk::has_access(arg1, arg2), 2);
        0x2::kiosk::return_purchase_cap<T0>(arg1, 0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut v0.id, arg3));
        let SimpleListing {
            id                    : v1,
            type                  : v2,
            nft_id                : v3,
            price                 : v4,
            seller                : v5,
            maybe_seller_kiosk_id : v6,
        } = v0;
        0x2::object::delete(v1);
        let v7 = CancelSimpleListingEvent{
            type                  : v2,
            nft_id                : v3,
            coin_type             : type_string<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            price                 : v4,
            seller                : v5,
            maybe_seller_kiosk_id : v6,
        };
        0x2::event::emit<CancelSimpleListingEvent>(v7);
    }

    entry fun cancel_multi_bid(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, MultiBid>(&arg0.id, arg1), 7);
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, MultiBid>(&mut arg0.id, arg1);
        assert!(v0.buyer == 0x2::tx_context::sender(arg2) || arg0.admin == 0x2::tx_context::sender(arg2), 2);
        let v1 = CancelMultiBidEvent{
            multi_bid_id : 0x2::object::id<MultiBid>(&v0),
            buyer        : v0.buyer,
            maybe_name   : v0.maybe_name,
            coin_type    : type_string<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            balance      : 0,
        };
        0x2::event::emit<CancelMultiBidEvent>(v1);
        let MultiBid {
            id         : v2,
            buyer      : v3,
            maybe_name : _,
            bids       : v5,
            balance    : v6,
        } = v0;
        let v7 = v6;
        0x2::object::delete(v2);
        let v8 = v5;
        let v9 = 0;
        while (v9 < 0x1::vector::length<0x2::object::ID>(&v8)) {
            0x1::vector::pop_back<0x2::object::ID>(&mut v8);
            v9 = v9 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(v8);
        if (0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v7) > 0) {
            0x2::balance::send_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v7, v3);
        } else {
            0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v7);
        };
    }

    public fun create_bid<T0: store + key>(arg0: &mut Store, arg1: u64, arg2: 0x1::option::Option<0x2::object::ID>, arg3: 0x1::option::Option<0x2::object::ID>, arg4: 0x1::option::Option<vector<u8>>, arg5: vector<0x1::ascii::String>, arg6: vector<0x1::ascii::String>, arg7: 0x1::option::Option<u64>, arg8: u64, arg9: &0x2::transfer_policy::TransferPolicy<T0>, arg10: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        verify_version(arg0);
        verify_nft_type<T0>();
        assert_settleable<T0>(arg9);
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = type_string<T0>();
        let v2 = royalty_amount<T0>(arg9, arg8);
        let v3 = market_fee(arg0, arg8);
        assert!(arg1 < 3, 11);
        if (arg1 == 1) {
            assert!(0x1::option::is_some<0x2::object::ID>(&arg3), 11);
        };
        if (arg1 == 2) {
            assert!(0x1::vector::length<0x1::ascii::String>(&arg5) > 0, 11);
            assert!(0x1::vector::length<0x1::ascii::String>(&arg5) == 0x1::vector::length<0x1::ascii::String>(&arg6), 11);
        } else {
            assert!(0x1::vector::is_empty<0x1::ascii::String>(&arg5) && 0x1::vector::is_empty<0x1::ascii::String>(&arg6), 11);
        };
        let v4 = SingleBid{
            id                 : 0x2::object::new(arg11),
            type               : arg1,
            buyer              : v0,
            maybe_multi_bid_id : arg2,
            nft_type           : v1,
            maybe_nft_id       : arg3,
            maybe_nft_bcs      : arg4,
            attribute_names    : arg5,
            attribute_values   : arg6,
            maybe_expire_at    : arg7,
            price              : arg8,
            royalty            : v2,
            fee                : v3,
            balance            : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
        };
        let v5 = 0x2::object::id<SingleBid>(&v4);
        let v6 = CreateSingleBidEvent{
            bid_id             : v5,
            type               : arg1,
            buyer              : v0,
            maybe_multi_bid_id : arg2,
            nft_type           : v1,
            maybe_nft_id       : arg3,
            maybe_nft_bcs      : arg4,
            attribute_names    : arg5,
            attribute_values   : arg6,
            maybe_expire_at    : arg7,
            coin_type          : type_string<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            price              : arg8,
            royalty            : v2,
            fee                : v3,
        };
        if (0x1::option::is_some<0x2::object::ID>(&arg2)) {
            let v7 = 0x1::option::destroy_some<0x2::object::ID>(arg2);
            assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, MultiBid>(&arg0.id, v7), 7);
            let v8 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, MultiBid>(&mut arg0.id, v7);
            assert!(v8.buyer == v0, 2);
            if (0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg10) > 0) {
                0x2::coin::put<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v8.balance, arg10);
                let v9 = UpdateMultiBidEvent{
                    multi_bid_id : 0x2::object::id<MultiBid>(v8),
                    buyer        : v8.buyer,
                    maybe_name   : v8.maybe_name,
                    coin_type    : type_string<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
                    balance      : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v8.balance),
                };
                0x2::event::emit<UpdateMultiBidEvent>(v9);
            } else {
                0x2::coin::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg10);
            };
            assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v8.balance) >= arg8 + v3 + v2, 4);
            0x2::event::emit<CreateSingleBidEvent>(v6);
            0x2::dynamic_object_field::add<0x2::object::ID, SingleBid>(&mut v8.id, v5, v4);
        } else {
            assert!(0x1::option::is_none<u64>(&arg7), 11);
            assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg10) == arg8 + v3 + v2, 4);
            0x2::coin::put<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v4.balance, arg10);
            0x2::event::emit<CreateSingleBidEvent>(v6);
            0x2::dynamic_object_field::add<0x2::object::ID, SingleBid>(&mut arg0.id, v5, v4);
        };
        v5
    }

    entry fun create_listing<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: 0x2::object::ID, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_nft_type<T0>();
        assert_settleable<T0>(arg3);
        let v0 = 1;
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v3 = SimpleListing<T0>{
            id                    : 0x2::object::new(arg6),
            type                  : v0,
            nft_id                : arg4,
            price                 : arg5,
            seller                : v1,
            maybe_seller_kiosk_id : 0x1::option::some<0x2::object::ID>(v2),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut v3.id, arg4, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg4, 0, arg6));
        0x2::dynamic_object_field::add<0x2::object::ID, SimpleListing<T0>>(&mut arg0.id, arg4, v3);
        let v4 = CreateSimpleListingEvent{
            type                  : v0,
            nft_id                : arg4,
            coin_type             : type_string<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            price                 : arg5,
            seller                : v1,
            maybe_seller_kiosk_id : 0x1::option::some<0x2::object::ID>(v2),
        };
        0x2::event::emit<CreateSimpleListingEvent>(v4);
    }

    public fun create_multi_bid(arg0: &mut Store, arg1: 0x1::option::Option<0x1::ascii::String>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        verify_version(arg0);
        let v0 = MultiBid{
            id         : 0x2::object::new(arg2),
            buyer      : 0x2::tx_context::sender(arg2),
            maybe_name : arg1,
            bids       : 0x1::vector::empty<0x2::object::ID>(),
            balance    : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
        };
        let v1 = 0x2::object::id<MultiBid>(&v0);
        let v2 = CreateMultiBidEvent{
            multi_bid_id : v1,
            buyer        : v0.buyer,
            maybe_name   : arg1,
            coin_type    : type_string<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            balance      : 0,
        };
        0x2::event::emit<CreateMultiBidEvent>(v2);
        0x2::dynamic_object_field::add<0x2::object::ID, MultiBid>(&mut arg0.id, v1, v0);
        v1
    }

    fun get_bid(arg0: &mut Store, arg1: 0x2::object::ID, arg2: 0x1::option::Option<0x2::object::ID>, arg3: bool) : SingleBid {
        verify_version(arg0);
        if (0x1::option::is_some<0x2::object::ID>(&arg2)) {
            let v1 = 0x1::option::destroy_some<0x2::object::ID>(arg2);
            assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, MultiBid>(&arg0.id, v1), 7);
            let v2 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, MultiBid>(&mut arg0.id, v1);
            assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SingleBid>(&v2.id, arg1), 8);
            let v3 = 0x2::dynamic_object_field::remove<0x2::object::ID, SingleBid>(&mut v2.id, arg1);
            if (arg3) {
                let v4 = v3.price + v3.fee + v3.royalty;
                assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v2.balance) >= v4, 4);
                0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v3.balance, 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v2.balance, v4));
                let v5 = UpdateMultiBidEvent{
                    multi_bid_id : 0x2::object::id<MultiBid>(v2),
                    buyer        : v2.buyer,
                    maybe_name   : v2.maybe_name,
                    coin_type    : type_string<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
                    balance      : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v2.balance),
                };
                0x2::event::emit<UpdateMultiBidEvent>(v5);
            };
            v3
        } else {
            assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SingleBid>(&arg0.id, arg1), 8);
            0x2::dynamic_object_field::remove<0x2::object::ID, SingleBid>(&mut arg0.id, arg1)
        }
    }

    public fun get_multi_bid_balance(arg0: &Store, arg1: 0x2::object::ID) : u64 {
        if (!has_multi_bid(arg0, arg1)) {
            return 0
        };
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&0x2::dynamic_object_field::borrow<0x2::object::ID, MultiBid>(&arg0.id, arg1).balance)
    }

    public fun has_multi_bid(arg0: &Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, MultiBid>(&arg0.id, arg1)
    }

    fun init(arg0: RIPSTATION_MARKETPLACE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<RIPSTATION_MARKETPLACE>(arg0, arg1);
        let v0 = Store{
            id                     : 0x2::object::new(arg1),
            version                : 1,
            admin                  : 0x2::tx_context::sender(arg1),
            fee_bps                : 300,
            beneficiary            : 0x2::tx_context::sender(arg1),
            sponsor_price          : 20000000,
            max_sponsored_listings : 3,
        };
        0x2::transfer::share_object<Store>(v0);
    }

    fun market_fee(arg0: &Store, arg1: u64) : u64 {
        (((arg1 as u128) * (arg0.fee_bps as u128) / 10000) as u64)
    }

    entry fun relist_listing<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64) {
        verify_version(arg0);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SimpleListing<T0>>(&arg0.id, arg3), 3);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, SimpleListing<T0>>(&arg0.id, arg3);
        assert!(0x2::kiosk::has_access(arg1, arg2), 2);
        assert!(0x2::kiosk::has_item(arg1, arg3), 2);
        assert!(v0.type == 1, 6);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, SimpleListing<T0>>(&mut arg0.id, arg3);
        v1.price = arg4;
        let v2 = RelistSimpleListingEvent{
            type                  : v1.type,
            nft_id                : arg3,
            coin_type             : type_string<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            new_price             : arg4,
            seller                : v1.seller,
            maybe_seller_kiosk_id : v1.maybe_seller_kiosk_id,
        };
        0x2::event::emit<RelistSimpleListingEvent>(v2);
    }

    fun remove_sponsored_listing_if_exists<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID) {
        let v0 = type_string<T0>();
        if (!0x2::dynamic_object_field::exists_with_type<0x1::ascii::String, SimpleSponsoredCollection<T0>>(&arg0.id, v0)) {
            return
        };
        let v1 = &mut 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, SimpleSponsoredCollection<T0>>(&mut arg0.id, v0).listings;
        if (0x2::vec_map::contains<0x2::object::ID, u64>(v1, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x2::object::ID, u64>(v1, &arg1);
        };
    }

    fun royalty_amount<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: u64) : u64 {
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg0)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg0, arg1)
        } else {
            0
        }
    }

    entry fun set_admin(arg0: &mut Store, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.admin = arg1;
    }

    entry fun set_beneficiary(arg0: &mut Store, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.beneficiary = arg1;
    }

    entry fun set_fee_bps(arg0: &mut Store, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        assert!(arg1 <= 10000, 11);
        arg0.fee_bps = arg1;
    }

    entry fun set_max_sponsored_listings(arg0: &mut Store, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.max_sponsored_listings = arg1;
    }

    entry fun set_sponsor_price(arg0: &mut Store, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.sponsor_price = arg1;
    }

    entry fun set_version(arg0: &mut Store, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.version = arg1;
    }

    fun type_string<T0>() : 0x1::ascii::String {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        *0x1::type_name::as_string(&v0)
    }

    entry fun update_multi_bid(arg0: &mut Store, arg1: 0x2::object::ID, arg2: 0x1::option::Option<0x1::ascii::String>, arg3: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: 0x1::option::Option<u64>, arg5: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, MultiBid>(&arg0.id, arg1), 7);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, MultiBid>(&mut arg0.id, arg1);
        assert!(v0.buyer == 0x2::tx_context::sender(arg5), 2);
        if (0x1::option::is_some<0x1::ascii::String>(&arg2)) {
            v0.maybe_name = arg2;
        };
        0x2::coin::put<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v0.balance, arg3);
        if (0x1::option::is_some<u64>(&arg4)) {
            let v1 = *0x1::option::borrow<u64>(&arg4);
            assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v0.balance) >= v1, 4);
            0x2::balance::send_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v0.balance, v1), 0x2::tx_context::sender(arg5));
        };
        let v2 = UpdateMultiBidEvent{
            multi_bid_id : 0x2::object::id<MultiBid>(v0),
            buyer        : v0.buyer,
            maybe_name   : v0.maybe_name,
            coin_type    : type_string<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            balance      : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v0.balance),
        };
        0x2::event::emit<UpdateMultiBidEvent>(v2);
    }

    fun verify_admin(arg0: &Store, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 2);
    }

    fun verify_nft_type<T0>() {
        let v0 = type_string<T0>();
        let v1 = type_string<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<RIPSTATION_MARKETPLACE>>();
        let v2 = type_string<RIPSTATION_MARKETPLACE>();
        let v3 = 0x1::ascii::substring(&v1, 0, 0x1::ascii::length(&v1) - 0x1::ascii::length(&v2) - 1);
        assert!(0x1::ascii::length(&v0) > 0x1::ascii::length(&v3) && 0x1::ascii::substring(&v0, 0, 0x1::ascii::length(&v3)) == v3, 14);
    }

    fun verify_version(arg0: &Store) {
        assert!(arg0.version == 1, 1);
    }

    fun zero_purchase<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::kiosk::PurchaseCap<T0>, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        assert_settleable<T0>(arg2);
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(arg0, arg1, 0x2::coin::zero<0x2::sui::SUI>(arg3));
        let v2 = v1;
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg2)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg2, &mut v2, 0x2::coin::zero<0x2::sui::SUI>(arg3));
        };
        (v0, v2)
    }

    // decompiled from Move bytecode v7
}

