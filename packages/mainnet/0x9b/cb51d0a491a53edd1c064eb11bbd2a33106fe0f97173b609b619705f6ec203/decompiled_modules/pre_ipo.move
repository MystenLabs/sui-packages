module 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::pre_ipo {
    struct PreIPOVault<phantom T0> has key {
        id: 0x2::object::UID,
        table: 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::KeyedBigVector,
        max_deposit: u64,
        deposited: u64,
        deadline: u64,
        balance: 0x2::balance::Balance<T0>,
    }

    struct Purchase has drop, store {
        owner_address: address,
        deposited: u64,
    }

    struct PurchaseInfo has copy, drop {
        account_id: 0x2::object::ID,
        owner_address: address,
        deposited: u64,
    }

    struct PreIPOVaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        max_deposit: u64,
        deadline: u64,
        timestamp: u64,
    }

    struct PreIPOMaxDepositUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        old_max_deposit: u64,
        new_max_deposit: u64,
        timestamp: u64,
    }

    struct PreIPODeadlineUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        old_deadline: u64,
        new_deadline: u64,
        timestamp: u64,
    }

    struct PreIPOPurchased has copy, drop {
        vault_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        account_id: 0x2::object::ID,
        owner_address: address,
        deposit_amount: u64,
        refund_amount: u64,
        account_deposited: u64,
        total_deposited: u64,
        max_deposit: u64,
        sender: address,
    }

    struct PreIPOWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient_address: address,
    }

    public fun withdraw_all<T0>(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut PreIPOVault<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1.balance);
        if (v0 == 0) {
            return
        };
        let v1 = PreIPOWithdrawn{
            vault_id          : 0x2::object::id<PreIPOVault<T0>>(arg1),
            token_type        : 0x1::type_name::with_defining_ids<T0>(),
            amount            : v0,
            recipient_address : arg2,
        };
        0x2::event::emit<PreIPOWithdrawn>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.balance), arg3), arg2);
    }

    public fun create_vault<T0>(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = PreIPOVault<T0>{
            id          : 0x2::object::new(arg4),
            table       : 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::new<0x2::object::ID, Purchase>(256, arg4),
            max_deposit : arg1,
            deposited   : 0,
            deadline    : arg2,
            balance     : 0x2::balance::zero<T0>(),
        };
        let v1 = PreIPOVaultCreated{
            vault_id    : 0x2::object::id<PreIPOVault<T0>>(&v0),
            token_type  : 0x1::type_name::with_defining_ids<T0>(),
            max_deposit : arg1,
            deadline    : arg2,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PreIPOVaultCreated>(v1);
        0x2::transfer::share_object<PreIPOVault<T0>>(v0);
    }

    public fun purchase<T0>(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::global_config::GlobalConfig, arg1: &mut PreIPOVault<T0>, arg2: &mut 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::user_account::AccountRegistry, arg3: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg4: address, arg5: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::global_config::assert_version(arg0);
        if (0x2::clock::timestamp_ms(arg7) > arg1.deadline) {
            abort 13906835462833569793
        };
        if (arg6 == 0) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_insufficient_balance();
        };
        let v0 = 0x2::object::id_from_address(arg4);
        let v1 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg3);
        let v2 = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::user_account::get_account_owner(arg2, v0);
        if (v1 != v2) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_not_account_owner();
        };
        let (v3, v4) = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::user_account::receive_and_merge_internal<T0>(arg2, v0, arg5, arg8);
        let v5 = v3;
        if (0x2::coin::value<T0>(&v5) < arg6) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_insufficient_balance();
        };
        let v6 = 0x1::u64::min(arg6, arg1.max_deposit - arg1.deposited);
        if (v6 == 0) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_exceed_capacity();
        };
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v6, arg8)));
        arg1.deposited = arg1.deposited + v6;
        let v7 = 0x2::coin::value<T0>(&v5);
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v4);
        } else {
            0x2::coin::destroy_zero<T0>(v5);
        };
        let v8 = if (0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<0x2::object::ID>(&arg1.table, v0)) {
            let v9 = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow_by_key_mut<0x2::object::ID, Purchase>(&mut arg1.table, v0);
            v9.deposited = v9.deposited + v6;
            v9.deposited
        } else {
            let v10 = Purchase{
                owner_address : v2,
                deposited     : v6,
            };
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::push_back<0x2::object::ID, Purchase>(&mut arg1.table, v0, v10);
            v6
        };
        let v11 = PreIPOPurchased{
            vault_id          : 0x2::object::id<PreIPOVault<T0>>(arg1),
            token_type        : 0x1::type_name::with_defining_ids<T0>(),
            account_id        : v0,
            owner_address     : v2,
            deposit_amount    : v6,
            refund_amount     : v7,
            account_deposited : v8,
            total_deposited   : arg1.deposited,
            max_deposit       : arg1.max_deposit,
            sender            : v1,
        };
        0x2::event::emit<PreIPOPurchased>(v11);
    }

    public fun purchase_deposited(arg0: &Purchase) : u64 {
        arg0.deposited
    }

    public fun purchase_info_account_id(arg0: &PurchaseInfo) : 0x2::object::ID {
        arg0.account_id
    }

    public fun purchase_info_deposited(arg0: &PurchaseInfo) : u64 {
        arg0.deposited
    }

    public fun purchase_info_owner_address(arg0: &PurchaseInfo) : address {
        arg0.owner_address
    }

    public fun purchase_owner_address(arg0: &Purchase) : address {
        arg0.owner_address
    }

    public fun set_deadline<T0>(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut PreIPOVault<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        arg1.deadline = arg2;
        let v0 = PreIPODeadlineUpdated{
            vault_id     : 0x2::object::id<PreIPOVault<T0>>(arg1),
            token_type   : 0x1::type_name::with_defining_ids<T0>(),
            old_deadline : arg1.deadline,
            new_deadline : arg2,
            timestamp    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PreIPODeadlineUpdated>(v0);
    }

    public fun set_max_deposit<T0>(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut PreIPOVault<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        if (arg2 < arg1.deposited) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_invalid_config();
        };
        arg1.max_deposit = arg2;
        let v0 = PreIPOMaxDepositUpdated{
            vault_id        : 0x2::object::id<PreIPOVault<T0>>(arg1),
            token_type      : 0x1::type_name::with_defining_ids<T0>(),
            old_max_deposit : arg1.max_deposit,
            new_max_deposit : arg2,
            timestamp       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PreIPOMaxDepositUpdated>(v0);
    }

    public fun vault_balance_value<T0>(arg0: &PreIPOVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun vault_borrow_purchase<T0>(arg0: &PreIPOVault<T0>, arg1: 0x2::object::ID) : &Purchase {
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow_by_key<0x2::object::ID, Purchase>(&arg0.table, arg1)
    }

    public fun vault_deadline<T0>(arg0: &PreIPOVault<T0>) : u64 {
        arg0.deadline
    }

    public fun vault_deposited<T0>(arg0: &PreIPOVault<T0>) : u64 {
        arg0.deposited
    }

    public fun vault_has_purchase<T0>(arg0: &PreIPOVault<T0>, arg1: 0x2::object::ID) : bool {
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<0x2::object::ID>(&arg0.table, arg1)
    }

    public fun vault_max_deposit<T0>(arg0: &PreIPOVault<T0>) : u64 {
        arg0.max_deposit
    }

    public fun vault_purchases_length<T0>(arg0: &PreIPOVault<T0>) : u64 {
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::length(&arg0.table)
    }

    public fun vault_purchases_page<T0>(arg0: &PreIPOVault<T0>, arg1: u64, arg2: u64) : vector<PurchaseInfo> {
        let v0 = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::length(&arg0.table);
        if (arg1 >= v0) {
            return 0x1::vector::empty<PurchaseInfo>()
        };
        let v1 = 0x1::vector::empty<PurchaseInfo>();
        let v2 = 0;
        while (v2 < 0x1::u64::min(v0 - arg1, arg2)) {
            let (v3, v4) = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow<0x2::object::ID, Purchase>(&arg0.table, arg1 + v2);
            let v5 = PurchaseInfo{
                account_id    : v3,
                owner_address : v4.owner_address,
                deposited     : v4.deposited,
            };
            0x1::vector::push_back<PurchaseInfo>(&mut v1, v5);
            v2 = v2 + 1;
        };
        v1
    }

    public fun withdraw<T0>(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut PreIPOVault<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0 || arg2 > 0x2::balance::value<T0>(&arg1.balance)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_insufficient_balance();
        };
        let v0 = PreIPOWithdrawn{
            vault_id          : 0x2::object::id<PreIPOVault<T0>>(arg1),
            token_type        : 0x1::type_name::with_defining_ids<T0>(),
            amount            : arg2,
            recipient_address : arg3,
        };
        0x2::event::emit<PreIPOWithdrawn>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg4), arg3);
    }

    // decompiled from Move bytecode v7
}

