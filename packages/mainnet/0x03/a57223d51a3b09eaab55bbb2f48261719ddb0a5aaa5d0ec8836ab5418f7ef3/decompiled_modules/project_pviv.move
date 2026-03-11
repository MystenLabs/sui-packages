module 0x3a57223d51a3b09eaab55bbb2f48261719ddb0a5aaa5d0ec8836ab5418f7ef3::project_pviv {
    struct PROJECT_PVIV has drop {
        dummy_field: bool,
    }

    struct ConvertibleCharacter {
        dummy_field: bool,
    }

    fun init(arg0: PROJECT_PVIV, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xbdde946e259608ec41f29bf24bca40c7fa195bf618d6a4f95ca6b1328320831a::nonfungible::NftTicket<ConvertibleCharacter>>(0xbdde946e259608ec41f29bf24bca40c7fa195bf618d6a4f95ca6b1328320831a::nonfungible::claim_ticket<PROJECT_PVIV, ConvertibleCharacter>(arg0, 0x1::option::none<u32>(), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

