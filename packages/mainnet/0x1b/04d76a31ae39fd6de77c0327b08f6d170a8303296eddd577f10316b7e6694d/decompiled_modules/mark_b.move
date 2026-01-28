module 0x1b04d76a31ae39fd6de77c0327b08f6d170a8303296eddd577f10316b7e6694d::mark_b {
    struct MARK_B has drop {
        dummy_field: bool,
    }

    struct Hatchling {
        dummy_field: bool,
    }

    fun init(arg0: MARK_B, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xbdde946e259608ec41f29bf24bca40c7fa195bf618d6a4f95ca6b1328320831a::nonfungible::NftTicket<Hatchling>>(0xbdde946e259608ec41f29bf24bca40c7fa195bf618d6a4f95ca6b1328320831a::nonfungible::claim_ticket<MARK_B, Hatchling>(arg0, 0x1::option::none<u32>(), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

