module 0x8cf60cffaa7e50cc9b0c4a537aab9d19ed3886cdc7879874567d9978f2484474::mmt_claim {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ClaimVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        signer_pubkey: vector<u8>,
        used_biz_ids: 0x2::table::Table<u64, bool>,
        balance: 0x2::balance::Balance<T0>,
    }

    struct ClaimMessage has copy, drop, store {
        vault_id: 0x2::object::ID,
        biz_id: u64,
        to: address,
        amount: u64,
    }

    struct Claimed has copy, drop {
        vault_id: 0x2::object::ID,
        biz_id: u64,
        to: address,
        amount: u64,
    }

    struct SignerUpdated has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct Deposited has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct EmergencyWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        to: address,
        amount: u64,
    }

    public entry fun claim<T0>(arg0: &mut ClaimVault<T0>, arg1: u64, arg2: address, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 1);
        assert!(arg2 != @0x0, 1);
        assert!(arg3 > 0, 1);
        assert!(!0x2::table::contains<u64, bool>(&arg0.used_biz_ids, arg1), 3);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg3, 4);
        let v0 = 0x2::object::id<ClaimVault<T0>>(arg0);
        let v1 = ClaimMessage{
            vault_id : v0,
            biz_id   : arg1,
            to       : arg2,
            amount   : arg3,
        };
        let v2 = 0x1::bcs::to_bytes<ClaimMessage>(&v1);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg4, &arg0.signer_pubkey, &v2, 0), 2);
        0x2::table::add<u64, bool>(&mut arg0.used_biz_ids, arg1, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg3), arg5), arg2);
        let v3 = Claimed{
            vault_id : v0,
            biz_id   : arg1,
            to       : arg2,
            amount   : arg3,
        };
        0x2::event::emit<Claimed>(v3);
    }

    public entry fun create_vault<T0>(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) > 0, 1);
        let v0 = ClaimVault<T0>{
            id            : 0x2::object::new(arg2),
            signer_pubkey : arg1,
            used_biz_ids  : 0x2::table::new<u64, bool>(arg2),
            balance       : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<ClaimVault<T0>>(v0);
    }

    public entry fun deposit<T0>(arg0: &mut ClaimVault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = Deposited{
            vault_id : 0x2::object::id<ClaimVault<T0>>(arg0),
            amount   : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<Deposited>(v0);
    }

    public entry fun emergency_withdraw<T0>(arg0: &AdminCap, arg1: &mut ClaimVault<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 != @0x0, 1);
        let v0 = 0x2::balance::value<T0>(&arg1.balance);
        let v1 = if (arg2 == 0) {
            v0
        } else {
            arg2
        };
        assert!(v1 > 0, 1);
        assert!(v0 >= v1, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v1), arg4), arg3);
        let v2 = EmergencyWithdrawn{
            vault_id : 0x2::object::id<ClaimVault<T0>>(arg1),
            to       : arg3,
            amount   : v1,
        };
        0x2::event::emit<EmergencyWithdrawn>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun set_signer<T0>(arg0: &AdminCap, arg1: &mut ClaimVault<T0>, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg2) > 0, 1);
        arg1.signer_pubkey = arg2;
        let v0 = SignerUpdated{vault_id: 0x2::object::id<ClaimVault<T0>>(arg1)};
        0x2::event::emit<SignerUpdated>(v0);
    }

    public fun vault_balance<T0>(arg0: &ClaimVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    // decompiled from Move bytecode v6
}

