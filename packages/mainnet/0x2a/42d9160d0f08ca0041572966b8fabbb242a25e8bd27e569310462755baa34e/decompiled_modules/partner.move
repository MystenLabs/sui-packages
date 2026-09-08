module 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::partner {
    struct Partner has key {
        id: 0x2::object::UID,
        version: u64,
        name: 0x1::string::String,
        ref_fee_bps: u16,
        balances: 0x2::bag::Bag,
        is_active: bool,
        current_cap_id: 0x2::object::ID,
        current_recovery_cap_id: 0x2::object::ID,
        extra: 0x2::bag::Bag,
    }

    struct PartnerCap has store, key {
        id: 0x2::object::UID,
        partner_id: 0x2::object::ID,
    }

    struct PartnerRecoveryCap has store, key {
        id: 0x2::object::UID,
        partner_id: 0x2::object::ID,
    }

    struct PartnerCreatedEvent has copy, drop {
        partner_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        recovery_cap_id: 0x2::object::ID,
        name: 0x1::string::String,
        ref_fee_bps: u16,
    }

    struct PartnerFeeRateUpdatedEvent has copy, drop {
        partner_id: 0x2::object::ID,
        new_rate: u16,
    }

    struct PartnerClaimedEvent has copy, drop {
        partner_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct PartnerCapRotatedEvent has copy, drop {
        partner_id: 0x2::object::ID,
        old_cap_id: 0x2::object::ID,
        new_cap_id: 0x2::object::ID,
        recovery_cap_id: 0x2::object::ID,
        new_recipient: address,
    }

    struct PartnerRecoveryCapRotatedEvent has copy, drop {
        partner_id: 0x2::object::ID,
        old_recovery_cap_id: 0x2::object::ID,
        new_recovery_cap_id: 0x2::object::ID,
        new_recipient: address,
    }

    struct PartnerActiveChangedEvent has copy, drop {
        partner_id: 0x2::object::ID,
        is_active: bool,
    }

    struct PartnerMigratedEvent has copy, drop {
        partner_id: 0x2::object::ID,
        old_version: u64,
        new_version: u64,
    }

    public(friend) fun accrue<T0>(arg0: &mut Partner, arg1: 0x2::balance::Balance<T0>) {
        assert_version(arg0);
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    fun assert_version(arg0: &Partner) {
        assert!(arg0.version == 1, 703);
    }

    public fun balance_of<T0>(arg0: &Partner) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    public fun claim<T0>(arg0: &PartnerCap, arg1: &mut Partner, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version(arg1);
        assert!(arg0.partner_id == 0x2::object::id<Partner>(arg1), 701);
        assert!(0x2::object::id<PartnerCap>(arg0) == arg1.current_cap_id, 701);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg1.balances, v0)) {
            return 0x2::coin::zero<T0>(arg2)
        };
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0);
        let v2 = PartnerClaimedEvent{
            partner_id : 0x2::object::id<Partner>(arg1),
            coin_type  : v0,
            amount     : 0x2::balance::value<T0>(&v1),
        };
        0x2::event::emit<PartnerClaimedEvent>(v2);
        0x2::coin::from_balance<T0>(v1, arg2)
    }

    entry fun create_partner(arg0: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::AdminCap, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::AdminRegistry, arg2: vector<u8>, arg3: u16, arg4: address, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::assert_registry_version(arg1);
        0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::assert_nonzero_recipient(arg4);
        0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::assert_nonzero_recipient(arg5);
        let (v0, v1, v2, v3, v4) = new_partner_for_create(arg2, arg3, arg6);
        let v5 = v0;
        let v6 = PartnerCreatedEvent{
            partner_id      : 0x2::object::id<Partner>(&v5),
            cap_id          : v3,
            recovery_cap_id : v4,
            name            : v5.name,
            ref_fee_bps     : arg3,
        };
        0x2::event::emit<PartnerCreatedEvent>(v6);
        0x2::transfer::share_object<Partner>(v5);
        0x2::transfer::public_transfer<PartnerRecoveryCap>(v2, arg5);
        0x2::transfer::public_transfer<PartnerCap>(v1, arg4);
    }

    public fun current_cap_id(arg0: &Partner) : 0x2::object::ID {
        arg0.current_cap_id
    }

    public fun current_recovery_cap_id(arg0: &Partner) : 0x2::object::ID {
        arg0.current_recovery_cap_id
    }

    public fun current_version() : u64 {
        1
    }

    public fun effective_ref_fee_bps(arg0: &Partner, arg1: u64) : u16 {
        assert_version(arg0);
        if (is_partner_active_at(arg0, arg1)) {
            arg0.ref_fee_bps
        } else {
            0
        }
    }

    public fun is_active(arg0: &Partner) : bool {
        arg0.is_active
    }

    public fun is_partner_active_at(arg0: &Partner, arg1: u64) : bool {
        arg0.is_active
    }

    public fun max_partner_fee_bps() : u16 {
        2500
    }

    entry fun migrate(arg0: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::AdminRegistry, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::OperatorCap, arg2: &mut Partner) {
        0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::assert_operator_cap(arg0, arg1);
        assert!(arg2.version < 1, 703);
        arg2.version = 1;
        let v0 = PartnerMigratedEvent{
            partner_id  : 0x2::object::id<Partner>(arg2),
            old_version : arg2.version,
            new_version : 1,
        };
        0x2::event::emit<PartnerMigratedEvent>(v0);
    }

    fun new_partner_for_create(arg0: vector<u8>, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) : (Partner, PartnerCap, PartnerRecoveryCap, 0x2::object::ID, 0x2::object::ID) {
        assert!(arg1 <= 2500, 700);
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::object::new(arg2);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = Partner{
            id                      : 0x2::object::new(arg2),
            version                 : 1,
            name                    : 0x1::string::utf8(arg0),
            ref_fee_bps             : arg1,
            balances                : 0x2::bag::new(arg2),
            is_active               : true,
            current_cap_id          : v1,
            current_recovery_cap_id : v3,
            extra                   : 0x2::bag::new(arg2),
        };
        let v5 = 0x2::object::id<Partner>(&v4);
        let v6 = PartnerCap{
            id         : v0,
            partner_id : v5,
        };
        let v7 = PartnerRecoveryCap{
            id         : v2,
            partner_id : v5,
        };
        (v4, v6, v7, v1, v3)
    }

    public fun partner_id_of_cap(arg0: &PartnerCap) : 0x2::object::ID {
        arg0.partner_id
    }

    public fun partner_id_of_recovery_cap(arg0: &PartnerRecoveryCap) : 0x2::object::ID {
        arg0.partner_id
    }

    public fun partner_name(arg0: &Partner) : &0x1::string::String {
        &arg0.name
    }

    public fun ref_fee_bps(arg0: &Partner) : u16 {
        arg0.ref_fee_bps
    }

    entry fun rotate_partner_cap(arg0: &PartnerRecoveryCap, arg1: &mut Partner, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::assert_nonzero_recipient(arg2);
        assert!(arg0.partner_id == 0x2::object::id<Partner>(arg1), 704);
        assert!(0x2::object::id<PartnerRecoveryCap>(arg0) == arg1.current_recovery_cap_id, 704);
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::object::id<Partner>(arg1);
        let v3 = PartnerCap{
            id         : v0,
            partner_id : v2,
        };
        arg1.current_cap_id = v1;
        let v4 = PartnerCapRotatedEvent{
            partner_id      : v2,
            old_cap_id      : arg1.current_cap_id,
            new_cap_id      : v1,
            recovery_cap_id : 0x2::object::id<PartnerRecoveryCap>(arg0),
            new_recipient   : arg2,
        };
        0x2::event::emit<PartnerCapRotatedEvent>(v4);
        0x2::transfer::public_transfer<PartnerCap>(v3, arg2);
    }

    entry fun rotate_partner_recovery_cap(arg0: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::AdminCap, arg1: &mut Partner, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::assert_nonzero_recipient(arg2);
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::object::id<Partner>(arg1);
        let v3 = PartnerRecoveryCap{
            id         : v0,
            partner_id : v2,
        };
        arg1.current_recovery_cap_id = v1;
        let v4 = PartnerRecoveryCapRotatedEvent{
            partner_id          : v2,
            old_recovery_cap_id : arg1.current_recovery_cap_id,
            new_recovery_cap_id : v1,
            new_recipient       : arg2,
        };
        0x2::event::emit<PartnerRecoveryCapRotatedEvent>(v4);
        0x2::transfer::public_transfer<PartnerRecoveryCap>(v3, arg2);
    }

    entry fun set_partner_active(arg0: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::AdminCap, arg1: &mut Partner, arg2: bool) {
        assert_version(arg1);
        arg1.is_active = arg2;
        let v0 = PartnerActiveChangedEvent{
            partner_id : 0x2::object::id<Partner>(arg1),
            is_active  : arg2,
        };
        0x2::event::emit<PartnerActiveChangedEvent>(v0);
    }

    entry fun set_ref_fee_bps(arg0: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::AdminCap, arg1: &mut Partner, arg2: u16) {
        assert_version(arg1);
        assert!(arg2 <= 2500, 700);
        arg1.ref_fee_bps = arg2;
        let v0 = PartnerFeeRateUpdatedEvent{
            partner_id : 0x2::object::id<Partner>(arg1),
            new_rate   : arg2,
        };
        0x2::event::emit<PartnerFeeRateUpdatedEvent>(v0);
    }

    public fun version(arg0: &Partner) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

