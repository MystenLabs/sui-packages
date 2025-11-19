module 0xe76387c93b70d3d5eeda612e6ca1ea19c6aa983e0dd945daf0a3ada6dc64c4f6::vault {
    struct VAULT has drop {
        dummy_field: bool,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        whitelist: 0x2::table::Table<address, bool>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        creator: address,
    }

    public entry fun add_to_whitelist<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: address) {
        0x2::table::add<address, bool>(&mut arg1.whitelist, arg2, true);
    }

    public entry fun admin_withdraw_all<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun create_vault<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = Vault<T0>{
            id        : v0,
            balance   : 0x2::balance::zero<T0>(),
            whitelist : 0x2::table::new<address, bool>(arg0),
        };
        let v2 = VaultCreated{
            vault_id  : 0x2::object::uid_to_inner(&v0),
            coin_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            creator   : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<VaultCreated>(v2);
        0x2::transfer::share_object<Vault<T0>>(v1);
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun get_balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_whitelisted<T0>(arg0: &Vault<T0>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.whitelist, arg1)
    }

    public entry fun remove_from_whitelist<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: address) {
        0x2::table::remove<address, bool>(&mut arg1.whitelist, arg2);
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_whitelisted<T0>(arg0, 0x2::tx_context::sender(arg2)), 4003);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 4002);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

