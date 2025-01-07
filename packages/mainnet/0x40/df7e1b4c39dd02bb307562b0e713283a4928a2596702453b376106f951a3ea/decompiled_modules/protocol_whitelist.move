module 0x40df7e1b4c39dd02bb307562b0e713283a4928a2596702453b376106f951a3ea::protocol_whitelist {
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

    public fun add_whitelist_address(arg0: &0x2::package::Publisher, arg1: &mut 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::Market, arg2: address) {
        if (0x2da61c07dec5b60272c576ecd96a8f95e067b5e4387dc31b41ab6a12a49086db::whitelist::in_whitelist(0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::uid(arg1), arg2)) {
            return
        };
        0x2da61c07dec5b60272c576ecd96a8f95e067b5e4387dc31b41ab6a12a49086db::whitelist::add_whitelist_address(0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::uid_mut_delegated(arg1, 0xf0e5c13ef3fa79931ab95d25f9b362b732a892f44d64743ef19f6f5fadaa852a::witness::from_publisher<0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::Market>(arg0)), arg2);
        let v0 = 0x2::object::id<0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::Market>(arg1);
        let v1 = ScallopWhitelistAdded{
            address : arg2,
            market  : 0x2::object::id_to_address(&v0),
        };
        0x2::event::emit<ScallopWhitelistAdded>(v1);
    }

    public fun allow_all(arg0: &0x2::package::Publisher, arg1: &mut 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::Market) {
        if (0x2da61c07dec5b60272c576ecd96a8f95e067b5e4387dc31b41ab6a12a49086db::whitelist::is_allow_all(0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::uid(arg1))) {
            return
        };
        0x2da61c07dec5b60272c576ecd96a8f95e067b5e4387dc31b41ab6a12a49086db::whitelist::allow_all(0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::uid_mut_delegated(arg1, 0xf0e5c13ef3fa79931ab95d25f9b362b732a892f44d64743ef19f6f5fadaa852a::witness::from_publisher<0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::Market>(arg0)));
        let v0 = 0x2::object::id<0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::Market>(arg1);
        let v1 = ScallopWhitelistAllowAll{market: 0x2::object::id_to_address(&v0)};
        0x2::event::emit<ScallopWhitelistAllowAll>(v1);
    }

    public fun reject_all(arg0: &0x2::package::Publisher, arg1: &mut 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::Market) {
        if (0x2da61c07dec5b60272c576ecd96a8f95e067b5e4387dc31b41ab6a12a49086db::whitelist::is_reject_all(0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::uid(arg1))) {
            return
        };
        0x2da61c07dec5b60272c576ecd96a8f95e067b5e4387dc31b41ab6a12a49086db::whitelist::reject_all(0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::uid_mut_delegated(arg1, 0xf0e5c13ef3fa79931ab95d25f9b362b732a892f44d64743ef19f6f5fadaa852a::witness::from_publisher<0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::Market>(arg0)));
        let v0 = 0x2::object::id<0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::Market>(arg1);
        let v1 = ScallopWhitelistRejectAll{market: 0x2::object::id_to_address(&v0)};
        0x2::event::emit<ScallopWhitelistRejectAll>(v1);
    }

    public fun remove_whitelist_address(arg0: &0x2::package::Publisher, arg1: &mut 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::Market, arg2: address) {
        if (0x2da61c07dec5b60272c576ecd96a8f95e067b5e4387dc31b41ab6a12a49086db::whitelist::in_whitelist(0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::uid(arg1), arg2) == false) {
            return
        };
        0x2da61c07dec5b60272c576ecd96a8f95e067b5e4387dc31b41ab6a12a49086db::whitelist::remove_whitelist_address(0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::uid_mut_delegated(arg1, 0xf0e5c13ef3fa79931ab95d25f9b362b732a892f44d64743ef19f6f5fadaa852a::witness::from_publisher<0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::Market>(arg0)), arg2);
        let v0 = 0x2::object::id<0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::Market>(arg1);
        let v1 = ScallopWhitelistRemoved{
            address : arg2,
            market  : 0x2::object::id_to_address(&v0),
        };
        0x2::event::emit<ScallopWhitelistRemoved>(v1);
    }

    public fun switch_to_whitelist_mode(arg0: &0x2::package::Publisher, arg1: &mut 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::Market) {
        0x2da61c07dec5b60272c576ecd96a8f95e067b5e4387dc31b41ab6a12a49086db::whitelist::switch_to_whitelist_mode(0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::uid_mut_delegated(arg1, 0xf0e5c13ef3fa79931ab95d25f9b362b732a892f44d64743ef19f6f5fadaa852a::witness::from_publisher<0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::Market>(arg0)));
    }

    // decompiled from Move bytecode v6
}

