module 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::harvest {
    public fun emergency_drain<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: &0x2::clock::Clock, arg4: u64) : vector<u64> {
        let v0 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::auth::issue_on<T0>(arg1, arg0);
        let (v1, v2) = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::emergency_drain<T0>(&v0, arg0, arg1, arg2, arg4);
        credit_rows<T0>(&v0, arg0, arg1, arg3, v2);
        v1
    }

    public fun harvest<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x2::clock::Clock, arg3: u64) : vector<u64> {
        let v0 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::auth::issue_on<T0>(arg1, arg0);
        let (v1, v2) = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::harvest<T0>(&v0, arg0, arg1, arg3);
        credit_rows<T0>(&v0, arg0, arg1, arg2, v2);
        v1
    }

    fun credit_rows<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: &0x2::clock::Clock, arg4: vector<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::HarvestFeeCredit>) {
        let v0 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::game_paused(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::HarvestFeeCredit>(&arg4)) {
            let v3 = 0x1::vector::borrow<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::HarvestFeeCredit>(&arg4, v2);
            let v4 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::fee_credit_amount(v3);
            let v5 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::fee_credit_owner(v3);
            if (v4 > 0) {
                0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::note_fee_credit(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1), v5, v4);
            };
            let v6 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::fee_credit_refund(v3);
            if (v6 > 0) {
                0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::note_harvest_gain(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1), 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg2), v5, v6, !v0, v1);
            };
            if (0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::fee_credit_settle(v3) && !v0) {
                0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_book::settle_fee_achievement(arg0, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid_mut<T0>(arg0, arg1), 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg2), v5, v1);
            };
            v2 = v2 + 1;
        };
    }

    // decompiled from Move bytecode v7
}

