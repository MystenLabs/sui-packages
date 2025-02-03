module 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::operator_offer {
    public entry fun system_cancel_offer<T0>(arg0: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::operator::OperatorCap, arg1: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::Version, arg2: &mut 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::State, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::assert_current_version(arg1);
        let v0 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::new_offer_key<T0>(arg3);
        assert!(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::contain<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::OfferKey<T0>, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::Offer<T0>>(arg2, v0), 1);
        let v1 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::borrow_mut<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::OfferKey<T0>, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::Offer<T0>>(arg2, v0);
        assert!(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::is_cancelling_status<T0>(v1), 2);
        assert!(0x2::coin::value<T0>(&arg4) == 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::amount<T0>(v1), 3);
        let v2 = 0x2::coin::zero<T0>(arg6);
        0x2::coin::join<T0>(&mut v2, arg4);
        0x2::coin::join<T0>(&mut v2, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::lender<T0>(v1));
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::system_cancel_offer<T0>(v1);
    }

    entry fun system_open_offer<T0>(arg0: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::operator::OperatorCap, arg1: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::Version, arg2: &mut 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::State, arg3: 0x1::string::String, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::version::assert_current_version(arg1);
        let v0 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::borrow<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset_tier::AssetTierKey<T0>, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset_tier::AssetTier<T0>>(arg2, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset_tier::new_asset_tier_key<T0>(arg3));
        let v1 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::system_open_offer<T0>(0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset_tier::id<T0>(v0), 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset_tier::amount<T0>(v0), 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset_tier::duration<T0>(v0), arg4, arg5, arg6);
        let v2 = 0x2::object::id<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::Offer<T0>>(&v1);
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::add<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::OfferKey<T0>, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::Offer<T0>>(arg2, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::new_offer_key<T0>(v2), v1);
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state::add_offer(arg2, v2, arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

