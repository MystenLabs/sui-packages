module 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::init {
    public entry fun init_movecoin<T0: drop>(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::TickRecordV2, arg1: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::InitTreasuryArgs<T0>) {
        abort 0
    }

    public entry fun init_protocol(arg0: &mut 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::DeployRecord, arg1: &mut 0x2::tx_context::TxContext) {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::tick_factory::deploy_tick_tick(arg0, arg1);
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::epoch_bus_factory::deploy_move_tick(arg0, arg1);
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::name_factory::deploy_name_tick(arg0, arg1);
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::mint_get_factory::deploy_test_tick(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

