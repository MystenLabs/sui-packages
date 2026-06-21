module 0x6ea861c0a3587ad2d1fcfe0a4cc5edc3384338aec76e415655883ec190f4ac39::vault {
    struct BlobMetadata has copy, drop, store {
        size_bytes: u64,
        uploaded_at_ms: u64,
        end_epoch: u64,
        is_encrypted: bool,
        last_extended_at_ms: u64,
    }

    struct StorageVault<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        keeper: address,
        access_policy: 0x6ea861c0a3587ad2d1fcfe0a4cc5edc3384338aec76e415655883ec190f4ac39::access::AccessPolicy,
        blobs: 0x2::table::Table<vector<u8>, BlobMetadata>,
        vault_type: u8,
        label: vector<u8>,
        funds: 0x2::balance::Balance<T0>,
        principal_floor: u64,
        total_renewals: u64,
        total_yield_consumed: u64,
        created_at_ms: u64,
        last_renewal_at_ms: u64,
        closed: bool,
    }

    struct VaultCreated has copy, drop {
        vault_id: address,
        owner: address,
        keeper: address,
        principal_floor: u64,
        deposit_units: u64,
        vault_type: u8,
        access_kind: u8,
        timestamp_ms: u64,
    }

    struct BlobRegistered has copy, drop {
        vault_id: address,
        blob_id: vector<u8>,
        size_bytes: u64,
        end_epoch: u64,
        is_encrypted: bool,
        timestamp_ms: u64,
    }

    struct BlobExtended has copy, drop {
        vault_id: address,
        blob_id: vector<u8>,
        new_end_epoch: u64,
        timestamp_ms: u64,
    }

    struct YieldClaimed has copy, drop {
        vault_id: address,
        caller: address,
        claimed_sui_equiv: u64,
        claimed_units: u64,
        timestamp_ms: u64,
    }

    struct DepositAdded has copy, drop {
        vault_id: address,
        added_units: u64,
        new_total_units: u64,
        timestamp_ms: u64,
    }

    struct VaultClosed has copy, drop {
        vault_id: address,
        returned_units: u64,
        timestamp_ms: u64,
    }

    public fun access_policy<T0>(arg0: &StorageVault<T0>) : &0x6ea861c0a3587ad2d1fcfe0a4cc5edc3384338aec76e415655883ec190f4ac39::access::AccessPolicy {
        &arg0.access_policy
    }

    public fun blob_count<T0>(arg0: &StorageVault<T0>) : u64 {
        0x2::table::length<vector<u8>, BlobMetadata>(&arg0.blobs)
    }

    public fun blob_end_epoch<T0>(arg0: &StorageVault<T0>, arg1: vector<u8>) : u64 {
        0x2::table::borrow<vector<u8>, BlobMetadata>(&arg0.blobs, arg1).end_epoch
    }

    public fun claim_for_renewal<T0>(arg0: &mut StorageVault<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.closed, 3);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == arg0.keeper || v0 == arg0.owner, 10);
        assert!(arg1 > 0 && arg2 > 0, 7);
        let v1 = to_sui(0x2::balance::value<T0>(&arg0.funds), arg1, arg2);
        assert!(v1 > arg0.principal_floor, 8);
        let v2 = v1 - arg0.principal_floor;
        let v3 = if (arg3 < v2) {
            arg3
        } else {
            v2
        };
        let v4 = to_units(v3, arg1, arg2);
        assert!(to_sui(0x2::balance::value<T0>(&arg0.funds), arg1, arg2) >= arg0.principal_floor, 9);
        arg0.total_yield_consumed = arg0.total_yield_consumed + v3;
        let v5 = YieldClaimed{
            vault_id          : 0x2::object::uid_to_address(&arg0.id),
            caller            : v0,
            claimed_sui_equiv : v3,
            claimed_units     : v4,
            timestamp_ms      : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<YieldClaimed>(v5);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, v4), arg5)
    }

    public fun close_vault<T0>(arg0: &mut StorageVault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        assert!(!arg0.closed, 3);
        arg0.closed = true;
        let v0 = VaultClosed{
            vault_id       : 0x2::object::uid_to_address(&arg0.id),
            returned_units : 0x2::balance::value<T0>(&arg0.funds),
            timestamp_ms   : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<VaultClosed>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.funds), arg2)
    }

    public fun create_and_share_vault<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u8, arg3: vector<address>, arg4: u64, arg5: u8, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<StorageVault<T0>>(new_vault<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8));
    }

    public fun deposit_additional<T0>(arg0: &mut StorageVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock) {
        assert!(!arg0.closed, 3);
        0x2::balance::join<T0>(&mut arg0.funds, 0x2::coin::into_balance<T0>(arg1));
        let v0 = DepositAdded{
            vault_id        : 0x2::object::uid_to_address(&arg0.id),
            added_units     : 0x2::coin::value<T0>(&arg1),
            new_total_units : 0x2::balance::value<T0>(&arg0.funds),
            timestamp_ms    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DepositAdded>(v0);
    }

    public fun funds_units<T0>(arg0: &StorageVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    public fun has_blob<T0>(arg0: &StorageVault<T0>, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, BlobMetadata>(&arg0.blobs, arg1)
    }

    public fun is_closed<T0>(arg0: &StorageVault<T0>) : bool {
        arg0.closed
    }

    public fun keeper<T0>(arg0: &StorageVault<T0>) : address {
        arg0.keeper
    }

    public fun new_vault<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u8, arg3: vector<address>, arg4: u64, arg5: u8, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : StorageVault<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 1);
        let v1 = 0x6ea861c0a3587ad2d1fcfe0a4cc5edc3384338aec76e415655883ec190f4ac39::access::from_args(arg2, arg3, arg4);
        let v2 = 0x2::clock::timestamp_ms(arg7);
        let v3 = 0x2::tx_context::sender(arg8);
        let v4 = StorageVault<T0>{
            id                   : 0x2::object::new(arg8),
            owner                : v3,
            keeper               : v3,
            access_policy        : v1,
            blobs                : 0x2::table::new<vector<u8>, BlobMetadata>(arg8),
            vault_type           : arg5,
            label                : arg6,
            funds                : 0x2::coin::into_balance<T0>(arg0),
            principal_floor      : arg1,
            total_renewals       : 0,
            total_yield_consumed : 0,
            created_at_ms        : v2,
            last_renewal_at_ms   : v2,
            closed               : false,
        };
        let v5 = VaultCreated{
            vault_id        : 0x2::object::uid_to_address(&v4.id),
            owner           : v3,
            keeper          : v3,
            principal_floor : arg1,
            deposit_units   : v0,
            vault_type      : arg5,
            access_kind     : 0x6ea861c0a3587ad2d1fcfe0a4cc5edc3384338aec76e415655883ec190f4ac39::access::kind(&v1),
            timestamp_ms    : v2,
        };
        0x2::event::emit<VaultCreated>(v5);
        v4
    }

    public fun owner<T0>(arg0: &StorageVault<T0>) : address {
        arg0.owner
    }

    public fun principal_floor<T0>(arg0: &StorageVault<T0>) : u64 {
        arg0.principal_floor
    }

    public fun raise_floor<T0>(arg0: &mut StorageVault<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        assert!(arg1 >= arg0.principal_floor, 9);
        arg0.principal_floor = arg1;
    }

    public(friend) fun record_blob_extension<T0>(arg0: &mut StorageVault<T0>, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(0x2::table::contains<vector<u8>, BlobMetadata>(&arg0.blobs, arg1), 4);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::table::borrow_mut<vector<u8>, BlobMetadata>(&mut arg0.blobs, arg1);
        v1.end_epoch = arg2;
        v1.last_extended_at_ms = v0;
        arg0.total_renewals = arg0.total_renewals + 1;
        arg0.last_renewal_at_ms = v0;
        let v2 = BlobExtended{
            vault_id      : 0x2::object::uid_to_address(&arg0.id),
            blob_id       : arg1,
            new_end_epoch : arg2,
            timestamp_ms  : v0,
        };
        0x2::event::emit<BlobExtended>(v2);
    }

    public fun register_blob<T0>(arg0: &mut StorageVault<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(!arg0.closed, 3);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(0x6ea861c0a3587ad2d1fcfe0a4cc5edc3384338aec76e415655883ec190f4ac39::access::check_access(&arg0.access_policy, 0x2::tx_context::sender(arg6), arg0.owner, v0), 6);
        assert!(!0x2::table::contains<vector<u8>, BlobMetadata>(&arg0.blobs, arg1), 5);
        let v1 = BlobMetadata{
            size_bytes          : arg2,
            uploaded_at_ms      : v0,
            end_epoch           : arg3,
            is_encrypted        : arg4,
            last_extended_at_ms : v0,
        };
        0x2::table::add<vector<u8>, BlobMetadata>(&mut arg0.blobs, arg1, v1);
        let v2 = BlobRegistered{
            vault_id     : 0x2::object::uid_to_address(&arg0.id),
            blob_id      : arg1,
            size_bytes   : arg2,
            end_epoch    : arg3,
            is_encrypted : arg4,
            timestamp_ms : v0,
        };
        0x2::event::emit<BlobRegistered>(v2);
    }

    public fun set_keeper<T0>(arg0: &mut StorageVault<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        arg0.keeper = arg1;
    }

    fun to_sui(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    fun to_units(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg2 as u128) / (arg1 as u128)) as u64)
    }

    public fun total_renewals<T0>(arg0: &StorageVault<T0>) : u64 {
        arg0.total_renewals
    }

    public fun total_yield_consumed<T0>(arg0: &StorageVault<T0>) : u64 {
        arg0.total_yield_consumed
    }

    public fun vault_id<T0>(arg0: &StorageVault<T0>) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    // decompiled from Move bytecode v7
}

