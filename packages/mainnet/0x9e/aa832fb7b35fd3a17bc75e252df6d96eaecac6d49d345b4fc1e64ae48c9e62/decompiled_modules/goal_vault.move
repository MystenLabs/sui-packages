module 0xb0898eef5734ee9ebfbdbacd9e39533d7070159d4a87287ddde8a5b331059947::goal_vault {
    struct GoalVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        target: u64,
        principal: 0x2::balance::Balance<T0>,
        venue: u8,
        basis: u64,
        receipt_type: 0x1::ascii::String,
        created_at_ms: u64,
        deposits_total: u64,
        withdrawals_total: u64,
    }

    struct GoalCreated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        target: u64,
    }

    struct GoalDeposited has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        balance: u64,
    }

    struct GoalWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        balance: u64,
    }

    struct GoalClosed has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        returned: u64,
    }

    struct GoalUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        target: u64,
    }

    struct GoalSupplied has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        venue: u8,
        basis: u64,
    }

    struct GoalRedeemed has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        venue: u8,
        basis: u64,
    }

    struct GoalRenamed has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
    }

    struct GoalRenamedV2 has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
    }

    struct GoalOwnerChanged has copy, drop {
        vault_id: 0x2::object::ID,
        old_owner: address,
        new_owner: address,
    }

    public fun balance<T0>(arg0: &GoalVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.principal)
    }

    public fun new<T0>(arg0: vector<u8>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : GoalVault<T0> {
        new_vault<T0>(arg0, arg1, 0x2::balance::zero<T0>(), arg2, arg3)
    }

    public fun basis<T0>(arg0: &GoalVault<T0>) : u64 {
        arg0.basis
    }

    public fun close<T0>(arg0: GoalVault<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 300);
        assert!(!0x2::dynamic_object_field::exists<u8>(&arg0.id, 0), 305);
        let GoalVault {
            id                : v0,
            owner             : v1,
            name              : _,
            target            : _,
            principal         : v4,
            venue             : _,
            basis             : _,
            receipt_type      : _,
            created_at_ms     : _,
            deposits_total    : _,
            withdrawals_total : _,
        } = arg0;
        let v11 = v4;
        let v12 = v0;
        let v13 = GoalClosed{
            vault_id : 0x2::object::uid_to_inner(&v12),
            owner    : v1,
            returned : 0x2::balance::value<T0>(&v11),
        };
        0x2::event::emit<GoalClosed>(v13);
        0x2::object::delete(v12);
        0x2::coin::from_balance<T0>(v11, arg1)
    }

    public fun create<T0>(arg0: vector<u8>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = new<T0>(arg0, arg1, arg2, arg3);
        keep<T0>(v0, arg3);
    }

    public fun create_with<T0>(arg0: vector<u8>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = new_with<T0>(arg0, arg1, arg2, arg3, arg4);
        keep<T0>(v0, arg4);
    }

    public fun deposit<T0>(arg0: &mut GoalVault<T0>, arg1: 0x2::coin::Coin<T0>) {
        deposit_internal<T0>(arg0, arg1);
    }

    fun deposit_internal<T0>(arg0: &mut GoalVault<T0>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 302);
        0x2::balance::join<T0>(&mut arg0.principal, 0x2::coin::into_balance<T0>(arg1));
        arg0.deposits_total = 0x1::u64::saturating_add(arg0.deposits_total, v0);
        let v1 = GoalDeposited{
            vault_id : 0x2::object::id<GoalVault<T0>>(arg0),
            owner    : arg0.owner,
            amount   : v0,
            balance  : 0x2::balance::value<T0>(&arg0.principal),
        };
        0x2::event::emit<GoalDeposited>(v1);
    }

    public fun deposit_v2<T0>(arg0: &mut GoalVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 300);
        deposit_internal<T0>(arg0, arg1);
    }

    public fun deposits_total<T0>(arg0: &GoalVault<T0>) : u64 {
        arg0.deposits_total
    }

    public fun has_receipt<T0>(arg0: &GoalVault<T0>) : bool {
        arg0.venue != 0
    }

    public fun is_complete<T0>(arg0: &GoalVault<T0>) : bool {
        arg0.target > 0 && total_value<T0>(arg0) >= arg0.target
    }

    public fun keep<T0>(arg0: GoalVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<GoalVault<T0>>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun name<T0>(arg0: &GoalVault<T0>) : 0x1::string::String {
        arg0.name
    }

    fun new_vault<T0>(arg0: vector<u8>, arg1: u64, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : GoalVault<T0> {
        assert!(0x1::vector::length<u8>(&arg0) <= 64, 303);
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = GoalVault<T0>{
            id                : 0x2::object::new(arg4),
            owner             : 0x2::tx_context::sender(arg4),
            name              : 0x1::string::utf8(arg0),
            target            : arg1,
            principal         : arg2,
            venue             : 0,
            basis             : 0,
            receipt_type      : 0x1::ascii::string(b""),
            created_at_ms     : 0x2::clock::timestamp_ms(arg3),
            deposits_total    : v0,
            withdrawals_total : 0,
        };
        let v2 = 0x2::object::uid_to_inner(&v1.id);
        let v3 = GoalCreated{
            vault_id : v2,
            owner    : v1.owner,
            target   : arg1,
        };
        0x2::event::emit<GoalCreated>(v3);
        if (v0 > 0) {
            let v4 = GoalDeposited{
                vault_id : v2,
                owner    : v1.owner,
                amount   : v0,
                balance  : v0,
            };
            0x2::event::emit<GoalDeposited>(v4);
        };
        v1
    }

    public fun new_with<T0>(arg0: vector<u8>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : GoalVault<T0> {
        new_vault<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), arg3, arg4)
    }

    public fun owner<T0>(arg0: &GoalVault<T0>) : address {
        arg0.owner
    }

    public fun park_receipt<T0, T1: store + key>(arg0: &mut GoalVault<T0>, arg1: T1, arg2: u8, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        park_receipt_internal<T0, T1>(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg4));
    }

    fun park_receipt_internal<T0, T1: store + key>(arg0: &mut GoalVault<T0>, arg1: T1, arg2: u8, arg3: u64, arg4: address) {
        assert!(arg4 == arg0.owner, 300);
        assert!(arg2 != 0, 304);
        assert!(arg0.venue == 0 && !0x2::dynamic_object_field::exists<u8>(&arg0.id, 0), 305);
        assert!((0x2::balance::value<T0>(&arg0.principal) as u128) + (arg3 as u128) <= 18446744073709551615, 309);
        0x2::dynamic_object_field::add<u8, T1>(&mut arg0.id, 0, arg1);
        arg0.venue = arg2;
        arg0.basis = arg3;
        arg0.receipt_type = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>());
        let v0 = GoalSupplied{
            vault_id : 0x2::object::id<GoalVault<T0>>(arg0),
            owner    : arg0.owner,
            venue    : arg2,
            basis    : arg3,
        };
        0x2::event::emit<GoalSupplied>(v0);
    }

    public fun park_receipt_v2<T0, T1: store + key>(arg0: &mut GoalVault<T0>, arg1: T1, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        park_receipt_internal<T0, T1>(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg4));
    }

    public fun progress_bps<T0>(arg0: &GoalVault<T0>) : u64 {
        if (arg0.target == 0) {
            return 0
        };
        let v0 = total_value<T0>(arg0);
        if (v0 >= arg0.target) {
            return 10000
        };
        (((v0 as u128) * 10000 / (arg0.target as u128)) as u64)
    }

    public fun receipt_type<T0>(arg0: &GoalVault<T0>) : 0x1::ascii::String {
        arg0.receipt_type
    }

    public fun rename<T0>(arg0: &mut GoalVault<T0>, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        rename_internal<T0>(arg0, arg1, 0x2::tx_context::sender(arg2));
    }

    fun rename_internal<T0>(arg0: &mut GoalVault<T0>, arg1: vector<u8>, arg2: address) {
        assert!(arg2 == arg0.owner, 300);
        assert!(0x1::vector::length<u8>(&arg1) <= 64, 303);
        let v0 = 0x1::string::utf8(arg1);
        arg0.name = v0;
        let v1 = 0x2::object::id<GoalVault<T0>>(arg0);
        let v2 = GoalRenamed{
            vault_id : v1,
            owner    : arg0.owner,
        };
        0x2::event::emit<GoalRenamed>(v2);
        let v3 = GoalRenamedV2{
            vault_id : v1,
            owner    : arg0.owner,
            name     : v0,
        };
        0x2::event::emit<GoalRenamedV2>(v3);
    }

    public fun rename_v2<T0>(arg0: &mut GoalVault<T0>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        rename_internal<T0>(arg0, arg1, 0x2::tx_context::sender(arg2));
    }

    public fun set_target<T0>(arg0: &mut GoalVault<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        set_target_internal<T0>(arg0, arg1, 0x2::tx_context::sender(arg2));
    }

    fun set_target_internal<T0>(arg0: &mut GoalVault<T0>, arg1: u64, arg2: address) {
        assert!(arg2 == arg0.owner, 300);
        arg0.target = arg1;
        let v0 = GoalUpdated{
            vault_id : 0x2::object::id<GoalVault<T0>>(arg0),
            owner    : arg0.owner,
            target   : arg1,
        };
        0x2::event::emit<GoalUpdated>(v0);
    }

    public fun set_target_v2<T0>(arg0: &mut GoalVault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        set_target_internal<T0>(arg0, arg1, 0x2::tx_context::sender(arg2));
    }

    public fun take_receipt<T0, T1: store + key>(arg0: &mut GoalVault<T0>, arg1: &0x2::tx_context::TxContext) : T1 {
        take_receipt_internal<T0, T1>(arg0, 0x2::tx_context::sender(arg1))
    }

    fun take_receipt_internal<T0, T1: store + key>(arg0: &mut GoalVault<T0>, arg1: address) : T1 {
        assert!(arg1 == arg0.owner, 300);
        assert!(0x2::dynamic_object_field::exists_with_type<u8, T1>(&arg0.id, 0), 306);
        arg0.venue = 0;
        arg0.basis = 0;
        arg0.receipt_type = 0x1::ascii::string(b"");
        let v0 = GoalRedeemed{
            vault_id : 0x2::object::id<GoalVault<T0>>(arg0),
            owner    : arg0.owner,
            venue    : arg0.venue,
            basis    : arg0.basis,
        };
        0x2::event::emit<GoalRedeemed>(v0);
        0x2::dynamic_object_field::remove<u8, T1>(&mut arg0.id, 0)
    }

    public fun take_receipt_v2<T0, T1: store + key>(arg0: &mut GoalVault<T0>, arg1: &mut 0x2::tx_context::TxContext) : T1 {
        take_receipt_internal<T0, T1>(arg0, 0x2::tx_context::sender(arg1))
    }

    public fun target<T0>(arg0: &GoalVault<T0>) : u64 {
        arg0.target
    }

    public fun total_value<T0>(arg0: &GoalVault<T0>) : u64 {
        0x1::u64::saturating_add(0x2::balance::value<T0>(&arg0.principal), arg0.basis)
    }

    public fun transfer_ownership<T0>(arg0: GoalVault<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 300);
        assert!(arg1 != @0x0, 307);
        assert!(arg1 != arg0.owner, 308);
        arg0.owner = arg1;
        let v0 = GoalOwnerChanged{
            vault_id  : 0x2::object::uid_to_inner(&arg0.id),
            old_owner : arg0.owner,
            new_owner : arg1,
        };
        0x2::event::emit<GoalOwnerChanged>(v0);
        0x2::transfer::public_transfer<GoalVault<T0>>(arg0, arg1);
    }

    public fun venue<T0>(arg0: &GoalVault<T0>) : u8 {
        arg0.venue
    }

    public fun withdraw<T0>(arg0: &mut GoalVault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 300);
        assert!(arg1 > 0, 302);
        assert!(0x2::balance::value<T0>(&arg0.principal) >= arg1, 301);
        arg0.withdrawals_total = 0x1::u64::saturating_add(arg0.withdrawals_total, arg1);
        let v0 = GoalWithdrawn{
            vault_id : 0x2::object::id<GoalVault<T0>>(arg0),
            owner    : arg0.owner,
            amount   : arg1,
            balance  : 0x2::balance::value<T0>(&arg0.principal),
        };
        0x2::event::emit<GoalWithdrawn>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.principal, arg1), arg2)
    }

    public fun withdrawals_total<T0>(arg0: &GoalVault<T0>) : u64 {
        arg0.withdrawals_total
    }

    // decompiled from Move bytecode v7
}

