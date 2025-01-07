module 0x552f1287cae4147d8a1a4637ce99d36e5423f164f04da01829c6e36db22b09f3::bucket_oracle {
    public fun update_price_afsui(arg0: &mut 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg1: &0x2::clock::Clock, arg2: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg3: &0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg4: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>) {
        update_price_sui(arg0, arg1, arg2);
        0x2480d9a3ff2c821061df22c4365316f894c6fa686fbd03ba828fe7c5bef9ad22::afsui_rule::update_price(arg0, arg3, arg4, arg1);
    }

    public fun update_price_sui(arg0: &mut 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg1: &0x2::clock::Clock, arg2: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::update_price_from_supra<0x2::sui::SUI>(arg0, arg1, arg2, 90);
    }

    // decompiled from Move bytecode v6
}

