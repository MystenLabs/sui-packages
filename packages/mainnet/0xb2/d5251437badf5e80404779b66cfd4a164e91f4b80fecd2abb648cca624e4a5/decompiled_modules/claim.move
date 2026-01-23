module 0xb2d5251437badf5e80404779b66cfd4a164e91f4b80fecd2abb648cca624e4a5::claim {
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

    struct PersonalVault<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<T0>,
        nonce: u64,
    }

    fun address_to_bytes(arg0: address) : vector<u8> {
        0x1::bcs::to_bytes<address>(&arg0)
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

    public entry fun claim_with_signature<T0>(arg0: &mut PersonalVault<T0>, arg1: u64, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.nonce;
        let v1 = b"claim|";
        0x1::vector::append<u8>(&mut v1, address_to_bytes(0x2::object::id_address<PersonalVault<T0>>(arg0)));
        0x1::vector::append<u8>(&mut v1, b"|");
        0x1::vector::append<u8>(&mut v1, u64_to_bytes(arg1));
        0x1::vector::append<u8>(&mut v1, b"|");
        0x1::vector::append<u8>(&mut v1, u64_to_bytes(v0));
        0x1::vector::append<u8>(&mut v1, b"|");
        0x1::vector::append<u8>(&mut v1, address_to_bytes(arg2));
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg4, &v1), 1);
        arg0.nonce = v0 + 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg5), arg2);
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

    public entry fun create_vault<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PersonalVault<T0>{
            id      : 0x2::object::new(arg1),
            owner   : 0x2::tx_context::sender(arg1),
            balance : 0x2::coin::into_balance<T0>(arg0),
            nonce   : 0,
        };
        0x2::transfer::share_object<PersonalVault<T0>>(v0);
    }

    public entry fun deposit_to_vault<T0>(arg0: &mut PersonalVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
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

    fun u64_to_bytes(arg0: u64) : vector<u8> {
        0x1::bcs::to_bytes<u64>(&arg0)
    }

    public fun vault_balance<T0>(arg0: &PersonalVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun vault_nonce<T0>(arg0: &PersonalVault<T0>) : u64 {
        arg0.nonce
    }

    public entry fun withdraw_from_vault<T0>(arg0: &mut PersonalVault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2), arg0.owner);
    }

    // decompiled from Move bytecode v6
}

