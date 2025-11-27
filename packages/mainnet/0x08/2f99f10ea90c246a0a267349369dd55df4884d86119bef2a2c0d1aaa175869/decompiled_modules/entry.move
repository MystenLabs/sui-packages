module 0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::entry {
    entry fun accept_ownership<T0>(arg0: &mut 0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::treasury::Treasury<T0>, arg1: &0x2::tx_context::TxContext) {
        0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::treasury::assert_is_compatible<T0>(arg0);
        0xce0ca45b2ed62ad74b50ce0d6bbf94dfb20b4eeca4d72977e8d3fc800502bd08::two_step_role::accept_role<0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::roles::OwnerRole<T0>>(0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::roles::owner_role_mut<T0>(0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::treasury::roles_mut<T0>(arg0)), arg1);
    }

    entry fun transfer_ownership<T0>(arg0: &mut 0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::treasury::assert_is_compatible<T0>(arg0);
        0xce0ca45b2ed62ad74b50ce0d6bbf94dfb20b4eeca4d72977e8d3fc800502bd08::two_step_role::begin_role_transfer<0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::roles::OwnerRole<T0>>(0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::roles::owner_role_mut<T0>(0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::treasury::roles_mut<T0>(arg0)), arg1, arg2);
    }

    entry fun update_blocklister<T0>(arg0: &mut 0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::treasury::assert_is_compatible<T0>(arg0);
        0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::roles::update_blocklister<T0>(0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_master_minter<T0>(arg0: &mut 0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::treasury::assert_is_compatible<T0>(arg0);
        0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::roles::update_master_minter<T0>(0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_metadata_updater<T0>(arg0: &mut 0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::treasury::assert_is_compatible<T0>(arg0);
        0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::roles::update_metadata_updater<T0>(0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_pauser<T0>(arg0: &mut 0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::treasury::assert_is_compatible<T0>(arg0);
        0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::roles::update_pauser<T0>(0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

