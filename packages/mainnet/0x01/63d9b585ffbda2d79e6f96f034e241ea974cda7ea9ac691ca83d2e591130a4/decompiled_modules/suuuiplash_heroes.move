module 0x163d9b585ffbda2d79e6f96f034e241ea974cda7ea9ac691ca83d2e591130a4::suuuiplash_heroes {
    struct SUUUIPLASH_HEROES has drop {
        dummy_field: bool,
    }

    struct Hero {
        dummy_field: bool,
    }

    fun init(arg0: SUUUIPLASH_HEROES, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xbdde946e259608ec41f29bf24bca40c7fa195bf618d6a4f95ca6b1328320831a::nonfungible::NftTicket<Hero>>(0xbdde946e259608ec41f29bf24bca40c7fa195bf618d6a4f95ca6b1328320831a::nonfungible::claim_ticket<SUUUIPLASH_HEROES, Hero>(arg0, 0x1::option::none<u32>(), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

