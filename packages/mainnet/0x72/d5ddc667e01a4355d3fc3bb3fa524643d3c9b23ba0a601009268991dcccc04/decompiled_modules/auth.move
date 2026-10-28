module 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth {
    struct TradeAuth has drop {
        dummy_field: bool,
    }

    public fun impl_version() : u64 {
        1
    }

    public(friend) fun issue(arg0: &0x2::object::UID) : 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::assert_version_live<TradeAuth>(arg0, 1);
        let v0 = TradeAuth{dummy_field: false};
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::issue<TradeAuth>(v0, arg0)
    }

    public(friend) fun issue_on<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>) : 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::assert_version_live<TradeAuth>(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg0), 1);
        let v0 = TradeAuth{dummy_field: false};
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::issue_bound<TradeAuth, T0>(v0, arg0, arg1)
    }

    public(friend) fun issue_refund<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>) : 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::assert_version_live<TradeAuth>(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg0), 1);
        let v0 = TradeAuth{dummy_field: false};
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::issue_refund<TradeAuth, T0>(v0, arg0, arg1)
    }

    public(friend) fun issue_refund_for_market<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::Market<T0>) : 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::assert_version_live<TradeAuth>(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg0), 1);
        let v0 = TradeAuth{dummy_field: false};
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::issue_refund<TradeAuth, T0>(v0, arg0, arg1)
    }

    public entry fun register<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::register_extension<TradeAuth>(arg0, arg2);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::register_extension<TradeAuth, T0>(arg1, arg0, arg2);
        if (0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::primary(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg1)) == 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<TradeAuth>())) {
            0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::pin_harvest_witness<TradeAuth, T0>(arg1, arg0, arg2);
        };
    }

    public entry fun retire_previous_versions<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>) {
        let v0 = TradeAuth{dummy_field: false};
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::retire_extension_versions<TradeAuth>(arg0, arg2, v0, 1);
        let v1 = TradeAuth{dummy_field: false};
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::retire_extension_versions<TradeAuth, T0>(arg1, arg0, arg2, v1, 1);
    }

    public entry fun unregister<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::unregister_extension<TradeAuth>(arg0, arg2);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::unregister_extension<TradeAuth, T0>(arg1, arg0, arg2);
    }

    // decompiled from Move bytecode v7
}

