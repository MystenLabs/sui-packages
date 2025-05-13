module 0xc465e4a1cd83a3113340199dde747a2794b923c48198fde7b63cdfa4e0e351a::vault_private {
    struct Vault has store, key {
        id: 0x2::object::UID,
        balance: u64,
    }

    struct Owner has store, key {
        id: 0x2::object::UID,
        address: address,
    }

    struct SecurityKey has store {
        key: vector<u8>,
    }

    public fun transfer(arg0: &mut Vault, arg1: &mut Vault, arg2: u64) {
        assert!(arg0.balance >= arg2, 2);
        arg0.balance = arg0.balance - arg2;
        arg1.balance = arg1.balance + arg2;
    }

    public fun create_owner(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : Owner {
        Owner{
            id      : 0x2::object::new(arg1),
            address : arg0,
        }
    }

    public fun create_security_key(arg0: vector<u8>) : SecurityKey {
        SecurityKey{key: arg0}
    }

    public entry fun create_vault(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id      : 0x2::object::new(arg0),
            balance : 0,
        };
        0x2::transfer::transfer<Vault>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun deposit(arg0: &mut Vault, arg1: u64) {
        arg0.balance = arg0.balance + arg1;
    }

    public fun get_balance(arg0: &Vault) : u64 {
        arg0.balance
    }

    public fun get_owner_address(arg0: &Owner) : address {
        arg0.address
    }

    public fun get_security_key(arg0: &Owner, arg1: &SecurityKey, arg2: address) : vector<u8> {
        assert!(arg0.address == arg2, 3);
        arg1.key
    }

    public fun request_funding_from_other_vault(arg0: &Owner, arg1: &Owner, arg2: &mut Vault, arg3: &mut Vault, arg4: u64, arg5: address) {
        assert!(arg0.address == arg5, 7);
        assert!(arg1.address != arg5, 8);
        assert!(arg2.balance >= arg4, 9);
        arg2.balance = arg2.balance - arg4;
        arg3.balance = arg3.balance + arg4;
    }

    public entry fun send_sui_to_vault(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut Vault, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 4319421160000000000;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= v0, 1);
        let v1 = 0x2::coin::split<0x2::sui::SUI>(arg0, v0, arg2);
        deposit(arg1, 0x2::coin::value<0x2::sui::SUI>(&v1));
        0x2::coin::destroy_zero<0x2::sui::SUI>(v1);
    }

    public fun transfer_ownership(arg0: &mut Owner, arg1: address, arg2: address) {
        assert!(arg0.address == arg2, 1);
        arg0.address = arg1;
    }

    public fun update_security_key(arg0: &Owner, arg1: &mut SecurityKey, arg2: vector<u8>, arg3: address) {
        assert!(arg0.address == arg3, 4);
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

