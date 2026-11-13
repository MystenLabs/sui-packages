module 0xc9c0e5f69b6f88ad2240d5933d61ec7b7519525b958302edbbdf8c1e169f4022::perps {
    struct Connector has drop {
        dummy_field: bool,
    }

    public fun deposit<T0, T1>(arg0: &mut 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::AgentSigner, arg1: &0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicy, arg2: 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningRequest, arg3: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg4: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg5: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg6: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, T1>, arg7: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = Connector{dummy_field: false};
        0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::assert_destination<Connector>(&v0, arg0, 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>>(arg5));
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::deposit_collateral<T0, T1>(arg5, arg6, arg7, 0x2::coin::from_balance<T0>(0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::draw<T0, Connector>(v0, arg0, arg1, arg2, arg3, arg4, arg8, arg9), arg9));
    }

    // decompiled from Move bytecode v7
}

