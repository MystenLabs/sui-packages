module 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::setup {
    public entry fun initial_allocate<T0, T1>(arg0: &0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::admin_cap::AdminCap, arg1: &mut 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::treasury::Treasury, arg2: &mut 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::boardroom::Boardroom, arg3: &mut 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::Epoch, arg4: &mut 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::oracle::Oracle<T0, T1>, arg5: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg6: &mut 0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::TreasuryManagement, arg7: &0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Role<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo_minter_role::PDO_MINTER_ROLE>, arg8: &mut 0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo::TreasuryManagement, arg9: &0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Role<0x5908c00ffc580afc113740d96243de235e8c3a63dffa6ca432b8b4a9b00d9526::pbo_minter_role::PBO_MINTER_ROLE>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::treasury::initial_allocate<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun initialize<T0, T1>(arg0: &0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::admin_cap::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u8, arg6: u64, arg7: vector<u64>, arg8: vector<u64>, arg9: u64, arg10: address, arg11: vector<address>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::oracle::create<T0, T1>(arg4, arg5, arg12, arg13);
        0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::create(arg1, arg2, arg3, 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::state::expansion(), arg12, arg13);
        0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::boardroom::create(arg6, arg13);
        0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::treasury::create(arg7, arg8, arg9, arg10, arg11, arg13);
    }

    // decompiled from Move bytecode v6
}

