module 0x83f557e28324bf28f6aa8d72777c40bf9964e386e4912d376439d0033d9308fd::swap {
    struct Connector has drop {
        dummy_field: bool,
    }

    struct Swapped has copy, drop {
        signer: 0x2::object::ID,
        pool: 0x2::object::ID,
        owner: address,
        coin_in: 0x1::type_name::TypeName,
        amount_in: u64,
        coin_out: 0x1::type_name::TypeName,
        amount_out: u64,
        refund: u64,
    }

    fun draw<T0>(arg0: &mut 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::AgentSigner, arg1: &0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicy, arg2: 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningRequest, arg3: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg4: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = Connector{dummy_field: false};
        0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::assert_destination<Connector>(&v0, arg0, arg5);
        0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::draw<T0, Connector>(v0, arg0, arg1, arg2, arg3, arg4, arg6, arg7)
    }

    public fun buy<T0, T1>(arg0: &mut 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::AgentSigner, arg1: &0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicy, arg2: 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningRequest, arg3: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T1>>, arg4: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T1>>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg6 > 0, 0);
        let v0 = draw<T1>(arg0, arg1, arg2, arg3, arg4, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg5), arg7, arg8);
        let (v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg5, 0x2::coin::from_balance<T1>(v0, arg8), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg8), arg6, arg7, arg8);
        let v4 = v2;
        let v5 = v1;
        let v6 = 0x2::coin::value<T0>(&v5);
        assert!(v6 >= arg6, 1);
        settle<T0, T1>(arg0, v5, v4, v3);
        let v7 = Swapped{
            signer     : 0x2::object::id<0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::AgentSigner>(arg0),
            pool       : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg5),
            owner      : 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::owner(arg0),
            coin_in    : 0x1::type_name::with_original_ids<T1>(),
            amount_in  : 0x2::balance::value<T1>(&v0),
            coin_out   : 0x1::type_name::with_original_ids<T0>(),
            amount_out : v6,
            refund     : 0x2::coin::value<T1>(&v4),
        };
        0x2::event::emit<Swapped>(v7);
        v6
    }

    fun pay<T0>(arg0: &0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::AgentSigner, arg1: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
        } else {
            0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::pay_owner<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public fun sell<T0, T1>(arg0: &mut 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::AgentSigner, arg1: &0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicy, arg2: 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningRequest, arg3: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg4: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg6 > 0, 0);
        let v0 = draw<T0>(arg0, arg1, arg2, arg3, arg4, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg5), arg7, arg8);
        let (v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg5, 0x2::coin::from_balance<T0>(v0, arg8), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg8), arg6, arg7, arg8);
        let v4 = v2;
        let v5 = v1;
        let v6 = 0x2::coin::value<T1>(&v4);
        assert!(v6 >= arg6, 1);
        settle<T0, T1>(arg0, v5, v4, v3);
        let v7 = Swapped{
            signer     : 0x2::object::id<0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::AgentSigner>(arg0),
            pool       : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg5),
            owner      : 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::owner(arg0),
            coin_in    : 0x1::type_name::with_original_ids<T0>(),
            amount_in  : 0x2::balance::value<T0>(&v0),
            coin_out   : 0x1::type_name::with_original_ids<T1>(),
            amount_out : v6,
            refund     : 0x2::coin::value<T0>(&v5),
        };
        0x2::event::emit<Swapped>(v7);
        v6
    }

    fun settle<T0, T1>(arg0: &0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::AgentSigner, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        pay<T0>(arg0, arg1);
        pay<T1>(arg0, arg2);
        pay<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0, arg3);
    }

    // decompiled from Move bytecode v7
}

