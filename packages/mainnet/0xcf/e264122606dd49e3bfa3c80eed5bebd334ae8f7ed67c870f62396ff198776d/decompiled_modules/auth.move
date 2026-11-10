module 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::auth {
    struct TradeAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun issue(arg0: &0x2::object::UID) : 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::assert_version_live<TradeAuth>(arg0, 1);
        let v0 = TradeAuth{dummy_field: false};
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::issue<TradeAuth>(v0, arg0)
    }

    public(friend) fun issue_refund<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>) : 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::assert_version_live<TradeAuth>(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg0), 1);
        let v0 = TradeAuth{dummy_field: false};
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::issue_refund<TradeAuth, T0>(v0, arg0, arg1)
    }

    public fun impl_version() : u64 {
        1
    }

    public(friend) fun issue_on<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>) : 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::assert_version_live<TradeAuth>(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg0), 1);
        let v0 = TradeAuth{dummy_field: false};
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::issue_bound<TradeAuth, T0>(v0, arg0, arg1)
    }

    public(friend) fun issue_refund_for_market<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::Market<T0>) : 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::assert_version_live<TradeAuth>(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg0), 1);
        let v0 = TradeAuth{dummy_field: false};
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::market::issue_refund<TradeAuth, T0>(v0, arg0, arg1)
    }

    public entry fun register<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::register_extension<TradeAuth>(arg0, arg2);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::register_extension<TradeAuth, T0>(arg1, arg0, arg2);
        if (0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::primary(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg1)) == 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<TradeAuth>())) {
            0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::pin_harvest_witness<TradeAuth, T0>(arg1, arg0, arg2);
        };
    }

    public entry fun retire_previous_versions<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>) {
        let v0 = TradeAuth{dummy_field: false};
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::retire_extension_versions<TradeAuth>(arg0, arg2, v0, 1);
        let v1 = TradeAuth{dummy_field: false};
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::retire_extension_versions<TradeAuth, T0>(arg1, arg0, arg2, v1, 1);
    }

    public entry fun unregister<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::unregister_extension<TradeAuth>(arg0, arg2);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::unregister_extension<TradeAuth, T0>(arg1, arg0, arg2);
    }

    // decompiled from Move bytecode v7
}

