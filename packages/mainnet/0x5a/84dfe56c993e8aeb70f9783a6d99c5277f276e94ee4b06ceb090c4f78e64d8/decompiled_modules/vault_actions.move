module 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::vault_actions {
    struct VaultCreatedEvent has copy, drop {
        vaultId: 0x2::object::ID,
        createdBy: address,
        typeX: 0x1::type_name::TypeName,
        typeY: 0x1::type_name::TypeName,
    }

    struct AddressWhitelistedForTradingEvent has copy, drop {
        vaultId: 0x2::object::ID,
        address: address,
    }

    public entry fun create_vault<T0, T1, T2>(arg0: &0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::app::AdminCap, arg1: 0x2::coin::TreasuryCap<T2>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::vault::new_vault<T0, T1, T2>(arg0, arg1, arg2, arg3);
        let v2 = v0;
        let v3 = VaultCreatedEvent{
            vaultId   : 0x2::object::id<0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::vault::Vault<T0, T1, T2>>(&v2),
            createdBy : 0x2::tx_context::sender(arg3),
            typeX     : 0x1::type_name::get<T0>(),
            typeY     : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<VaultCreatedEvent>(v3);
        0x2::transfer::public_share_object<0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::vault::Vault<T0, T1, T2>>(v2);
        0x2::transfer::public_transfer<0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::vault::VaultCap>(v1, 0x2::tx_context::sender(arg3));
    }

    public entry fun whitelist_address_for_deepbook_access<T0, T1, T2>(arg0: &0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::vault::VaultCap, arg1: &mut 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::vault::Vault<T0, T1, T2>, arg2: address) {
        0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::vault::whitelist_address_for_trading<T0, T1, T2>(arg0, arg1, arg2);
        let v0 = AddressWhitelistedForTradingEvent{
            vaultId : 0x2::object::id<0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::vault::Vault<T0, T1, T2>>(arg1),
            address : arg2,
        };
        0x2::event::emit<AddressWhitelistedForTradingEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

