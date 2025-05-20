module 0xa1ebef7e0f2c4e5410314082f9bbae3e45b8ed217804579c20fdad9187a6d642::dov_safu {
    struct DOV_SAFU has drop {
        dummy_field: bool,
    }

    struct VERSION has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOV_SAFU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::issue_version<DOV_SAFU, VERSION>(&arg0, v0, arg1);
    }

    // decompiled from Move bytecode v6
}

