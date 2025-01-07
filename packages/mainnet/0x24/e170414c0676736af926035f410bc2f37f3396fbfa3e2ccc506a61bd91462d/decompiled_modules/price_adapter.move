module 0x24e170414c0676736af926035f410bc2f37f3396fbfa3e2ccc506a61bd91462d::price_adapter {
    struct PriceAdapter has drop {
        dummy_field: bool,
    }

    public fun get_vault_equity<T0, T1>(arg0: &mut 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::price_receipt::PriceReceipt, arg1: &0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::price_policy::PricePolicyRegistry, arg2: &0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::credit_account::CreditAccount, arg3: &0x8634da98c01396dfce9e6a24710597284b1e4a3b069f54fa4c5d673416d0c3ba::vault::Vault<T0, T1>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &0x8ee3fa15277a5ee632a49043e4fd683cde9ce8ac1a27ad00023acc63499ad8fd::oracle::KriyaOracle, arg6: &0x6f8b4b9e08f73fac834d603c29cba18892de780f642d5e7ab2a7e798452413b4::registry::CoinDecimalsRegistry, arg7: &0x2::clock::Clock) {
        let (v0, v1, _) = 0x8634da98c01396dfce9e6a24710597284b1e4a3b069f54fa4c5d673416d0c3ba::vault::vault_info<T0, T1>(arg3, arg4);
        let v3 = PriceAdapter{dummy_field: false};
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::price_receipt::set_asset_value<PriceAdapter>(v3, arg1, arg0, 0x1::type_name::get<0x8634da98c01396dfce9e6a24710597284b1e4a3b069f54fa4c5d673416d0c3ba::vault::OwnerKey>(), 0x8ee3fa15277a5ee632a49043e4fd683cde9ce8ac1a27ad00023acc63499ad8fd::oracle_utils::get_usd_value<T0>(v0, arg5, arg6, arg7) - 0x8ee3fa15277a5ee632a49043e4fd683cde9ce8ac1a27ad00023acc63499ad8fd::oracle_utils::get_usd_value<T1>(v1, arg5, arg6, arg7));
    }

    // decompiled from Move bytecode v6
}

