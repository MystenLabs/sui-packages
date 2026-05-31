module 0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::account {
    struct OsAccount has key {
        id: 0x2::object::UID,
        name: 0x1::option::Option<0x1::string::String>,
        parent_wallet_identity: address,
        signer: 0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::account::Account,
        delegates: 0x2::vec_map::VecMap<address, u32>,
        max_leverage_bps: u64,
        paused: bool,
        allowed_versions_packed: u64,
        created_at_ms: u64,
        margin_mode: u8,
    }

    struct ProtocolDataKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun id(arg0: &OsAccount) : 0x2::object::ID {
        0x2::object::id<OsAccount>(arg0)
    }

    public fun new(arg0: address, arg1: 0x1::option::Option<0x1::string::String>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : OsAccount {
        new_with_mode(arg0, arg1, arg2, 0, arg3, arg4)
    }

    public fun add_delegate(arg0: &mut OsAccount, arg1: address, arg2: u32, arg3: &0x2::tx_context::TxContext) {
        assert_perm(arg0, 0x2::tx_context::sender(arg3), 16);
        add_delegate_internal(arg0, arg1, arg2);
    }

    public fun add_delegate_by_request(arg0: &mut OsAccount, arg1: &0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::account::AccountRequest, arg2: address, arg3: u32) {
        assert_request(arg0, arg1, 16);
        add_delegate_internal(arg0, arg2, arg3);
    }

    fun add_delegate_internal(arg0: &mut OsAccount, arg1: address, arg2: u32) {
        assert!(!0x2::vec_map::contains<address, u32>(&arg0.delegates, &arg1), 3);
        assert!(0x2::vec_map::length<address, u32>(&arg0.delegates) < 16, 5);
        0x2::vec_map::insert<address, u32>(&mut arg0.delegates, arg1, arg2);
        0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::events::emit_delegate_added(0x2::object::id<OsAccount>(arg0), arg1, arg2);
    }

    public fun allow_version(arg0: &mut OsAccount, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        assert_perm(arg0, 0x2::tx_context::sender(arg2), 16);
        arg0.allowed_versions_packed = arg0.allowed_versions_packed | version_mask(arg1);
        0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::events::emit_version_allowed(0x2::object::id<OsAccount>(arg0), arg1);
    }

    public fun allowed_versions_packed(arg0: &OsAccount) : u64 {
        arg0.allowed_versions_packed
    }

    public fun assert_margin_mode(arg0: &OsAccount, arg1: u8) {
        assert!(arg0.margin_mode == arg1, 12);
    }

    public fun assert_not_paused(arg0: &OsAccount) {
        assert!(!arg0.paused, 6);
    }

    public fun assert_perm(arg0: &OsAccount, arg1: address, arg2: u32) {
        if (arg1 == arg0.parent_wallet_identity) {
            return
        };
        assert!(0x2::vec_map::contains<address, u32>(&arg0.delegates, &arg1), 2);
        assert!(*0x2::vec_map::get<address, u32>(&arg0.delegates, &arg1) & arg2 == arg2, 2);
    }

    public fun assert_request(arg0: &OsAccount, arg1: &0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::account::AccountRequest, arg2: u32) {
        assert_perm(arg0, 0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::account::request_address(arg1), arg2);
    }

    public fun assert_version(arg0: &OsAccount, arg1: u8) {
        assert!(arg0.allowed_versions_packed & version_mask(arg1) != 0, 9);
    }

    public fun borrow_data<T0, T1: store>(arg0: &OsAccount) : &T1 {
        let v0 = ProtocolDataKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ProtocolDataKey<T0>>(&arg0.id, v0), 8);
        0x2::dynamic_field::borrow<ProtocolDataKey<T0>, T1>(&arg0.id, v0)
    }

    public fun borrow_data_mut<T0: drop, T1: store>(arg0: &mut OsAccount, arg1: T0) : &mut T1 {
        let v0 = ProtocolDataKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ProtocolDataKey<T0>>(&arg0.id, v0), 8);
        0x2::dynamic_field::borrow_mut<ProtocolDataKey<T0>, T1>(&mut arg0.id, v0)
    }

    public fun create_and_share(arg0: &mut 0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::registry::WalletAccountRegistry, arg1: 0x1::option::Option<0x1::string::String>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = new(v0, arg1, arg2, arg3, arg4);
        0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::registry::register(arg0, 0x2::tx_context::sender(arg4), 0x2::object::id<OsAccount>(&v1));
        share(v1);
    }

    public fun create_and_share_for(arg0: &mut 0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::registry::WalletAccountRegistry, arg1: address, arg2: 0x1::option::Option<0x1::string::String>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new(arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::object::id<OsAccount>(&v0);
        0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::registry::register(arg0, arg1, v1);
        share(v0);
        v1
    }

    public fun created_at_ms(arg0: &OsAccount) : u64 {
        arg0.created_at_ms
    }

    public fun delegate_count(arg0: &OsAccount) : u64 {
        0x2::vec_map::length<address, u32>(&arg0.delegates)
    }

    public fun delegate_permissions(arg0: &OsAccount, arg1: address) : u32 {
        if (arg1 == arg0.parent_wallet_identity) {
            return 4294967295
        };
        assert!(0x2::vec_map::contains<address, u32>(&arg0.delegates, &arg1), 4);
        *0x2::vec_map::get<address, u32>(&arg0.delegates, &arg1)
    }

    public fun deposit_balance_for_protocol<T0: drop, T1>(arg0: &OsAccount, arg1: T0, arg2: 0x2::balance::Balance<T1>) {
        0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::account::send_balance<T1>(&arg0.signer, arg2);
    }

    public fun deposit_for_protocol<T0: drop, T1>(arg0: &OsAccount, arg1: T0, arg2: 0x2::coin::Coin<T1>) {
        0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::account::send_funds<T1>(&arg0.signer, arg2);
    }

    public fun disallow_version(arg0: &mut OsAccount, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        assert_perm(arg0, 0x2::tx_context::sender(arg2), 16);
        let v0 = version_mask(arg1);
        if (arg0.allowed_versions_packed & v0 != 0) {
            arg0.allowed_versions_packed = arg0.allowed_versions_packed - v0;
        };
        0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::events::emit_version_disallowed(0x2::object::id<OsAccount>(arg0), arg1);
    }

    public fun has_data<T0>(arg0: &OsAccount) : bool {
        let v0 = ProtocolDataKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists<ProtocolDataKey<T0>>(&arg0.id, v0)
    }

    public fun has_permission(arg0: &OsAccount, arg1: address, arg2: u32) : bool {
        if (arg1 == arg0.parent_wallet_identity) {
            return true
        };
        if (!0x2::vec_map::contains<address, u32>(&arg0.delegates, &arg1)) {
            return false
        };
        *0x2::vec_map::get<address, u32>(&arg0.delegates, &arg1) & arg2 == arg2
    }

    public fun is_cross_margin(arg0: &OsAccount) : bool {
        arg0.margin_mode == 1
    }

    public fun is_isolated_margin(arg0: &OsAccount) : bool {
        arg0.margin_mode == 0
    }

    public fun is_owner(arg0: &OsAccount, arg1: address) : bool {
        arg1 == arg0.parent_wallet_identity
    }

    public fun is_paused(arg0: &OsAccount) : bool {
        arg0.paused
    }

    public fun margin_mode(arg0: &OsAccount) : u8 {
        arg0.margin_mode
    }

    public fun margin_mode_cross() : u8 {
        1
    }

    public fun margin_mode_isolated() : u8 {
        0
    }

    public fun max_delegates() : u64 {
        16
    }

    public fun max_leverage_bps(arg0: &OsAccount) : u64 {
        arg0.max_leverage_bps
    }

    public fun name(arg0: &OsAccount) : &0x1::option::Option<0x1::string::String> {
        &arg0.name
    }

    public fun new_data<T0: drop, T1: store>(arg0: &mut OsAccount, arg1: T0, arg2: T1) {
        let v0 = ProtocolDataKey<T0>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<ProtocolDataKey<T0>>(&arg0.id, v0), 7);
        0x2::dynamic_field::add<ProtocolDataKey<T0>, T1>(&mut arg0.id, v0, arg2);
    }

    public fun new_with_mode(arg0: address, arg1: 0x1::option::Option<0x1::string::String>, arg2: u64, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : OsAccount {
        assert!(arg3 == 0 || arg3 == 1, 11);
        let v0 = 0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::account::new(0x1::option::none<0x1::string::String>(), arg5);
        let v1 = OsAccount{
            id                      : 0x2::object::new(arg5),
            name                    : arg1,
            parent_wallet_identity  : arg0,
            signer                  : v0,
            delegates               : 0x2::vec_map::empty<address, u32>(),
            max_leverage_bps        : arg2,
            paused                  : false,
            allowed_versions_packed : version_mask(1),
            created_at_ms           : 0x2::clock::timestamp_ms(arg4),
            margin_mode             : arg3,
        };
        0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::events::emit_os_account_created(0x2::object::id<OsAccount>(&v1), arg0, v1.name, 0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::account::account_address(&v0), v1.created_at_ms);
        v1
    }

    public fun parent_wallet_identity(arg0: &OsAccount) : address {
        arg0.parent_wallet_identity
    }

    public fun perm_admin() : u32 {
        16
    }

    public fun perm_all() : u32 {
        4294967295
    }

    public fun perm_close() : u32 {
        2
    }

    public fun perm_deposit() : u32 {
        8
    }

    public fun perm_none() : u32 {
        0
    }

    public fun perm_open() : u32 {
        1
    }

    public fun perm_withdraw() : u32 {
        4
    }

    public fun register_and_share(arg0: &mut 0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::registry::WalletAccountRegistry, arg1: OsAccount, arg2: address) {
        assert!(arg1.parent_wallet_identity == arg2, 13);
        0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::registry::register(arg0, arg2, 0x2::object::id<OsAccount>(&arg1));
        share(arg1);
    }

    public fun remove_data<T0: drop, T1: store>(arg0: &mut OsAccount, arg1: T0) : T1 {
        let v0 = ProtocolDataKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ProtocolDataKey<T0>>(&arg0.id, v0), 8);
        0x2::dynamic_field::remove<ProtocolDataKey<T0>, T1>(&mut arg0.id, v0)
    }

    public fun remove_delegate(arg0: &mut OsAccount, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_perm(arg0, 0x2::tx_context::sender(arg2), 16);
        remove_delegate_internal(arg0, arg1);
    }

    public fun remove_delegate_by_request(arg0: &mut OsAccount, arg1: &0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::account::AccountRequest, arg2: address) {
        assert_request(arg0, arg1, 16);
        remove_delegate_internal(arg0, arg2);
    }

    fun remove_delegate_internal(arg0: &mut OsAccount, arg1: address) {
        assert!(0x2::vec_map::contains<address, u32>(&arg0.delegates, &arg1), 4);
        let (_, _) = 0x2::vec_map::remove<address, u32>(&mut arg0.delegates, &arg1);
        0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::events::emit_delegate_removed(0x2::object::id<OsAccount>(arg0), arg1);
    }

    public fun request(arg0: &OsAccount) : 0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::account::AccountRequest {
        0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::account::request_with_account(&arg0.signer)
    }

    public fun set_max_leverage(arg0: &mut OsAccount, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_perm(arg0, 0x2::tx_context::sender(arg2), 16);
        arg0.max_leverage_bps = arg1;
        0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::events::emit_max_leverage_updated(0x2::object::id<OsAccount>(arg0), arg1);
    }

    public fun set_max_leverage_by_request(arg0: &mut OsAccount, arg1: &0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::account::AccountRequest, arg2: u64) {
        assert_request(arg0, arg1, 16);
        arg0.max_leverage_bps = arg2;
        0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::events::emit_max_leverage_updated(0x2::object::id<OsAccount>(arg0), arg2);
    }

    public fun set_paused(arg0: &mut OsAccount, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert_perm(arg0, 0x2::tx_context::sender(arg2), 16);
        arg0.paused = arg1;
        0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::events::emit_os_account_paused_updated(0x2::object::id<OsAccount>(arg0), arg1);
    }

    public fun set_paused_by_request(arg0: &mut OsAccount, arg1: &0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::account::AccountRequest, arg2: bool) {
        assert_request(arg0, arg1, 16);
        arg0.paused = arg2;
        0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::events::emit_os_account_paused_updated(0x2::object::id<OsAccount>(arg0), arg2);
    }

    public fun share(arg0: OsAccount) {
        0x2::transfer::share_object<OsAccount>(arg0);
    }

    public fun signer_address(arg0: &OsAccount) : address {
        0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::account::account_address(&arg0.signer)
    }

    public fun update_delegate_permissions(arg0: &mut OsAccount, arg1: address, arg2: u32, arg3: &0x2::tx_context::TxContext) {
        assert_perm(arg0, 0x2::tx_context::sender(arg3), 16);
        update_delegate_permissions_internal(arg0, arg1, arg2);
    }

    public fun update_delegate_permissions_by_request(arg0: &mut OsAccount, arg1: &0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::account::AccountRequest, arg2: address, arg3: u32) {
        assert_request(arg0, arg1, 16);
        update_delegate_permissions_internal(arg0, arg2, arg3);
    }

    fun update_delegate_permissions_internal(arg0: &mut OsAccount, arg1: address, arg2: u32) {
        assert!(0x2::vec_map::contains<address, u32>(&arg0.delegates, &arg1), 4);
        *0x2::vec_map::get_mut<address, u32>(&mut arg0.delegates, &arg1) = arg2;
        0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::events::emit_delegate_permissions_updated(0x2::object::id<OsAccount>(arg0), arg1, arg2);
    }

    fun version_mask(arg0: u8) : u64 {
        assert!(arg0 < 64, 10);
        1 << arg0
    }

    public fun withdraw_for_protocol<T0: drop, T1>(arg0: &mut OsAccount, arg1: T0, arg2: u64) : 0x2::balance::Balance<T1> {
        0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::account::withdraw_funds<T1>(&mut arg0.signer, arg2)
    }

    // decompiled from Move bytecode v7
}

