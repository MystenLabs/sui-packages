module 0x24e170414c0676736af926035f410bc2f37f3396fbfa3e2ccc506a61bd91462d::create_vault_action {
    struct CreateVaultAction has drop {
        dummy_field: bool,
    }

    public fun create_vault<T0, T1>(arg0: &mut 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::action_receipt::ActionReceipt, arg1: &0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::action_policy_registry::ActionPolicyRegistry, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = CreateVaultAction{dummy_field: false};
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::actions::add_output_asset<0x8634da98c01396dfce9e6a24710597284b1e4a3b069f54fa4c5d673416d0c3ba::vault::OwnerKey, CreateVaultAction>(v0, arg0, arg1, 0x8634da98c01396dfce9e6a24710597284b1e4a3b069f54fa4c5d673416d0c3ba::init::initialize<T0, T1>(arg2, arg3, arg4));
    }

    // decompiled from Move bytecode v6
}

