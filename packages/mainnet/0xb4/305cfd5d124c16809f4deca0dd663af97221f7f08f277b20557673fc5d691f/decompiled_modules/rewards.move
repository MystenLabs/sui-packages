module 0xb4305cfd5d124c16809f4deca0dd663af97221f7f08f277b20557673fc5d691f::rewards {
    fun accrue_performance_fee(arg0: &mut 0xb4305cfd5d124c16809f4deca0dd663af97221f7f08f277b20557673fc5d691f::vault::Vault, arg1: &mut 0x2::coin::TreasuryCap<0xb4305cfd5d124c16809f4deca0dd663af97221f7f08f277b20557673fc5d691f::vault::VAULT>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext, arg5: u64) {
        if (arg2 <= 0xb4305cfd5d124c16809f4deca0dd663af97221f7f08f277b20557673fc5d691f::vault::get_hwm(arg0)) {
            0xb4305cfd5d124c16809f4deca0dd663af97221f7f08f277b20557673fc5d691f::vault::set_hwm(arg0, arg2);
            return
        };
        let v0 = arg3 * 0xb4305cfd5d124c16809f4deca0dd663af97221f7f08f277b20557673fc5d691f::vault::get_fee_bps(arg0) / 10000;
        if (v0 == 0) {
            0xb4305cfd5d124c16809f4deca0dd663af97221f7f08f277b20557673fc5d691f::vault::set_hwm(arg0, arg2);
            return
        };
        let v1 = (((v0 as u128) * (0xb4305cfd5d124c16809f4deca0dd663af97221f7f08f277b20557673fc5d691f::vault::get_total_shares(arg0) as u128) / (arg5 as u128)) as u64);
        if (v1 > 0) {
            0xb4305cfd5d124c16809f4deca0dd663af97221f7f08f277b20557673fc5d691f::vault::add_total_shares(arg0, v1);
            0x2::transfer::public_freeze_object<0x2::coin::Coin<0xb4305cfd5d124c16809f4deca0dd663af97221f7f08f277b20557673fc5d691f::vault::VAULT>>(0x2::coin::mint<0xb4305cfd5d124c16809f4deca0dd663af97221f7f08f277b20557673fc5d691f::vault::VAULT>(arg1, v1, arg4));
        };
        0xb4305cfd5d124c16809f4deca0dd663af97221f7f08f277b20557673fc5d691f::vault::set_hwm(arg0, arg2);
        0xb4305cfd5d124c16809f4deca0dd663af97221f7f08f277b20557673fc5d691f::vault::emit_performance_fee_event(arg0, v1, 0xb4305cfd5d124c16809f4deca0dd663af97221f7f08f277b20557673fc5d691f::vault::get_fee_recipient(arg0));
    }

    public entry fun get_reward_and_compound(arg0: &mut 0xb4305cfd5d124c16809f4deca0dd663af97221f7f08f277b20557673fc5d691f::vault::Vault, arg1: &mut 0x2::coin::TreasuryCap<0xb4305cfd5d124c16809f4deca0dd663af97221f7f08f277b20557673fc5d691f::vault::VAULT>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb4305cfd5d124c16809f4deca0dd663af97221f7f08f277b20557673fc5d691f::vault::get_sui_balance(arg0) + arg2;
        let v1 = (((v0 as u128) * 1000000000000 / (0xb4305cfd5d124c16809f4deca0dd663af97221f7f08f277b20557673fc5d691f::vault::get_total_shares(arg0) as u128)) as u64);
        accrue_performance_fee(arg0, arg1, v1, arg2, arg3, v0);
    }

    // decompiled from Move bytecode v6
}

