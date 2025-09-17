module 0x1451e04805b4afd33503fcc7a3871c571ce12e94690c76c43ff5eaff360fd855::simple_distributor {
    struct SimpleDistributor<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        base_distributor: 0x1451e04805b4afd33503fcc7a3871c571ce12e94690c76c43ff5eaff360fd855::base_distributor::BaseDistributor<T0, T1, T2>,
    }

    public fun base_distributor<T0, T1, T2>(arg0: &SimpleDistributor<T0, T1, T2>) : &0x1451e04805b4afd33503fcc7a3871c571ce12e94690c76c43ff5eaff360fd855::base_distributor::BaseDistributor<T0, T1, T2> {
        &arg0.base_distributor
    }

    public fun base_distributor_mut<T0, T1, T2>(arg0: &mut SimpleDistributor<T0, T1, T2>) : &mut 0x1451e04805b4afd33503fcc7a3871c571ce12e94690c76c43ff5eaff360fd855::base_distributor::BaseDistributor<T0, T1, T2> {
        &mut arg0.base_distributor
    }

    public fun claim<T0, T1, T2>(arg0: &mut SimpleDistributor<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: vector<0x1451e04805b4afd33503fcc7a3871c571ce12e94690c76c43ff5eaff360fd855::bytes32::Bytes32>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: address, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0x1451e04805b4afd33503fcc7a3871c571ce12e94690c76c43ff5eaff360fd855::base_distributor::claim_check_with_merkle_proof<T0, T1, T2>(&mut arg0.base_distributor, arg1, &arg0.id, &arg2, &arg3, arg4, arg5, arg6, &arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg8), arg6);
    }

    public fun new_simple_distributor<T0, T1, T2>(arg0: vector<u8>, arg1: 0x2::coin::Coin<T1>, arg2: &0x1451e04805b4afd33503fcc7a3871c571ce12e94690c76c43ff5eaff360fd855::roles::ProjectAdminCap<T0>, arg3: &mut 0x2::tx_context::TxContext) : SimpleDistributor<T0, T1, T2> {
        SimpleDistributor<T0, T1, T2>{
            id               : 0x2::object::new(arg3),
            base_distributor : 0x1451e04805b4afd33503fcc7a3871c571ce12e94690c76c43ff5eaff360fd855::base_distributor::new_base_distributor<T0, T1, T2>(arg0, arg1, arg2, arg3),
        }
    }

    // decompiled from Move bytecode v6
}

