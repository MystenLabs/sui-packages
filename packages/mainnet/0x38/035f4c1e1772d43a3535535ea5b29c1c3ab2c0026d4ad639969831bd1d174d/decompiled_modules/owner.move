module 0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::owner {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    public fun create_state(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &mut OwnerCap, arg2: 0x2::package::UpgradeCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"create_state"), 0);
        0x2::dynamic_field::remove<vector<u8>, bool>(&mut arg1.id, b"create_state");
        0x2::package::make_immutable(arg2);
        0x2::transfer::public_share_object<0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::state::State>(0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::state::new(arg0, 100000000, 100000000, arg3));
    }

    public fun deregister_token<T0>(arg0: &OwnerCap, arg1: &mut 0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::state::State) {
        0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::state::deregister_token<T0>(arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::dynamic_field::add<vector<u8>, bool>(&mut v0.id, b"create_state", true);
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun register_foreign_contract(arg0: &OwnerCap, arg1: &mut 0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::state::State, arg2: u16, arg3: address) {
        0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::state::register_foreign_contract(arg1, arg2, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::from_address(arg3));
    }

    public fun register_token<T0>(arg0: &OwnerCap, arg1: &mut 0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::state::State, arg2: u64, arg3: u64, arg4: bool) {
        0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::state::register_token<T0>(arg1, arg2, arg3, arg4);
    }

    public fun toggle_swap_enabled<T0>(arg0: &OwnerCap, arg1: &mut 0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::state::State, arg2: bool) {
        0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::state::toggle_swap_enabled<T0>(arg1, arg2);
    }

    public fun update_max_native_swap_amount<T0>(arg0: &OwnerCap, arg1: &mut 0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::state::State, arg2: u64) {
        0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::state::update_max_native_swap_amount<T0>(arg1, arg2);
    }

    public fun update_relayer_fee(arg0: &OwnerCap, arg1: &mut 0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::state::State, arg2: u16, arg3: u64) {
        0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::state::update_relayer_fee(arg1, arg2, arg3);
    }

    public fun update_relayer_fee_precision(arg0: &OwnerCap, arg1: &mut 0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::state::State, arg2: u64) {
        0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::state::update_relayer_fee_precision(arg1, arg2);
    }

    public fun update_swap_rate<T0>(arg0: &OwnerCap, arg1: &mut 0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::state::State, arg2: u64) {
        0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::state::update_swap_rate<T0>(arg1, arg2);
    }

    public fun update_swap_rate_precision(arg0: &OwnerCap, arg1: &mut 0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::state::State, arg2: u64) {
        0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::state::update_swap_rate_precision(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

