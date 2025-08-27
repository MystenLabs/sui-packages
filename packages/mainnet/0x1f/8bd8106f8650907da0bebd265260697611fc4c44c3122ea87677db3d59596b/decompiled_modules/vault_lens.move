module 0x1f8bd8106f8650907da0bebd265260697611fc4c44c3122ea87677db3d59596b::vault_lens {
    public fun get_bluefin_position_liquidities(arg0: &0xe849ed38c23794e6f76a01b8cacab1315a0e628c18855002312e32b650de6f24::bluefin_executor::BluefinExecutorConfig, arg1: vector<0x2::object::ID>) : (vector<0x2::object::ID>, vector<u128>) {
        0xe849ed38c23794e6f76a01b8cacab1315a0e628c18855002312e32b650de6f24::bluefin_executor::get_position_liquidities(arg0, arg1)
    }

    public fun get_cetus_position_liquidities(arg0: &0xd4988943a42f4d2f6cc9eca8070877baff9f414575785e40eea6d5551cb8bfea::cetus_executor::CetusConfig, arg1: vector<0x2::object::ID>) : (vector<0x2::object::ID>, vector<u128>) {
        0xd4988943a42f4d2f6cc9eca8070877baff9f414575785e40eea6d5551cb8bfea::cetus_executor::get_position_liquidities(arg0, arg1)
    }

    public fun get_mmt_position_liquidities(arg0: &0x9af398e1beb71b97ce06092f5fad7d6b62f04ee0519dc4555ec1628c4bf5d12::mmt_executor::MmtExecutorConfig, arg1: vector<0x2::object::ID>) : (vector<0x2::object::ID>, vector<u128>) {
        0x9af398e1beb71b97ce06092f5fad7d6b62f04ee0519dc4555ec1628c4bf5d12::mmt_executor::get_position_liquidities(arg0, arg1)
    }

    public fun get_vault_asset_balances<T0, T1>(arg0: &0xa6504798530fce064b77e82b9ae96b9a9d95b85971cda3a3d92a1b8ff7406390::vault::Vault<T0, T1>) : (vector<0x1::ascii::String>, vector<u128>) {
        0xa6504798530fce064b77e82b9ae96b9a9d95b85971cda3a3d92a1b8ff7406390::vault::get_vault_asset_balances<T0, T1>(arg0)
    }

    public fun get_withdraw_asset_balances<T0, T1>(arg0: &0xa6504798530fce064b77e82b9ae96b9a9d95b85971cda3a3d92a1b8ff7406390::vault::Vault<T0, T1>) : (vector<0x1::ascii::String>, vector<u128>) {
        0xa6504798530fce064b77e82b9ae96b9a9d95b85971cda3a3d92a1b8ff7406390::vault::get_withdraw_asset_balances<T0, T1>(arg0)
    }

    // decompiled from Move bytecode v6
}

