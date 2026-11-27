module 0xfc6397dc6d8bdaade8f5713ac80c4373337a9f77b714717a2174dccb3af2f316::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        version: u64,
        executors: 0x2::table::Table<address, bool>,
        bridge_caps: 0x2::table::Table<0x2::object::ID, address>,
        accounting: 0xfc6397dc6d8bdaade8f5713ac80c4373337a9f77b714717a2174dccb3af2f316::accounting::Accounting,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct BridgeCap has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = 0x2::object::new(arg0);
        let v1 = Vault{
            id          : v0,
            version     : 1,
            executors   : 0x2::table::new<address, bool>(arg0),
            bridge_caps : 0x2::table::new<0x2::object::ID, address>(arg0),
            accounting  : 0xfc6397dc6d8bdaade8f5713ac80c4373337a9f77b714717a2174dccb3af2f316::accounting::new(arg0),
        };
        0x2::transfer::share_object<Vault>(v1);
        AdminCap{
            id       : 0x2::object::new(arg0),
            vault_id : 0x2::object::uid_to_inner(&v0),
        }
    }

    public fun accounting_of<T0>(arg0: &Vault, arg1: address) : (bool, u128) {
        0xfc6397dc6d8bdaade8f5713ac80c4373337a9f77b714717a2174dccb3af2f316::accounting::position_of<T0>(&arg0.accounting, arg1)
    }

    public fun admin_withdraw<T0>(arg0: &mut Vault, arg1: &AdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin_cap(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(split_balance<T0>(arg0, arg2), arg4), arg3);
        0xfc6397dc6d8bdaade8f5713ac80c4373337a9f77b714717a2174dccb3af2f316::events::emit_admin_withdrawn(0x1::type_name::with_defining_ids<T0>(), arg2, arg3);
    }

    public(friend) fun apply_accounting(arg0: &mut Vault, arg1: address, arg2: 0x1::type_name::TypeName, arg3: bool, arg4: u128) {
        0xfc6397dc6d8bdaade8f5713ac80c4373337a9f77b714717a2174dccb3af2f316::accounting::apply(&mut arg0.accounting, arg1, arg2, arg3, arg4);
    }

    fun assert_admin_cap(arg0: &Vault, arg1: &AdminCap) {
        assert!(arg1.vault_id == 0x2::object::uid_to_inner(&arg0.id), 3);
    }

    public(friend) fun assert_executor(arg0: &Vault, arg1: address) {
        assert!(is_executor(arg0, arg1), 0);
    }

    public(friend) fun assert_version(arg0: &Vault) {
        assert!(arg0.version == 1, 2);
    }

    public fun bridge_withdraw<T0>(arg0: &mut Vault, arg1: &BridgeCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg1.vault_id == 0x2::object::uid_to_inner(&arg0.id), 3);
        assert!(0x2::table::contains<0x2::object::ID, address>(&arg0.bridge_caps, 0x2::object::id<BridgeCap>(arg1)), 5);
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(split_balance<T0>(arg0, arg2), arg3), v0);
        0xfc6397dc6d8bdaade8f5713ac80c4373337a9f77b714717a2174dccb3af2f316::events::emit_bridge_withdrawn(0x1::type_name::with_defining_ids<T0>(), arg2, v0);
    }

    public fun deposit<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        join_balance<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
        0xfc6397dc6d8bdaade8f5713ac80c4373337a9f77b714717a2174dccb3af2f316::events::emit_deposited(0x1::type_name::with_defining_ids<T0>(), 0x2::coin::value<T0>(&arg1), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = new(arg0);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_bridge_cap_active(arg0: &Vault, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, address>(&arg0.bridge_caps, arg1)
    }

    public fun is_executor(arg0: &Vault, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.executors, arg1)
    }

    public fun issue_bridge_cap(arg0: &mut Vault, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin_cap(arg0, arg1);
        let v0 = BridgeCap{
            id       : 0x2::object::new(arg3),
            vault_id : 0x2::object::uid_to_inner(&arg0.id),
        };
        let v1 = 0x2::object::id<BridgeCap>(&v0);
        0x2::table::add<0x2::object::ID, address>(&mut arg0.bridge_caps, v1, arg2);
        0xfc6397dc6d8bdaade8f5713ac80c4373337a9f77b714717a2174dccb3af2f316::events::emit_bridge_cap_issued(v1, arg2);
        0x2::transfer::transfer<BridgeCap>(v0, arg2);
    }

    fun join_balance<T0>(arg0: &Vault, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::send_funds<T0>(arg1, 0x2::object::uid_to_address(&arg0.id));
    }

    public fun migrate(arg0: &mut Vault, arg1: &AdminCap) {
        assert_admin_cap(arg0, arg1);
        assert!(arg0.version < 1, 4);
        arg0.version = 1;
    }

    public(friend) fun put<T0>(arg0: &Vault, arg1: 0x2::coin::Coin<T0>) {
        join_balance<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun revoke_bridge_cap(arg0: &mut Vault, arg1: &AdminCap, arg2: 0x2::object::ID) {
        assert_version(arg0);
        assert_admin_cap(arg0, arg1);
        if (0x2::table::contains<0x2::object::ID, address>(&arg0.bridge_caps, arg2)) {
            0x2::table::remove<0x2::object::ID, address>(&mut arg0.bridge_caps, arg2);
        };
        0xfc6397dc6d8bdaade8f5713ac80c4373337a9f77b714717a2174dccb3af2f316::events::emit_bridge_cap_revoked(arg2);
    }

    public fun set_executor(arg0: &mut Vault, arg1: &AdminCap, arg2: address, arg3: bool) {
        assert_version(arg0);
        assert_admin_cap(arg0, arg1);
        if (arg3) {
            if (!0x2::table::contains<address, bool>(&arg0.executors, arg2)) {
                0x2::table::add<address, bool>(&mut arg0.executors, arg2, true);
            };
        } else if (0x2::table::contains<address, bool>(&arg0.executors, arg2)) {
            0x2::table::remove<address, bool>(&mut arg0.executors, arg2);
        };
        0xfc6397dc6d8bdaade8f5713ac80c4373337a9f77b714717a2174dccb3af2f316::events::emit_executor_set(arg2, arg3);
    }

    fun split_balance<T0>(arg0: &mut Vault, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(&mut arg0.id, arg1))
    }

    public(friend) fun take<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(split_balance<T0>(arg0, arg1), arg2)
    }

    public(friend) fun uid(arg0: &Vault) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut Vault) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun version(arg0: &Vault) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

