module 0xd5aa6f6bbc694069c19d2b1fe6af162c75298a06da735dd5209b9612f34c13ac::x_vault {
    struct XVaultRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        paused: bool,
    }

    struct XVault has key {
        id: 0x2::object::UID,
        x_user_id: u64,
        owner: address,
        recovery_counter: u64,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct VaultClaimed has copy, drop {
        x_user_id: u64,
        vault_id: address,
        owner: address,
    }

    struct FundsSwept has copy, drop {
        vault_id: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct FundsWithdrawn has copy, drop {
        vault_id: address,
        owner: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct OwnerUpdated has copy, drop {
        x_user_id: u64,
        vault_id: address,
        old_owner: address,
        new_owner: address,
        next_recovery_counter: u64,
    }

    struct RegistryPaused has copy, drop {
        registry_id: address,
        admin: address,
    }

    struct RegistryUnpaused has copy, drop {
        registry_id: address,
        admin: address,
    }

    struct RegistryCreated has copy, drop {
        registry_id: address,
        admin: address,
    }

    fun assert_registry_active(arg0: &XVaultRegistry) {
        assert!(!arg0.paused, 7);
    }

    public fun claim_vault(arg0: &mut XVaultRegistry, arg1: &0xd5aa6f6bbc694069c19d2b1fe6af162c75298a06da735dd5209b9612f34c13ac::nautilus_verifier::EnclaveRegistry, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : XVault {
        assert_registry_active(arg0);
        assert!(0x2::tx_context::sender(arg8) == arg3, 1);
        0xd5aa6f6bbc694069c19d2b1fe6af162c75298a06da735dd5209b9612f34c13ac::nautilus_verifier::verify_attestation(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v0 = 0x2::derived_object::claim<u64>(&mut arg0.id, arg2);
        let v1 = XVault{
            id               : v0,
            x_user_id        : arg2,
            owner            : arg3,
            recovery_counter : 0,
        };
        let v2 = VaultClaimed{
            x_user_id : arg2,
            vault_id  : 0x2::object::uid_to_address(&v0),
            owner     : arg3,
        };
        0x2::event::emit<VaultClaimed>(v2);
        v1
    }

    public fun derive_vault_address(arg0: &XVaultRegistry, arg1: u64) : address {
        0x2::derived_object::derive_address<u64>(0x2::object::uid_to_inner(&arg0.id), arg1)
    }

    fun event_coin_type<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = XVaultRegistry{
            id     : 0x2::object::new(arg0),
            admin  : v0,
            paused : false,
        };
        let v2 = RegistryCreated{
            registry_id : 0x2::object::uid_to_address(&v1.id),
            admin       : v0,
        };
        0x2::event::emit<RegistryCreated>(v2);
        0x2::transfer::share_object<XVaultRegistry>(v1);
    }

    fun is_coin_object_type<T0>() : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x1::type_name::address_string(&v0) == 0x1::ascii::string(b"0000000000000000000000000000000000000000000000000000000000000002")) {
            if (0x1::type_name::module_string(&v0) == 0x1::ascii::string(b"coin")) {
                0x1::type_name::datatype_string(&v0) == 0x1::ascii::string(b"Coin")
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun pause(arg0: &mut XVaultRegistry, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 6);
        assert!(!arg0.paused, 9);
        arg0.paused = true;
        let v0 = RegistryPaused{
            registry_id : 0x2::object::uid_to_address(&arg0.id),
            admin       : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<RegistryPaused>(v0);
    }

    public fun rescue_object<T0: store + key>(arg0: &XVaultRegistry, arg1: &mut XVault, arg2: 0x2::transfer::Receiving<T0>, arg3: &0x2::tx_context::TxContext) : T0 {
        assert_registry_active(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 0);
        assert!(!is_coin_object_type<T0>(), 3);
        0x2::transfer::public_receive<T0>(&mut arg1.id, arg2)
    }

    public fun sweep_coin_to_vault<T0>(arg0: &XVaultRegistry, arg1: &mut XVault, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        assert_registry_active(arg0);
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg1.id, arg2);
        let v1 = 0x2::coin::value<T0>(&v0);
        if (v1 == 0) {
            0x2::coin::destroy_zero<T0>(v0);
            return
        };
        let v2 = BalanceKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<BalanceKey<T0>>(&arg1.id, v2)) {
            0x2::coin::join<T0>(0x2::dynamic_field::borrow_mut<BalanceKey<T0>, 0x2::coin::Coin<T0>>(&mut arg1.id, v2), v0);
        } else {
            0x2::dynamic_field::add<BalanceKey<T0>, 0x2::coin::Coin<T0>>(&mut arg1.id, v2, v0);
        };
        let v3 = FundsSwept{
            vault_id  : 0x2::object::uid_to_address(&arg1.id),
            coin_type : event_coin_type<T0>(),
            amount    : v1,
        };
        0x2::event::emit<FundsSwept>(v3);
    }

    public fun transfer_vault(arg0: XVault, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::transfer<XVault>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun unpause(arg0: &mut XVaultRegistry, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 6);
        assert!(arg0.paused, 10);
        arg0.paused = false;
        let v0 = RegistryUnpaused{
            registry_id : 0x2::object::uid_to_address(&arg0.id),
            admin       : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<RegistryUnpaused>(v0);
    }

    public fun update_owner(arg0: &XVaultRegistry, arg1: &0xd5aa6f6bbc694069c19d2b1fe6af162c75298a06da735dd5209b9612f34c13ac::nautilus_verifier::EnclaveRegistry, arg2: XVault, arg3: address, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_registry_active(arg0);
        assert!(0x2::tx_context::sender(arg7) == arg2.owner, 0);
        assert!(arg3 != arg2.owner, 8);
        let v0 = arg2.owner;
        let v1 = 0x2::object::uid_to_address(&arg2.id);
        let v2 = arg2.recovery_counter;
        0xd5aa6f6bbc694069c19d2b1fe6af162c75298a06da735dd5209b9612f34c13ac::nautilus_verifier::verify_owner_recovery_attestation(arg1, arg2.x_user_id, v1, v0, arg3, v2, arg4, arg5, arg6);
        let v3 = v2 + 1;
        arg2.owner = arg3;
        arg2.recovery_counter = v3;
        let v4 = OwnerUpdated{
            x_user_id             : arg2.x_user_id,
            vault_id              : v1,
            old_owner             : v0,
            new_owner             : arg3,
            next_recovery_counter : v3,
        };
        0x2::event::emit<OwnerUpdated>(v4);
        0x2::transfer::transfer<XVault>(arg2, arg3);
    }

    public fun vault_balance<T0>(arg0: &XVault) : u64 {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<BalanceKey<T0>>(&arg0.id, v0)) {
            0x2::coin::value<T0>(0x2::dynamic_field::borrow<BalanceKey<T0>, 0x2::coin::Coin<T0>>(&arg0.id, v0))
        } else {
            0
        }
    }

    public fun vault_owner(arg0: &XVault) : address {
        arg0.owner
    }

    public fun vault_recovery_counter(arg0: &XVault) : u64 {
        arg0.recovery_counter
    }

    public fun vault_x_user_id(arg0: &XVault) : u64 {
        arg0.x_user_id
    }

    public fun withdraw<T0>(arg0: &XVaultRegistry, arg1: &mut XVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 0);
        assert!(arg2 > 0, 5);
        let v0 = BalanceKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<BalanceKey<T0>>(&arg1.id, v0), 4);
        let v1 = 0x2::dynamic_field::remove<BalanceKey<T0>, 0x2::coin::Coin<T0>>(&mut arg1.id, v0);
        assert!(0x2::coin::value<T0>(&v1) >= arg2, 2);
        let v2 = if (arg2 == 0x2::coin::value<T0>(&v1)) {
            v1
        } else {
            0x2::dynamic_field::add<BalanceKey<T0>, 0x2::coin::Coin<T0>>(&mut arg1.id, v0, v1);
            0x2::coin::split<T0>(&mut v1, arg2, arg3)
        };
        let v3 = FundsWithdrawn{
            vault_id  : 0x2::object::uid_to_address(&arg1.id),
            owner     : arg1.owner,
            coin_type : event_coin_type<T0>(),
            amount    : arg2,
        };
        0x2::event::emit<FundsWithdrawn>(v3);
        v2
    }

    public fun withdraw_all<T0>(arg0: &XVaultRegistry, arg1: &mut XVault, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 0);
        let v0 = BalanceKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<BalanceKey<T0>>(&arg1.id, v0), 4);
        let v1 = 0x2::dynamic_field::remove<BalanceKey<T0>, 0x2::coin::Coin<T0>>(&mut arg1.id, v0);
        let v2 = 0x2::coin::value<T0>(&v1);
        assert!(v2 > 0, 5);
        let v3 = FundsWithdrawn{
            vault_id  : 0x2::object::uid_to_address(&arg1.id),
            owner     : arg1.owner,
            coin_type : event_coin_type<T0>(),
            amount    : v2,
        };
        0x2::event::emit<FundsWithdrawn>(v3);
        v1
    }

    // decompiled from Move bytecode v6
}

