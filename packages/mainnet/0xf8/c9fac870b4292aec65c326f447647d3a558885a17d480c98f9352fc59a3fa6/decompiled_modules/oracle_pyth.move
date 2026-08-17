module 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::oracle_pyth {
    struct PythBinding<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        aggregator_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        price_identifier: vector<u8>,
    }

    public fun binding_aggregator_id<T0, T1>(arg0: &PythBinding<T0, T1>) : 0x2::object::ID {
        arg0.aggregator_id
    }

    public fun binding_price_identifier<T0, T1>(arg0: &PythBinding<T0, T1>) : vector<u8> {
        arg0.price_identifier
    }

    public fun create_binding<T0, T1>(arg0: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::oracle::OracleAggregator<T0, T1>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg2: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultAdminCap<T1>, arg3: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        share_binding<T0, T1>(new_binding<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6));
    }

    public fun max_abs_expo() : u64 {
        18
    }

    public fun new_binding<T0, T1>(arg0: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::oracle::OracleAggregator<T0, T1>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg2: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultAdminCap<T1>, arg3: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) : PythBinding<T0, T1> {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::assert_governance_active(arg3, arg4);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::assert_admin<T1>(arg1, arg2);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::oracle::assert_aggregator<T0, T1>(arg0, arg1, arg3);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::oracle_bad_param());
        PythBinding<T0, T1>{
            id               : 0x2::object::new(arg6),
            aggregator_id    : 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::oracle::aggregator_id<T0, T1>(arg0),
            vault_id         : 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::id<T1>(arg1),
            price_identifier : arg5,
        }
    }

    public fun normalize(arg0: u64, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_bad_scale());
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(arg1);
        let v1 = if (v0) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(arg1)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(arg1)
        };
        assert!(v1 <= 18, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::oracle_bad_param());
        if (v0) {
            0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::oracle::normalize_decimals((arg0 as u128), (v1 as u8), arg2)
        } else {
            let v3 = 1;
            let v4 = 0;
            while (v4 < v1) {
                v3 = v3 * 10;
                v4 = v4 + 1;
            };
            let v5 = (arg0 as u256) * (v3 as u256);
            assert!(v5 <= 340282366920938463463374607431768211455, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::overflow());
            0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::oracle::normalize_decimals((v5 as u128), 0, arg2)
        }
    }

    public fun share_binding<T0, T1>(arg0: PythBinding<T0, T1>) {
        0x2::transfer::share_object<PythBinding<T0, T1>>(arg0);
    }

    public fun submit<T0, T1>(arg0: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::oracle::OracleAggregator<T0, T1>, arg1: &PythBinding<T0, T1>, arg2: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::oracle::Quorum, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) {
        assert!(arg1.aggregator_id == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::oracle::aggregator_id<T0, T1>(arg0), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::oracle_mismatch());
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg3);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price_identifier(v1);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2) == arg1.price_identifier, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::oracle_mismatch());
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(v1);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v3);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v4), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::oracle_bad_param());
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v3);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::oracle::push_sample<T0, T1>(arg0, arg2, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::oracle::source_pyth(), normalize(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v4), &v5, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::oracle::quorum_scale(arg2)), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::mul(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v3), 1000), arg4);
    }

    // decompiled from Move bytecode v7
}

