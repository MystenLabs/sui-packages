module 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::setup {
    struct DeployerCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun init_and_share_state(arg0: DeployerCap, arg1: 0x2::package::UpgradeCap, arg2: u64, arg3: u64, arg4: 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::data_source::DataSource, arg5: vector<0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::data_source::DataSource>, arg6: &mut 0x2::tx_context::TxContext) {
        0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::package_utils::assert_package_upgrade_cap<DeployerCap>(&arg1, 0x2::package::compatible_policy(), 1);
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_share_object<0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::State>(0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::new(arg1, arg5, arg4, arg2, arg3, arg6));
    }

    // decompiled from Move bytecode v6
}

