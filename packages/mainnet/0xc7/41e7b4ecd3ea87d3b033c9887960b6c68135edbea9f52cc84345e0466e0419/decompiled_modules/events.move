module 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::events {
    struct VaultPublishedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        coin: 0x1::ascii::String,
        nft: 0x1::ascii::String,
    }

    struct DepositedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        nft_ids: vector<0x2::object::ID>,
        minted_amount: u64,
    }

    struct WithdrawnEvent has copy, drop {
        vault_id: 0x2::object::ID,
        nft_ids: vector<0x2::object::ID>,
        burned_amount: u64,
    }

    public(friend) fun emit_deposited<T0, T1: store + key>(arg0: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>, arg1: vector<0x2::object::ID>, arg2: u64) {
        let v0 = DepositedEvent{
            vault_id      : 0x2::object::id<0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>>(arg0),
            nft_ids       : arg1,
            minted_amount : arg2,
        };
        0x2::event::emit<DepositedEvent>(v0);
    }

    public(friend) fun emit_vault_published<T0, T1: store + key>(arg0: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>) {
        let v0 = VaultPublishedEvent{
            vault_id : 0x2::object::id<0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>>(arg0),
            coin     : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            nft      : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        };
        0x2::event::emit<VaultPublishedEvent>(v0);
    }

    public(friend) fun emit_withdrawn<T0, T1: store + key>(arg0: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>, arg1: vector<0x2::object::ID>, arg2: u64) {
        let v0 = WithdrawnEvent{
            vault_id      : 0x2::object::id<0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>>(arg0),
            nft_ids       : arg1,
            burned_amount : arg2,
        };
        0x2::event::emit<WithdrawnEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

