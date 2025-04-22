module 0x18b7339d1c28020b6fd08222eff7d339d542460ba977672d5a6556b2900e017a::owner {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    public fun create_state(arg0: &mut OwnerCap, arg1: 0x2::package::UpgradeCap, arg2: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"create_state"), 0);
        0x2::dynamic_field::remove<vector<u8>, bool>(&mut arg0.id, b"create_state");
        0x2::package::make_immutable(arg1);
        0x2::transfer::public_share_object<0x18b7339d1c28020b6fd08222eff7d339d542460ba977672d5a6556b2900e017a::state::State>(0x18b7339d1c28020b6fd08222eff7d339d542460ba977672d5a6556b2900e017a::state::new(arg2, arg3, arg4, arg5));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::dynamic_field::add<vector<u8>, bool>(&mut v0.id, b"create_state", true);
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun register_foreign_contract(arg0: &OwnerCap, arg1: &mut 0x18b7339d1c28020b6fd08222eff7d339d542460ba977672d5a6556b2900e017a::state::State, arg2: u16, arg3: address) {
        0x18b7339d1c28020b6fd08222eff7d339d542460ba977672d5a6556b2900e017a::state::register_foreign_contract(arg1, arg2, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::from_address(arg3));
    }

    public fun update_relayer_fee(arg0: &OwnerCap, arg1: &mut 0x18b7339d1c28020b6fd08222eff7d339d542460ba977672d5a6556b2900e017a::state::State, arg2: u64, arg3: u64) {
        0x18b7339d1c28020b6fd08222eff7d339d542460ba977672d5a6556b2900e017a::state::update_relayer_fee(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

