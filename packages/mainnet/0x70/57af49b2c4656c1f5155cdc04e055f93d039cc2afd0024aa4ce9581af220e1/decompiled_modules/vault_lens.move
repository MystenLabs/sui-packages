module 0x7057af49b2c4656c1f5155cdc04e055f93d039cc2afd0024aa4ce9581af220e1::vault_lens {
    public fun get_vault_asset_balances<T0, T1>(arg0: &0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>) : (vector<0x1::ascii::String>, vector<u128>) {
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::get_vault_asset_balances<T0, T1>(arg0)
    }

    public fun get_withdraw_asset_balances<T0, T1>(arg0: &0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>) : (vector<0x1::ascii::String>, vector<u128>) {
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::get_withdraw_asset_balances<T0, T1>(arg0)
    }

    public fun get_bluefin_position_liquidities(arg0: &0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::BluefinExecutorConfig, arg1: vector<0x2::object::ID>) : (vector<0x2::object::ID>, vector<u128>) {
        0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::get_position_liquidities(arg0, arg1)
    }

    public fun get_cetus_position_liquidities(arg0: &0x92742f6fd33d38f2a1828940aa6eb458f5ad5eafd17dfd62951e4cb914922d20::cetus_executor::CetusConfig, arg1: vector<0x2::object::ID>) : (vector<0x2::object::ID>, vector<u128>) {
        0x92742f6fd33d38f2a1828940aa6eb458f5ad5eafd17dfd62951e4cb914922d20::cetus_executor::get_position_liquidities(arg0, arg1)
    }

    public fun get_mmt_position_liquidities(arg0: &0x1c795cde6dc8bed429b65eaad81cb4559273029599a65463a0caddd38758e18f::mmt_executor::MmtExecutorConfig, arg1: vector<0x2::object::ID>) : (vector<0x2::object::ID>, vector<u128>) {
        0x1c795cde6dc8bed429b65eaad81cb4559273029599a65463a0caddd38758e18f::mmt_executor::get_position_liquidities(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

