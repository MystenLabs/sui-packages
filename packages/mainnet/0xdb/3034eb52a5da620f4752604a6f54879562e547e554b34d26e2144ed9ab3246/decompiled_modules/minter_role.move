module 0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::minter_role {
    struct MINTER_ROLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINTER_ROLE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9145333f34ed7fab143bffc5622632892c3e742c7fd6c3f0679a2d67bb42e5e1::access_control::AdminCap<MINTER_ROLE>>(0x9145333f34ed7fab143bffc5622632892c3e742c7fd6c3f0679a2d67bb42e5e1::access_control::create_role<MINTER_ROLE>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

