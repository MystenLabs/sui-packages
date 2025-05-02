module 0xc7a2920684a964965529e74d345270bbcd538aff714a1c78b32f85a9e3abc7c0::vault_private {
    struct Vault {
        balance: u64,
    }

    struct Owner {
        address: address,
    }

    struct SecurityKey {
        key: vector<u8>,
    }

    public fun authenticate(arg0: &Owner, arg1: vector<u8>, arg2: address) {
        assert!(arg0.address == arg2, 1);
        assert!(arg1 == x"010203", 4);
    }

    public fun create_owner(arg0: address) : Owner {
        Owner{address: arg0}
    }

    public fun create_security_key(arg0: vector<u8>) : SecurityKey {
        SecurityKey{key: arg0}
    }

    public fun create_vault(arg0: u64) : Vault {
        Vault{balance: arg0}
    }

    public fun deposit(arg0: &mut Vault, arg1: u64) {
        arg0.balance = arg0.balance + arg1;
    }

    public fun get_balance(arg0: &Vault) : u64 {
        arg0.balance
    }

    public fun get_owner(arg0: &Owner) : address {
        arg0.address
    }

    public fun get_security_key(arg0: &Owner, arg1: &SecurityKey, arg2: address) : vector<u8> {
        assert!(arg0.address == arg2, 3);
        arg1.key
    }

    public fun transfer(arg0: &mut Vault, arg1: address, arg2: u64) {
        assert!(arg0.balance >= arg2, 2);
        arg0.balance = arg0.balance - arg2;
    }

    public fun transfer_ownership(arg0: &mut Owner, arg1: address, arg2: address) {
        assert!(arg0.address == arg2, 1);
        arg0.address = arg1;
    }

    public fun update_security_key(arg0: &mut Owner, arg1: &mut SecurityKey, arg2: vector<u8>, arg3: address) {
        assert!(arg0.address == arg3, 3);
        arg1.key = arg2;
    }

    public fun withdraw(arg0: &mut Vault, arg1: u64) : bool {
        if (arg0.balance >= arg1) {
            arg0.balance = arg0.balance - arg1;
            true
        } else {
            false
        }
    }

    // decompiled from Move bytecode v6
}

