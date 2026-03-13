module 0x98b6321910faa4f593131f394e1a5485bded69ee9e446c958c714946354b1302::vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
    }

    public fun create_account_cap(arg0: &mut 0x2::tx_context::TxContext) : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg0)
    }

    public fun create_user_vault(arg0: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg1: &mut 0x2::tx_context::TxContext) : Vault {
        Vault{
            id          : 0x2::object::new(arg1),
            account_cap : arg0,
        }
    }

    public fun get_account_owner(arg0: &Vault) : address {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.account_cap)
    }

    public fun get_platform_account_cap_id() : address {
        @0xd906a3250a4c70ff788697e24a417230a74cc38756f91e0d564843eb4a727df4
    }

    public fun get_platform_address() : address {
        @0x630814b75b95971c98ac1763e466b1276c0eb5be36526c235497ca975dc0660c
    }

    // decompiled from Move bytecode v6
}

