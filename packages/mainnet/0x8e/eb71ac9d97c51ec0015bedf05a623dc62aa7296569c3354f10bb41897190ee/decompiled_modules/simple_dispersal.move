module 0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::simple_dispersal {
    struct SimpleDispersal<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        base_distributor: 0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::base_distributor::BaseDistributor<T0, T1, T2>,
    }

    public fun active<T0, T1, T2>(arg0: &SimpleDispersal<T0, T1, T2>) : bool {
        0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::base_distributor::active<T0, T1, T2>(&arg0.base_distributor)
    }

    public fun claimed_of<T0, T1, T2>(arg0: &SimpleDispersal<T0, T1, T2>, arg1: 0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::bytes32::Bytes32, arg2: address) : u64 {
        0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::base_distributor::claimed_of<T0, T1, T2>(&arg0.base_distributor, arg1, arg2)
    }

    public fun collected_fee_amount<T0, T1, T2>(arg0: &SimpleDispersal<T0, T1, T2>) : u64 {
        0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::base_distributor::collected_fee_amount<T0, T1, T2>(&arg0.base_distributor)
    }

    public fun configurator_of<T0, T1, T2>(arg0: &SimpleDispersal<T0, T1, T2>, arg1: 0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::bytes32::Bytes32) : 0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::bytes32::Bytes32 {
        0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::base_distributor::configurator_of<T0, T1, T2>(&arg0.base_distributor, arg1)
    }

    public fun default_fee_mode<T0, T1, T2>(arg0: &SimpleDispersal<T0, T1, T2>) : 0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::fee_mode::FeeMode {
        0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::base_distributor::default_fee_mode<T0, T1, T2>(&arg0.base_distributor)
    }

    public fun deposit_airdrop_token<T0, T1, T2>(arg0: &mut SimpleDispersal<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>) {
        0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::base_distributor::deposit_airdrop_token<T0, T1, T2>(&mut arg0.base_distributor, arg1);
    }

    public fun fee_mode_of<T0, T1, T2>(arg0: &SimpleDispersal<T0, T1, T2>, arg1: 0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::bytes32::Bytes32) : 0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::fee_mode::FeeMode {
        0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::base_distributor::fee_mode_of<T0, T1, T2>(&arg0.base_distributor, arg1)
    }

    public fun required_fee<T0, T1, T2>(arg0: &SimpleDispersal<T0, T1, T2>, arg1: 0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::bytes32::Bytes32, arg2: u64) : u64 {
        0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::base_distributor::required_fee<T0, T1, T2>(&arg0.base_distributor, arg1, arg2)
    }

    public fun set_configurator<T0, T1, T2>(arg0: &mut SimpleDispersal<T0, T1, T2>, arg1: &0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::roles::ProjectAdminCap<T0>, arg2: 0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::bytes32::Bytes32, arg3: 0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::bytes32::Bytes32) {
        0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::base_distributor::set_configurator<T0, T1, T2>(&mut arg0.base_distributor, arg1, arg2, arg3);
    }

    public fun set_default_fee_mode<T0, T1, T2>(arg0: &mut SimpleDispersal<T0, T1, T2>, arg1: &0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::roles::ProjectAdminCap<T0>, arg2: 0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::fee_mode::FeeMode) {
        0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::base_distributor::set_default_fee_mode<T0, T1, T2>(&mut arg0.base_distributor, arg1, arg2);
    }

    public fun set_fee_mode<T0, T1, T2>(arg0: &mut SimpleDispersal<T0, T1, T2>, arg1: &0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::roles::ProjectAdminCap<T0>, arg2: 0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::bytes32::Bytes32, arg3: 0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::fee_mode::FeeMode) {
        0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::base_distributor::set_fee_mode<T0, T1, T2>(&mut arg0.base_distributor, arg1, arg2, arg3);
    }

    public fun set_signer_pubkey<T0, T1, T2>(arg0: &mut SimpleDispersal<T0, T1, T2>, arg1: &0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::roles::ProjectAdminCap<T0>, arg2: vector<u8>) {
        0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::base_distributor::set_signer_pubkey<T0, T1, T2>(&mut arg0.base_distributor, arg1, arg2);
    }

    public fun signer_pubkey<T0, T1, T2>(arg0: &SimpleDispersal<T0, T1, T2>) : vector<u8> {
        0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::base_distributor::signer_pubkey<T0, T1, T2>(&arg0.base_distributor)
    }

    public fun toggle_active<T0, T1, T2>(arg0: &mut SimpleDispersal<T0, T1, T2>, arg1: &0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::roles::ProjectAdminCap<T0>) {
        0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::base_distributor::toggle_active<T0, T1, T2>(&mut arg0.base_distributor, arg1);
    }

    public fun vault_balance<T0, T1, T2>(arg0: &SimpleDispersal<T0, T1, T2>) : u64 {
        0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::base_distributor::vault_balance<T0, T1, T2>(&arg0.base_distributor)
    }

    public fun withdraw_airdrop_token<T0, T1, T2>(arg0: &mut SimpleDispersal<T0, T1, T2>, arg1: &0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::roles::AirdropTokenWithdrawCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::base_distributor::withdraw_airdrop_token<T0, T1, T2>(&mut arg0.base_distributor, arg1, arg2, arg3)
    }

    public fun withdraw_fee<T0, T1, T2>(arg0: &mut SimpleDispersal<T0, T1, T2>, arg1: &0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::roles::OwnerCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::base_distributor::withdraw_fee<T0, T1, T2>(&mut arg0.base_distributor, arg1, arg2)
    }

    public fun claim<T0, T1, T2>(arg0: &mut SimpleDispersal<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: 0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::bytes32::Bytes32, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: address, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::base_distributor::claim_check<T0, T1, T2>(&mut arg0.base_distributor, arg1, &arg0.id, arg2, &arg3, arg4, arg5, arg6, &arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg8), arg6);
    }

    public fun new_simple_dispersal<T0, T1, T2>(arg0: &0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::roles::ProjectAdminCap<T0>, arg1: vector<u8>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : SimpleDispersal<T0, T1, T2> {
        SimpleDispersal<T0, T1, T2>{
            id               : 0x2::object::new(arg3),
            base_distributor : 0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::base_distributor::new_base_distributor<T0, T1, T2>(arg0, arg1, arg2, arg3),
        }
    }

    public fun receive_airdrop_token<T0, T1, T2>(arg0: &mut SimpleDispersal<T0, T1, T2>, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T1>>) {
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T1>>(&mut arg0.id, arg1);
        deposit_airdrop_token<T0, T1, T2>(arg0, v0);
    }

    entry fun withdraw_airdrop_token_to_sender<T0, T1, T2>(arg0: &mut SimpleDispersal<T0, T1, T2>, arg1: &0x8eeb71ac9d97c51ec0015bedf05a623dc62aa7296569c3354f10bb41897190ee::roles::AirdropTokenWithdrawCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::u64::min(arg2, vault_balance<T0, T1, T2>(arg0));
        let v1 = withdraw_airdrop_token<T0, T1, T2>(arg0, arg1, v0, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

