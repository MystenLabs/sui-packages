module 0x7647efebba2627670463fa7aee1568ca0c1efa0069db86b4ed8998e03e69356c::calculate_swift_fee {
    struct SwiftInitParams has drop {
        fee_rate_mayan: u8,
    }

    public fun calculate_swift_fee(arg0: &0x7647efebba2627670463fa7aee1568ca0c1efa0069db86b4ed8998e03e69356c::state::FeeManagerState, arg1: &mut 0x2::tx_context::TxContext) : SwiftInitParams {
        0x7647efebba2627670463fa7aee1568ca0c1efa0069db86b4ed8998e03e69356c::state::assert_valid_version(arg0);
        SwiftInitParams{fee_rate_mayan: 6}
    }

    public fun unpack_swift_init_params(arg0: SwiftInitParams) : u8 {
        arg0.fee_rate_mayan
    }

    // decompiled from Move bytecode v6
}

