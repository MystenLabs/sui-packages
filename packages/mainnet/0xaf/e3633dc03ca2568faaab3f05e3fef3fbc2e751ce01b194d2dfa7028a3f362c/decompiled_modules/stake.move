module 0xafe3633dc03ca2568faaab3f05e3fef3fbc2e751ce01b194d2dfa7028a3f362c::stake {
    struct Connector has drop {
        dummy_field: bool,
    }

    fun draw(arg0: &mut 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::AgentSigner, arg1: &0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicy, arg2: 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningRequest, arg3: &mut 0x2::allowance::Allowance<0x2::balance::Balance<0x2::sui::SUI>>, arg4: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<0x2::sui::SUI>>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = Connector{dummy_field: false};
        0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::draw<0x2::sui::SUI, Connector>(v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun stake(arg0: &mut 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::AgentSigner, arg1: &0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicy, arg2: 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningRequest, arg3: &mut 0x2::allowance::Allowance<0x2::balance::Balance<0x2::sui::SUI>>, arg4: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<0x2::sui::SUI>>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = draw(arg0, arg1, arg2, arg3, arg4, arg7, arg8);
        0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(0x3::sui_system::request_add_stake_non_entry(arg5, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg8), arg6, arg8), 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::owner(arg0));
    }

    // decompiled from Move bytecode v7
}

