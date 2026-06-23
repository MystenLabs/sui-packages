module 0xfc599f12a984b979cf8c1c0262d1e3287f4d2408397bf4ddc72046b57eb0c9a7::pool {
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

    struct CetusSwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        atob: bool,
        amount_in: u64,
        amount_out: u64,
        ref_amount: u64,
        fee_amount: u64,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        recipient: address,
    }

    struct SuilendDepositEvent has copy, drop {
        sender: address,
        obligation_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        deposit_amount: u64,
    }

    public entry fun emit_cetus_swap_event(arg0: address, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_original_ids<0x2::sui::SUI>();
        let v1 = CetusSwapEvent{
            pool_id     : 0x2::object::id_from_address(arg1),
            atob        : true,
            amount_in   : arg2,
            amount_out  : arg2,
            ref_amount  : 0,
            fee_amount  : arg2 / 100,
            coin_type_a : v0,
            coin_type_b : v0,
            recipient   : arg0,
        };
        0x2::event::emit<CetusSwapEvent>(v1);
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

    public entry fun emit_suilend_deposit_event(arg0: address, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = SuilendDepositEvent{
            sender         : arg0,
            obligation_id  : 0x2::object::id_from_address(arg1),
            coin_type      : 0x1::type_name::with_original_ids<0x2::sui::SUI>(),
            deposit_amount : arg2,
        };
        0x2::event::emit<SuilendDepositEvent>(v0);
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

