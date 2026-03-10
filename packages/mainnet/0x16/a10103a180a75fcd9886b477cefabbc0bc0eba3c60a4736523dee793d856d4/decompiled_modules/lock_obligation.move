module 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::lock_obligation {
    struct ObligationUnhealthyUnlocked has copy, drop {
        obligation: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
    }

    struct ObligationForceUnlocked has copy, drop {
        obligation: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
    }

    public fun force_unlock<T0: drop>(arg0: &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::version::Version, arg1: &mut 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::Obligation, arg2: T0) {
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::version::assert_current_version(arg0);
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::set_unlock<T0>(arg1, arg2);
        let v0 = ObligationForceUnlocked{
            obligation : 0x2::object::id<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::Obligation>(arg1),
            witness    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ObligationForceUnlocked>(v0);
    }

    public fun force_unlock_unhealthy<T0: drop>(arg0: &mut 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::Obligation, arg1: &mut 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xe2785270b2e6179e68204dd5901a43f9a0e1c566baf656cad705d45a419c4d3a::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: T0) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

