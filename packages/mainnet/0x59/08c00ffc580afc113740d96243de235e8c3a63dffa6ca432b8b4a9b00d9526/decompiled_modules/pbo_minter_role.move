module 0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo_minter_role {
    struct PBO_MINTER_ROLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PBO_MINTER_ROLE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::AdminCap<PBO_MINTER_ROLE>>(0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::create_role<PBO_MINTER_ROLE>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

