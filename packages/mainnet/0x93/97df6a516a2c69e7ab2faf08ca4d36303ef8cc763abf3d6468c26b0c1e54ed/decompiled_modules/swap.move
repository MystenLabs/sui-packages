module 0x9397df6a516a2c69e7ab2faf08ca4d36303ef8cc763abf3d6468c26b0c1e54ed::swap {
    public fun add_swap_route<T0, T1, T2>(arg0: &0x9397df6a516a2c69e7ab2faf08ca4d36303ef8cc763abf3d6468c26b0c1e54ed::vault::VaultCap, arg1: &mut 0x9397df6a516a2c69e7ab2faf08ca4d36303ef8cc763abf3d6468c26b0c1e54ed::vault::Vault<T0, T1, T2>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>, arg3: &0x9397df6a516a2c69e7ab2faf08ca4d36303ef8cc763abf3d6468c26b0c1e54ed::version::Version) {
        0x9397df6a516a2c69e7ab2faf08ca4d36303ef8cc763abf3d6468c26b0c1e54ed::version::assert_current_version(arg3);
        0x9397df6a516a2c69e7ab2faf08ca4d36303ef8cc763abf3d6468c26b0c1e54ed::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0x9397df6a516a2c69e7ab2faf08ca4d36303ef8cc763abf3d6468c26b0c1e54ed::vault::add_swap_route<T0, T1, T2>(arg1, arg2);
    }

    public fun remove_swap_route<T0, T1, T2>(arg0: &0x9397df6a516a2c69e7ab2faf08ca4d36303ef8cc763abf3d6468c26b0c1e54ed::vault::VaultCap, arg1: &mut 0x9397df6a516a2c69e7ab2faf08ca4d36303ef8cc763abf3d6468c26b0c1e54ed::vault::Vault<T0, T1, T2>, arg2: &0x9397df6a516a2c69e7ab2faf08ca4d36303ef8cc763abf3d6468c26b0c1e54ed::version::Version) {
        0x9397df6a516a2c69e7ab2faf08ca4d36303ef8cc763abf3d6468c26b0c1e54ed::version::assert_current_version(arg2);
        0x9397df6a516a2c69e7ab2faf08ca4d36303ef8cc763abf3d6468c26b0c1e54ed::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0x9397df6a516a2c69e7ab2faf08ca4d36303ef8cc763abf3d6468c26b0c1e54ed::vault::remove_swap_route<T0, T1, T2>(arg1);
    }

    // decompiled from Move bytecode v6
}

