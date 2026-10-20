module 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth {
    struct TradeAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun issue(arg0: &0x2::object::UID) : 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth {
        let v0 = TradeAuth{dummy_field: false};
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::issue<TradeAuth>(v0, arg0)
    }

    public entry fun register<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::register_extension<TradeAuth>(arg0, arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::register_extension<TradeAuth, T0>(arg1, arg0, arg2);
    }

    public entry fun unregister<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::unregister_extension<TradeAuth>(arg0, arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::unregister_extension<TradeAuth, T0>(arg1, arg0, arg2);
    }

    // decompiled from Move bytecode v7
}

