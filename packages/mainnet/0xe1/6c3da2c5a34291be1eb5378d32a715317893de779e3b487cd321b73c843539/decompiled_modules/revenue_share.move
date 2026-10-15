module 0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::revenue_share {
    struct RevenueVault has key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        bucket_cap: 0x1::option::Option<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::FeeBucketCap>,
        u64_padding: vector<u64>,
    }

    struct IndexKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct GlobalIndex<phantom T0> has store {
        cumulative_per_vp: u128,
        vault: 0x2::balance::Balance<T0>,
        carry: u128,
        init_bind_sequence: u64,
    }

    struct AccountKey<phantom T0> has copy, drop, store {
        user: address,
    }

    struct Account has store {
        last_index: u128,
        claimable: u64,
        binding_generation: u64,
        voting_power_checkpoint: u64,
        remainder: u128,
    }

    struct RevenueVaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
    }

    struct RevenueBucketCapInstalled has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct RevenueCoinInitialized has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
    }

    struct RevenueDeposited has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        total_voting_power: u64,
        delta_index: u128,
        cumulative_per_vp: u128,
        refunded: u64,
    }

    struct RevenueAccrued has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        user: address,
        owed: u64,
        claimable: u64,
    }

    struct RevenueClaimed has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        user: address,
        amount: u64,
    }

    public fun accrue<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::Version, arg2: &mut RevenueVault, arg3: &0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::vesca_booster::VeScaBindingRegistry, arg4: &0x2::tx_context::TxContext) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::assert_version(arg0);
        0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::version_check(arg1);
        accrue_internal<T0>(arg2, arg3, 0x2::tx_context::sender(arg4));
    }

    fun accrue_internal<T0>(arg0: &mut RevenueVault, arg1: &0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::vesca_booster::VeScaBindingRegistry, arg2: address) {
        assert_registry(arg0, arg1);
        let v0 = borrow_index<T0>(arg0);
        let v1 = v0.cumulative_per_vp;
        let v2 = 0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::vesca_booster::voting_power_of(arg1, arg2);
        let v3 = 0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::vesca_booster::binding_generation(arg1, arg2);
        let v4 = AccountKey<T0>{user: arg2};
        if (!0x2::dynamic_field::exists_<AccountKey<T0>>(&arg0.id, v4)) {
            let v5 = 0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::vesca_booster::is_bound(arg1, arg2) && 0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::vesca_booster::binding_sequence_of(arg1, arg2) < v0.init_bind_sequence;
            let v6 = AccountKey<T0>{user: arg2};
            let v7 = if (v5) {
                0
            } else {
                v1
            };
            let v8 = Account{
                last_index              : v7,
                claimable               : 0,
                binding_generation      : v3,
                voting_power_checkpoint : v2,
                remainder               : 0,
            };
            0x2::dynamic_field::add<AccountKey<T0>, Account>(&mut arg0.id, v6, v8);
        };
        let v9 = AccountKey<T0>{user: arg2};
        let v10 = 0x2::dynamic_field::borrow_mut<AccountKey<T0>, Account>(&mut arg0.id, v9);
        let v11 = if (v10.binding_generation == v3) {
            0x1::u64::min(v2, v10.voting_power_checkpoint)
        } else {
            0
        };
        let v12 = (v1 - v10.last_index) * (v11 as u128) + v10.remainder;
        let v13 = ((v12 / 1000000000000) as u64);
        v10.remainder = v12 % 1000000000000;
        v10.claimable = v10.claimable + v13;
        v10.last_index = v1;
        v10.binding_generation = v3;
        v10.voting_power_checkpoint = v2;
        let v14 = RevenueAccrued{
            vault_id  : 0x2::object::id<RevenueVault>(arg0),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            user      : arg2,
            owed      : v13,
            claimable : v10.claimable,
        };
        0x2::event::emit<RevenueAccrued>(v14);
    }

    fun assert_registry(arg0: &RevenueVault, arg1: &0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::vesca_booster::VeScaBindingRegistry) {
        assert!(arg0.registry_id == 0x2::object::id<0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::vesca_booster::VeScaBindingRegistry>(arg1), 2302);
    }

    fun borrow_index<T0>(arg0: &RevenueVault) : &GlobalIndex<T0> {
        assert!(is_initialized<T0>(arg0), 2301);
        let v0 = IndexKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<IndexKey<T0>, GlobalIndex<T0>>(&arg0.id, v0)
    }

    fun borrow_index_mut<T0>(arg0: &mut RevenueVault) : &mut GlobalIndex<T0> {
        assert!(is_initialized<T0>(arg0), 2301);
        let v0 = IndexKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<IndexKey<T0>, GlobalIndex<T0>>(&mut arg0.id, v0)
    }

    public(friend) fun bucket_cap(arg0: &RevenueVault) : &0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::FeeBucketCap {
        assert!(0x1::option::is_some<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::FeeBucketCap>(&arg0.bucket_cap), 2305);
        0x1::option::borrow<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::FeeBucketCap>(&arg0.bucket_cap)
    }

    public fun carry<T0>(arg0: &RevenueVault) : u128 {
        borrow_index<T0>(arg0).carry
    }

    public fun checkpoint_with_ticket<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::Version, arg2: &mut RevenueVault, arg3: &0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::vesca_booster::VeScaBindingRegistry, arg4: &mut 0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::vesca_booster::VpUpdateTicket) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::assert_version(arg0);
        0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::version_check(arg1);
        assert_registry(arg2, arg3);
        0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::vesca_booster::ticket_mark_settled(arg4, 0x2::object::id<0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::vesca_booster::VeScaBindingRegistry>(arg3), 0x1::type_name::with_defining_ids<T0>());
        accrue_internal<T0>(arg2, arg3, 0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::vesca_booster::ticket_user(arg4));
    }

    public fun claim<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::Version, arg2: &mut RevenueVault, arg3: &0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::vesca_booster::VeScaBindingRegistry, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::assert_version(arg0);
        0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::version_check(arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        accrue_internal<T0>(arg2, arg3, v0);
        let v1 = 0x2::object::id<RevenueVault>(arg2);
        let v2 = AccountKey<T0>{user: v0};
        let v3 = 0x2::dynamic_field::borrow_mut<AccountKey<T0>, Account>(&mut arg2.id, v2);
        let v4 = v3.claimable;
        assert!(v4 > 0, 2303);
        v3.claimable = 0;
        let v5 = RevenueClaimed{
            vault_id  : v1,
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            user      : v0,
            amount    : v4,
        };
        0x2::event::emit<RevenueClaimed>(v5);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut borrow_index_mut<T0>(arg2).vault, v4), arg4)
    }

    public fun claimable_of<T0>(arg0: &RevenueVault, arg1: address) : u64 {
        let v0 = AccountKey<T0>{user: arg1};
        if (!0x2::dynamic_field::exists_<AccountKey<T0>>(&arg0.id, v0)) {
            return 0
        };
        let v1 = AccountKey<T0>{user: arg1};
        0x2::dynamic_field::borrow<AccountKey<T0>, Account>(&arg0.id, v1).claimable
    }

    public fun cumulative_per_vp<T0>(arg0: &RevenueVault) : u128 {
        borrow_index<T0>(arg0).cumulative_per_vp
    }

    public(friend) fun deposit<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::Version, arg2: &mut RevenueVault, arg3: &0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::vesca_booster::VeScaBindingRegistry, arg4: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::assert_version(arg0);
        0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::version_check(arg1);
        assert_registry(arg2, arg3);
        assert!(0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::vesca_booster::open_tickets(arg3) == 0, 2209);
        let v0 = 0x2::object::id<RevenueVault>(arg2);
        let v1 = 0x2::balance::value<T0>(&arg4);
        let v2 = 0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::vesca_booster::total_voting_power(arg3);
        let v3 = borrow_index_mut<T0>(arg2);
        if (v1 == 0 || v2 == 0) {
            let v4 = RevenueDeposited{
                vault_id           : v0,
                coin_type          : 0x1::type_name::with_defining_ids<T0>(),
                amount             : v1,
                total_voting_power : v2,
                delta_index        : 0,
                cumulative_per_vp  : v3.cumulative_per_vp,
                refunded           : v1,
            };
            0x2::event::emit<RevenueDeposited>(v4);
            return arg4
        };
        0x2::balance::join<T0>(&mut v3.vault, arg4);
        let v5 = (v1 as u128) * 1000000000000 + v3.carry;
        let v6 = v5 / (v2 as u128);
        v3.carry = v5 % (v2 as u128);
        v3.cumulative_per_vp = v3.cumulative_per_vp + v6;
        let v7 = RevenueDeposited{
            vault_id           : v0,
            coin_type          : 0x1::type_name::with_defining_ids<T0>(),
            amount             : v1,
            total_voting_power : v2,
            delta_index        : v6,
            cumulative_per_vp  : v3.cumulative_per_vp,
            refunded           : 0,
        };
        0x2::event::emit<RevenueDeposited>(v7);
        0x2::balance::zero<T0>()
    }

    public fun deposit_revenue<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::Version, arg2: &mut RevenueVault, arg3: &0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::vesca_booster::VeScaBindingRegistry, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(deposit<T0>(arg0, arg1, arg2, arg3, 0x2::coin::into_balance<T0>(arg4)), arg5)
    }

    public fun has_bucket_cap(arg0: &RevenueVault) : bool {
        0x1::option::is_some<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::FeeBucketCap>(&arg0.bucket_cap)
    }

    public fun init_revenue_coin<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::Version, arg2: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::AdminCap, arg3: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::cap_revocation::CapRevocationRegistry, arg4: &mut RevenueVault, arg5: &mut 0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::vesca_booster::VeScaBindingRegistry) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::assert_admin_cap(arg0, arg2, arg3);
        0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::version_check(arg1);
        assert!(arg4.registry_id == 0x2::object::id<0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::vesca_booster::VeScaBindingRegistry>(arg5), 2302);
        assert!(!is_initialized<T0>(arg4), 2300);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::vesca_booster::register_revenue_coin(arg5, v0);
        let v1 = IndexKey<T0>{dummy_field: false};
        let v2 = GlobalIndex<T0>{
            cumulative_per_vp  : 0,
            vault              : 0x2::balance::zero<T0>(),
            carry              : 0,
            init_bind_sequence : 0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::vesca_booster::next_bind_sequence(arg5),
        };
        0x2::dynamic_field::add<IndexKey<T0>, GlobalIndex<T0>>(&mut arg4.id, v1, v2);
        let v3 = RevenueCoinInitialized{
            vault_id  : 0x2::object::id<RevenueVault>(arg4),
            coin_type : v0,
        };
        0x2::event::emit<RevenueCoinInitialized>(v3);
    }

    public fun install_bucket_cap(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::Version, arg2: &mut RevenueVault, arg3: 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::FeeBucketCap, arg4: &0x2::tx_context::TxContext) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::assert_authority(arg0, arg4);
        0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::version_check(arg1);
        assert!(0x1::option::is_none<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::FeeBucketCap>(&arg2.bucket_cap), 2304);
        0x1::option::fill<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::FeeBucketCap>(&mut arg2.bucket_cap, arg3);
        let v0 = RevenueBucketCapInstalled{vault_id: 0x2::object::id<RevenueVault>(arg2)};
        0x2::event::emit<RevenueBucketCapInstalled>(v0);
    }

    public fun is_initialized<T0>(arg0: &RevenueVault) : bool {
        let v0 = IndexKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<IndexKey<T0>>(&arg0.id, v0)
    }

    public fun new_vault(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::Version, arg2: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::AdminCap, arg3: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::cap_revocation::CapRevocationRegistry, arg4: &0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::vesca_booster::VeScaBindingRegistry, arg5: &mut 0x2::tx_context::TxContext) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::assert_admin_cap(arg0, arg2, arg3);
        0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::version_check(arg1);
        let v0 = RevenueVault{
            id          : 0x2::object::new(arg5),
            registry_id : 0x2::object::id<0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::vesca_booster::VeScaBindingRegistry>(arg4),
            bucket_cap  : 0x1::option::none<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::FeeBucketCap>(),
            u64_padding : vector[],
        };
        let v1 = RevenueVaultCreated{
            vault_id    : 0x2::object::id<RevenueVault>(&v0),
            registry_id : 0x2::object::id<0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::vesca_booster::VeScaBindingRegistry>(arg4),
        };
        0x2::event::emit<RevenueVaultCreated>(v1);
        0x2::transfer::share_object<RevenueVault>(v0);
    }

    public fun registry_id(arg0: &RevenueVault) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun vault_balance<T0>(arg0: &RevenueVault) : u64 {
        0x2::balance::value<T0>(&borrow_index<T0>(arg0).vault)
    }

    // decompiled from Move bytecode v7
}

