module 0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_authority {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct AuctionOperatorCap has key {
        id: 0x2::object::UID,
    }

    struct AuctionManagerCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun issue_auction_manager(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AuctionManagerCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<AuctionManagerCap>(v0, arg1);
    }

    entry fun issue_operator_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AuctionOperatorCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<AuctionOperatorCap>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

