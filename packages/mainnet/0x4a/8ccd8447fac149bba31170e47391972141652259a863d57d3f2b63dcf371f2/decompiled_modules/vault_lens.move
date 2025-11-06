module 0x7057af49b2c4656c1f5155cdc04e055f93d039cc2afd0024aa4ce9581af220e1::vault_lens {
    public fun get_last_credit_profit<T0, T1>(arg0: &0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>) : (u64, u64, bool, u64) {
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::get_last_credit_profit<T0, T1>(arg0)
    }

    public fun get_vault_asset_balances<T0, T1>(arg0: &0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>) : (vector<0x1::ascii::String>, vector<u128>) {
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::get_vault_asset_balances<T0, T1>(arg0)
    }

    public fun get_withdraw_asset_balances<T0, T1>(arg0: &0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>) : (vector<0x1::ascii::String>, vector<u128>) {
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::get_withdraw_asset_balances<T0, T1>(arg0)
    }

    public fun get_bluefin_position_liquidities(arg0: &0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::BluefinExecutorConfig, arg1: vector<0x2::object::ID>) : (vector<0x2::object::ID>, vector<u128>) {
        0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::get_position_liquidities(arg0, arg1)
    }

    public fun get_bluefin_vault_position_liquidities(arg0: &0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::BluefinExecutorConfig, arg1: 0x2::object::ID) : (vector<0x2::object::ID>, vector<u128>) {
        0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::get_vault_position_liquidities(arg0, arg1)
    }

    public fun get_bluefin_vault_position_value(arg0: &0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::BluefinExecutorConfig, arg1: 0x2::object::ID) : (vector<0x2::object::ID>, vector<u128>, vector<u32>, vector<u32>) {
        0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::get_vault_position_value(arg0, arg1)
    }

    public fun get_cetus_position_liquidities(arg0: &0x92742f6fd33d38f2a1828940aa6eb458f5ad5eafd17dfd62951e4cb914922d20::cetus_executor::CetusConfig, arg1: vector<0x2::object::ID>) : (vector<0x2::object::ID>, vector<u128>) {
        0x92742f6fd33d38f2a1828940aa6eb458f5ad5eafd17dfd62951e4cb914922d20::cetus_executor::get_position_liquidities(arg0, arg1)
    }

    public fun get_cetus_vault_position_liquidities(arg0: &0x92742f6fd33d38f2a1828940aa6eb458f5ad5eafd17dfd62951e4cb914922d20::cetus_executor::CetusConfig, arg1: 0x2::object::ID) : (vector<0x2::object::ID>, vector<u128>) {
        0x92742f6fd33d38f2a1828940aa6eb458f5ad5eafd17dfd62951e4cb914922d20::cetus_executor::get_vault_position_liquidities(arg0, arg1)
    }

    public fun get_cetus_vault_position_value(arg0: &0x92742f6fd33d38f2a1828940aa6eb458f5ad5eafd17dfd62951e4cb914922d20::cetus_executor::CetusConfig, arg1: 0x2::object::ID) : (vector<0x2::object::ID>, vector<u128>, vector<u32>, vector<u32>) {
        0x92742f6fd33d38f2a1828940aa6eb458f5ad5eafd17dfd62951e4cb914922d20::cetus_executor::get_vault_position_value(arg0, arg1)
    }

    public fun get_last_credit_profit_test<T0, T1>(arg0: &0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg1: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>) {
        while (0 < 0x1::vector::length<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1)) {
        };
    }

    public fun get_mmt_position_liquidities(arg0: &0x1c795cde6dc8bed429b65eaad81cb4559273029599a65463a0caddd38758e18f::mmt_executor::MmtExecutorConfig, arg1: vector<0x2::object::ID>) : (vector<0x2::object::ID>, vector<u128>) {
        0x1c795cde6dc8bed429b65eaad81cb4559273029599a65463a0caddd38758e18f::mmt_executor::get_position_liquidities(arg0, arg1)
    }

    public fun get_mmt_vault_position_liquidities(arg0: &0x1c795cde6dc8bed429b65eaad81cb4559273029599a65463a0caddd38758e18f::mmt_executor::MmtExecutorConfig, arg1: 0x2::object::ID) : (vector<0x2::object::ID>, vector<u128>) {
        0x1c795cde6dc8bed429b65eaad81cb4559273029599a65463a0caddd38758e18f::mmt_executor::get_vault_position_liquidities(arg0, arg1)
    }

    public fun get_mmt_vault_position_value(arg0: &0x1c795cde6dc8bed429b65eaad81cb4559273029599a65463a0caddd38758e18f::mmt_executor::MmtExecutorConfig, arg1: 0x2::object::ID) : (vector<0x2::object::ID>, vector<u128>, vector<u32>, vector<u32>) {
        0x1c795cde6dc8bed429b65eaad81cb4559273029599a65463a0caddd38758e18f::mmt_executor::get_vault_position_value(arg0, arg1)
    }

    public fun get_vault_info_bluefin<T0, T1>(arg0: &0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::BluefinExecutorConfig, arg1: &0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>) : (vector<0x2::object::ID>, vector<u128>, vector<u32>, vector<u32>, vector<0x1::ascii::String>, vector<u128>, vector<0x1::ascii::String>, vector<u128>) {
        let (v0, v1, v2, v3) = 0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::get_vault_position_value(arg0, 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg1));
        let (v4, v5) = 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::get_vault_asset_balances<T0, T1>(arg1);
        let (v6, v7) = 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::get_withdraw_asset_balances<T0, T1>(arg1);
        (v0, v1, v2, v3, v4, v5, v6, v7)
    }

    public fun get_vault_info_cetus<T0, T1>(arg0: &0x92742f6fd33d38f2a1828940aa6eb458f5ad5eafd17dfd62951e4cb914922d20::cetus_executor::CetusConfig, arg1: &0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>) : (vector<0x2::object::ID>, vector<u128>, vector<u32>, vector<u32>, vector<0x1::ascii::String>, vector<u128>, vector<0x1::ascii::String>, vector<u128>) {
        let (v0, v1, v2, v3) = 0x92742f6fd33d38f2a1828940aa6eb458f5ad5eafd17dfd62951e4cb914922d20::cetus_executor::get_vault_position_value(arg0, 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg1));
        let (v4, v5) = 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::get_vault_asset_balances<T0, T1>(arg1);
        let (v6, v7) = 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::get_withdraw_asset_balances<T0, T1>(arg1);
        (v0, v1, v2, v3, v4, v5, v6, v7)
    }

    public fun get_vault_info_mmt<T0, T1>(arg0: &0x1c795cde6dc8bed429b65eaad81cb4559273029599a65463a0caddd38758e18f::mmt_executor::MmtExecutorConfig, arg1: &0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>) : (vector<0x2::object::ID>, vector<u128>, vector<u32>, vector<u32>, vector<0x1::ascii::String>, vector<u128>, vector<0x1::ascii::String>, vector<u128>) {
        let (v0, v1, v2, v3) = 0x1c795cde6dc8bed429b65eaad81cb4559273029599a65463a0caddd38758e18f::mmt_executor::get_vault_position_value(arg0, 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg1));
        let (v4, v5) = 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::get_vault_asset_balances<T0, T1>(arg1);
        let (v6, v7) = 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::get_withdraw_asset_balances<T0, T1>(arg1);
        (v0, v1, v2, v3, v4, v5, v6, v7)
    }

    // decompiled from Move bytecode v6
}

