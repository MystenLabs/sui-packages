module 0x8533912e0233ed5d9a5ac8995b2acb826fa2e1705dff3d52f04e343a54ec4526::vault_lens {
    public fun get_vault_asset_balances<T0, T1>(arg0: &0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>) : (vector<0x1::ascii::String>, vector<u128>) {
        0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::get_vault_asset_balances<T0, T1>(arg0)
    }

    public fun get_withdraw_asset_balances<T0, T1>(arg0: &0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>) : (vector<0x1::ascii::String>, vector<u128>) {
        0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::get_withdraw_asset_balances<T0, T1>(arg0)
    }

    public fun get_bluefin_position_liquidities(arg0: &0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::BluefinExecutorConfig, arg1: vector<0x2::object::ID>) : (vector<0x2::object::ID>, vector<u128>) {
        0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::get_position_liquidities(arg0, arg1)
    }

    public fun get_cetus_position_liquidities(arg0: &0x2682a8dd7d227c23de3e0a067b2e5b1f027ea1f14e66e979149f991a7490bef8::cetus_executor::CetusConfig, arg1: vector<0x2::object::ID>) : (vector<0x2::object::ID>, vector<u128>) {
        0x2682a8dd7d227c23de3e0a067b2e5b1f027ea1f14e66e979149f991a7490bef8::cetus_executor::get_position_liquidities(arg0, arg1)
    }

    public fun get_mmt_position_liquidities(arg0: &0x26dbf8790969ceda9f4cf175762beb11b07b83ec58b8dec4d41241d5a7badc45::mmt_executor::MmtExecutorConfig, arg1: vector<0x2::object::ID>) : (vector<0x2::object::ID>, vector<u128>) {
        0x26dbf8790969ceda9f4cf175762beb11b07b83ec58b8dec4d41241d5a7badc45::mmt_executor::get_position_liquidities(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

