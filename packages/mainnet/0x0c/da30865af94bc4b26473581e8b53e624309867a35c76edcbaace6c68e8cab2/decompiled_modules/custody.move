module 0xcda30865af94bc4b26473581e8b53e624309867a35c76edcbaace6c68e8cab2::custody {
    struct OwnerKey has copy, drop, store {
        addr: address,
    }

    struct AccountKey has copy, drop, store {
        addr: address,
    }

    struct RecordKey has copy, drop, store {
        name: 0x1::string::String,
    }

    struct ConfigKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PriceKey has copy, drop, store {
        coin: 0x1::type_name::TypeName,
    }

    struct TreasuryKey has copy, drop, store {
        coin: 0x1::type_name::TypeName,
    }

    struct GrantKey has copy, drop, store {
        addr: address,
    }

    struct ApprovalKey has copy, drop, store {
        name: 0x1::string::String,
    }

    struct Account has drop, store {
        registered: u64,
        held: u64,
        names: vector<0x1::string::String>,
    }

    struct NameRecord has drop, store {
        holder: address,
        registrant: address,
        kind: u8,
        immune: bool,
        registered_at_ms: u64,
        reserved_versions: u64,
        premium_versions: u64,
    }

    struct EconomyConfig has drop, store {
        reserved_roots: vector<vector<u8>>,
        premium_roots: vector<vector<u8>>,
    }

    struct Grant has drop, store {
        remaining: u64,
        price: u64,
        coin: 0x1::type_name::TypeName,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Custody has key {
        id: 0x2::object::UID,
        parent: 0x1::option::Option<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>,
    }

    struct NameRegistered has copy, drop {
        name: 0x1::string::String,
        owner: address,
        kind: u8,
        price: u64,
    }

    struct NameTransferred has copy, drop {
        name: 0x1::string::String,
        from: address,
        to: address,
    }

    struct NameDeleted has copy, drop {
        name: 0x1::string::String,
        holder: address,
    }

    struct NameRevoked has copy, drop {
        name: 0x1::string::String,
        holder: address,
        reason: u8,
    }

    struct RootUpdated has copy, drop {
        list: u8,
        version: u64,
    }

    struct GrantUpdated has copy, drop {
        addr: address,
        remaining: u64,
        price: u64,
    }

    struct AccountPurged has copy, drop {
        addr: address,
        names_removed: u64,
    }

    fun account(arg0: &Custody, arg1: address) : &Account {
        let v0 = AccountKey{addr: arg1};
        0x2::dynamic_field::borrow<AccountKey, Account>(&arg0.id, v0)
    }

    fun account_mut(arg0: &mut Custody, arg1: address) : &mut Account {
        let v0 = AccountKey{addr: arg1};
        0x2::dynamic_field::borrow_mut<AccountKey, Account>(&mut arg0.id, v0)
    }

    public fun admin_register(arg0: &AdminCap, arg1: &mut Custody, arg2: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg3: &0x2::clock::Clock, arg4: 0x1::string::String, arg5: address, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        mint_leaf(arg1, arg2, arg3, arg4, arg5, 2, arg6, 0, arg7);
    }

    public fun approval_of(arg0: &Custody, arg1: 0x1::string::String) : 0x1::option::Option<address> {
        let v0 = ApprovalKey{name: full_leaf_name(arg0, arg1)};
        if (0x2::dynamic_field::exists_with_type<ApprovalKey, address>(&arg0.id, v0)) {
            0x1::option::some<address>(*0x2::dynamic_field::borrow<ApprovalKey, address>(&arg0.id, v0))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun approve_name(arg0: &AdminCap, arg1: &mut Custody, arg2: 0x1::string::String, arg3: address) {
        let v0 = ApprovalKey{name: full_leaf_name(arg1, arg2)};
        if (0x2::dynamic_field::exists_with_type<ApprovalKey, address>(&arg1.id, v0)) {
            *0x2::dynamic_field::borrow_mut<ApprovalKey, address>(&mut arg1.id, v0) = arg3;
        } else {
            0x2::dynamic_field::add<ApprovalKey, address>(&mut arg1.id, v0, arg3);
        };
    }

    fun assert_challengeable(arg0: &NameRecord, arg1: u64, arg2: &vector<vector<u8>>, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = arg1 > 0 && arg3 + 1 == arg1;
        let v1 = arg3 + 1 == 0x1::vector::length<vector<u8>>(arg2) && 0x2::clock::timestamp_ms(arg4) < arg0.registered_at_ms + 2592000000;
        assert!(v0 || v1, 20);
    }

    fun bytes_lt(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = if (v0 < v1) {
            v0
        } else {
            v1
        };
        let v3 = 0;
        while (v3 < v2) {
            if (*0x1::vector::borrow<u8>(arg0, v3) != *0x1::vector::borrow<u8>(arg1, v3)) {
                return *0x1::vector::borrow<u8>(arg0, v3) < *0x1::vector::borrow<u8>(arg1, v3)
            };
            v3 = v3 + 1;
        };
        v0 < v1
    }

    public fun claim_grant<T0>(arg0: &mut Custody, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: &0x2::clock::Clock, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        ensure_account(arg0, v0);
        let v1 = GrantKey{addr: v0};
        assert!(0x2::dynamic_field::exists_with_type<GrantKey, Grant>(&arg0.id, v1), 12);
        let v2 = 0x2::dynamic_field::borrow_mut<GrantKey, Grant>(&mut arg0.id, v1);
        assert!(v2.coin == 0x1::type_name::with_defining_ids<T0>(), 13);
        v2.remaining = v2.remaining - 1;
        let v3 = v2.price;
        let v4 = v2.remaining;
        if (v4 == 0) {
            let Grant {
                remaining : _,
                price     : _,
                coin      : _,
            } = 0x2::dynamic_field::remove<GrantKey, Grant>(&mut arg0.id, v1);
        };
        take_payment<T0>(arg0, arg4, v3);
        mint_leaf(arg0, arg1, arg2, arg3, v0, 2, false, v3, arg5);
        let v8 = GrantUpdated{
            addr      : v0,
            remaining : v4,
            price     : v3,
        };
        0x2::event::emit<GrantUpdated>(v8);
    }

    fun clear_primary_if(arg0: &mut Custody, arg1: address, arg2: 0x1::string::String) {
        let v0 = OwnerKey{addr: arg1};
        if (0x2::dynamic_field::exists_with_type<OwnerKey, 0x1::string::String>(&arg0.id, v0) && *0x2::dynamic_field::borrow<OwnerKey, 0x1::string::String>(&arg0.id, v0) == arg2) {
            0x2::dynamic_field::remove<OwnerKey, 0x1::string::String>(&mut arg0.id, v0);
        };
    }

    fun config_mut(arg0: &mut Custody) : &mut EconomyConfig {
        let v0 = ConfigKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<ConfigKey, EconomyConfig>(&arg0.id, v0)) {
            let v1 = ConfigKey{dummy_field: false};
            let v2 = EconomyConfig{
                reserved_roots : vector[],
                premium_roots  : vector[],
            };
            0x2::dynamic_field::add<ConfigKey, EconomyConfig>(&mut arg0.id, v1, v2);
        };
        let v3 = ConfigKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ConfigKey, EconomyConfig>(&mut arg0.id, v3)
    }

    public fun create_grant<T0>(arg0: &AdminCap, arg1: &mut Custody, arg2: address, arg3: u64, arg4: u64) {
        assert!(arg3 > 0, 12);
        let v0 = GrantKey{addr: arg2};
        if (0x2::dynamic_field::exists_with_type<GrantKey, Grant>(&arg1.id, v0)) {
            let Grant {
                remaining : _,
                price     : _,
                coin      : _,
            } = 0x2::dynamic_field::remove<GrantKey, Grant>(&mut arg1.id, v0);
        };
        let v4 = Grant{
            remaining : arg3,
            price     : arg4,
            coin      : 0x1::type_name::with_defining_ids<T0>(),
        };
        0x2::dynamic_field::add<GrantKey, Grant>(&mut arg1.id, v0, v4);
        let v5 = GrantUpdated{
            addr      : arg2,
            remaining : arg3,
            price     : arg4,
        };
        0x2::event::emit<GrantUpdated>(v5);
    }

    public fun delete_name(arg0: &mut Custody, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: &0x2::clock::Clock, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.parent), 0);
        ensure_account(arg0, v0);
        let v1 = full_leaf_name(arg0, arg3);
        let v2 = RecordKey{name: v1};
        assert!(0x2::dynamic_field::exists_with_type<RecordKey, NameRecord>(&arg0.id, v2), 8);
        let NameRecord {
            holder            : v3,
            registrant        : v4,
            kind              : v5,
            immune            : _,
            registered_at_ms  : _,
            reserved_versions : _,
            premium_versions  : _,
        } = 0x2::dynamic_field::remove<RecordKey, NameRecord>(&mut arg0.id, v2);
        assert!(v3 == v0, 9);
        let v10 = account_mut(arg0, v0);
        let v11 = &mut v10.names;
        remove_name(v11, &v1);
        if (v5 != 2) {
            v10.held = v10.held - 1;
            if (v4 == v0 && v10.registered > 0) {
                v10.registered = v10.registered - 1;
            };
        };
        0xe177697e191327901637f8d2c5ffbbde8b1aaac27ec1024c4b62d1ebd1cd7430::subdomains::remove_leaf(arg1, 0x1::option::borrow<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.parent), arg2, v1);
        clear_primary_if(arg0, v0, v1);
        let v12 = NameDeleted{
            name   : v1,
            holder : v0,
        };
        0x2::event::emit<NameDeleted>(v12);
    }

    public fun deposit_parent(arg0: &AdminCap, arg1: &mut Custody, arg2: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration) {
        assert!(0x1::option::is_none<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg1.parent), 1);
        0x1::option::fill<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&mut arg1.parent, arg2);
    }

    fun ensure_account(arg0: &mut Custody, arg1: address) {
        let v0 = AccountKey{addr: arg1};
        if (!0x2::dynamic_field::exists_with_type<AccountKey, Account>(&arg0.id, v0)) {
            let v1 = Account{
                registered : 0,
                held       : 0,
                names      : 0x1::vector::empty<0x1::string::String>(),
            };
            0x2::dynamic_field::add<AccountKey, Account>(&mut arg0.id, v0, v1);
        };
    }

    fun full_leaf_name(arg0: &Custody, arg1: 0x1::string::String) : 0x1::string::String {
        0x1::string::append_utf8(&mut arg1, b".");
        0x1::string::append(&mut arg1, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(0x1::option::borrow<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.parent)));
        arg1
    }

    public fun grant_of(arg0: &Custody, arg1: address) : (u64, u64) {
        let v0 = GrantKey{addr: arg1};
        if (0x2::dynamic_field::exists_with_type<GrantKey, Grant>(&arg0.id, v0)) {
            let v3 = 0x2::dynamic_field::borrow<GrantKey, Grant>(&arg0.id, v0);
            (v3.remaining, v3.price)
        } else {
            (0, 0)
        }
    }

    public fun holder_of(arg0: &Custody, arg1: 0x1::string::String) : 0x1::option::Option<address> {
        let v0 = RecordKey{name: full_leaf_name(arg0, arg1)};
        if (0x2::dynamic_field::exists_with_type<RecordKey, NameRecord>(&arg0.id, v0)) {
            0x1::option::some<address>(0x2::dynamic_field::borrow<RecordKey, NameRecord>(&arg0.id, v0).holder)
        } else {
            0x1::option::none<address>()
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Custody{
            id     : 0x2::object::new(arg0),
            parent : 0x1::option::none<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(),
        };
        0x2::transfer::share_object<Custody>(v1);
    }

    public fun is_transferable(arg0: &Custody, arg1: 0x1::string::String) : bool {
        let v0 = RecordKey{name: full_leaf_name(arg0, arg1)};
        assert!(0x2::dynamic_field::exists_with_type<RecordKey, NameRecord>(&arg0.id, v0), 8);
        0x2::dynamic_field::borrow<RecordKey, NameRecord>(&arg0.id, v0).kind != 0
    }

    fun leaf_hash(arg0: &0x1::string::String) : vector<u8> {
        let v0 = x"00";
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(arg0));
        0x2::hash::blake2b256(&v0)
    }

    public fun limits_of(arg0: &Custody, arg1: address) : (u64, u64) {
        let v0 = AccountKey{addr: arg1};
        if (0x2::dynamic_field::exists_with_type<AccountKey, Account>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow<AccountKey, Account>(&arg0.id, v0);
            return (v1.registered, v1.held)
        };
        (0, 0)
    }

    public fun list_versions(arg0: &Custody) : (u64, u64) {
        let v0 = reserved_roots(arg0);
        let v1 = premium_roots(arg0);
        (0x1::vector::length<vector<u8>>(&v0), 0x1::vector::length<vector<u8>>(&v1))
    }

    fun mint_leaf(arg0: &mut Custody, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: &0x2::clock::Clock, arg3: 0x1::string::String, arg4: address, arg5: u8, arg6: bool, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x1::string::String {
        assert!(0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.parent), 0);
        ensure_account(arg0, arg4);
        let v0 = full_leaf_name(arg0, arg3);
        let v1 = ApprovalKey{name: v0};
        if (0x2::dynamic_field::exists_with_type<ApprovalKey, address>(&arg0.id, v1) && *0x2::dynamic_field::borrow<ApprovalKey, address>(&arg0.id, v1) == arg4) {
            0x2::dynamic_field::remove<ApprovalKey, address>(&mut arg0.id, v1);
            arg6 = true;
        };
        let v2 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::reverse_lookup(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::registry<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::Registry>(arg1), arg4);
        0xe177697e191327901637f8d2c5ffbbde8b1aaac27ec1024c4b62d1ebd1cd7430::subdomains::new_leaf(arg1, 0x1::option::borrow<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.parent), arg2, v0, arg4, arg8);
        if (!0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain>(&v2) && arg4 == 0x2::tx_context::sender(arg8)) {
            0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::controller::set_reverse_lookup(arg1, v0, arg8);
        };
        let v3 = reserved_roots(arg0);
        let v4 = premium_roots(arg0);
        let v5 = RecordKey{name: v0};
        let v6 = NameRecord{
            holder            : arg4,
            registrant        : arg4,
            kind              : arg5,
            immune            : arg6,
            registered_at_ms  : 0x2::clock::timestamp_ms(arg2),
            reserved_versions : 0x1::vector::length<vector<u8>>(&v3),
            premium_versions  : 0x1::vector::length<vector<u8>>(&v4),
        };
        0x2::dynamic_field::add<RecordKey, NameRecord>(&mut arg0.id, v5, v6);
        let v7 = account_mut(arg0, arg4);
        0x1::vector::push_back<0x1::string::String>(&mut v7.names, v0);
        set_primary_if_absent(arg0, arg4, v0);
        let v8 = NameRegistered{
            name  : v0,
            owner : arg4,
            kind  : arg5,
            price : arg7,
        };
        0x2::event::emit<NameRegistered>(v8);
        v0
    }

    public fun names_of(arg0: &Custody, arg1: address) : vector<0x1::string::String> {
        let v0 = AccountKey{addr: arg1};
        if (0x2::dynamic_field::exists_with_type<AccountKey, Account>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<AccountKey, Account>(&arg0.id, v0).names
        } else {
            0x1::vector::empty<0x1::string::String>()
        }
    }

    fun node_hash(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = x"01";
        if (bytes_lt(&arg0, &arg1)) {
            0x1::vector::append<u8>(&mut v0, arg0);
            0x1::vector::append<u8>(&mut v0, arg1);
        } else {
            0x1::vector::append<u8>(&mut v0, arg1);
            0x1::vector::append<u8>(&mut v0, arg0);
        };
        0x2::hash::blake2b256(&v0)
    }

    fun premium_roots(arg0: &Custody) : vector<vector<u8>> {
        let v0 = ConfigKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<ConfigKey, EconomyConfig>(&arg0.id, v0)) {
            let v2 = ConfigKey{dummy_field: false};
            0x2::dynamic_field::borrow<ConfigKey, EconomyConfig>(&arg0.id, v2).premium_roots
        } else {
            vector[]
        }
    }

    public fun price_of<T0>(arg0: &Custody, arg1: u64) : u64 {
        let v0 = PriceKey{coin: 0x1::type_name::with_defining_ids<T0>()};
        assert!(0x2::dynamic_field::exists_with_type<PriceKey, vector<u64>>(&arg0.id, v0), 6);
        *0x1::vector::borrow<u64>(0x2::dynamic_field::borrow<PriceKey, vector<u64>>(&arg0.id, v0), arg1)
    }

    public fun purge_account(arg0: &mut Custody, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.parent), 0);
        let v1 = AccountKey{addr: v0};
        let v2 = 0;
        if (0x2::dynamic_field::exists_with_type<AccountKey, Account>(&arg0.id, v1)) {
            let Account {
                registered : _,
                held       : _,
                names      : v5,
            } = 0x2::dynamic_field::remove<AccountKey, Account>(&mut arg0.id, v1);
            let v6 = v5;
            v2 = 0x1::vector::length<0x1::string::String>(&v6);
            0x1::vector::reverse<0x1::string::String>(&mut v6);
            let v7 = 0;
            while (v7 < 0x1::vector::length<0x1::string::String>(&v6)) {
                let v8 = 0x1::vector::pop_back<0x1::string::String>(&mut v6);
                let v9 = RecordKey{name: v8};
                let NameRecord {
                    holder            : _,
                    registrant        : _,
                    kind              : _,
                    immune            : _,
                    registered_at_ms  : _,
                    reserved_versions : _,
                    premium_versions  : _,
                } = 0x2::dynamic_field::remove<RecordKey, NameRecord>(&mut arg0.id, v9);
                0xe177697e191327901637f8d2c5ffbbde8b1aaac27ec1024c4b62d1ebd1cd7430::subdomains::remove_leaf(arg1, 0x1::option::borrow<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.parent), arg2, v8);
                let v17 = NameRevoked{
                    name   : v8,
                    holder : v0,
                    reason : 2,
                };
                0x2::event::emit<NameRevoked>(v17);
                v7 = v7 + 1;
            };
            0x1::vector::destroy_empty<0x1::string::String>(v6);
        };
        let v18 = OwnerKey{addr: v0};
        if (0x2::dynamic_field::exists_with_type<OwnerKey, 0x1::string::String>(&arg0.id, v18)) {
            0x2::dynamic_field::remove<OwnerKey, 0x1::string::String>(&mut arg0.id, v18);
        };
        let v19 = AccountPurged{
            addr          : v0,
            names_removed : v2,
        };
        0x2::event::emit<AccountPurged>(v19);
    }

    public fun register<T0>(arg0: &mut Custody, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: &0x2::clock::Clock, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        ensure_account(arg0, v0);
        let v1 = account(arg0, v0);
        assert!(v1.registered >= 1, 3);
        assert!(v1.registered < 5, 4);
        assert!(v1.held < 5, 5);
        let v2 = price_of<T0>(arg0, v1.registered);
        take_payment<T0>(arg0, arg4, v2);
        let v3 = account_mut(arg0, v0);
        v3.registered = v3.registered + 1;
        v3.held = v3.held + 1;
        mint_leaf(arg0, arg1, arg2, arg3, v0, 1, false, v2, arg5);
    }

    public fun register_initial(arg0: &mut Custody, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: &0x2::clock::Clock, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        ensure_account(arg0, v0);
        let v1 = account_mut(arg0, v0);
        assert!(v1.registered == 0, 2);
        assert!(v1.held < 5, 5);
        v1.registered = v1.registered + 1;
        v1.held = v1.held + 1;
        mint_leaf(arg0, arg1, arg2, arg3, v0, 0, false, 0, arg4);
    }

    fun remove_name(arg0: &mut vector<0x1::string::String>, arg1: &0x1::string::String) {
        let (v0, v1) = 0x1::vector::index_of<0x1::string::String>(arg0, arg1);
        if (v0) {
            0x1::vector::swap_remove<0x1::string::String>(arg0, v1);
        };
    }

    public fun remove_prices<T0>(arg0: &AdminCap, arg1: &mut Custody) {
        let v0 = PriceKey{coin: 0x1::type_name::with_defining_ids<T0>()};
        assert!(0x2::dynamic_field::exists_with_type<PriceKey, vector<u64>>(&arg1.id, v0), 6);
        0x2::dynamic_field::remove<PriceKey, vector<u64>>(&mut arg1.id, v0);
    }

    fun reserved_roots(arg0: &Custody) : vector<vector<u8>> {
        let v0 = ConfigKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<ConfigKey, EconomyConfig>(&arg0.id, v0)) {
            let v2 = ConfigKey{dummy_field: false};
            0x2::dynamic_field::borrow<ConfigKey, EconomyConfig>(&arg0.id, v2).reserved_roots
        } else {
            vector[]
        }
    }

    public fun revoke_approval(arg0: &AdminCap, arg1: &mut Custody, arg2: 0x1::string::String) {
        let v0 = ApprovalKey{name: full_leaf_name(arg1, arg2)};
        assert!(0x2::dynamic_field::exists_with_type<ApprovalKey, address>(&arg1.id, v0), 19);
        0x2::dynamic_field::remove<ApprovalKey, address>(&mut arg1.id, v0);
    }

    public fun revoke_grant(arg0: &AdminCap, arg1: &mut Custody, arg2: address) {
        let v0 = GrantKey{addr: arg2};
        assert!(0x2::dynamic_field::exists_with_type<GrantKey, Grant>(&arg1.id, v0), 12);
        let Grant {
            remaining : _,
            price     : _,
            coin      : _,
        } = 0x2::dynamic_field::remove<GrantKey, Grant>(&mut arg1.id, v0);
        let v4 = GrantUpdated{
            addr      : arg2,
            remaining : 0,
            price     : 0,
        };
        0x2::event::emit<GrantUpdated>(v4);
    }

    fun revoke_internal(arg0: &mut Custody, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: &0x2::clock::Clock, arg3: 0x1::string::String, arg4: u8) {
        let v0 = RecordKey{name: arg3};
        let NameRecord {
            holder            : v1,
            registrant        : _,
            kind              : v3,
            immune            : _,
            registered_at_ms  : _,
            reserved_versions : _,
            premium_versions  : _,
        } = 0x2::dynamic_field::remove<RecordKey, NameRecord>(&mut arg0.id, v0);
        let v8 = account_mut(arg0, v1);
        let v9 = &mut v8.names;
        remove_name(v9, &arg3);
        if (v3 != 2) {
            v8.held = v8.held - 1;
        };
        0xe177697e191327901637f8d2c5ffbbde8b1aaac27ec1024c4b62d1ebd1cd7430::subdomains::remove_leaf(arg1, 0x1::option::borrow<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.parent), arg2, arg3);
        clear_primary_if(arg0, v1, arg3);
        let v10 = NameRevoked{
            name   : arg3,
            holder : v1,
            reason : arg4,
        };
        0x2::event::emit<NameRevoked>(v10);
    }

    public fun revoke_premium(arg0: &mut Custody, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: &0x2::clock::Clock, arg3: 0x1::string::String, arg4: u64, arg5: vector<vector<u8>>) {
        assert!(0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.parent), 0);
        let v0 = full_leaf_name(arg0, arg3);
        let v1 = RecordKey{name: v0};
        assert!(0x2::dynamic_field::exists_with_type<RecordKey, NameRecord>(&arg0.id, v1), 8);
        let v2 = premium_roots(arg0);
        let v3 = 0x2::dynamic_field::borrow<RecordKey, NameRecord>(&arg0.id, v1);
        assert!(!v3.immune, 15);
        assert!(v3.kind == 0, 16);
        assert_challengeable(v3, v3.premium_versions, &v2, arg4, arg2);
        assert!(arg4 < 0x1::vector::length<vector<u8>>(&v2), 14);
        assert!(verify_membership(*0x1::vector::borrow<vector<u8>>(&v2, arg4), &arg3, &arg5), 14);
        revoke_internal(arg0, arg1, arg2, v0, 1);
    }

    public fun revoke_reserved(arg0: &mut Custody, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: &0x2::clock::Clock, arg3: 0x1::string::String, arg4: u64, arg5: vector<vector<u8>>) {
        assert!(0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.parent), 0);
        let v0 = full_leaf_name(arg0, arg3);
        let v1 = RecordKey{name: v0};
        assert!(0x2::dynamic_field::exists_with_type<RecordKey, NameRecord>(&arg0.id, v1), 8);
        let v2 = reserved_roots(arg0);
        let v3 = 0x2::dynamic_field::borrow<RecordKey, NameRecord>(&arg0.id, v1);
        assert!(!v3.immune, 15);
        assert_challengeable(v3, v3.reserved_versions, &v2, arg4, arg2);
        assert!(arg4 < 0x1::vector::length<vector<u8>>(&v2), 14);
        assert!(verify_membership(*0x1::vector::borrow<vector<u8>>(&v2, arg4), &arg3, &arg5), 14);
        revoke_internal(arg0, arg1, arg2, v0, 0);
    }

    public fun set_as_default(arg0: &Custody, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.parent), 0);
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::controller::set_reverse_lookup(arg1, full_leaf_name(arg0, arg2), arg3);
    }

    public fun set_premium_root(arg0: &AdminCap, arg1: &mut Custody, arg2: vector<u8>) {
        let v0 = config_mut(arg1);
        0x1::vector::push_back<vector<u8>>(&mut v0.premium_roots, arg2);
        let v1 = RootUpdated{
            list    : 1,
            version : 0x1::vector::length<vector<u8>>(&v0.premium_roots) - 1,
        };
        0x2::event::emit<RootUpdated>(v1);
    }

    public fun set_prices<T0>(arg0: &AdminCap, arg1: &mut Custody, arg2: vector<u64>) {
        assert!(0x1::vector::length<u64>(&arg2) == 5 && *0x1::vector::borrow<u64>(&arg2, 0) == 0, 17);
        let v0 = PriceKey{coin: 0x1::type_name::with_defining_ids<T0>()};
        if (0x2::dynamic_field::exists_with_type<PriceKey, vector<u64>>(&arg1.id, v0)) {
            *0x2::dynamic_field::borrow_mut<PriceKey, vector<u64>>(&mut arg1.id, v0) = arg2;
        } else {
            0x2::dynamic_field::add<PriceKey, vector<u64>>(&mut arg1.id, v0, arg2);
        };
    }

    public fun set_primary(arg0: &mut Custody, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = full_leaf_name(arg0, arg1);
        let v2 = RecordKey{name: v1};
        assert!(0x2::dynamic_field::exists_with_type<RecordKey, NameRecord>(&arg0.id, v2), 8);
        assert!(0x2::dynamic_field::borrow<RecordKey, NameRecord>(&arg0.id, v2).holder == v0, 9);
        let v3 = OwnerKey{addr: v0};
        if (0x2::dynamic_field::exists_with_type<OwnerKey, 0x1::string::String>(&arg0.id, v3)) {
            *0x2::dynamic_field::borrow_mut<OwnerKey, 0x1::string::String>(&mut arg0.id, v3) = v1;
        } else {
            0x2::dynamic_field::add<OwnerKey, 0x1::string::String>(&mut arg0.id, v3, v1);
        };
    }

    fun set_primary_if_absent(arg0: &mut Custody, arg1: address, arg2: 0x1::string::String) {
        let v0 = OwnerKey{addr: arg1};
        if (!0x2::dynamic_field::exists_with_type<OwnerKey, 0x1::string::String>(&arg0.id, v0)) {
            0x2::dynamic_field::add<OwnerKey, 0x1::string::String>(&mut arg0.id, v0, arg2);
        };
    }

    public fun set_reserved_root(arg0: &AdminCap, arg1: &mut Custody, arg2: vector<u8>) {
        let v0 = config_mut(arg1);
        0x1::vector::push_back<vector<u8>>(&mut v0.reserved_roots, arg2);
        let v1 = RootUpdated{
            list    : 0,
            version : 0x1::vector::length<vector<u8>>(&v0.reserved_roots) - 1,
        };
        0x2::event::emit<RootUpdated>(v1);
    }

    public fun subname_of(arg0: &Custody, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: address) : 0x1::option::Option<0x1::string::String> {
        let v0 = OwnerKey{addr: arg2};
        if (!0x2::dynamic_field::exists_with_type<OwnerKey, 0x1::string::String>(&arg0.id, v0)) {
            return 0x1::option::none<0x1::string::String>()
        };
        let v1 = *0x2::dynamic_field::borrow<OwnerKey, 0x1::string::String>(&arg0.id, v0);
        let v2 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::lookup(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::registry<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::Registry>(arg1), 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::new(v1));
        if (0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::NameRecord>(&v2)) {
            let v3 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::target_address(0x1::option::borrow<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::NameRecord>(&v2));
            if (0x1::option::is_some<address>(&v3) && *0x1::option::borrow<address>(&v3) == arg2) {
                return 0x1::option::some<0x1::string::String>(v1)
            };
        };
        0x1::option::none<0x1::string::String>()
    }

    fun take_payment<T0>(arg0: &mut Custody, arg1: 0x2::coin::Coin<T0>, arg2: u64) {
        assert!(0x2::coin::value<T0>(&arg1) == arg2, 7);
        let v0 = TreasuryKey{coin: 0x1::type_name::with_defining_ids<T0>()};
        if (!0x2::dynamic_field::exists_with_type<TreasuryKey, 0x2::balance::Balance<T0>>(&arg0.id, v0)) {
            0x2::dynamic_field::add<TreasuryKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<TreasuryKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), 0x2::coin::into_balance<T0>(arg1));
    }

    public fun transfer_name(arg0: &mut Custody, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: &0x2::clock::Clock, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg4 != v0, 11);
        assert!(0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.parent), 0);
        ensure_account(arg0, v0);
        ensure_account(arg0, arg4);
        let v1 = full_leaf_name(arg0, arg3);
        let v2 = RecordKey{name: v1};
        assert!(0x2::dynamic_field::exists_with_type<RecordKey, NameRecord>(&arg0.id, v2), 8);
        let v3 = 0x2::dynamic_field::borrow<RecordKey, NameRecord>(&arg0.id, v2);
        assert!(v3.holder == v0, 9);
        assert!(v3.kind != 0, 10);
        let v4 = v3.kind;
        let v5 = account_mut(arg0, v0);
        let v6 = &mut v5.names;
        remove_name(v6, &v1);
        if (v4 == 1) {
            v5.held = v5.held - 1;
        };
        let v7 = account_mut(arg0, arg4);
        assert!(v7.held < 5, 5);
        v7.held = v7.held + 1;
        0x1::vector::push_back<0x1::string::String>(&mut v7.names, v1);
        let v8 = 0x2::dynamic_field::borrow_mut<RecordKey, NameRecord>(&mut arg0.id, v2);
        v8.holder = arg4;
        v8.kind = 1;
        let v9 = 0x1::option::borrow<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.parent);
        0xe177697e191327901637f8d2c5ffbbde8b1aaac27ec1024c4b62d1ebd1cd7430::subdomains::remove_leaf(arg1, v9, arg2, v1);
        0xe177697e191327901637f8d2c5ffbbde8b1aaac27ec1024c4b62d1ebd1cd7430::subdomains::new_leaf(arg1, v9, arg2, v1, arg4, arg5);
        clear_primary_if(arg0, v0, v1);
        set_primary_if_absent(arg0, arg4, v1);
        let v10 = NameTransferred{
            name : v1,
            from : v0,
            to   : arg4,
        };
        0x2::event::emit<NameTransferred>(v10);
    }

    fun verify_membership(arg0: vector<u8>, arg1: &0x1::string::String, arg2: &vector<vector<u8>>) : bool {
        if (0x1::vector::is_empty<u8>(&arg0)) {
            return false
        };
        let v0 = leaf_hash(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg2)) {
            v0 = node_hash(v0, *0x1::vector::borrow<vector<u8>>(arg2, v1));
            v1 = v1 + 1;
        };
        v0 == arg0
    }

    public fun withdraw_parent(arg0: &AdminCap, arg1: &mut Custody) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration {
        assert!(0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg1.parent), 0);
        0x1::option::extract<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&mut arg1.parent)
    }

    public fun withdraw_treasury<T0>(arg0: &AdminCap, arg1: &mut Custody, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = TreasuryKey{coin: 0x1::type_name::with_defining_ids<T0>()};
        assert!(0x2::dynamic_field::exists_with_type<TreasuryKey, 0x2::balance::Balance<T0>>(&arg1.id, v0), 18);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::dynamic_field::borrow_mut<TreasuryKey, 0x2::balance::Balance<T0>>(&mut arg1.id, v0)), arg2)
    }

    // decompiled from Move bytecode v7
}

