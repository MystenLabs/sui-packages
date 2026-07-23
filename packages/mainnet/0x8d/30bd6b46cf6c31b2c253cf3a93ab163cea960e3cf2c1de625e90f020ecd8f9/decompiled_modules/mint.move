module 0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::mint {
    public fun burn_jetpack(arg0: &0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::admin::AdminCap, arg1: &mut 0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::admin::JetpackCounter, arg2: 0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::jetpack::JetpackConso, arg3: &0x2::tx_context::TxContext) {
        0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::admin::clear_mint(arg1, 0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::jetpack::player(&arg2));
        0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::events::emit_jetpack_burned(0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::jetpack::jetpack_id(&arg2), 0x2::object::id<0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::jetpack::JetpackConso>(&arg2), 0x2::tx_context::sender(arg3));
        0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::jetpack::destroy(arg2);
    }

    public fun mint_jetpack(arg0: &0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::admin::AdminCap, arg1: &mut 0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::admin::JetpackCounter, arg2: address, arg3: 0x1::option::Option<0x1::string::String>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::option::Option<0x1::string::String>, arg11: vector<0x1::string::String>, arg12: vector<0x1::string::String>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(!0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::admin::has_minted(arg1, arg2), 1);
        let v0 = 0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::admin::next_jetpack_id(arg1);
        0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::admin::record_mint(arg1, arg2, v0);
        let v1 = 0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::jetpack::new(v0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::events::emit_jetpack_minted(v0, 0x2::object::id<0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::jetpack::JetpackConso>(&v1), arg2, arg4, arg5, arg6, arg7, *0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::jetpack::character(&v1), *0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::jetpack::jetpack_type(&v1));
        0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::jetpack::transfer_to(v1, arg2);
    }

    public fun update_metadata_uri(arg0: &0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::admin::AdminCap, arg1: &mut 0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::jetpack::JetpackConso, arg2: 0x1::string::String, arg3: &0x2::clock::Clock) {
        0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::jetpack::set_metadata_uri(arg1, arg2, 0x2::clock::timestamp_ms(arg3));
    }

    // decompiled from Move bytecode v7
}

