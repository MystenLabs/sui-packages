module 0xb1309b1547968f2256e77dcd4b43a9f0d3aa1b0af5cad460432581f439e33c60::vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        claimed_nonces: 0x2::table::Table<u64, bool>,
        public_key: vector<u8>,
        version: u64,
    }

    struct VaultCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        initial_amount: u64,
    }

    struct DepositEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        depositor: address,
    }

    struct WithdrawEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        withdrawer: address,
    }

    struct ClaimEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        nonce: u64,
        receiver: address,
    }

    struct VaultDeletedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        sender: address,
    }

    struct ClaimStruct has drop {
        vault_id: 0x2::object::ID,
        receiver: address,
        amount: u64,
        nonce: u64,
    }

    public fun assert_vault_version<T0>(arg0: &Vault<T0>) {
        assert!(arg0.version == 1, 1);
    }

    public fun change_public_key<T0>(arg0: &mut Vault<T0>, arg1: &0xb1309b1547968f2256e77dcd4b43a9f0d3aa1b0af5cad460432581f439e33c60::giverep_claim::SuperAdmin, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xb1309b1547968f2256e77dcd4b43a9f0d3aa1b0af5cad460432581f439e33c60::giverep_claim::is_super_admin(arg1, 0x2::tx_context::sender(arg3)), 1);
        arg0.public_key = arg2;
    }

    public fun claim_by_signature<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = create_claim_struct(0x2::object::id<Vault<T0>>(arg0), v0, arg1, arg2);
        let v2 = 0x2::bcs::to_bytes<ClaimStruct>(&v1);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.public_key, &v2), 0);
        internal_claim_to_address<T0>(arg0, arg1, arg2, v0, arg4);
    }

    public fun create_claim_struct(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) : ClaimStruct {
        ClaimStruct{
            vault_id : arg0,
            receiver : arg1,
            amount   : arg2,
            nonce    : arg3,
        }
    }

    public fun create_vault<T0>(arg0: &0xb1309b1547968f2256e77dcd4b43a9f0d3aa1b0af5cad460432581f439e33c60::giverep_claim::SuperAdmin, arg1: vector<u8>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xb1309b1547968f2256e77dcd4b43a9f0d3aa1b0af5cad460432581f439e33c60::giverep_claim::is_super_admin(arg0, 0x2::tx_context::sender(arg3)), 1);
        let v0 = Vault<T0>{
            id             : 0x2::object::new(arg3),
            balance        : 0x2::coin::into_balance<T0>(arg2),
            claimed_nonces : 0x2::table::new<u64, bool>(arg3),
            public_key     : arg1,
            version        : 1,
        };
        let v1 = VaultCreatedEvent{
            vault_id       : 0x2::object::id<Vault<T0>>(&v0),
            initial_amount : 0x2::balance::value<T0>(&v0.balance),
        };
        0x2::event::emit<VaultCreatedEvent>(v1);
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public fun delete_multiple_nonce_fields<T0>(arg0: &mut Vault<T0>, arg1: &0xb1309b1547968f2256e77dcd4b43a9f0d3aa1b0af5cad460432581f439e33c60::giverep_claim::SuperAdmin, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xb1309b1547968f2256e77dcd4b43a9f0d3aa1b0af5cad460432581f439e33c60::giverep_claim::is_super_admin(arg1, 0x2::tx_context::sender(arg3)), 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            0x2::table::remove<u64, bool>(&mut arg0.claimed_nonces, *0x1::vector::borrow<u64>(&arg2, v0));
            v0 = v0 + 1;
        };
    }

    public fun delete_nonce_fields<T0>(arg0: &mut Vault<T0>, arg1: &0xb1309b1547968f2256e77dcd4b43a9f0d3aa1b0af5cad460432581f439e33c60::giverep_claim::SuperAdmin, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xb1309b1547968f2256e77dcd4b43a9f0d3aa1b0af5cad460432581f439e33c60::giverep_claim::is_super_admin(arg1, 0x2::tx_context::sender(arg3)), 1);
        0x2::table::remove<u64, bool>(&mut arg0.claimed_nonces, arg2);
    }

    public fun delete_vault<T0>(arg0: Vault<T0>, arg1: &0xb1309b1547968f2256e77dcd4b43a9f0d3aa1b0af5cad460432581f439e33c60::giverep_claim::SuperAdmin, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xb1309b1547968f2256e77dcd4b43a9f0d3aa1b0af5cad460432581f439e33c60::giverep_claim::is_super_admin(arg1, 0x2::tx_context::sender(arg2)), 1);
        assert_vault_version<T0>(&arg0);
        let Vault {
            id             : v0,
            balance        : v1,
            claimed_nonces : v2,
            public_key     : _,
            version        : _,
        } = arg0;
        let v5 = VaultDeletedEvent{
            vault_id : 0x2::object::id<Vault<T0>>(&arg0),
            sender   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<VaultDeletedEvent>(v5);
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v1);
        0x2::table::destroy_empty<u64, bool>(v2);
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: &0xb1309b1547968f2256e77dcd4b43a9f0d3aa1b0af5cad460432581f439e33c60::giverep_claim::SuperAdmin, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xb1309b1547968f2256e77dcd4b43a9f0d3aa1b0af5cad460432581f439e33c60::giverep_claim::is_super_admin(arg1, 0x2::tx_context::sender(arg3)), 1);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg2));
        let v0 = DepositEvent<T0>{
            vault_id  : 0x2::object::id<Vault<T0>>(arg0),
            amount    : 0x2::coin::value<T0>(&arg2),
            depositor : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<DepositEvent<T0>>(v0);
    }

    public fun get_balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_public_key<T0>(arg0: &Vault<T0>) : &vector<u8> {
        &arg0.public_key
    }

    fun internal_claim_to_address<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<u64, bool>(&arg0.claimed_nonces, arg2), 2);
        assert_vault_version<T0>(arg0);
        let v0 = ClaimEvent<T0>{
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
            amount   : arg1,
            nonce    : arg2,
            receiver : arg3,
        };
        0x2::event::emit<ClaimEvent<T0>>(v0);
        0x2::table::add<u64, bool>(&mut arg0.claimed_nonces, arg2, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg4), arg3);
    }

    public fun is_nonce_used<T0>(arg0: &Vault<T0>, arg1: u64) : bool {
        0x2::table::contains<u64, bool>(&arg0.claimed_nonces, arg1)
    }

    public fun migrate_vault<T0>(arg0: &mut Vault<T0>, arg1: &0xb1309b1547968f2256e77dcd4b43a9f0d3aa1b0af5cad460432581f439e33c60::giverep_claim::SuperAdmin, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xb1309b1547968f2256e77dcd4b43a9f0d3aa1b0af5cad460432581f439e33c60::giverep_claim::is_super_admin(arg1, 0x2::tx_context::sender(arg2)), 1);
        assert!(arg0.version <= 1, 1);
        arg0.version = 1;
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: &0xb1309b1547968f2256e77dcd4b43a9f0d3aa1b0af5cad460432581f439e33c60::giverep_claim::SuperAdmin, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0xb1309b1547968f2256e77dcd4b43a9f0d3aa1b0af5cad460432581f439e33c60::giverep_claim::is_super_admin(arg1, 0x2::tx_context::sender(arg3)), 1);
        let v0 = WithdrawEvent<T0>{
            vault_id   : 0x2::object::id<Vault<T0>>(arg0),
            amount     : arg2,
            withdrawer : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<WithdrawEvent<T0>>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

