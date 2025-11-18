module 0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::asset_revenue {
    public fun fulfill_take_revenue_wish<T0, T1>(arg0: &0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::DragonBallCollector, arg1: &0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::app::ProtocolApp, arg2: &mut 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::market::Market<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::ensure_can_summon_shenron(arg0);
        0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::revenue_admin::take_revenue<T0, T1>(0x829edec8740e448c8352fd42d2e14dd0b2580051bfcde1b1b4f9c20bcf35fd0e::governance::lending_admin_cap(arg0), arg1, arg2, arg3, 0x2::tx_context::sender(arg5), arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

