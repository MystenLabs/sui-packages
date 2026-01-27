module 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::zo_adaptor {
    public fun get_zo_position_value<T0, T1>(arg0: &0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::Pool<T0, T1>, arg1: &0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::CredentialV2<T0, T1>, arg2: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::OracleConfig, arg3: &0x2::clock::Clock) : u256 {
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_utils::mul_with_oracle_price((((((0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::pool_acc_reward_per_share<T0, T1>(arg0) - 0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::credential_v2_acc_reward_per_share<T0, T1>(arg1)) as u256) * (0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::credential_v2_staked_amount<T0, T1>(arg1) as u256) / (1000000000000000000 as u256)) as u128) as u256), 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::get_normalized_asset_price(arg2, arg3, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()))) + 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_utils::mul_with_oracle_price((0x2::balance::value<T0>(0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::credential_v2_stake_ref<T0, T1>(arg1)) as u256), 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::get_normalized_asset_price(arg2, arg3, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())))
    }

    public fun update_zo_position_value<T0, T1, T2>(arg0: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg1: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String, arg4: &mut 0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::Pool<T1, T2>, arg5: &0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::CredentialV2<T1, T2>) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::credential_v2_lock_until<T1, T2>(arg5);
        if (v1 >= v0) {
            assert!(v1 - v0 < 31536000000, 9001);
        };
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::finish_update_asset_value<T0>(arg0, arg3, get_zo_position_value<T1, T2>(arg4, arg5, arg1, arg2), v0);
    }

    public fun update_zo_position_value_v2<T0, T1, T2>(arg0: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg1: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String, arg4: &mut 0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::Pool<T1, T2>) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = v0 / 1000;
        let v2 = 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::get_defi_asset<T0, 0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::CredentialV2<T1, T2>>(arg0, arg3);
        let v3 = 0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool::credential_v2_lock_until<T1, T2>(v2);
        if (v3 >= v1) {
            assert!(v3 - v1 < 31536000000, 9001);
        };
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::finish_update_asset_value<T0>(arg0, arg3, get_zo_position_value<T1, T2>(arg4, v2, arg1, arg2), v0);
    }

    // decompiled from Move bytecode v6
}

