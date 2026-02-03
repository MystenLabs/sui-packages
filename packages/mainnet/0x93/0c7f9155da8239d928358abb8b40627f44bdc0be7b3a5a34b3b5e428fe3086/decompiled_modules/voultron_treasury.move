module 0x930c7f9155da8239d928358abb8b40627f44bdc0be7b3a5a34b3b5e428fe3086::voultron_treasury {
    struct VOULTRON_TREASURY has drop {
        dummy_field: bool,
    }

    struct Treasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct TreasuryWhitelistedModules has store, key {
        id: 0x2::object::UID,
        modules: vector<0x1::string::String>,
    }

    struct TreasuryCreatedEvent has copy, drop {
        treasury_id: 0x2::object::ID,
        created_at: u64,
    }

    struct TreasuryDepositEvent has copy, drop {
        treasury_id: 0x2::object::ID,
        amount: u64,
        new_balance: u64,
        timestamp: u64,
    }

    struct TreasuryWithdrawEvent has copy, drop {
        treasury_id: 0x2::object::ID,
        amount: u64,
        remaining_balance: u64,
        timestamp: u64,
    }

    struct TreasuryDeletedEvent has copy, drop {
        treasury_id: 0x2::object::ID,
        timestamp: u64,
    }

    public fun add_to_treasury<T0: drop, T1>(arg0: &mut Treasury<T1>, arg1: &TreasuryWhitelistedModules, arg2: T0, arg3: 0x2::coin::Coin<T1>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::string::from_ascii(0x1::type_name::address_string(&v0));
        assert!(0x1::vector::contains<0x1::string::String>(&arg1.modules, &v1), 1);
        assert!(0x2::coin::value<T1>(&arg3) > 0, 0);
        0x2::balance::join<T1>(&mut arg0.balance, 0x2::coin::into_balance<T1>(arg3));
    }

    public fun admin_create_treasury<T0>(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg2);
        let v0 = Treasury<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::zero<T0>(),
        };
        let v1 = TreasuryCreatedEvent{
            treasury_id : *0x2::object::uid_as_inner(&v0.id),
            created_at  : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<TreasuryCreatedEvent>(v1);
        0x2::transfer::public_share_object<Treasury<T0>>(v0);
    }

    public fun admin_delete_treasury<T0>(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: Treasury<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg3);
        assert!(0x2::balance::value<T0>(&arg1.balance) == 0, 7);
        let Treasury {
            id      : v0,
            balance : v1,
        } = arg1;
        let v2 = v0;
        0x2::balance::destroy_zero<T0>(v1);
        let v3 = TreasuryDeletedEvent{
            treasury_id : *0x2::object::uid_as_inner(&v2),
            timestamp   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TreasuryDeletedEvent>(v3);
        0x2::object::delete(v2);
    }

    public fun admin_whitelist_modules(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut TreasuryWhitelistedModules, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg3);
        0x1::vector::push_back<0x1::string::String>(&mut arg1.modules, arg2);
    }

    public fun get_treasury_balance<T0>(arg0: &Treasury<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_treasury_id<T0>(arg0: &Treasury<T0>) : 0x2::object::ID {
        *0x2::object::uid_as_inner(&arg0.id)
    }

    public fun get_whitelisted_modules(arg0: &TreasuryWhitelistedModules) : &vector<0x1::string::String> {
        &arg0.modules
    }

    fun init(arg0: VOULTRON_TREASURY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TreasuryWhitelistedModules{
            id      : 0x2::object::new(arg1),
            modules : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::transfer::public_share_object<TreasuryWhitelistedModules>(v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<VOULTRON_TREASURY>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun remove_from_treasury<T0: drop, T1>(arg0: &mut Treasury<T1>, arg1: &TreasuryWhitelistedModules, arg2: T0, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::string::from_ascii(0x1::type_name::address_string(&v0));
        assert!(0x1::vector::contains<0x1::string::String>(&arg1.modules, &v1), 1);
        assert!(0x2::balance::value<T1>(&arg0.balance) >= arg3, 6);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance, arg3), arg4)
    }

    public fun super_admin_create_treasury<T0>(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::SuperAdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::zero<T0>(),
        };
        let v1 = TreasuryCreatedEvent{
            treasury_id : *0x2::object::uid_as_inner(&v0.id),
            created_at  : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<TreasuryCreatedEvent>(v1);
        0x2::transfer::public_share_object<Treasury<T0>>(v0);
    }

    public fun super_admin_delete_treasury<T0>(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::SuperAdminCap, arg1: Treasury<T0>, arg2: &0x2::clock::Clock) {
        assert!(0x2::balance::value<T0>(&arg1.balance) == 0, 7);
        let Treasury {
            id      : v0,
            balance : v1,
        } = arg1;
        let v2 = v0;
        0x2::balance::destroy_zero<T0>(v1);
        let v3 = TreasuryDeletedEvent{
            treasury_id : *0x2::object::uid_as_inner(&v2),
            timestamp   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TreasuryDeletedEvent>(v3);
        0x2::object::delete(v2);
    }

    public fun super_admin_deposit_to_treasury<T0>(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::SuperAdminCap, arg1: &mut Treasury<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) {
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg2));
        let v0 = TreasuryDepositEvent{
            treasury_id : *0x2::object::uid_as_inner(&arg1.id),
            amount      : 0x2::coin::value<T0>(&arg2),
            new_balance : 0x2::balance::value<T0>(&arg1.balance),
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TreasuryDepositEvent>(v0);
    }

    public fun super_admin_whitelist_modules(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::SuperAdminCap, arg1: &mut TreasuryWhitelistedModules, arg2: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg1.modules, arg2);
    }

    public fun super_admin_withdraw_from_treasury<T0>(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::SuperAdminCap, arg1: &mut Treasury<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg2, 6);
        let v0 = TreasuryWithdrawEvent{
            treasury_id       : *0x2::object::uid_as_inner(&arg1.id),
            amount            : arg2,
            remaining_balance : 0x2::balance::value<T0>(&arg1.balance),
            timestamp         : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TreasuryWithdrawEvent>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg4)
    }

    // decompiled from Move bytecode v6
}

