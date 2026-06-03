module 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account {
    struct ACCOUNT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct WaterXAccount has drop {
        dummy_field: bool,
    }

    struct AccountRegistry has key {
        id: 0x2::object::UID,
        accounts: 0x2::object_table::ObjectTable<0x2::object::ID, Account>,
        owner_index: 0x2::table::Table<address, vector<0x2::object::ID>>,
        protocol_whitelist: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>,
        deposit_policies: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>,
        withdraw_policies: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>,
        balances: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        allowed_versions: 0x2::vec_set::VecSet<u16>,
        managers: 0x2::vec_set::VecSet<address>,
        paused: bool,
    }

    struct VaultKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Vault<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        sheet: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T0, WaterXAccount>,
    }

    struct ProtocolDataKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Account has store, key {
        id: 0x2::object::UID,
        owner_address: address,
        alias: 0x1::string::String,
        delegates: vector<Delegate>,
        balances: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct Delegate has copy, drop, store {
        delegate_address: address,
        alias: 0x1::string::String,
        permissions: u32,
        protocol_permissions: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u32>,
        expires_at_ms: 0x1::option::Option<u64>,
    }

    struct DepositRequest<phantom T0> {
        account_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<T0>,
        extra_data: vector<u8>,
    }

    struct WithdrawRequest<phantom T0> {
        account_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<T0>,
        recipient: address,
        extra_data: vector<u8>,
    }

    struct PausedProtocolsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AccountKey has copy, drop, store {
        owner: address,
        index: u64,
    }

    public fun balance<T0>(arg0: &AccountRegistry) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.balances, &v0)) {
            return 0
        };
        *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.balances, &v0)
    }

    public fun account_address(arg0: &Account) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun account_alias(arg0: &Account) : 0x1::string::String {
        arg0.alias
    }

    public fun account_balance<T0>(arg0: &AccountRegistry, arg1: 0x2::object::ID) : u64 {
        if (!has_account(arg0, arg1)) {
            return 0
        };
        let v0 = borrow_account(arg0, arg1);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v0.balances, &v1)) {
            return 0
        };
        *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&v0.balances, &v1)
    }

    public fun account_balances(arg0: &AccountRegistry, arg1: 0x2::object::ID) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &borrow_account(arg0, arg1).balances
    }

    public fun account_balances_field(arg0: &Account) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &arg0.balances
    }

    public fun account_count(arg0: &AccountRegistry, arg1: address) : u64 {
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.owner_index, arg1)) {
            return 0
        };
        0x1::vector::length<0x2::object::ID>(0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.owner_index, arg1))
    }

    fun account_credit<T0>(arg0: &mut AccountRegistry, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return
        };
        let v1 = borrow_vault_mut<T0>(arg0);
        0x2::balance::join<T0>(&mut v1.balance, arg2);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        let v3 = 0x2::object_table::borrow_mut<0x2::object::ID, Account>(&mut arg0.accounts, arg1);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v3.balances, &v2)) {
            let v4 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v3.balances, &v2);
            *v4 = *v4 + v0;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v3.balances, v2, v0);
        };
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.balances, &v2)) {
            let v5 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.balances, &v2);
            *v5 = *v5 + v0;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.balances, v2, v0);
        };
    }

    fun account_debit<T0>(arg0: &mut AccountRegistry, arg1: 0x2::object::ID, arg2: u64) : 0x2::balance::Balance<T0> {
        if (arg2 == 0) {
            abort 13906841716307591194
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, Account>(&mut arg0.accounts, arg1);
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v1.balances, &v0)) {
            abort 13906841733487329304
        };
        let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v1.balances, &v0);
        if (*v2 < arg2) {
            abort 13906841742077263896
        };
        *v2 = *v2 - arg2;
        if (*v2 == 0) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut v1.balances, &v0);
        };
        let v5 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.balances, &v0);
        *v5 = *v5 - arg2;
        if (*v5 == 0) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.balances, &v0);
        };
        0x2::balance::split<T0>(&mut borrow_vault_mut<T0>(arg0).balance, arg2)
    }

    public fun account_delegates(arg0: &Account) : &vector<Delegate> {
        &arg0.delegates
    }

    public fun account_id(arg0: &Account) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun account_ids(arg0: &AccountRegistry, arg1: address) : vector<0x2::object::ID> {
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.owner_index, arg1)) {
            return 0x1::vector::empty<0x2::object::ID>()
        };
        *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.owner_index, arg1)
    }

    public fun account_owner(arg0: &Account) : address {
        arg0.owner_address
    }

    public fun add_delegate(arg0: &mut AccountRegistry, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: 0x2::object::ID, arg3: address, arg4: 0x1::string::String, arg5: u32, arg6: 0x1::option::Option<u64>, arg7: &0x2::clock::Clock) {
        assert_version(arg0);
        if (0x1::string::length(&arg4) > 64) {
            abort 13906837494353559560
        };
        if (0x1::option::is_some<u64>(&arg6) && *0x1::option::borrow<u64>(&arg6) <= 0x2::clock::timestamp_ms(arg7)) {
            abort 13906837507239772188
        };
        let v0 = borrow_account_owner_only(arg0, arg2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1));
        let v1 = find_delegate_idx(&v0.delegates, arg3);
        if (0x1::option::is_some<u64>(&v1)) {
            0x1::vector::swap_remove<Delegate>(&mut v0.delegates, *0x1::option::borrow<u64>(&v1));
        } else if (0x1::vector::length<Delegate>(&v0.delegates) >= 20) {
            abort 13906837545893822482
        };
        let v2 = Delegate{
            delegate_address     : arg3,
            alias                : arg4,
            permissions          : arg5,
            protocol_permissions : 0x2::vec_map::empty<0x1::type_name::TypeName, u32>(),
            expires_at_ms        : arg6,
        };
        0x1::vector::push_back<Delegate>(&mut v0.delegates, v2);
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_delegate_added(0x2::object::id_to_address(&arg2), arg3, arg4, arg5, arg6);
    }

    public fun add_manager(arg0: &mut AccountRegistry, arg1: &AdminCap, arg2: address) {
        assert_version(arg0);
        if (!0x2::vec_set::contains<address>(&arg0.managers, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg0.managers, arg2);
            0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_manager_added(arg2);
        };
    }

    public fun alias_max_length() : u64 {
        64
    }

    public fun allow_protocol_asset<T0, T1>(arg0: &mut AccountRegistry, arg1: &AdminCap) {
        assert_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.protocol_whitelist, &v0)) {
            abort 13906836412023898152
        };
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.protocol_whitelist, &v0);
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(v2, &v1)) {
            abort 13906836424909324336
        };
        0x2::vec_set::insert<0x1::type_name::TypeName>(v2, v1);
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_protocol_asset_allowed(v0, v1);
    }

    public fun allow_version(arg0: &mut AccountRegistry, arg1: &AdminCap, arg2: u16) {
        if (!0x2::vec_set::contains<u16>(&arg0.allowed_versions, &arg2)) {
            0x2::vec_set::insert<u16>(&mut arg0.allowed_versions, arg2);
            0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_version_allowed(arg2);
        };
    }

    public(friend) fun assert_deposit_policy_registered<T0>(arg0: &AccountRegistry) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.deposit_policies, &v0)) {
            abort 13906841183733219378
        };
        if (0x2::vec_set::length<0x1::type_name::TypeName>(0x2::vec_map::get<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.deposit_policies, &v0)) == 0) {
            abort 13906841188028186674
        };
    }

    public fun assert_not_paused(arg0: &AccountRegistry) {
        if (arg0.paused) {
            abort 13906835729123967014
        };
    }

    public(friend) fun assert_not_policy_managed_coin<T0>(arg0: &AccountRegistry) {
        let v0 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.deposit_policies);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            if (0x2::vec_set::length<0x1::type_name::TypeName>(0x2::vec_map::get<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.deposit_policies, &v2)) == 0) {
                v1 = v1 + 1;
                continue
            };
            if (coin_typename_for(v2) == 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())) {
                abort 13906841329762762812
            };
            v1 = v1 + 1;
        };
    }

    public(friend) fun assert_protocol_asset_allowed<T0, T1>(arg0: &AccountRegistry) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.protocol_whitelist, &v0)) {
            abort 13906841153667792936
        };
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(0x2::vec_map::get<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.protocol_whitelist, &v0), &v1)) {
            abort 13906841162258120750
        };
    }

    public(friend) fun assert_protocol_not_paused<T0>(arg0: &AccountRegistry) {
        if (is_protocol_paused_internal(arg0, 0x1::type_name::with_defining_ids<T0>())) {
            abort 13906836369074356266
        };
    }

    public(friend) fun assert_protocol_whitelisted<T0>(arg0: &AccountRegistry) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.protocol_whitelist, &v0)) {
            abort 13906841127897989160
        };
    }

    public fun assert_version(arg0: &AccountRegistry) {
        let v0 = 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::version::package_version();
        if (!0x2::vec_set::contains<u16>(&arg0.allowed_versions, &v0)) {
            abort 13906835613159325726
        };
    }

    public(friend) fun assert_withdraw_policy_registered<T0>(arg0: &AccountRegistry) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.withdraw_policies, &v0)) {
            abort 13906841209503154228
        };
        if (0x2::vec_set::length<0x1::type_name::TypeName>(0x2::vec_map::get<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.withdraw_policies, &v0)) == 0) {
            abort 13906841213798121524
        };
    }

    public(friend) fun borrow_account(arg0: &AccountRegistry, arg1: 0x2::object::ID) : &Account {
        if (!has_account(arg0, arg1)) {
            abort 13906841067766743054
        };
        0x2::object_table::borrow<0x2::object::ID, Account>(&arg0.accounts, arg1)
    }

    fun borrow_account_for_delegate_management(arg0: &mut AccountRegistry, arg1: 0x2::object::ID, arg2: address, arg3: u64) : &mut Account {
        if (!has_account(arg0, arg1)) {
            abort 13906841896695431182
        };
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Account>(&mut arg0.accounts, arg1);
        if (v0.owner_address == arg2) {
            return v0
        };
        if (effective_permissions_from_account(v0, arg2, arg3) & 2 != 2) {
            abort 13906841918170005514
        };
        v0
    }

    public(friend) fun borrow_account_mut(arg0: &mut AccountRegistry, arg1: 0x2::object::ID) : &mut Account {
        if (!has_account(arg0, arg1)) {
            abort 13906841102126481422
        };
        0x2::object_table::borrow_mut<0x2::object::ID, Account>(&mut arg0.accounts, arg1)
    }

    fun borrow_account_owner_only(arg0: &mut AccountRegistry, arg1: 0x2::object::ID, arg2: address) : &mut Account {
        if (!has_account(arg0, arg1)) {
            abort 13906841836565889038
        };
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Account>(&mut arg0.accounts, arg1);
        if (v0.owner_address != arg2) {
            abort 13906841845155692556
        };
        v0
    }

    public fun borrow_data<T0, T1: store>(arg0: &AccountRegistry, arg1: 0x2::object::ID) : &T1 {
        let v0 = borrow_account(arg0, arg1);
        let v1 = ProtocolDataKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists<ProtocolDataKey<T0>>(&v0.id, v1)) {
            abort 13906840878790934584
        };
        0x2::dynamic_field::borrow<ProtocolDataKey<T0>, T1>(&v0.id, v1)
    }

    public fun borrow_data_mut<T0: drop, T1: store>(arg0: &mut AccountRegistry, arg1: 0x2::object::ID, arg2: T0) : &mut T1 {
        assert_version(arg0);
        assert_protocol_whitelisted<T0>(arg0);
        let v0 = borrow_account_mut(arg0, arg1);
        let v1 = ProtocolDataKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists<ProtocolDataKey<T0>>(&v0.id, v1)) {
            abort 13906840943215444024
        };
        0x2::dynamic_field::borrow_mut<ProtocolDataKey<T0>, T1>(&mut v0.id, v1)
    }

    fun borrow_vault_mut<T0>(arg0: &mut AccountRegistry) : &mut Vault<T0> {
        ensure_vault<T0>(arg0);
        let v0 = VaultKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<VaultKey<T0>, Vault<T0>>(&mut arg0.id, v0)
    }

    fun coin_typename_for(arg0: 0x1::type_name::TypeName) : 0x1::ascii::String {
        let v0 = 0x1::ascii::string(b"0000000000000000000000000000000000000000000000000000000000000002::coin::Coin<");
        0x1::ascii::append(&mut v0, 0x1::type_name::into_string(arg0));
        0x1::ascii::append(&mut v0, 0x1::ascii::string(b">"));
        v0
    }

    public fun consume_deposit<T0, T1: drop>(arg0: &AccountRegistry, arg1: DepositRequest<T0>, arg2: T1) : (0x2::object::ID, 0x2::balance::Balance<T0>, vector<u8>) {
        assert_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.deposit_policies, &v0)) {
            abort 13906838628227678258
        };
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(0x2::vec_map::get<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.deposit_policies, &v0), &v1)) {
            abort 13906838641112842294
        };
        let DepositRequest {
            account_id : v2,
            balance    : v3,
            extra_data : v4,
        } = arg1;
        let v5 = v3;
        let v6 = v2;
        let v7 = 0x2::balance::value<T0>(&v5);
        if (v7 > 0) {
            0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_deposit_consumed(0x2::object::id_to_address(&v6), v0, v1, v7);
        };
        (v6, v5, v4)
    }

    public fun consume_withdraw<T0, T1: drop>(arg0: &AccountRegistry, arg1: WithdrawRequest<T0>, arg2: T1) : (0x2::object::ID, 0x2::balance::Balance<T0>, address, vector<u8>) {
        assert_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.withdraw_policies, &v0)) {
            abort 13906838898810748980
        };
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(0x2::vec_map::get<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.withdraw_policies, &v0), &v1)) {
            abort 13906838911695781942
        };
        let WithdrawRequest {
            account_id : v2,
            balance    : v3,
            recipient  : v4,
            extra_data : v5,
        } = arg1;
        let v6 = v3;
        let v7 = v2;
        let v8 = 0x2::balance::value<T0>(&v6);
        if (v8 > 0) {
            0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_withdraw_consumed(0x2::object::id_to_address(&v7), v0, v1, v8, v4);
        };
        (v7, v6, v4, v5)
    }

    public fun create_account(arg0: &mut AccountRegistry, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_version(arg0);
        if (0x1::string::length(&arg2) > 64) {
            abort 13906837103511535624
        };
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.owner_index, v0)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.owner_index, v0, 0x1::vector::empty<0x2::object::ID>());
        };
        let v1 = 0x1::vector::length<0x2::object::ID>(0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.owner_index, v0));
        if (v1 >= 20) {
            abort 13906837133576830992
        };
        let v2 = AccountKey{
            owner : v0,
            index : v1,
        };
        let v3 = 0x2::derived_object::claim<AccountKey>(&mut arg0.id, v2);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = Account{
            id            : v3,
            owner_address : v0,
            alias         : arg2,
            delegates     : 0x1::vector::empty<Delegate>(),
            balances      : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
        };
        0x2::object_table::add<0x2::object::ID, Account>(&mut arg0.accounts, v4, v5);
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.owner_index, v0), v4);
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_account_created(v0, 0x2::object::id_to_address(&v4), arg2, v1);
        v4
    }

    public fun delegate_address(arg0: &Delegate) : address {
        arg0.delegate_address
    }

    public fun delegate_alias(arg0: &Delegate) : 0x1::string::String {
        arg0.alias
    }

    public fun delegate_expires_at_ms(arg0: &Delegate) : 0x1::option::Option<u64> {
        arg0.expires_at_ms
    }

    public fun delegate_permissions(arg0: &Delegate) : u32 {
        arg0.permissions
    }

    public fun delegate_protocol_permissions(arg0: &Delegate) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u32> {
        &arg0.protocol_permissions
    }

    public fun delist_protocol<T0>(arg0: &mut AccountRegistry, arg1: &AdminCap) {
        assert_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.protocol_whitelist, &v0)) {
            abort 13906836137145991208
        };
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.protocol_whitelist, &v0);
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_protocol_delisted(v0);
    }

    public fun deposit_policies(arg0: &AccountRegistry) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>> {
        &arg0.deposit_policies
    }

    public fun deposit_policies_for<T0>(arg0: &AccountRegistry) : vector<0x1::type_name::TypeName> {
        assert_deposit_policy_registered<T0>(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        *0x2::vec_set::keys<0x1::type_name::TypeName>(0x2::vec_map::get<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.deposit_policies, &v0))
    }

    public fun deposit_request_account_id<T0>(arg0: &DepositRequest<T0>) : 0x2::object::ID {
        arg0.account_id
    }

    public fun deposit_request_amount<T0>(arg0: &DepositRequest<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun deposit_request_balance<T0>(arg0: &DepositRequest<T0>) : &0x2::balance::Balance<T0> {
        &arg0.balance
    }

    public fun deposit_request_extra_data<T0>(arg0: &DepositRequest<T0>) : vector<u8> {
        arg0.extra_data
    }

    public fun derive_account_address(arg0: &AccountRegistry, arg1: address, arg2: u64) : address {
        let v0 = AccountKey{
            owner : arg1,
            index : arg2,
        };
        0x2::derived_object::derive_address<AccountKey>(0x2::object::id<AccountRegistry>(arg0), v0)
    }

    public fun disallow_protocol_asset<T0, T1>(arg0: &mut AccountRegistry, arg1: &AdminCap) {
        assert_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.protocol_whitelist, &v0)) {
            abort 13906836476448407592
        };
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.protocol_whitelist, &v0);
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(v2, &v1)) {
            abort 13906836489333702702
        };
        0x2::vec_set::remove<0x1::type_name::TypeName>(v2, &v1);
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_protocol_asset_disallowed(v0, v1);
    }

    public fun disallow_version(arg0: &mut AccountRegistry, arg1: &AdminCap, arg2: u16) {
        if (0x2::vec_set::contains<u16>(&arg0.allowed_versions, &arg2)) {
            0x2::vec_set::remove<u16>(&mut arg0.allowed_versions, &arg2);
            0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_version_disallowed(arg2);
        };
    }

    public fun effective_permissions(arg0: &AccountRegistry, arg1: 0x2::object::ID, arg2: address, arg3: u64) : u32 {
        if (!has_account(arg0, arg1)) {
            return 0
        };
        let v0 = borrow_account(arg0, arg1);
        if (v0.owner_address == arg2) {
            return 4294967295
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<Delegate>(&v0.delegates)) {
            let v2 = 0x1::vector::borrow<Delegate>(&v0.delegates, v1);
            if (v2.delegate_address == arg2) {
                if (0x1::option::is_some<u64>(&v2.expires_at_ms) && arg3 >= *0x1::option::borrow<u64>(&v2.expires_at_ms)) {
                    return 0
                };
                return v2.permissions
            };
            v1 = v1 + 1;
        };
        0
    }

    fun effective_permissions_from_account(arg0: &Account, arg1: address, arg2: u64) : u32 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Delegate>(&arg0.delegates)) {
            let v1 = 0x1::vector::borrow<Delegate>(&arg0.delegates, v0);
            if (v1.delegate_address == arg1) {
                if (0x1::option::is_some<u64>(&v1.expires_at_ms) && arg2 >= *0x1::option::borrow<u64>(&v1.expires_at_ms)) {
                    return 0
                };
                return v1.permissions
            };
            v0 = v0 + 1;
        };
        0
    }

    public fun effective_protocol_permissions<T0>(arg0: &AccountRegistry, arg1: 0x2::object::ID, arg2: address, arg3: u64) : u32 {
        if (!has_account(arg0, arg1)) {
            return 0
        };
        let v0 = borrow_account(arg0, arg1);
        if (v0.owner_address == arg2) {
            return 4294967295
        };
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<Delegate>(&v0.delegates)) {
            let v3 = 0x1::vector::borrow<Delegate>(&v0.delegates, v2);
            if (v3.delegate_address == arg2) {
                if (0x1::option::is_some<u64>(&v3.expires_at_ms) && arg3 >= *0x1::option::borrow<u64>(&v3.expires_at_ms)) {
                    return 0
                };
                if (0x2::vec_map::contains<0x1::type_name::TypeName, u32>(&v3.protocol_permissions, &v1)) {
                    return *0x2::vec_map::get<0x1::type_name::TypeName, u32>(&v3.protocol_permissions, &v1)
                };
                return 0
            };
            v2 = v2 + 1;
        };
        0
    }

    fun ensure_vault<T0>(arg0: &mut AccountRegistry) {
        let v0 = VaultKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<VaultKey<T0>, Vault<T0>>(&arg0.id, v0)) {
            let v1 = Vault<T0>{
                balance : 0x2::balance::zero<T0>(),
                sheet   : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::new<T0, WaterXAccount>(witness()),
            };
            0x2::dynamic_field::add<VaultKey<T0>, Vault<T0>>(&mut arg0.id, v0, v1);
        };
    }

    fun find_delegate_idx(arg0: &vector<Delegate>, arg1: address) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Delegate>(arg0)) {
            if (0x1::vector::borrow<Delegate>(arg0, v0).delegate_address == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun has_account(arg0: &AccountRegistry, arg1: 0x2::object::ID) : bool {
        0x2::object_table::contains<0x2::object::ID, Account>(&arg0.accounts, arg1)
    }

    public fun has_data<T0>(arg0: &AccountRegistry, arg1: 0x2::object::ID) : bool {
        if (!has_account(arg0, arg1)) {
            return false
        };
        let v0 = ProtocolDataKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists<ProtocolDataKey<T0>>(&0x2::object_table::borrow<0x2::object::ID, Account>(&arg0.accounts, arg1).id, v0)
    }

    public fun has_permission(arg0: &AccountRegistry, arg1: 0x2::object::ID, arg2: address, arg3: u32, arg4: u64) : bool {
        if (arg3 == 0) {
            return false
        };
        effective_permissions(arg0, arg1, arg2, arg4) & arg3 == arg3
    }

    public fun has_protocol_permission<T0>(arg0: &AccountRegistry, arg1: 0x2::object::ID, arg2: address, arg3: u32, arg4: u64) : bool {
        if (arg3 == 0) {
            return false
        };
        effective_protocol_permissions<T0>(arg0, arg1, arg2, arg4) & arg3 == arg3
    }

    fun init(arg0: ACCOUNT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AccountRegistry{
            id                 : 0x2::object::new(arg1),
            accounts           : 0x2::object_table::new<0x2::object::ID, Account>(arg1),
            owner_index        : 0x2::table::new<address, vector<0x2::object::ID>>(arg1),
            protocol_whitelist : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(),
            deposit_policies   : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(),
            withdraw_policies  : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(),
            balances           : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            allowed_versions   : 0x2::vec_set::singleton<u16>(0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::version::package_version()),
            managers           : 0x2::vec_set::singleton<address>(v0),
            paused             : false,
        };
        0x2::transfer::share_object<AccountRegistry>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    public fun is_account_authorized(arg0: &AccountRegistry, arg1: 0x2::object::ID, arg2: address, arg3: u64) : bool {
        if (!has_account(arg0, arg1)) {
            return false
        };
        let v0 = borrow_account(arg0, arg1);
        if (v0.owner_address == arg2) {
            return true
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<Delegate>(&v0.delegates)) {
            let v2 = 0x1::vector::borrow<Delegate>(&v0.delegates, v1);
            if (v2.delegate_address == arg2) {
                if (0x1::option::is_some<u64>(&v2.expires_at_ms) && arg3 >= *0x1::option::borrow<u64>(&v2.expires_at_ms)) {
                    return false
                };
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun is_deposit_policy_registered<T0>(arg0: &AccountRegistry) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.deposit_policies, &v0)) {
            return false
        };
        0x2::vec_set::length<0x1::type_name::TypeName>(0x2::vec_map::get<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.deposit_policies, &v0)) > 0
    }

    public fun is_deposit_policy_registered_for<T0, T1: drop>(arg0: &AccountRegistry) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.deposit_policies, &v0)) {
            return false
        };
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(0x2::vec_map::get<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.deposit_policies, &v0), &v1)
    }

    public fun is_manager(arg0: &AccountRegistry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.managers, &arg1)
    }

    public fun is_paused(arg0: &AccountRegistry) : bool {
        arg0.paused
    }

    public fun is_protocol_asset_allowed<T0, T1>(arg0: &AccountRegistry) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.protocol_whitelist, &v0)) {
            return false
        };
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(0x2::vec_map::get<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.protocol_whitelist, &v0), &v1)
    }

    public fun is_protocol_paused<T0>(arg0: &AccountRegistry) : bool {
        is_protocol_paused_internal(arg0, 0x1::type_name::with_defining_ids<T0>())
    }

    fun is_protocol_paused_internal(arg0: &AccountRegistry, arg1: 0x1::type_name::TypeName) : bool {
        let v0 = PausedProtocolsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<PausedProtocolsKey>(&arg0.id, v0)) {
            return false
        };
        let v1 = PausedProtocolsKey{dummy_field: false};
        0x2::vec_set::contains<0x1::type_name::TypeName>(0x2::dynamic_field::borrow<PausedProtocolsKey, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.id, v1), &arg1)
    }

    public fun is_protocol_whitelisted<T0>(arg0: &AccountRegistry) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.protocol_whitelist, &v0)
    }

    public fun is_version_allowed(arg0: &AccountRegistry, arg1: u16) : bool {
        0x2::vec_set::contains<u16>(&arg0.allowed_versions, &arg1)
    }

    public fun is_withdraw_policy_registered<T0>(arg0: &AccountRegistry) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.withdraw_policies, &v0)) {
            return false
        };
        0x2::vec_set::length<0x1::type_name::TypeName>(0x2::vec_map::get<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.withdraw_policies, &v0)) > 0
    }

    public fun is_withdraw_policy_registered_for<T0, T1: drop>(arg0: &AccountRegistry) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.withdraw_policies, &v0)) {
            return false
        };
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(0x2::vec_map::get<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.withdraw_policies, &v0), &v1)
    }

    public fun managers(arg0: &AccountRegistry) : &0x2::vec_set::VecSet<address> {
        &arg0.managers
    }

    public fun max_accounts_per_owner() : u64 {
        20
    }

    public fun max_delegates_per_account() : u64 {
        20
    }

    public fun max_protocol_perms_per_delegate() : u64 {
        20
    }

    public fun new_data<T0: drop, T1: store>(arg0: &mut AccountRegistry, arg1: 0x2::object::ID, arg2: T0, arg3: T1) {
        assert_version(arg0);
        assert_protocol_whitelisted<T0>(arg0);
        assert_protocol_not_paused<T0>(arg0);
        let v0 = borrow_account_mut(arg0, arg1);
        let v1 = ProtocolDataKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists<ProtocolDataKey<T0>>(&v0.id, v1)) {
            abort 13906840827251458106
        };
        0x2::dynamic_field::add<ProtocolDataKey<T0>, T1>(&mut v0.id, v1, arg3);
    }

    public fun pause(arg0: &mut AccountRegistry, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) {
        assert_version(arg0);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1);
        if (!0x2::vec_set::contains<address>(&arg0.managers, &v0)) {
            abort 13906835754893377568
        };
        if (arg0.paused) {
            abort 13906835759188475938
        };
        arg0.paused = true;
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_paused(v0);
    }

    public fun pause_protocol<T0>(arg0: &mut AccountRegistry, arg1: &AdminCap) {
        assert_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = PausedProtocolsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<PausedProtocolsKey>(&arg0.id, v1)) {
            let v2 = PausedProtocolsKey{dummy_field: false};
            0x2::dynamic_field::add<PausedProtocolsKey, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.id, v2, 0x2::vec_set::empty<0x1::type_name::TypeName>());
        };
        let v3 = PausedProtocolsKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow_mut<PausedProtocolsKey, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.id, v3);
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(v4, &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(v4, v0);
        };
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_protocol_paused(v0);
    }

    public fun perm_all() : u32 {
        4294967295
    }

    public fun perm_manage_delegates() : u32 {
        2
    }

    public fun perm_none() : u32 {
        0
    }

    public fun perm_receive() : u32 {
        4
    }

    public fun perm_withdraw() : u32 {
        1
    }

    public fun protocol_whitelist(arg0: &AccountRegistry) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>> {
        &arg0.protocol_whitelist
    }

    public fun put<T0, T1: drop>(arg0: &mut AccountRegistry, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<T0>, arg3: T1) {
        assert_version(arg0);
        assert_protocol_whitelisted<T1>(arg0);
        if (!has_account(arg0, arg1)) {
            abort 13906839659017469966
        };
        let v0 = 0x2::balance::value<T0>(&arg2);
        account_credit<T0>(arg0, arg1, arg2);
        if (v0 == 0) {
            return
        };
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_returned_by_protocol(0x2::object::id_to_address(&arg1), 0x1::type_name::with_defining_ids<T1>(), 0x1::type_name::with_defining_ids<T0>(), v0);
    }

    public fun receive<T0: store + key>(arg0: &mut AccountRegistry, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: 0x2::object::ID, arg3: 0x2::transfer::Receiving<T0>, arg4: &0x2::clock::Clock) : T0 {
        assert_version(arg0);
        assert_not_policy_managed_coin<T0>(arg0);
        if (!has_permission(arg0, arg2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1), 4, 0x2::clock::timestamp_ms(arg4))) {
            abort 13906839195160739850
        };
        0x2::transfer::public_receive<T0>(&mut borrow_account_mut(arg0, arg2).id, arg3)
    }

    fun receive_into_coin<T0>(arg0: &mut Account, arg1: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg2);
        0x1::vector::reverse<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&arg1)) {
            0x2::coin::join<T0>(&mut v0, 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, 0x1::vector::pop_back<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&mut arg1)));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(arg1);
        v0
    }

    public fun register_deposit_policy<T0, T1: drop>(arg0: &mut AccountRegistry, arg1: &AdminCap) {
        assert_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.deposit_policies, &v0)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.deposit_policies, v0, 0x2::vec_set::empty<0x1::type_name::TypeName>());
        };
        let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.deposit_policies, &v0);
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(v2, &v1)) {
            return
        };
        0x2::vec_set::insert<0x1::type_name::TypeName>(v2, v1);
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_deposit_policy_registered(v0, v1);
    }

    public fun register_withdraw_policy<T0, T1: drop>(arg0: &mut AccountRegistry, arg1: &AdminCap) {
        assert_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.withdraw_policies, &v0)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.withdraw_policies, v0, 0x2::vec_set::empty<0x1::type_name::TypeName>());
        };
        let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.withdraw_policies, &v0);
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(v2, &v1)) {
            return
        };
        0x2::vec_set::insert<0x1::type_name::TypeName>(v2, v1);
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_withdraw_policy_registered(v0, v1);
    }

    public fun remove_data<T0: drop, T1: store>(arg0: &mut AccountRegistry, arg1: 0x2::object::ID, arg2: T0) : T1 {
        assert_version(arg0);
        assert_protocol_whitelisted<T0>(arg0);
        let v0 = borrow_account_mut(arg0, arg1);
        let v1 = ProtocolDataKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists<ProtocolDataKey<T0>>(&v0.id, v1)) {
            abort 13906841033409757240
        };
        0x2::dynamic_field::remove<ProtocolDataKey<T0>, T1>(&mut v0.id, v1)
    }

    public fun remove_delegate(arg0: &mut AccountRegistry, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: 0x2::object::ID, arg3: address, arg4: &0x2::clock::Clock) {
        assert_version(arg0);
        if (!has_account(arg0, arg2)) {
            abort 13906837683332513806
        };
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Account>(&mut arg0.accounts, arg2);
        let v1 = find_delegate_idx(&v0.delegates, arg3);
        if (0x1::option::is_none<u64>(&v1)) {
            abort 13906837704807874582
        };
        let v2 = *0x1::option::borrow<u64>(&v1);
        let v3 = 0x1::option::is_some<u64>(&0x1::vector::borrow<Delegate>(&v0.delegates, v2).expires_at_ms) && 0x2::clock::timestamp_ms(arg4) >= *0x1::option::borrow<u64>(&0x1::vector::borrow<Delegate>(&v0.delegates, v2).expires_at_ms);
        if (!v3 && v0.owner_address != 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1)) {
            abort 13906837726282055692
        };
        0x1::vector::swap_remove<Delegate>(&mut v0.delegates, v2);
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_delegate_removed(0x2::object::id_to_address(&arg2), arg3);
    }

    public fun remove_manager(arg0: &mut AccountRegistry, arg1: &AdminCap, arg2: address) {
        assert_version(arg0);
        if (0x2::vec_set::contains<address>(&arg0.managers, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg0.managers, &arg2);
            0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_manager_removed(arg2);
        };
    }

    public fun request_deposit<T0>(arg0: &AccountRegistry, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>) : DepositRequest<T0> {
        assert_version(arg0);
        assert_deposit_policy_registered<T0>(arg0);
        if (!has_account(arg0, arg1)) {
            abort 13906838207318523918
        };
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 > 0) {
            0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_deposit_requested(0x2::object::id_to_address(&arg1), 0x1::type_name::with_defining_ids<T0>(), v1);
        };
        DepositRequest<T0>{
            account_id : arg1,
            balance    : v0,
            extra_data : arg3,
        }
    }

    public fun request_deposit_from_funds<T0>(arg0: &mut AccountRegistry, arg1: 0x2::object::ID, arg2: &0x2::accumulator::AccumulatorRoot, arg3: vector<u8>) : DepositRequest<T0> {
        assert_version(arg0);
        assert_deposit_policy_registered<T0>(arg0);
        if (!has_account(arg0, arg1)) {
            abort 13906838490786365454
        };
        let v0 = 0x2::object::id_to_address(&arg1);
        let v1 = 0x2::balance::settled_funds_value<T0>(arg2, v0);
        let v2 = if (v1 == 0) {
            0x2::balance::zero<T0>()
        } else {
            0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_deposit_requested(v0, 0x1::type_name::with_defining_ids<T0>(), v1);
            0x2::balance::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(&mut borrow_account_mut(arg0, arg1).id, v1))
        };
        DepositRequest<T0>{
            account_id : arg1,
            balance    : v2,
            extra_data : arg3,
        }
    }

    public fun request_deposit_from_receivings<T0>(arg0: &mut AccountRegistry, arg1: 0x2::object::ID, arg2: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : DepositRequest<T0> {
        assert_version(arg0);
        assert_deposit_policy_registered<T0>(arg0);
        let v0 = borrow_account_mut(arg0, arg1);
        let v1 = 0x2::coin::into_balance<T0>(receive_into_coin<T0>(v0, arg2, arg4));
        let v2 = 0x2::balance::value<T0>(&v1);
        if (v2 > 0) {
            0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_deposit_requested(0x2::object::id_to_address(&arg1), 0x1::type_name::with_defining_ids<T0>(), v2);
        };
        DepositRequest<T0>{
            account_id : arg1,
            balance    : v1,
            extra_data : arg3,
        }
    }

    public fun request_withdraw<T0>(arg0: &mut AccountRegistry, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: 0x2::object::ID, arg3: u64, arg4: address, arg5: vector<u8>, arg6: &0x2::clock::Clock) : WithdrawRequest<T0> {
        assert_version(arg0);
        assert_not_paused(arg0);
        assert_withdraw_policy_registered<T0>(arg0);
        if (arg3 == 0) {
            abort 13906838761370091546
        };
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1);
        if (!has_permission(arg0, arg2, v0, 1, 0x2::clock::timestamp_ms(arg6))) {
            abort 13906838778548912138
        };
        if (!has_account(arg0, arg2)) {
            abort 13906838787139108878
        };
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_withdraw_requested(0x2::object::id_to_address(&arg2), 0x1::type_name::with_defining_ids<T0>(), arg3, v0, arg4);
        WithdrawRequest<T0>{
            account_id : arg2,
            balance    : account_debit<T0>(arg0, arg2, arg3),
            recipient  : arg4,
            extra_data : arg5,
        }
    }

    public fun set_alias(arg0: &mut AccountRegistry, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: 0x2::object::ID, arg3: 0x1::string::String) {
        assert_version(arg0);
        if (0x1::string::length(&arg3) > 64) {
            abort 13906837348324671496
        };
        borrow_account_owner_only(arg0, arg2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1)).alias = arg3;
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_account_alias_updated(0x2::object::id_to_address(&arg2), arg3);
    }

    public fun set_delegate_protocol_permission<T0>(arg0: &mut AccountRegistry, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: 0x2::object::ID, arg3: address, arg4: u32, arg5: &0x2::clock::Clock) {
        assert_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = borrow_account_for_delegate_management(arg0, arg2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1), 0x2::clock::timestamp_ms(arg5));
        let v2 = find_delegate_idx(&v1.delegates, arg3);
        if (0x1::option::is_none<u64>(&v2)) {
            abort 13906837953915977750
        };
        let v3 = 0x1::vector::borrow_mut<Delegate>(&mut v1.delegates, *0x1::option::borrow<u64>(&v2));
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u32>(&v3.protocol_permissions, &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u32>(&mut v3.protocol_permissions, &v0) = arg4;
        } else {
            if (0x2::vec_map::length<0x1::type_name::TypeName, u32>(&v3.protocol_permissions) >= 20) {
                abort 13906837988275585044
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, u32>(&mut v3.protocol_permissions, v0, arg4);
        };
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_delegate_protocol_permission_set(0x2::object::id_to_address(&arg2), arg3, v0, arg4);
    }

    public fun take<T0, T1: drop>(arg0: &mut AccountRegistry, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: 0x2::object::ID, arg3: u64, arg4: T1, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        assert_version(arg0);
        assert_protocol_asset_allowed<T1, T0>(arg0);
        assert_protocol_not_paused<T1>(arg0);
        if (!has_account(arg0, arg2)) {
            abort 13906839543053352974
        };
        if (!is_account_authorized(arg0, arg2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1), 0x2::clock::timestamp_ms(arg5))) {
            abort 13906839560232960010
        };
        if (arg3 == 0) {
            return 0x2::balance::zero<T0>()
        };
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_taken_by_protocol(0x2::object::id_to_address(&arg2), 0x1::type_name::with_defining_ids<T1>(), 0x1::type_name::with_defining_ids<T0>(), arg3);
        account_debit<T0>(arg0, arg2, arg3)
    }

    public fun transfer_coin<T0>(arg0: &AccountRegistry, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>) {
        assert_version(arg0);
        if (0x2::coin::value<T0>(&arg2) == 0) {
            0x2::coin::destroy_zero<T0>(arg2);
            return
        };
        if (!has_account(arg0, arg1)) {
            abort 13906839044837146638
        };
        0x2::coin::send_funds<T0>(arg2, 0x2::object::id_to_address(&arg1));
    }

    public fun unpause(arg0: &mut AccountRegistry, arg1: &AdminCap) {
        assert_version(arg0);
        if (!arg0.paused) {
            abort 13906835789253378084
        };
        arg0.paused = false;
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_unpaused();
    }

    public fun unpause_protocol<T0>(arg0: &mut AccountRegistry, arg1: &AdminCap) {
        assert_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = PausedProtocolsKey{dummy_field: false};
        if (0x2::dynamic_field::exists<PausedProtocolsKey>(&arg0.id, v1)) {
            let v2 = PausedProtocolsKey{dummy_field: false};
            let v3 = 0x2::dynamic_field::borrow_mut<PausedProtocolsKey, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.id, v2);
            if (0x2::vec_set::contains<0x1::type_name::TypeName>(v3, &v0)) {
                0x2::vec_set::remove<0x1::type_name::TypeName>(v3, &v0);
            };
        };
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_protocol_unpaused(v0);
    }

    public fun unregister_deposit_policy<T0, T1: drop>(arg0: &mut AccountRegistry, arg1: &AdminCap) {
        assert_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.deposit_policies, &v0)) {
            abort 13906836927420629042
        };
        let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.deposit_policies, &v0);
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(v2, &v1)) {
            abort 13906836936010563634
        };
        0x2::vec_set::remove<0x1::type_name::TypeName>(v2, &v1);
        if (0x2::vec_set::length<0x1::type_name::TypeName>(v2) == 0) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.deposit_policies, &v0);
        };
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_deposit_policy_unregistered(v0, v1);
    }

    public fun unregister_withdraw_policy<T0, T1: drop>(arg0: &mut AccountRegistry, arg1: &AdminCap) {
        assert_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.withdraw_policies, &v0)) {
            abort 13906836978960367668
        };
        let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.withdraw_policies, &v0);
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(v2, &v1)) {
            abort 13906836987550302260
        };
        0x2::vec_set::remove<0x1::type_name::TypeName>(v2, &v1);
        if (0x2::vec_set::length<0x1::type_name::TypeName>(v2) == 0) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.withdraw_policies, &v0);
        };
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_withdraw_policy_unregistered(v0, v1);
    }

    public fun unset_delegate_protocol_permission<T0>(arg0: &mut AccountRegistry, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: 0x2::object::ID, arg3: address, arg4: &0x2::clock::Clock) {
        assert_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = borrow_account_for_delegate_management(arg0, arg2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1), 0x2::clock::timestamp_ms(arg4));
        let v2 = find_delegate_idx(&v1.delegates, arg3);
        if (0x1::option::is_none<u64>(&v2)) {
            abort 13906838095649898518
        };
        let v3 = 0x1::vector::borrow_mut<Delegate>(&mut v1.delegates, *0x1::option::borrow<u64>(&v2));
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u32>(&v3.protocol_permissions, &v0)) {
            return
        };
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u32>(&mut v3.protocol_permissions, &v0);
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_delegate_protocol_permission_unset(0x2::object::id_to_address(&arg2), arg3, v0);
    }

    public fun update_delegate(arg0: &mut AccountRegistry, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: 0x2::object::ID, arg3: address, arg4: 0x1::string::String, arg5: u32, arg6: 0x1::option::Option<u64>, arg7: &0x2::clock::Clock) {
        assert_version(arg0);
        if (0x1::string::length(&arg4) > 64) {
            abort 13906837795001270280
        };
        if (0x1::option::is_some<u64>(&arg6) && *0x1::option::borrow<u64>(&arg6) <= 0x2::clock::timestamp_ms(arg7)) {
            abort 13906837807887482908
        };
        let v0 = borrow_account_owner_only(arg0, arg2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1));
        let v1 = find_delegate_idx(&v0.delegates, arg3);
        if (0x1::option::is_none<u64>(&v1)) {
            abort 13906837829361926166
        };
        let v2 = 0x1::vector::borrow_mut<Delegate>(&mut v0.delegates, *0x1::option::borrow<u64>(&v1));
        v2.alias = arg4;
        v2.permissions = arg5;
        v2.expires_at_ms = arg6;
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_delegate_updated(0x2::object::id_to_address(&arg2), arg3, arg4, arg5, arg6);
    }

    public fun whitelist_protocol<T0>(arg0: &mut AccountRegistry, arg1: &AdminCap) {
        assert_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.protocol_whitelist, &v0)) {
            abort 13906836068426776620
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.protocol_whitelist, v0, 0x2::vec_set::empty<0x1::type_name::TypeName>());
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events::emit_protocol_whitelisted(v0);
    }

    public fun withdraw_from_funds<T0>(arg0: &mut AccountRegistry, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: 0x2::object::ID, arg3: &0x2::accumulator::AccumulatorRoot, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        assert_version(arg0);
        assert_not_paused(arg0);
        if (is_deposit_policy_registered<T0>(arg0)) {
            abort 13906839319718068284
        };
        if (!has_account(arg0, arg2)) {
            abort 13906839324010020878
        };
        if (!has_permission(arg0, arg2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1), 1, 0x2::clock::timestamp_ms(arg4))) {
            abort 13906839341189627914
        };
        let v0 = 0x2::balance::settled_funds_value<T0>(arg3, 0x2::object::id_to_address(&arg2));
        if (v0 == 0) {
            return 0x2::balance::zero<T0>()
        };
        0x2::balance::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(&mut borrow_account_mut(arg0, arg2).id, v0))
    }

    public fun withdraw_policies(arg0: &AccountRegistry) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>> {
        &arg0.withdraw_policies
    }

    public fun withdraw_policies_for<T0>(arg0: &AccountRegistry) : vector<0x1::type_name::TypeName> {
        assert_withdraw_policy_registered<T0>(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        *0x2::vec_set::keys<0x1::type_name::TypeName>(0x2::vec_map::get<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.withdraw_policies, &v0))
    }

    public fun withdraw_request_account_id<T0>(arg0: &WithdrawRequest<T0>) : 0x2::object::ID {
        arg0.account_id
    }

    public fun withdraw_request_amount<T0>(arg0: &WithdrawRequest<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun withdraw_request_balance<T0>(arg0: &WithdrawRequest<T0>) : &0x2::balance::Balance<T0> {
        &arg0.balance
    }

    public fun withdraw_request_extra_data<T0>(arg0: &WithdrawRequest<T0>) : vector<u8> {
        arg0.extra_data
    }

    public fun withdraw_request_recipient<T0>(arg0: &WithdrawRequest<T0>) : address {
        arg0.recipient
    }

    public(friend) fun witness() : WaterXAccount {
        WaterXAccount{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

