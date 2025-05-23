module 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::setup {
    struct DeployerCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun init_and_share_state(arg0: DeployerCap, arg1: 0x2::package::UpgradeCap, arg2: u64, arg3: u64, arg4: 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::data_source::DataSource, arg5: vector<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::data_source::DataSource>, arg6: &mut 0x2::tx_context::TxContext) {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::package_utils::assert_package_upgrade_cap<DeployerCap>(&arg1, 0x2::package::compatible_policy(), 1);
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_share_object<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::State>(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::new(arg1, arg5, arg4, arg2, arg3, arg6));
    }

    // decompiled from Move bytecode v6
}

