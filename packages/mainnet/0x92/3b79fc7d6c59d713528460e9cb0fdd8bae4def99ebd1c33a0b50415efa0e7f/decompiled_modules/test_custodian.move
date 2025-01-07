module 0x923b79fc7d6c59d713528460e9cb0fdd8bae4def99ebd1c33a0b50415efa0e7f::test_custodian {
    struct Custodian has store, key {
        id: 0x2::object::UID,
    }

    fun ensure_authorized(arg0: address) {
        assert!(arg0 == @0x1975d66c272b33c1614f219a223a24db133b5a61287f90d76fff6c76aa958585, 1001);
    }

    public entry fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        ensure_authorized(v0);
        let v1 = Custodian{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<Custodian>(v1, v0);
    }

    public entry fun spend_sui_from_contract(arg0: &mut Custodian, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        ensure_authorized(0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg1);
    }

    public entry fun spend_usdc_from_contract<T0>(arg0: &mut Custodian, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        ensure_authorized(0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

