module 0xbac15e113529152d3f83484aac2cfba3d61443d3d38bd5a38ba3eb6b0470c77d::pool {
    struct DepositEvent has copy, drop {
        user: address,
        pool_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct SwapAndDeposit has copy, drop {
        sender: address,
        recipient: address,
        asset_in: 0x1::type_name::TypeName,
        asset_out: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
    }

    struct VaultWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        redeemer: address,
        asset: 0x1::type_name::TypeName,
        amount: u64,
    }

    public entry fun emit_deposit_event(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DepositEvent{
            user       : arg0,
            pool_id    : 0x2::object::id_from_address(@0xdeadc0de),
            token_type : 0x1::type_name::with_original_ids<0x2::sui::SUI>(),
            amount     : arg1,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public entry fun emit_swap_and_deposit(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_original_ids<0x2::sui::SUI>();
        let v1 = SwapAndDeposit{
            sender     : 0x2::tx_context::sender(arg2),
            recipient  : arg0,
            asset_in   : v0,
            asset_out  : v0,
            amount_in  : arg1,
            amount_out : arg1,
        };
        0x2::event::emit<SwapAndDeposit>(v1);
    }

    public entry fun emit_vault_withdrawn(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultWithdrawn{
            vault_id : 0x2::object::id_from_address(@0xcafebabe),
            redeemer : arg0,
            asset    : 0x1::type_name::with_original_ids<0x2::sui::SUI>(),
            amount   : arg1,
        };
        0x2::event::emit<VaultWithdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

