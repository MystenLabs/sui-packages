module 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::setup {
    struct DeployerCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun init_and_share_state(arg0: DeployerCap, arg1: 0x2::package::UpgradeCap, arg2: u64, arg3: u64, arg4: 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::data_source::DataSource, arg5: vector<0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::data_source::DataSource>, arg6: &mut 0x2::tx_context::TxContext) {
        0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::package_utils::assert_package_upgrade_cap<DeployerCap>(&arg1, 0x2::package::compatible_policy(), 1);
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_share_object<0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::state::State>(0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::state::new(arg1, arg5, arg4, arg2, arg3, arg6));
    }

    // decompiled from Move bytecode v7
}

