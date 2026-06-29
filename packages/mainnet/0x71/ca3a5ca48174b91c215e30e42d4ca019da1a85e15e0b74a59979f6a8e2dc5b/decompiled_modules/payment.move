module 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::payment {
    struct Witness {
        preimage: vector<u8>,
        nonce: u64,
    }

    struct PaymentSettled has copy, drop {
        mandate_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        amount: u64,
        base_out: u64,
        category: u8,
        nonce: u64,
    }

    public(friend) fun authorize(arg0: &mut 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::mandate::Mandate, arg1: &0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::market_registry::MarketRegistry, arg2: &0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::policy::PaymentIntent, arg3: Witness, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::mandate::assert_active(arg0, arg5);
        0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::policy::check(arg0, arg1, arg2, arg5);
        let Witness {
            preimage : v0,
            nonce    : v1,
        } = arg3;
        assert!(v1 == 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::mandate::nonce(arg0), 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::errors::replay());
        assert!(commitment_of(v0) == 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::mandate::witness_commitment(arg0), 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::errors::bad_witness());
        0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::mandate::rotate(arg0, arg4);
        0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::mandate::apply_spend(arg0, 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::policy::amount(arg2), arg5);
    }

    public fun commitment_of(arg0: vector<u8>) : vector<u8> {
        0x2::hash::keccak256(&arg0)
    }

    public fun mint_witness(arg0: vector<u8>, arg1: u64) : Witness {
        Witness{
            preimage : arg0,
            nonce    : arg1,
        }
    }

    public fun pay_mock<T0, T1>(arg0: &mut 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::mandate::Mandate, arg1: &0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::market_registry::MarketRegistry, arg2: &mut 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::execution::MockPool<T0, T1>, arg3: 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::policy::PaymentIntent, arg4: Witness, arg5: vector<u8>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::policy::amount(&arg3) == 0x2::coin::value<T1>(&arg6), 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::errors::amount());
        assert!(0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::execution::id<T0, T1>(arg2) == 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::policy::pool_id(&arg3), 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::errors::market());
        authorize(arg0, arg1, &arg3, arg4, arg5, arg8);
        let v0 = 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::execution::execute_mock<T0, T1>(arg2, arg6, arg7, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::policy::recipient(&arg3));
        let v1 = PaymentSettled{
            mandate_id : 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::policy::mandate_id(&arg3),
            pool_id    : 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::policy::pool_id(&arg3),
            amount     : 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::policy::amount(&arg3),
            base_out   : 0x2::coin::value<T0>(&v0),
            category   : 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::policy::category(&arg3),
            nonce      : 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::policy::nonce(&arg3),
        };
        0x2::event::emit<PaymentSettled>(v1);
    }

    public fun pay_real<T0, T1>(arg0: &mut 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::mandate::Mandate, arg1: &0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::market_registry::MarketRegistry, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::policy::PaymentIntent, arg4: Witness, arg5: vector<u8>, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::policy::amount(&arg3) == 0x2::coin::value<T1>(&arg6), 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::errors::amount());
        assert!(0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::execution::real_pool_id<T0, T1>(arg2) == 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::policy::pool_id(&arg3), 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::errors::market());
        authorize(arg0, arg1, &arg3, arg4, arg5, arg9);
        let (v0, v1, v2) = 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::execution::execute_real<T0, T1>(arg2, arg6, arg7, arg8, arg9, arg10);
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::policy::recipient(&arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v2, 0x2::tx_context::sender(arg10));
        let v4 = PaymentSettled{
            mandate_id : 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::policy::mandate_id(&arg3),
            pool_id    : 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::policy::pool_id(&arg3),
            amount     : 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::policy::amount(&arg3),
            base_out   : 0x2::coin::value<T0>(&v3),
            category   : 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::policy::category(&arg3),
            nonce      : 0x71ca3a5ca48174b91c215e30e42d4ca019da1a85e15e0b74a59979f6a8e2dc5b::policy::nonce(&arg3),
        };
        0x2::event::emit<PaymentSettled>(v4);
    }

    // decompiled from Move bytecode v7
}

