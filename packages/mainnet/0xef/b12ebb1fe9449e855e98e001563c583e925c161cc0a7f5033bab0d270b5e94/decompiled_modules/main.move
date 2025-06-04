module 0xefb12ebb1fe9449e855e98e001563c583e925c161cc0a7f5033bab0d270b5e94::main {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct WhitelistStorage has key {
        id: 0x2::object::UID,
        lawyers: 0x2::table::Table<address, bool>,
        delegates: 0x2::table::Table<address, bool>,
    }

    struct LawyerWhitelisted has copy, drop {
        lawyer_address: address,
        admin: address,
    }

    struct DelegateAdded has copy, drop {
        delegate_address: address,
        admin: address,
    }

    public entry fun add_delegate(arg0: &AdminCap, arg1: &mut WhitelistStorage, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, bool>(&arg1.delegates, arg2), 2);
        0x2::table::add<address, bool>(&mut arg1.delegates, arg2, true);
        let v0 = DelegateAdded{
            delegate_address : arg2,
            admin            : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<DelegateAdded>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = WhitelistStorage{
            id        : 0x2::object::new(arg0),
            lawyers   : 0x2::table::new<address, bool>(arg0),
            delegates : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<WhitelistStorage>(v1);
    }

    public fun is_delegate(arg0: &WhitelistStorage, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.delegates, arg1)
    }

    public fun is_whitelisted(arg0: &WhitelistStorage, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.lawyers, arg1)
    }

    public entry fun whitelist_lawyer(arg0: &AdminCap, arg1: &mut WhitelistStorage, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, bool>(&arg1.lawyers, arg2), 2);
        0x2::table::add<address, bool>(&mut arg1.lawyers, arg2, true);
        let v0 = LawyerWhitelisted{
            lawyer_address : arg2,
            admin          : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<LawyerWhitelisted>(v0);
    }

    // decompiled from Move bytecode v6
}

