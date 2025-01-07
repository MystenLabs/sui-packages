module 0x6a8b5f10dff913b0c03154a11a1094709ee8f2f85716bd560579f929235ab241::minter_role {
    struct MINTER_ROLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINTER_ROLE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x8e50ef1d7caceed350eb95d69a9fbc01fd094286e819bf570a9fa5248ae05431::access_control::AdminCap<MINTER_ROLE>>(0x8e50ef1d7caceed350eb95d69a9fbc01fd094286e819bf570a9fa5248ae05431::access_control::create_role<MINTER_ROLE>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

