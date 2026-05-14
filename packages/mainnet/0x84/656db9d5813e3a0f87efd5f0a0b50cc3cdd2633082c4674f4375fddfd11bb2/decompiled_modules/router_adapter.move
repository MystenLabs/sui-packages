module 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::router_adapter {
    struct AdapterReceipt<phantom T0> {
        output: 0x2::balance::Balance<T0>,
        vault_id: 0x2::object::ID,
        proposal_id: u64,
        methodology_hash: vector<u8>,
        target_weights_hash: vector<u8>,
        router: address,
        input_type: 0x1::type_name::TypeName,
        output_type: 0x1::type_name::TypeName,
        amount_in: u64,
        min_amount_out: u64,
        amount_out: u64,
        notional_usd_micro: u64,
    }

    public(friend) fun consume<T0>(arg0: AdapterReceipt<T0>) : (0x2::balance::Balance<T0>, 0x2::object::ID, u64, vector<u8>, vector<u8>, address, 0x1::type_name::TypeName, 0x1::type_name::TypeName, u64, u64, u64, u64) {
        let AdapterReceipt {
            output              : v0,
            vault_id            : v1,
            proposal_id         : v2,
            methodology_hash    : v3,
            target_weights_hash : v4,
            router              : v5,
            input_type          : v6,
            output_type         : v7,
            amount_in           : v8,
            min_amount_out      : v9,
            amount_out          : v10,
            notional_usd_micro  : v11,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11)
    }

    public(friend) fun mint_receipt<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: 0x2::balance::Balance<T1>) : AdapterReceipt<T1> {
        let v0 = 0x2::balance::value<T1>(&arg8);
        assert!(v0 > 0, 28);
        assert!(v0 >= arg6, 27);
        AdapterReceipt<T1>{
            output              : arg8,
            vault_id            : arg0,
            proposal_id         : arg1,
            methodology_hash    : arg2,
            target_weights_hash : arg3,
            router              : arg4,
            input_type          : 0x1::type_name::with_defining_ids<T0>(),
            output_type         : 0x1::type_name::with_defining_ids<T1>(),
            amount_in           : arg5,
            min_amount_out      : arg6,
            amount_out          : v0,
            notional_usd_micro  : arg7,
        }
    }

    public fun receipt_amount_in<T0>(arg0: &AdapterReceipt<T0>) : u64 {
        arg0.amount_in
    }

    public fun receipt_amount_out<T0>(arg0: &AdapterReceipt<T0>) : u64 {
        arg0.amount_out
    }

    public fun receipt_input_type<T0>(arg0: &AdapterReceipt<T0>) : 0x1::type_name::TypeName {
        arg0.input_type
    }

    public fun receipt_min_amount_out<T0>(arg0: &AdapterReceipt<T0>) : u64 {
        arg0.min_amount_out
    }

    public fun receipt_output_type<T0>(arg0: &AdapterReceipt<T0>) : 0x1::type_name::TypeName {
        arg0.output_type
    }

    public fun receipt_proposal_id<T0>(arg0: &AdapterReceipt<T0>) : u64 {
        arg0.proposal_id
    }

    public fun receipt_router<T0>(arg0: &AdapterReceipt<T0>) : address {
        arg0.router
    }

    public fun receipt_vault_id<T0>(arg0: &AdapterReceipt<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v7
}

