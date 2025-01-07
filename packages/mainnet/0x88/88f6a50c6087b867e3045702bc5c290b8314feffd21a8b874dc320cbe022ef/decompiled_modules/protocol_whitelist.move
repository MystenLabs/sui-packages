module 0x8888f6a50c6087b867e3045702bc5c290b8314feffd21a8b874dc320cbe022ef::protocol_whitelist {
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

    public fun add_whitelist_address(arg0: &0x2::package::Publisher, arg1: &mut 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::Market, arg2: address) {
        if (0x6e171d54f0023133c32bfa86ada020ec45c949c765ef37823fa7135f784362b::whitelist::in_whitelist(0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::uid(arg1), arg2)) {
            return
        };
        0x6e171d54f0023133c32bfa86ada020ec45c949c765ef37823fa7135f784362b::whitelist::add_whitelist_address(0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::uid_mut_delegated(arg1, 0xfa705ad96c3a6b13219de853dbf4389e6e4771c0719432b9575607ad0d7cfea9::witness::from_publisher<0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::Market>(arg0)), arg2);
        let v0 = 0x2::object::id<0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::Market>(arg1);
        let v1 = ScallopWhitelistAdded{
            address : arg2,
            market  : 0x2::object::id_to_address(&v0),
        };
        0x2::event::emit<ScallopWhitelistAdded>(v1);
    }

    public fun allow_all(arg0: &0x2::package::Publisher, arg1: &mut 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::Market) {
        if (0x6e171d54f0023133c32bfa86ada020ec45c949c765ef37823fa7135f784362b::whitelist::is_allow_all(0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::uid(arg1))) {
            return
        };
        0x6e171d54f0023133c32bfa86ada020ec45c949c765ef37823fa7135f784362b::whitelist::allow_all(0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::uid_mut_delegated(arg1, 0xfa705ad96c3a6b13219de853dbf4389e6e4771c0719432b9575607ad0d7cfea9::witness::from_publisher<0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::Market>(arg0)));
        let v0 = 0x2::object::id<0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::Market>(arg1);
        let v1 = ScallopWhitelistAllowAll{market: 0x2::object::id_to_address(&v0)};
        0x2::event::emit<ScallopWhitelistAllowAll>(v1);
    }

    public fun reject_all(arg0: &0x2::package::Publisher, arg1: &mut 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::Market) {
        if (0x6e171d54f0023133c32bfa86ada020ec45c949c765ef37823fa7135f784362b::whitelist::is_reject_all(0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::uid(arg1))) {
            return
        };
        0x6e171d54f0023133c32bfa86ada020ec45c949c765ef37823fa7135f784362b::whitelist::reject_all(0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::uid_mut_delegated(arg1, 0xfa705ad96c3a6b13219de853dbf4389e6e4771c0719432b9575607ad0d7cfea9::witness::from_publisher<0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::Market>(arg0)));
        let v0 = 0x2::object::id<0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::Market>(arg1);
        let v1 = ScallopWhitelistRejectAll{market: 0x2::object::id_to_address(&v0)};
        0x2::event::emit<ScallopWhitelistRejectAll>(v1);
    }

    public fun remove_whitelist_address(arg0: &0x2::package::Publisher, arg1: &mut 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::Market, arg2: address) {
        if (0x6e171d54f0023133c32bfa86ada020ec45c949c765ef37823fa7135f784362b::whitelist::in_whitelist(0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::uid(arg1), arg2) == false) {
            return
        };
        0x6e171d54f0023133c32bfa86ada020ec45c949c765ef37823fa7135f784362b::whitelist::remove_whitelist_address(0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::uid_mut_delegated(arg1, 0xfa705ad96c3a6b13219de853dbf4389e6e4771c0719432b9575607ad0d7cfea9::witness::from_publisher<0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::Market>(arg0)), arg2);
        let v0 = 0x2::object::id<0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::Market>(arg1);
        let v1 = ScallopWhitelistRemoved{
            address : arg2,
            market  : 0x2::object::id_to_address(&v0),
        };
        0x2::event::emit<ScallopWhitelistRemoved>(v1);
    }

    public fun switch_to_whitelist_mode(arg0: &0x2::package::Publisher, arg1: &mut 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::Market) {
        0x6e171d54f0023133c32bfa86ada020ec45c949c765ef37823fa7135f784362b::whitelist::switch_to_whitelist_mode(0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::uid_mut_delegated(arg1, 0xfa705ad96c3a6b13219de853dbf4389e6e4771c0719432b9575607ad0d7cfea9::witness::from_publisher<0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::Market>(arg0)));
    }

    // decompiled from Move bytecode v6
}

