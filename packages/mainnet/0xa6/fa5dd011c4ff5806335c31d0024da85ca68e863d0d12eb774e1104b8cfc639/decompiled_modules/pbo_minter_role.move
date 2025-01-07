module 0xa6fa5dd011c4ff5806335c31d0024da85ca68e863d0d12eb774e1104b8cfc639::pbo_minter_role {
    struct PBO_MINTER_ROLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PBO_MINTER_ROLE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::AdminCap<PBO_MINTER_ROLE>>(0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::create_role<PBO_MINTER_ROLE>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

