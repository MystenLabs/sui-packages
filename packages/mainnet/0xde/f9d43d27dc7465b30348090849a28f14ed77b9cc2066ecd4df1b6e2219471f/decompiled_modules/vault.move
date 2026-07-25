module 0xdef9d43d27dc7465b30348090849a28f14ed77b9cc2066ecd4df1b6e2219471f::vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        deployer: address,
        bots: 0x2::table::Table<address, bool>,
        version: u64,
        emergency_paused: bool,
    }

    struct VaultCreated has copy, drop {
        deployer: address,
        vault_id: 0x2::object::ID,
    }

    struct BotAdded has copy, drop {
        vault_id: 0x2::object::ID,
        bot: address,
    }

    struct BotRemoved has copy, drop {
        vault_id: 0x2::object::ID,
        bot: address,
    }

    struct TokenDeposited has copy, drop {
        vault_id: 0x2::object::ID,
        depositor: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct TokenWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        recipient: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct EmergencyPause has copy, drop {
        vault_id: 0x2::object::ID,
        paused: bool,
    }

    public fun add_bot(arg0: &AdminCap, arg1: &mut Vault, arg2: address) {
        assert!(!arg1.emergency_paused, 2);
        0x2::table::add<address, bool>(&mut arg1.bots, arg2, true);
        let v0 = BotAdded{
            vault_id : 0x2::object::uid_to_inner(&arg1.id),
            bot      : arg2,
        };
        0x2::event::emit<BotAdded>(v0);
    }

    public(friend) fun assert_authorized(arg0: &Vault, arg1: &0x2::tx_context::TxContext) {
        assert!(!arg0.emergency_paused, 2);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.deployer || 0x2::table::contains<address, bool>(&arg0.bots, v0), 1);
    }

    public fun deployer(arg0: &Vault) : address {
        arg0.deployer
    }

    public fun deposit<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_authorized(arg0, arg2);
        let v0 = 0x2::coin::value<T0>(&arg1);
        deposit_coin<T0>(arg0, arg1);
        if (v0 > 0) {
            let v1 = TokenDeposited{
                vault_id  : 0x2::object::uid_to_inner(&arg0.id),
                depositor : 0x2::tx_context::sender(arg2),
                coin_type : 0x1::type_name::with_defining_ids<T0>(),
                amount    : v0,
            };
            0x2::event::emit<TokenDeposited>(v1);
        };
    }

    public(friend) fun deposit_coin<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x2::balance::destroy_zero<T0>(v0);
        } else {
            let v1 = 0x1::type_name::with_defining_ids<T0>();
            if (0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, v1)) {
                0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v1), v0);
            } else {
                0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v1, v0);
            };
        };
    }

    public fun emergency_pause(arg0: &AdminCap, arg1: &mut Vault, arg2: bool) {
        arg1.emergency_paused = arg2;
        let v0 = EmergencyPause{
            vault_id : 0x2::object::uid_to_inner(&arg1.id),
            paused   : arg2,
        };
        0x2::event::emit<EmergencyPause>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Vault{
            id               : 0x2::object::new(arg0),
            deployer         : 0x2::tx_context::sender(arg0),
            bots             : 0x2::table::new<address, bool>(arg0),
            version          : 1,
            emergency_paused : false,
        };
        let v2 = VaultCreated{
            deployer : 0x2::tx_context::sender(arg0),
            vault_id : 0x2::object::uid_to_inner(&v1.id),
        };
        0x2::event::emit<VaultCreated>(v2);
        0x2::transfer::share_object<Vault>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_authorized(arg0: &Vault, arg1: address) : bool {
        arg1 == arg0.deployer || 0x2::table::contains<address, bool>(&arg0.bots, arg1)
    }

    public fun is_paused(arg0: &Vault) : bool {
        arg0.emergency_paused
    }

    public fun remove_bot(arg0: &AdminCap, arg1: &mut Vault, arg2: address) {
        assert!(!arg1.emergency_paused, 2);
        0x2::table::remove<address, bool>(&mut arg1.bots, arg2);
        let v0 = BotRemoved{
            vault_id : 0x2::object::uid_to_inner(&arg1.id),
            bot      : arg2,
        };
        0x2::event::emit<BotRemoved>(v0);
    }

    public fun sync_package_version(arg0: &AdminCap, arg1: &mut Vault) {
        arg1.version = arg1.version + 1;
    }

    public(friend) fun vault_id(arg0: &Vault) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun version(arg0: &Vault) : u64 {
        arg0.version
    }

    public fun withdraw<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_authorized(arg0, arg2);
        let v0 = withdraw_coin<T0>(arg0, arg1, arg2);
        let v1 = TokenWithdrawn{
            vault_id  : 0x2::object::uid_to_inner(&arg0.id),
            recipient : 0x2::tx_context::sender(arg2),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : arg1,
        };
        0x2::event::emit<TokenWithdrawn>(v1);
        v0
    }

    public(friend) fun withdraw_coin<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (arg1 == 0 || !0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, v0)) {
            0x2::coin::zero<T0>(arg2)
        } else {
            let v2 = 0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
            if (0x2::balance::value<T0>(&v2) > 0) {
                0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, v2);
            } else {
                0x2::balance::destroy_zero<T0>(v2);
            };
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, arg1), arg2)
        }
    }

    // decompiled from Move bytecode v7
}

