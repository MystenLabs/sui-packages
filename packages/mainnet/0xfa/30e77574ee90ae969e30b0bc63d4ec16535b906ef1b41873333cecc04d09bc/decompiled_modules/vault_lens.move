module 0xfa30e77574ee90ae969e30b0bc63d4ec16535b906ef1b41873333cecc04d09bc::vault_lens {
    public fun get_vault_asset_balances<T0, T1>(arg0: &0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::Vault<T0, T1>) : (vector<0x1::ascii::String>, vector<u128>) {
        0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::get_vault_asset_balances<T0, T1>(arg0)
    }

    public fun get_withdraw_asset_balances<T0, T1>(arg0: &0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::Vault<T0, T1>) : (vector<0x1::ascii::String>, vector<u128>) {
        0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::get_withdraw_asset_balances<T0, T1>(arg0)
    }

    public fun get_bluefin_position_liquidities(arg0: &0x7610f396068805a99c8ce587771b94eae8ccb4ba4dad464e4806459a5e259185::bluefin_executor::BluefinExecutorConfig, arg1: vector<0x2::object::ID>) : (vector<0x2::object::ID>, vector<u128>) {
        0x7610f396068805a99c8ce587771b94eae8ccb4ba4dad464e4806459a5e259185::bluefin_executor::get_position_liquidities(arg0, arg1)
    }

    public fun get_cetus_position_liquidities(arg0: &0xdf84e2863b9b122681cf7aa8c9b81835810fb3c0aa66252f212ebef1c70b7c77::cetus_executor::CetusConfig, arg1: vector<0x2::object::ID>) : (vector<0x2::object::ID>, vector<u128>) {
        0xdf84e2863b9b122681cf7aa8c9b81835810fb3c0aa66252f212ebef1c70b7c77::cetus_executor::get_position_liquidities(arg0, arg1)
    }

    public fun get_mmt_position_liquidities(arg0: &0x65b4ddf6c6b9c4a225e0e9136a9da5308b794258643a6d8774fbd0166bdd0c32::mmt_executor::MmtExecutorConfig, arg1: vector<0x2::object::ID>) : (vector<0x2::object::ID>, vector<u128>) {
        0x65b4ddf6c6b9c4a225e0e9136a9da5308b794258643a6d8774fbd0166bdd0c32::mmt_executor::get_position_liquidities(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

