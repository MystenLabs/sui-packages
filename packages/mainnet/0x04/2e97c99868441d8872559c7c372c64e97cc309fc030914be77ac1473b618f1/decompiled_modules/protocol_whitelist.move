module 0x42e97c99868441d8872559c7c372c64e97cc309fc030914be77ac1473b618f1::protocol_whitelist {
    struct ScallopWhitelistAdded has copy, drop {
        address: address,
        market: address,
    }

    struct ScallopWhitelistRemoved has copy, drop {
        address: address,
        market: address,
    }

    struct ScallopWhitelistAllowAll has copy, drop {
        market: address,
    }

    struct ScallopWhitelistRejectAll has copy, drop {
        market: address,
    }

    public fun add_whitelist_address(arg0: &0x2::package::Publisher, arg1: &mut 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::Market, arg2: address) {
        if (0x1318fdc90319ec9c24df1456d960a447521b0a658316155895014a6e39b5482f::whitelist::in_whitelist(0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::uid(arg1), arg2)) {
            return
        };
        0x1318fdc90319ec9c24df1456d960a447521b0a658316155895014a6e39b5482f::whitelist::add_whitelist_address(0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::uid_mut_delegated(arg1, 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::witness::from_publisher<0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::Market>(arg0)), arg2);
        let v0 = 0x2::object::id<0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::Market>(arg1);
        let v1 = ScallopWhitelistAdded{
            address : arg2,
            market  : 0x2::object::id_to_address(&v0),
        };
        0x2::event::emit<ScallopWhitelistAdded>(v1);
    }

    public fun allow_all(arg0: &0x2::package::Publisher, arg1: &mut 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::Market) {
        if (0x1318fdc90319ec9c24df1456d960a447521b0a658316155895014a6e39b5482f::whitelist::is_allow_all(0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::uid(arg1))) {
            return
        };
        0x1318fdc90319ec9c24df1456d960a447521b0a658316155895014a6e39b5482f::whitelist::allow_all(0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::uid_mut_delegated(arg1, 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::witness::from_publisher<0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::Market>(arg0)));
        let v0 = 0x2::object::id<0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::Market>(arg1);
        let v1 = ScallopWhitelistAllowAll{market: 0x2::object::id_to_address(&v0)};
        0x2::event::emit<ScallopWhitelistAllowAll>(v1);
    }

    public fun reject_all(arg0: &0x2::package::Publisher, arg1: &mut 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::Market) {
        if (0x1318fdc90319ec9c24df1456d960a447521b0a658316155895014a6e39b5482f::whitelist::is_reject_all(0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::uid(arg1))) {
            return
        };
        0x1318fdc90319ec9c24df1456d960a447521b0a658316155895014a6e39b5482f::whitelist::reject_all(0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::uid_mut_delegated(arg1, 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::witness::from_publisher<0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::Market>(arg0)));
        let v0 = 0x2::object::id<0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::Market>(arg1);
        let v1 = ScallopWhitelistRejectAll{market: 0x2::object::id_to_address(&v0)};
        0x2::event::emit<ScallopWhitelistRejectAll>(v1);
    }

    public fun remove_whitelist_address(arg0: &0x2::package::Publisher, arg1: &mut 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::Market, arg2: address) {
        if (0x1318fdc90319ec9c24df1456d960a447521b0a658316155895014a6e39b5482f::whitelist::in_whitelist(0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::uid(arg1), arg2) == false) {
            return
        };
        0x1318fdc90319ec9c24df1456d960a447521b0a658316155895014a6e39b5482f::whitelist::remove_whitelist_address(0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::uid_mut_delegated(arg1, 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::witness::from_publisher<0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::Market>(arg0)), arg2);
        let v0 = 0x2::object::id<0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::Market>(arg1);
        let v1 = ScallopWhitelistRemoved{
            address : arg2,
            market  : 0x2::object::id_to_address(&v0),
        };
        0x2::event::emit<ScallopWhitelistRemoved>(v1);
    }

    public fun switch_to_whitelist_mode(arg0: &0x2::package::Publisher, arg1: &mut 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::Market) {
        0x1318fdc90319ec9c24df1456d960a447521b0a658316155895014a6e39b5482f::whitelist::switch_to_whitelist_mode(0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::uid_mut_delegated(arg1, 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::witness::from_publisher<0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::Market>(arg0)));
    }

    // decompiled from Move bytecode v6
}

