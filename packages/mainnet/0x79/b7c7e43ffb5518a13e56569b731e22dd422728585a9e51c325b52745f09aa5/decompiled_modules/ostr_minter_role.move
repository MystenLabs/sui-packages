module 0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_minter_role {
    struct OSTR_MINTER_ROLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSTR_MINTER_ROLE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x25bd36e9963b8f1687d5f6c39678cb846032cfe2cc89def86bc7491083b52269::access_control::AdminCap<OSTR_MINTER_ROLE>>(0x25bd36e9963b8f1687d5f6c39678cb846032cfe2cc89def86bc7491083b52269::access_control::create_role<OSTR_MINTER_ROLE>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

