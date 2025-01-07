module 0xa96f17b56e1da636fa7c52940f4afa4aa2b33826b275649f0fa134f646a9a020::permissioned_vault {
    struct PermissionedVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        master_key: vector<u8>,
        nonce: u64,
        active: bool,
    }

    struct VaultCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    public fun deposit<T0: drop>(arg0: &mut PermissionedVault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun new_permissioned_vault<T0: drop>(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : (PermissionedVault<T0>, VaultCap) {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 5);
        let v0 = PermissionedVault<T0>{
            id         : 0x2::object::new(arg1),
            balance    : 0x2::balance::zero<T0>(),
            master_key : arg0,
            nonce      : 0,
            active     : true,
        };
        let v1 = VaultCap{
            id       : 0x2::object::new(arg1),
            vault_id : 0x2::object::id<PermissionedVault<T0>>(&v0),
        };
        (v0, v1)
    }

    public fun set_vault_active_status<T0: drop>(arg0: &VaultCap, arg1: &mut PermissionedVault<T0>, arg2: bool) {
        assert!(0x2::object::id<PermissionedVault<T0>>(arg1) == arg0.vault_id, 3);
        arg1.active = arg2;
    }

    public fun share_vault<T0: drop>(arg0: PermissionedVault<T0>) {
        0x2::transfer::share_object<PermissionedVault<T0>>(arg0);
    }

    public fun update_master_key<T0: drop>(arg0: &mut PermissionedVault<T0>, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 5);
        arg0.master_key = arg1;
    }

    public fun validate_master_signature<T0: drop>(arg0: vector<u8>, arg1: vector<u8>, arg2: &PermissionedVault<T0>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<PermissionedVault<T0>>(arg2);
        let v1 = 0x2::bcs::new(arg1);
        assert!(0x2::bcs::peel_vec_u8(&mut v1) == b"Permissioned vault withdraw|", 2);
        assert!(0x2::bcs::peel_address(&mut v1) == 0x2::object::id_to_address(&v0), 2);
        assert!(0x2::bcs::peel_address(&mut v1) == 0x2::tx_context::sender(arg4), 2);
        assert!(0x2::bcs::peel_u64(&mut v1) == arg3, 2);
        assert!(0x2::bcs::peel_u64(&mut v1) == arg2.nonce, 2);
        assert!(0x2::ed25519::ed25519_verify(&arg0, &arg2.master_key, &arg1), 1);
    }

    public fun withdraw<T0: drop>(arg0: &mut PermissionedVault<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.active, 4);
        validate_master_signature<T0>(arg2, arg1, arg0, arg3, arg4);
        arg0.nonce = arg0.nonce + 1;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg3), arg4)
    }

    public fun withdraw_with_vault_cap<T0: drop>(arg0: &VaultCap, arg1: &mut PermissionedVault<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::id<PermissionedVault<T0>>(arg1) == arg0.vault_id, 3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance)), arg2)
    }

    // decompiled from Move bytecode v6
}

