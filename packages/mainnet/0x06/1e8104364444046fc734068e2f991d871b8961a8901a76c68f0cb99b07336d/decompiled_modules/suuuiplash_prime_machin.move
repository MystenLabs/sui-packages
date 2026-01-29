module 0x61e8104364444046fc734068e2f991d871b8961a8901a76c68f0cb99b07336d::suuuiplash_prime_machin {
    struct SUUUIPLASH_PRIME_MACHIN has drop {
        dummy_field: bool,
    }

    struct Hatchling {
        dummy_field: bool,
    }

    fun init(arg0: SUUUIPLASH_PRIME_MACHIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xbdde946e259608ec41f29bf24bca40c7fa195bf618d6a4f95ca6b1328320831a::nonfungible::NftTicket<Hatchling>>(0xbdde946e259608ec41f29bf24bca40c7fa195bf618d6a4f95ca6b1328320831a::nonfungible::claim_ticket<SUUUIPLASH_PRIME_MACHIN, Hatchling>(arg0, 0x1::option::none<u32>(), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

