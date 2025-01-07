module 0xf30d80f22f77c0895ac466d74d0baa86289a0d45f956b0b482abfdb3c72c0256::create_vault_action {
    struct CreateVaultAction has drop {
        dummy_field: bool,
    }

    public fun create_vault<T0, T1>(arg0: &mut 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::action_receipt::ActionReceipt, arg1: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::action_policy_registry::ActionPolicyRegistry, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = CreateVaultAction{dummy_field: false};
        0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::actions::add_output_asset<0x8634da98c01396dfce9e6a24710597284b1e4a3b069f54fa4c5d673416d0c3ba::vault::OwnerKey, CreateVaultAction>(v0, arg0, arg1, 0x8634da98c01396dfce9e6a24710597284b1e4a3b069f54fa4c5d673416d0c3ba::init::initialize<T0, T1>(arg2, arg3, arg4));
    }

    // decompiled from Move bytecode v6
}

