module 0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::migration {
    struct MigrationCap has key {
        id: 0x2::object::UID,
    }

    public entry fun destroy_cap(arg0: MigrationCap) {
        let MigrationCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MigrationCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MigrationCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun migrate_profile(arg0: &MigrationCap, arg1: &mut 0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::loyalty_program::LoyaltyProgram, arg2: address, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::loyalty_program::migration_mint_profile(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun migrate_reward_nft(arg0: &MigrationCap, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::loyalty_program::migration_mint_reward_nft(arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun migrate_shop(arg0: &MigrationCap, arg1: &mut 0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::coffee_shop_registry::ShopRegistry, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: bool, arg8: bool, arg9: u64, arg10: u64, arg11: vector<u64>, arg12: vector<vector<u8>>, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::coffee_shop_registry::migration_mint_shop(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
    }

    public entry fun migrate_shop_account(arg0: &MigrationCap, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::loyalty_program::migration_mint_shop_account(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun migrate_voucher(arg0: &MigrationCap, arg1: address, arg2: address, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::voucher_system::migration_mint_voucher(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

