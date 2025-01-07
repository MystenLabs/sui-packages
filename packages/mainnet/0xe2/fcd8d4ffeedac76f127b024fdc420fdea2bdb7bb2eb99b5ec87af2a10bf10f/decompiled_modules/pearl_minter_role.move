module 0xe2fcd8d4ffeedac76f127b024fdc420fdea2bdb7bb2eb99b5ec87af2a10bf10f::pearl_minter_role {
    struct PEARL_MINTER_ROLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEARL_MINTER_ROLE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x25bd36e9963b8f1687d5f6c39678cb846032cfe2cc89def86bc7491083b52269::access_control::AdminCap<PEARL_MINTER_ROLE>>(0x25bd36e9963b8f1687d5f6c39678cb846032cfe2cc89def86bc7491083b52269::access_control::create_role<PEARL_MINTER_ROLE>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

