module 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::insurance_fund {
    struct InsuranceFund has key {
        id: 0x2::object::UID,
        u64_padding: vector<u64>,
    }

    struct VaultKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Vault<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        waterline_target: u64,
        uncovered_total: u64,
        pending_sweep: PendingSweep,
        u64_padding: vector<u64>,
    }

    struct PendingSweep has copy, drop, store {
        amount: u64,
        recipient: address,
        claimable_after_ms: u64,
        requested_by: 0x2::object::ID,
    }

    struct InsuranceFundCreated has copy, drop {
        fund_id: 0x2::object::ID,
    }

    struct VaultInitialized has copy, drop {
        fund_id: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
        waterline_target: u64,
    }

    struct WaterlineUpdated has copy, drop {
        fund_id: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
        waterline_target: u64,
    }

    struct ToppedUp has copy, drop {
        fund_id: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
        amount: u64,
        balance: u64,
    }

    struct Absorbed has copy, drop {
        fund_id: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
        requested: u64,
        paid: u64,
        balance: u64,
    }

    struct ShortfallUncovered has copy, drop {
        fund_id: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
        amount: u64,
        uncovered_total: u64,
        tallied: bool,
    }

    struct SweepRequested has copy, drop {
        fund_id: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
        claimable_after_ms: u64,
    }

    struct SweepCancelled has copy, drop {
        fund_id: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
        by_revocation: bool,
    }

    struct SweepClaimed has copy, drop {
        fund_id: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    struct BucketSettledEvent has copy, drop {
        token: 0x1::type_name::TypeName,
        bucket: u8,
        amount: u64,
        destination_id: 0x2::object::ID,
    }

    public(friend) fun absorb<T0>(arg0: &mut InsuranceFund, arg1: u64) : 0x2::balance::Balance<T0> {
        if (arg1 == 0 || !has_vault<T0>(arg0)) {
            return 0x2::balance::zero<T0>()
        };
        let v0 = 0x2::object::id<InsuranceFund>(arg0);
        let v1 = borrow_vault_mut<T0>(arg0);
        let v2 = 0x1::u64::min(arg1, 0x2::balance::value<T0>(&v1.balance));
        let v3 = Absorbed{
            fund_id   : v0,
            token     : 0x1::type_name::with_defining_ids<T0>(),
            requested : arg1,
            paid      : v2,
            balance   : 0x2::balance::value<T0>(&v1.balance),
        };
        0x2::event::emit<Absorbed>(v3);
        0x2::balance::split<T0>(&mut v1.balance, v2)
    }

    public fun balance_value<T0>(arg0: &InsuranceFund) : u64 {
        0x2::balance::value<T0>(&borrow_vault<T0>(arg0).balance)
    }

    fun borrow_vault<T0>(arg0: &InsuranceFund) : &Vault<T0> {
        assert!(has_vault<T0>(arg0), 1701);
        let v0 = VaultKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<VaultKey<T0>, Vault<T0>>(&arg0.id, v0)
    }

    fun borrow_vault_mut<T0>(arg0: &mut InsuranceFund) : &mut Vault<T0> {
        assert!(has_vault<T0>(arg0), 1701);
        let v0 = VaultKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<VaultKey<T0>, Vault<T0>>(&mut arg0.id, v0)
    }

    public fun cancel_sweep<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::AdminCap, arg2: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::cap_revocation::CapRevocationRegistry, arg3: &mut InsuranceFund) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::assert_admin_cap(arg0, arg1, arg2);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
        let v0 = 0x2::object::id<InsuranceFund>(arg3);
        let v1 = borrow_vault_mut<T0>(arg3);
        assert!(v1.pending_sweep.amount > 0, 1704);
        let PendingSweep {
            amount             : v2,
            recipient          : v3,
            claimable_after_ms : _,
            requested_by       : _,
        } = v1.pending_sweep;
        v1.pending_sweep = no_pending_sweep();
        let v6 = SweepCancelled{
            fund_id       : v0,
            token         : 0x1::type_name::with_defining_ids<T0>(),
            amount        : v2,
            recipient     : v3,
            by_revocation : false,
        };
        0x2::event::emit<SweepCancelled>(v6);
    }

    public fun claim_sweep<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::cap_revocation::CapRevocationRegistry, arg2: &mut InsuranceFund, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
        let v0 = 0x2::object::id<InsuranceFund>(arg2);
        let v1 = borrow_vault_mut<T0>(arg2);
        assert!(v1.pending_sweep.amount > 0, 1704);
        let PendingSweep {
            amount             : v2,
            recipient          : v3,
            claimable_after_ms : v4,
            requested_by       : v5,
        } = v1.pending_sweep;
        if (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::cap_revocation::is_revoked(arg1, v5)) {
            v1.pending_sweep = no_pending_sweep();
            let v6 = SweepCancelled{
                fund_id       : v0,
                token         : 0x1::type_name::with_defining_ids<T0>(),
                amount        : v2,
                recipient     : v3,
                by_revocation : true,
            };
            0x2::event::emit<SweepCancelled>(v6);
            return
        };
        assert!(0x2::clock::timestamp_ms(arg3) >= v4, 1705);
        let v7 = 0x1::u64::min(v2, sweepable<T0>(v1));
        v1.pending_sweep = no_pending_sweep();
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1.balance, v7), arg4), v3);
        let v8 = SweepClaimed{
            fund_id   : v0,
            token     : 0x1::type_name::with_defining_ids<T0>(),
            amount    : v7,
            recipient : v3,
        };
        0x2::event::emit<SweepClaimed>(v8);
    }

    public fun has_vault<T0>(arg0: &InsuranceFund) : bool {
        let v0 = VaultKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<VaultKey<T0>>(&arg0.id, v0)
    }

    public fun init_vault<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::AdminCap, arg2: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::cap_revocation::CapRevocationRegistry, arg3: &mut InsuranceFund, arg4: u64) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::assert_admin_cap(arg0, arg1, arg2);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
        assert!(!has_vault<T0>(arg3), 1700);
        let v0 = VaultKey<T0>{dummy_field: false};
        let v1 = Vault<T0>{
            balance          : 0x2::balance::zero<T0>(),
            waterline_target : arg4,
            uncovered_total  : 0,
            pending_sweep    : no_pending_sweep(),
            u64_padding      : vector[],
        };
        0x2::dynamic_field::add<VaultKey<T0>, Vault<T0>>(&mut arg3.id, v0, v1);
        let v2 = VaultInitialized{
            fund_id          : 0x2::object::id<InsuranceFund>(arg3),
            token            : 0x1::type_name::with_defining_ids<T0>(),
            waterline_target : arg4,
        };
        0x2::event::emit<VaultInitialized>(v2);
    }

    public fun new_fund(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::AdminCap, arg2: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::cap_revocation::CapRevocationRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::assert_admin_cap(arg0, arg1, arg2);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
        let v0 = InsuranceFund{
            id          : 0x2::object::new(arg3),
            u64_padding : vector[],
        };
        let v1 = InsuranceFundCreated{fund_id: 0x2::object::id<InsuranceFund>(&v0)};
        0x2::event::emit<InsuranceFundCreated>(v1);
        0x2::transfer::share_object<InsuranceFund>(v0);
    }

    fun no_pending_sweep() : PendingSweep {
        PendingSweep{
            amount             : 0,
            recipient          : @0x0,
            claimable_after_ms : 0,
            requested_by       : 0x2::object::id_from_address(@0x0),
        }
    }

    public fun pending_sweep_amount<T0>(arg0: &InsuranceFund) : u64 {
        borrow_vault<T0>(arg0).pending_sweep.amount
    }

    public fun pending_sweep_claimable_after_ms<T0>(arg0: &InsuranceFund) : u64 {
        borrow_vault<T0>(arg0).pending_sweep.claimable_after_ms
    }

    public(friend) fun record_uncovered<T0>(arg0: &mut InsuranceFund, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        let v0 = 0x2::object::id<InsuranceFund>(arg0);
        if (!has_vault<T0>(arg0)) {
            let v1 = ShortfallUncovered{
                fund_id         : v0,
                token           : 0x1::type_name::with_defining_ids<T0>(),
                amount          : arg1,
                uncovered_total : 0,
                tallied         : false,
            };
            0x2::event::emit<ShortfallUncovered>(v1);
            return
        };
        let v2 = borrow_vault_mut<T0>(arg0);
        let v3 = if (v2.uncovered_total > 18446744073709551615 - arg1) {
            18446744073709551615
        } else {
            v2.uncovered_total + arg1
        };
        v2.uncovered_total = v3;
        let v4 = ShortfallUncovered{
            fund_id         : v0,
            token           : 0x1::type_name::with_defining_ids<T0>(),
            amount          : arg1,
            uncovered_total : v2.uncovered_total,
            tallied         : true,
        };
        0x2::event::emit<ShortfallUncovered>(v4);
    }

    public fun request_sweep<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::AdminCap, arg2: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::cap_revocation::CapRevocationRegistry, arg3: &mut InsuranceFund, arg4: u64, arg5: address, arg6: &0x2::clock::Clock) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::assert_admin_cap(arg0, arg1, arg2);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
        assert!(arg4 > 0, 1702);
        let v0 = 0x2::object::id<InsuranceFund>(arg3);
        let v1 = borrow_vault_mut<T0>(arg3);
        assert!(v1.pending_sweep.amount == 0, 1703);
        assert!(arg4 <= sweepable<T0>(v1), 1702);
        let v2 = 0x2::clock::timestamp_ms(arg6) + 86400000;
        let v3 = PendingSweep{
            amount             : arg4,
            recipient          : arg5,
            claimable_after_ms : v2,
            requested_by       : 0x2::object::id<0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::AdminCap>(arg1),
        };
        v1.pending_sweep = v3;
        let v4 = SweepRequested{
            fund_id            : v0,
            token              : 0x1::type_name::with_defining_ids<T0>(),
            amount             : arg4,
            recipient          : arg5,
            claimable_after_ms : v2,
        };
        0x2::event::emit<SweepRequested>(v4);
    }

    public fun set_waterline<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::AdminCap, arg2: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::cap_revocation::CapRevocationRegistry, arg3: &mut InsuranceFund, arg4: u64) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::assert_admin_cap(arg0, arg1, arg2);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
        let v0 = 0x2::object::id<InsuranceFund>(arg3);
        borrow_vault_mut<T0>(arg3).waterline_target = arg4;
        let v1 = WaterlineUpdated{
            fund_id          : v0,
            token            : 0x1::type_name::with_defining_ids<T0>(),
            waterline_target : arg4,
        };
        0x2::event::emit<WaterlineUpdated>(v1);
    }

    public fun settle_insurance<T0>(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut InsuranceFund, arg2: &mut 0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::assert_insurance_fund_destination(arg0, 0x2::object::id<InsuranceFund>(arg1));
        settle_into_fund<T0>(arg0, arg1, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::bucket_insurance(), 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::take_fee_bucket<T0>(arg0, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::bucket_insurance()), arg2);
    }

    fun settle_into_fund<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut InsuranceFund, arg2: u8, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg3);
        assert!(v0 > 0, 2401);
        top_up<T0>(arg0, arg1, 0x2::coin::from_balance<T0>(arg3, arg4));
        let v1 = BucketSettledEvent{
            token          : 0x1::type_name::with_defining_ids<T0>(),
            bucket         : arg2,
            amount         : v0,
            destination_id : 0x2::object::id<InsuranceFund>(arg1),
        };
        0x2::event::emit<BucketSettledEvent>(v1);
    }

    public fun settle_liquidator_fees<T0>(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut InsuranceFund, arg2: &mut 0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::assert_insurance_fund_destination(arg0, 0x2::object::id<InsuranceFund>(arg1));
        settle_into_fund<T0>(arg0, arg1, 255, 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::take_liquidator_fee_pool<T0>(arg0), arg2);
    }

    fun sweepable<T0>(arg0: &Vault<T0>) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        if (v0 > arg0.waterline_target) {
            v0 - arg0.waterline_target
        } else {
            0
        }
    }

    public fun top_up<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut InsuranceFund, arg2: 0x2::coin::Coin<T0>) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
        let v0 = 0x2::object::id<InsuranceFund>(arg1);
        let v1 = borrow_vault_mut<T0>(arg1);
        0x2::balance::join<T0>(&mut v1.balance, 0x2::coin::into_balance<T0>(arg2));
        let v2 = ToppedUp{
            fund_id : v0,
            token   : 0x1::type_name::with_defining_ids<T0>(),
            amount  : 0x2::coin::value<T0>(&arg2),
            balance : 0x2::balance::value<T0>(&v1.balance),
        };
        0x2::event::emit<ToppedUp>(v2);
    }

    public fun uncovered_total<T0>(arg0: &InsuranceFund) : u64 {
        borrow_vault<T0>(arg0).uncovered_total
    }

    public fun waterline_target<T0>(arg0: &InsuranceFund) : u64 {
        borrow_vault<T0>(arg0).waterline_target
    }

    // decompiled from Move bytecode v7
}

