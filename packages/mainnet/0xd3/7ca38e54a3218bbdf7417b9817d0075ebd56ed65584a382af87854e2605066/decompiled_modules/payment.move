module 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::payment {
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

    public(friend) fun authorize(arg0: &mut 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::mandate::Mandate, arg1: &0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::market_registry::MarketRegistry, arg2: &0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::policy::PaymentIntent, arg3: Witness, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::mandate::assert_active(arg0, arg5);
        0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::policy::check(arg0, arg1, arg2, arg5);
        let Witness {
            preimage : v0,
            nonce    : v1,
        } = arg3;
        assert!(v1 == 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::mandate::nonce(arg0), 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::errors::replay());
        assert!(commitment_of(v0) == 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::mandate::witness_commitment(arg0), 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::errors::bad_witness());
        0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::mandate::rotate(arg0, arg4);
        0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::mandate::apply_spend(arg0, 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::policy::amount(arg2), arg5);
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

    public fun pay_mock<T0, T1>(arg0: &mut 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::mandate::Mandate, arg1: &0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::market_registry::MarketRegistry, arg2: &mut 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::execution::MockPool<T0, T1>, arg3: 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::policy::PaymentIntent, arg4: Witness, arg5: vector<u8>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::policy::amount(&arg3) == 0x2::coin::value<T1>(&arg6), 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::errors::amount());
        assert!(0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::execution::id<T0, T1>(arg2) == 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::policy::pool_id(&arg3), 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::errors::market());
        authorize(arg0, arg1, &arg3, arg4, arg5, arg8);
        let v0 = 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::execution::execute_mock<T0, T1>(arg2, arg6, arg7, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::policy::recipient(&arg3));
        let v1 = PaymentSettled{
            mandate_id : 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::policy::mandate_id(&arg3),
            pool_id    : 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::policy::pool_id(&arg3),
            amount     : 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::policy::amount(&arg3),
            base_out   : 0x2::coin::value<T0>(&v0),
            category   : 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::policy::category(&arg3),
            nonce      : 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::policy::nonce(&arg3),
        };
        0x2::event::emit<PaymentSettled>(v1);
    }

    public fun pay_real<T0, T1>(arg0: &mut 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::mandate::Mandate, arg1: &0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::market_registry::MarketRegistry, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::policy::PaymentIntent, arg4: Witness, arg5: vector<u8>, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::policy::amount(&arg3) == 0x2::coin::value<T1>(&arg6), 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::errors::amount());
        assert!(0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::execution::real_pool_id<T0, T1>(arg2) == 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::policy::pool_id(&arg3), 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::errors::market());
        authorize(arg0, arg1, &arg3, arg4, arg5, arg9);
        let (v0, v1, v2) = 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::execution::execute_real<T0, T1>(arg2, arg6, arg7, arg8, arg9, arg10);
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::policy::recipient(&arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v2, 0x2::tx_context::sender(arg10));
        let v4 = PaymentSettled{
            mandate_id : 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::policy::mandate_id(&arg3),
            pool_id    : 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::policy::pool_id(&arg3),
            amount     : 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::policy::amount(&arg3),
            base_out   : 0x2::coin::value<T0>(&v3),
            category   : 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::policy::category(&arg3),
            nonce      : 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::policy::nonce(&arg3),
        };
        0x2::event::emit<PaymentSettled>(v4);
    }

    // decompiled from Move bytecode v7
}

