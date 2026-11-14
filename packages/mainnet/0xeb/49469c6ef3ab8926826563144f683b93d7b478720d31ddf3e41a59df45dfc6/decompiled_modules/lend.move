module 0xeb49469c6ef3ab8926826563144f683b93d7b478720d31ddf3e41a59df45dfc6::lend {
    struct Connector has drop {
        dummy_field: bool,
    }

    fun draw<T0>(arg0: &mut 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::AgentSigner, arg1: &0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicy, arg2: 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningRequest, arg3: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg4: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = Connector{dummy_field: false};
        0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::draw<T0, Connector>(v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun deposit<T0>(arg0: &mut 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::AgentSigner, arg1: &0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicy, arg2: 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningRequest, arg3: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg4: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = draw<T0>(arg0, arg1, arg2, arg3, arg4, arg10, arg11);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::entry_deposit_on_behalf_of_user<T0>(arg10, arg5, arg6, arg7, 0x2::coin::from_balance<T0>(v0, arg11), 0x2::balance::value<T0>(&v0), 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::owner(arg0), arg8, arg9, arg11);
    }

    // decompiled from Move bytecode v7
}

