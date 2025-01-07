module 0x8d81a4bdf0b0c09407bd898f4933b5adbaf46f2c82e279b92f380035fd8285d::protocol_whitelist {
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

    public fun add_whitelist_address(arg0: &0x2::package::Publisher, arg1: &mut 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::Market, arg2: address) {
        if (0x7f57ec0d4321030acd3f97911411ad73ac456d2c56775016348bd159c9c8c163::whitelist::in_whitelist(0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::uid(arg1), arg2)) {
            return
        };
        0x7f57ec0d4321030acd3f97911411ad73ac456d2c56775016348bd159c9c8c163::whitelist::add_whitelist_address(0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::uid_mut_delegated(arg1, 0x59d41e24d4eba6fa35cbc12710cf2dce817cdeb2ed9c1798339e1add6e7d94d6::witness::from_publisher<0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::Market>(arg0)), arg2);
        let v0 = 0x2::object::id<0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::Market>(arg1);
        let v1 = ScallopWhitelistAdded{
            address : arg2,
            market  : 0x2::object::id_to_address(&v0),
        };
        0x2::event::emit<ScallopWhitelistAdded>(v1);
    }

    public fun allow_all(arg0: &0x2::package::Publisher, arg1: &mut 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::Market) {
        if (0x7f57ec0d4321030acd3f97911411ad73ac456d2c56775016348bd159c9c8c163::whitelist::is_allow_all(0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::uid(arg1))) {
            return
        };
        0x7f57ec0d4321030acd3f97911411ad73ac456d2c56775016348bd159c9c8c163::whitelist::allow_all(0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::uid_mut_delegated(arg1, 0x59d41e24d4eba6fa35cbc12710cf2dce817cdeb2ed9c1798339e1add6e7d94d6::witness::from_publisher<0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::Market>(arg0)));
        let v0 = 0x2::object::id<0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::Market>(arg1);
        let v1 = ScallopWhitelistAllowAll{market: 0x2::object::id_to_address(&v0)};
        0x2::event::emit<ScallopWhitelistAllowAll>(v1);
    }

    public fun reject_all(arg0: &0x2::package::Publisher, arg1: &mut 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::Market) {
        if (0x7f57ec0d4321030acd3f97911411ad73ac456d2c56775016348bd159c9c8c163::whitelist::is_reject_all(0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::uid(arg1))) {
            return
        };
        0x7f57ec0d4321030acd3f97911411ad73ac456d2c56775016348bd159c9c8c163::whitelist::reject_all(0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::uid_mut_delegated(arg1, 0x59d41e24d4eba6fa35cbc12710cf2dce817cdeb2ed9c1798339e1add6e7d94d6::witness::from_publisher<0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::Market>(arg0)));
        let v0 = 0x2::object::id<0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::Market>(arg1);
        let v1 = ScallopWhitelistRejectAll{market: 0x2::object::id_to_address(&v0)};
        0x2::event::emit<ScallopWhitelistRejectAll>(v1);
    }

    public fun remove_whitelist_address(arg0: &0x2::package::Publisher, arg1: &mut 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::Market, arg2: address) {
        if (0x7f57ec0d4321030acd3f97911411ad73ac456d2c56775016348bd159c9c8c163::whitelist::in_whitelist(0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::uid(arg1), arg2) == false) {
            return
        };
        0x7f57ec0d4321030acd3f97911411ad73ac456d2c56775016348bd159c9c8c163::whitelist::remove_whitelist_address(0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::uid_mut_delegated(arg1, 0x59d41e24d4eba6fa35cbc12710cf2dce817cdeb2ed9c1798339e1add6e7d94d6::witness::from_publisher<0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::Market>(arg0)), arg2);
        let v0 = 0x2::object::id<0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::Market>(arg1);
        let v1 = ScallopWhitelistRemoved{
            address : arg2,
            market  : 0x2::object::id_to_address(&v0),
        };
        0x2::event::emit<ScallopWhitelistRemoved>(v1);
    }

    public fun switch_to_whitelist_mode(arg0: &0x2::package::Publisher, arg1: &mut 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::Market) {
        0x7f57ec0d4321030acd3f97911411ad73ac456d2c56775016348bd159c9c8c163::whitelist::switch_to_whitelist_mode(0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::uid_mut_delegated(arg1, 0x59d41e24d4eba6fa35cbc12710cf2dce817cdeb2ed9c1798339e1add6e7d94d6::witness::from_publisher<0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::Market>(arg0)));
    }

    // decompiled from Move bytecode v6
}

