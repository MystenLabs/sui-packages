module 0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::entry {
    entry fun accept_ownership<T0>(arg0: &mut 0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::treasury::Treasury<T0>, arg1: &0x2::tx_context::TxContext) {
        0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::treasury::assert_is_compatible<T0>(arg0);
        0xbd4c85cadfe1b0ff08ee8f32a2f9bafc3936c0e2e4f70ac3c8efb76a060bccbb::two_step_role::accept_role<0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::roles::OwnerRole<T0>>(0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::roles::owner_role_mut<T0>(0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::treasury::roles_mut<T0>(arg0)), arg1);
    }

    entry fun transfer_ownership<T0>(arg0: &mut 0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::treasury::assert_is_compatible<T0>(arg0);
        0xbd4c85cadfe1b0ff08ee8f32a2f9bafc3936c0e2e4f70ac3c8efb76a060bccbb::two_step_role::begin_role_transfer<0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::roles::OwnerRole<T0>>(0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::roles::owner_role_mut<T0>(0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::treasury::roles_mut<T0>(arg0)), arg1, arg2);
    }

    entry fun update_blocklister<T0>(arg0: &mut 0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::treasury::assert_is_compatible<T0>(arg0);
        0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::roles::update_blocklister<T0>(0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_master_minter<T0>(arg0: &mut 0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::treasury::assert_is_compatible<T0>(arg0);
        0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::roles::update_master_minter<T0>(0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_metadata_updater<T0>(arg0: &mut 0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::treasury::assert_is_compatible<T0>(arg0);
        0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::roles::update_metadata_updater<T0>(0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_pauser<T0>(arg0: &mut 0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::treasury::assert_is_compatible<T0>(arg0);
        0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::roles::update_pauser<T0>(0x3c14bf12288b9705924ec84a914a66faa27ec1057604e47f7ce99a55236577a0::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

