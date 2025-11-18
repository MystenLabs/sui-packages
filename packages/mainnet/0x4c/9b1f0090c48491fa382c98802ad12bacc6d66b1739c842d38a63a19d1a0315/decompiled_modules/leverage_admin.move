module 0x4c9b1f0090c48491fa382c98802ad12bacc6d66b1739c842d38a63a19d1a0315::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::app::AdminCap, arg1: &mut 0x4c9b1f0090c48491fa382c98802ad12bacc6d66b1739c842d38a63a19d1a0315::leverage_app::LeverageApp, arg2: 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::app::PackageCallerCap) {
        0x4c9b1f0090c48491fa382c98802ad12bacc6d66b1739c842d38a63a19d1a0315::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun onboard_market<T0>(arg0: &0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::app::AdminCap, arg1: &0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::market::Market<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::market::assert_emode_group_exists<T0>(arg1, arg2);
        0x2::transfer::public_share_object<0x4c9b1f0090c48491fa382c98802ad12bacc6d66b1739c842d38a63a19d1a0315::leverage_market::LeverageMarket>(0x4c9b1f0090c48491fa382c98802ad12bacc6d66b1739c842d38a63a19d1a0315::leverage_market::new_market(0x2::object::id<0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::market::Market<T0>>(arg1), arg2, arg3));
    }

    public fun remove_protocol_caller_cap(arg0: &0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::app::AdminCap, arg1: &mut 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::app::ProtocolApp, arg2: &mut 0x4c9b1f0090c48491fa382c98802ad12bacc6d66b1739c842d38a63a19d1a0315::leverage_app::LeverageApp) {
        0x4c9b1f0090c48491fa382c98802ad12bacc6d66b1739c842d38a63a19d1a0315::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

