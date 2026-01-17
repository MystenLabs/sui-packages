module 0x3ca5f1fefdc3062532927bc54c7b30d60e16ce10e6bdb93e0b91f173be6437f6::membership {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Whitelist has key {
        id: 0x2::object::UID,
        members: 0x2::table::Table<address, bool>,
    }

    struct MemberNFT has key {
        id: 0x2::object::UID,
    }

    public entry fun add_to_whitelist(arg0: &AdminCap, arg1: &mut Whitelist, arg2: address) {
        0x2::table::add<address, bool>(&mut arg1.members, arg2, true);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Whitelist{
            id      : 0x2::object::new(arg0),
            members : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<Whitelist>(v1);
    }

    public entry fun mint_membership(arg0: &Whitelist, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, bool>(&arg0.members, v0), 0);
        let v1 = MemberNFT{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MemberNFT>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

