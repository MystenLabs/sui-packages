module 0xd477d53db5a70955a692e65f7fa9ebe8e795f75910f8f2f7883ebe086a0670c0::owner {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct FundCap has store, key {
        id: 0x2::object::UID,
    }

    public fun add_fundcap(arg0: &OwnerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = FundCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<FundCap>(v0, arg1);
    }

    public fun add_guardian(arg0: &OwnerCap, arg1: &mut 0xd477d53db5a70955a692e65f7fa9ebe8e795f75910f8f2f7883ebe086a0670c0::state::State, arg2: u64, arg3: address) {
        0xd477d53db5a70955a692e65f7fa9ebe8e795f75910f8f2f7883ebe086a0670c0::state::add_guardian(arg1, arg2, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::from_address(arg3));
    }

    public fun create_state(arg0: &mut OwnerCap, arg1: 0x2::package::UpgradeCap, arg2: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"create_state"), 0);
        0x2::dynamic_field::remove<vector<u8>, bool>(&mut arg0.id, b"create_state");
        0x2::package::make_immutable(arg1);
        0x2::transfer::public_share_object<0xd477d53db5a70955a692e65f7fa9ebe8e795f75910f8f2f7883ebe086a0670c0::state::State>(0xd477d53db5a70955a692e65f7fa9ebe8e795f75910f8f2f7883ebe086a0670c0::state::new(arg2, arg3, arg4, arg5));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::dynamic_field::add<vector<u8>, bool>(&mut v0.id, b"create_state", true);
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun register_foreign_contract(arg0: &OwnerCap, arg1: &mut 0xd477d53db5a70955a692e65f7fa9ebe8e795f75910f8f2f7883ebe086a0670c0::state::State, arg2: u16, arg3: address) {
        0xd477d53db5a70955a692e65f7fa9ebe8e795f75910f8f2f7883ebe086a0670c0::state::register_foreign_contract(arg1, arg2, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::from_address(arg3));
    }

    public fun update_relayer_fee(arg0: &OwnerCap, arg1: &mut 0xd477d53db5a70955a692e65f7fa9ebe8e795f75910f8f2f7883ebe086a0670c0::state::State, arg2: u64, arg3: u64) {
        0xd477d53db5a70955a692e65f7fa9ebe8e795f75910f8f2f7883ebe086a0670c0::state::update_relayer_fee(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

