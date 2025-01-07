module 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer {
    public entry fun create_offer<T0>(arg0: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::Version, arg1: &mut 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::State, arg2: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::Configuration, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::assert_current_version(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::is_valid_lend_coin<T0>(arg2), 6);
        assert!(arg5 > 0 && arg5 <= 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::max_offer_interest(arg2), 1);
        let v1 = 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::asset_tier::new_asset_tier_key<T0>(arg3);
        assert!(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::contain<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::asset_tier::AssetTierKey<T0>, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::asset_tier::AssetTier<T0>>(arg1, v1), 2);
        let v2 = 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::borrow<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::asset_tier::AssetTierKey<T0>, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::asset_tier::AssetTier<T0>>(arg1, v1);
        assert!(0x2::coin::value<T0>(&arg4) == 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::asset_tier::amount<T0>(v2), 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::hot_wallet(arg2));
        let v3 = 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::new_offer<T0>(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::asset_tier::id<T0>(v2), arg3, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::asset_tier::amount<T0>(v2), 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::asset_tier::duration<T0>(v2), arg5, v0, arg6);
        let v4 = 0x2::object::id<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::Offer<T0>>(&v3);
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::add<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::OfferKey<T0>, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::Offer<T0>>(arg1, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::new_offer_key<T0>(v4), v3);
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::add_offer(arg1, v4, v0, arg6);
    }

    public entry fun edit_offer<T0>(arg0: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::Version, arg1: &mut 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::State, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::assert_current_version(arg0);
        let v0 = 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::new_offer_key<T0>(arg2);
        assert!(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::contain<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::OfferKey<T0>, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::Offer<T0>>(arg1, v0), 5);
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::edit_offer<T0>(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::borrow_mut<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::OfferKey<T0>, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::Offer<T0>>(arg1, v0), arg3, 0x2::tx_context::sender(arg4));
    }

    public entry fun request_cancel_offer<T0>(arg0: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::Version, arg1: &mut 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::State, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::assert_current_version(arg0);
        let v0 = 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::new_offer_key<T0>(arg2);
        assert!(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::contain<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::OfferKey<T0>, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::Offer<T0>>(arg1, v0), 4);
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::cancel_offer<T0>(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::borrow_mut<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::OfferKey<T0>, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::Offer<T0>>(arg1, v0), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

