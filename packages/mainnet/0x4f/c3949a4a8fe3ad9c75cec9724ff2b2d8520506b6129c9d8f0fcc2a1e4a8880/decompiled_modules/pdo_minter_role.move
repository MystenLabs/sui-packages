module 0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo_minter_role {
    struct PDO_MINTER_ROLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDO_MINTER_ROLE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::AdminCap<PDO_MINTER_ROLE>>(0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::create_role<PDO_MINTER_ROLE>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

