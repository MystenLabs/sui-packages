module 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer {
    public entry fun create_offer<T0>(arg0: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::Version, arg1: &mut 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::State, arg2: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::Configuration, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::assert_current_version(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::is_lend_coin<T0>(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::borrow<0x1::string::String, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::Asset<T0>>(arg2, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::get_type<T0>())), 6);
        assert!(arg5 > 0 && arg5 <= 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::max_offer_interest(arg2), 1);
        let v1 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset_tier::new_asset_tier_key<T0>(arg3);
        assert!(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::contain<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset_tier::AssetTierKey<T0>, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset_tier::AssetTier<T0>>(arg1, v1), 2);
        let v2 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::borrow<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset_tier::AssetTierKey<T0>, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset_tier::AssetTier<T0>>(arg1, v1);
        assert!(0x2::coin::value<T0>(&arg4) == 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset_tier::amount<T0>(v2), 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::hot_wallet(arg2));
        let v3 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::new_offer<T0>(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset_tier::id<T0>(v2), arg3, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset_tier::amount<T0>(v2), 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset_tier::duration<T0>(v2), arg5, v0, arg6);
        let v4 = 0x2::object::id<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::Offer<T0>>(&v3);
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::add<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::OfferKey<T0>, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::Offer<T0>>(arg1, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::new_offer_key<T0>(v4), v3);
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::add_offer(arg1, v4, v0, arg6);
    }

    public entry fun edit_offer<T0>(arg0: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::Version, arg1: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::Configuration, arg2: &mut 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::State, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::assert_current_version(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::new_offer_key<T0>(arg3);
        assert!(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::contain<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::OfferKey<T0>, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::Offer<T0>>(arg2, v1), 5);
        let v2 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::borrow_mut<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::OfferKey<T0>, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::Offer<T0>>(arg2, v1);
        assert!(v0 == 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::lender<T0>(v2), 8);
        assert!(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::is_created_status<T0>(v2), 7);
        assert!(arg4 > 0 && arg4 <= 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::configuration::max_offer_interest(arg1), 1);
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::edit_offer<T0>(v2, arg4, v0);
    }

    public entry fun request_cancel_offer<T0>(arg0: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::Version, arg1: &mut 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::State, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::assert_current_version(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::new_offer_key<T0>(arg2);
        assert!(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::contain<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::OfferKey<T0>, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::Offer<T0>>(arg1, v1), 4);
        let v2 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::borrow_mut<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::OfferKey<T0>, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::Offer<T0>>(arg1, v1);
        assert!(v0 == 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::lender<T0>(v2), 8);
        assert!(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::is_created_status<T0>(v2), 7);
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::cancel_offer<T0>(v2, v0);
    }

    // decompiled from Move bytecode v6
}

