module 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::policy {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        royalty_bp: u16,
    }

    public fun add_royalty_rule<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::DonorPosition<T0>>, arg1: &0x2::transfer_policy::TransferPolicyCap<0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::DonorPosition<T0>>, arg2: u16) {
        assert!(arg2 <= 10000, 0);
        let v0 = Rule{dummy_field: false};
        let v1 = Config{royalty_bp: arg2};
        0x2::transfer_policy::add_rule<0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::DonorPosition<T0>, Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun pay_royalty<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::DonorPosition<T0>>, arg1: &mut 0x2::transfer_policy::TransferRequest<0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::DonorPosition<T0>>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = (((0x2::transfer_policy::paid<0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::DonorPosition<T0>>(arg1) as u128) * (0x2::transfer_policy::get_rule<0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::DonorPosition<T0>, Rule, Config>(v0, arg0).royalty_bp as u128) / (10000 as u128)) as u64);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v1, 1);
        let v2 = Rule{dummy_field: false};
        0x2::transfer_policy::add_to_balance<0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::DonorPosition<T0>, Rule>(v2, arg0, 0x2::coin::split<0x2::sui::SUI>(arg2, v1, arg3));
        let v3 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::DonorPosition<T0>, Rule>(v3, arg1);
    }

    public fun remove_royalty_rule<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::DonorPosition<T0>>, arg1: &0x2::transfer_policy::TransferPolicyCap<0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::DonorPosition<T0>>) {
        0x2::transfer_policy::remove_rule<0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::DonorPosition<T0>, Rule, Config>(arg0, arg1);
    }

    public fun setup_policy<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferPolicy<0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::DonorPosition<T0>>, 0x2::transfer_policy::TransferPolicyCap<0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::DonorPosition<T0>>) {
        0x2::transfer_policy::new<0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::DonorPosition<T0>>(arg0, arg1)
    }

    public fun setup_policy_with_royalty<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferPolicy<0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::DonorPosition<T0>>, 0x2::transfer_policy::TransferPolicyCap<0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::DonorPosition<T0>>) {
        let (v0, v1) = 0x2::transfer_policy::new<0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::DonorPosition<T0>>(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = Rule{dummy_field: false};
        let v5 = Config{royalty_bp: 500};
        0x2::transfer_policy::add_rule<0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::DonorPosition<T0>, Rule, Config>(v4, &mut v3, &v2, v5);
        (v3, v2)
    }

    public fun withdraw_royalties<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::DonorPosition<T0>>, arg1: &0x2::transfer_policy::TransferPolicyCap<0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::DonorPosition<T0>>, arg2: &0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::platform::PlatformConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::transfer_policy::withdraw<0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::position::DonorPosition<T0>>(arg0, arg1, 0x1::option::none<u64>(), arg3), 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::platform::treasury(arg2));
    }

    // decompiled from Move bytecode v6
}

