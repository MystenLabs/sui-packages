module 0x6101835e1df12852440c3ad3f079130e31702fe201eb1e3b77d141a0c6a58539::memez {
    struct MEMEZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEZ, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::ACL<MEMEZ>>(0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::new<MEMEZ>(&arg0, 7, 0x2::tx_context::sender(arg1), arg1));
        0x2::package::claim_and_keep<MEMEZ>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

