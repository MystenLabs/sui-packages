module 0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::entry {
    entry fun accept_ownership<T0>(arg0: &mut 0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::treasury::Treasury<T0>, arg1: &0x2::tx_context::TxContext) {
        0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::treasury::assert_is_compatible<T0>(arg0);
        0x795f9c96e043c7ad2f5789d19e21e6768962b5c846ba4ade8910b00e8ea9c347::two_step_role::accept_role<0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::roles::OwnerRole<T0>>(0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::roles::owner_role_mut<T0>(0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::treasury::roles_mut<T0>(arg0)), arg1);
    }

    entry fun transfer_ownership<T0>(arg0: &mut 0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::treasury::assert_is_compatible<T0>(arg0);
        0x795f9c96e043c7ad2f5789d19e21e6768962b5c846ba4ade8910b00e8ea9c347::two_step_role::begin_role_transfer<0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::roles::OwnerRole<T0>>(0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::roles::owner_role_mut<T0>(0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::treasury::roles_mut<T0>(arg0)), arg1, arg2);
    }

    entry fun update_blocklister<T0>(arg0: &mut 0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::treasury::assert_is_compatible<T0>(arg0);
        0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::roles::update_blocklister<T0>(0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_master_minter<T0>(arg0: &mut 0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::treasury::assert_is_compatible<T0>(arg0);
        0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::roles::update_master_minter<T0>(0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_metadata_updater<T0>(arg0: &mut 0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::treasury::assert_is_compatible<T0>(arg0);
        0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::roles::update_metadata_updater<T0>(0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    entry fun update_pauser<T0>(arg0: &mut 0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::treasury::Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::treasury::assert_is_compatible<T0>(arg0);
        0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::roles::update_pauser<T0>(0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::treasury::roles_mut<T0>(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

