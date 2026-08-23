module 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8 {
    struct MakerTreasuryV8<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        revenue: 0x2::balance::Balance<T0>,
        total_collected: u128,
        total_withdrawn: u128,
    }

    struct MakerAccessPassV8 has key {
        id: 0x2::object::UID,
        version: u64,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        holder: address,
        paid_atomic: u64,
        issued_at_ms: u64,
    }

    struct MakerAccessKeyV8 has copy, drop, store {
        holder: address,
    }

    struct MakerAccessRecordV8 has copy, drop, store {
        pass_id: 0x2::object::ID,
        holder: address,
        paid_atomic: u64,
        issued_at_ms: u64,
    }

    struct MakerRevenueV8Withdrawn has copy, drop {
        root_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        operator: address,
        recipient: address,
        amount: u64,
    }

    struct MakerAccessPassV8Issued has copy, drop {
        root_id: 0x2::object::ID,
        pass_id: 0x2::object::ID,
        holder: address,
        paid_atomic: u64,
        protocol_atomic: u64,
        maker_atomic: u64,
        issued_at_ms: u64,
    }

    public fun assert_maker_access_pass_v8<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &MakerAccessPassV8, arg2: address) {
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_lifecycle_v8<T0>(arg0) == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::lifecycle_active_v8(), 1);
        assert!(arg1.version == 8, 6);
        assert!(arg1.root_id == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_id_v8<T0>(arg0), 6);
        assert!(arg1.maker_version == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_maker_version_v8<T0>(arg0), 6);
        assert!(&arg1.root_content_commitment == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_content_commitment_v8<T0>(arg0), 6);
        assert!(arg1.holder == arg2, 6);
        let v0 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_economics_v8<T0>(arg0);
        let v1 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::economics_maker_access_v8(&v0);
        if (v1 == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::access_free_v8()) {
            assert!(arg1.paid_atomic == 0, 6);
        } else {
            assert!(v1 == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::access_paid_v8(), 6);
            assert!(arg1.paid_atomic == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::economics_maker_price_atomic_v8(&v0), 6);
        };
    }

    public fun assert_maker_treasury_v8<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &MakerTreasuryV8<T0>) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_maker_treasury_identity_v8<T0>(arg0, 0x2::object::id<MakerTreasuryV8<T0>>(arg1));
        assert!(arg1.version == 8, 0);
        assert!(arg1.root_id == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_id_v8<T0>(arg0), 0);
        assert!(arg1.maker_version == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_maker_version_v8<T0>(arg0), 0);
        assert!(&arg1.root_content_commitment == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_content_commitment_v8<T0>(arg0), 0);
    }

    public fun claim_free_maker_access_v8<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &mut MakerTreasuryV8<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_lifecycle_v8<T0>(arg0) == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::lifecycle_active_v8(), 1);
        assert_maker_treasury_v8<T0>(arg0, arg1);
        let v0 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_economics_v8<T0>(arg0);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::economics_maker_access_v8(&v0) == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::access_free_v8(), 6);
        issue_maker_access_pass<T0>(arg0, arg1, 0, 0, arg2, arg3);
    }

    public fun deposit_maker_revenue_v8<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &mut MakerTreasuryV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolConfigV8, arg3: 0x2::coin::Coin<T0>) {
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_lifecycle_v8<T0>(arg0) == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::lifecycle_active_v8(), 1);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_current_protocol_config_v8<T0>(arg0, arg2);
        assert_maker_treasury_v8<T0>(arg0, arg1);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 2);
        0x2::coin::put<T0>(&mut arg1.revenue, arg3);
        arg1.total_collected = arg1.total_collected + (v0 as u128);
    }

    fun issue_maker_access_pass<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &mut MakerTreasuryV8<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = MakerAccessKeyV8{holder: v0};
        assert!(!0x2::dynamic_field::exists<MakerAccessKeyV8>(&arg1.id, v1), 5);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        let v3 = MakerAccessPassV8{
            id                      : 0x2::object::new(arg5),
            version                 : 8,
            root_id                 : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_id_v8<T0>(arg0),
            maker_version           : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_maker_version_v8<T0>(arg0),
            root_content_commitment : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_content_commitment_v8<T0>(arg0),
            holder                  : v0,
            paid_atomic             : arg2,
            issued_at_ms            : v2,
        };
        let v4 = 0x2::object::id<MakerAccessPassV8>(&v3);
        let v5 = MakerAccessRecordV8{
            pass_id      : v4,
            holder       : v0,
            paid_atomic  : arg2,
            issued_at_ms : v2,
        };
        0x2::dynamic_field::add<MakerAccessKeyV8, MakerAccessRecordV8>(&mut arg1.id, v1, v5);
        let v6 = MakerAccessPassV8Issued{
            root_id         : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_id_v8<T0>(arg0),
            pass_id         : v4,
            holder          : v0,
            paid_atomic     : arg2,
            protocol_atomic : arg3,
            maker_atomic    : arg2 - arg3,
            issued_at_ms    : v2,
        };
        0x2::event::emit<MakerAccessPassV8Issued>(v6);
        0x2::transfer::transfer<MakerAccessPassV8>(v3, v0);
    }

    public fun maker_access_pass_holder_v8(arg0: &MakerAccessPassV8) : address {
        arg0.holder
    }

    public fun maker_access_pass_id_v8(arg0: &MakerAccessPassV8) : 0x2::object::ID {
        0x2::object::id<MakerAccessPassV8>(arg0)
    }

    public fun maker_access_pass_issued_at_ms_v8(arg0: &MakerAccessPassV8) : u64 {
        arg0.issued_at_ms
    }

    public fun maker_access_pass_maker_version_v8(arg0: &MakerAccessPassV8) : u64 {
        arg0.maker_version
    }

    public fun maker_access_pass_paid_atomic_v8(arg0: &MakerAccessPassV8) : u64 {
        arg0.paid_atomic
    }

    public fun maker_access_pass_root_content_commitment_v8(arg0: &MakerAccessPassV8) : &vector<u8> {
        &arg0.root_content_commitment
    }

    public fun maker_access_pass_root_id_v8(arg0: &MakerAccessPassV8) : 0x2::object::ID {
        arg0.root_id
    }

    public fun maker_treasury_balance_v8<T0>(arg0: &MakerTreasuryV8<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.revenue)
    }

    public fun maker_treasury_id_v8<T0>(arg0: &MakerTreasuryV8<T0>) : 0x2::object::ID {
        0x2::object::id<MakerTreasuryV8<T0>>(arg0)
    }

    public fun maker_treasury_root_id_v8<T0>(arg0: &MakerTreasuryV8<T0>) : 0x2::object::ID {
        arg0.root_id
    }

    public fun maker_treasury_total_collected_v8<T0>(arg0: &MakerTreasuryV8<T0>) : u128 {
        arg0.total_collected
    }

    public fun maker_treasury_total_withdrawn_v8<T0>(arg0: &MakerTreasuryV8<T0>) : u128 {
        arg0.total_withdrawn
    }

    public(friend) fun new_maker_treasury_v8<T0>(arg0: &mut 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerAdminCapV8, arg2: &mut 0x2::tx_context::TxContext) : MakerTreasuryV8<T0> {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_draft_admin_v8<T0>(arg0, arg1);
        let v0 = MakerTreasuryV8<T0>{
            id                      : 0x2::object::new(arg2),
            version                 : 8,
            root_id                 : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_id_v8<T0>(arg0),
            maker_version           : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_maker_version_v8<T0>(arg0),
            root_content_commitment : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_content_commitment_v8<T0>(arg0),
            revenue                 : 0x2::balance::zero<T0>(),
            total_collected         : 0,
            total_withdrawn         : 0,
        };
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::finalize_maker_treasury_binding_v8<T0>(arg0, arg1, 0x2::object::id<MakerTreasuryV8<T0>>(&v0));
        v0
    }

    public fun purchase_maker_access_v8<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &mut MakerTreasuryV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolConfigV8, arg3: &mut 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolTreasuryV8<T0>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_lifecycle_v8<T0>(arg0) == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::lifecycle_active_v8(), 1);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_current_protocol_config_v8<T0>(arg0, arg2);
        assert_maker_treasury_v8<T0>(arg0, arg1);
        let v0 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_economics_v8<T0>(arg0);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::economics_maker_access_v8(&v0) == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::access_paid_v8(), 6);
        let v1 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::economics_maker_price_atomic_v8(&v0);
        assert!(v1 > 0 && 0x2::coin::value<T0>(&arg4) == v1, 7);
        let v2 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::economics_primary_content_fee_bps_v8(&v0);
        let v3 = (v1 as u128) * (v2 as u128) / 10000;
        assert!(v2 == 0 || v3 > 0, 8);
        let v4 = (v3 as u64);
        let v5 = v1 - v4;
        if (v4 > 0) {
            0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::deposit_protocol_revenue_v8<T0>(arg2, arg3, 0x2::coin::split<T0>(&mut arg4, v4, arg6));
        };
        assert!(0x2::coin::value<T0>(&arg4) == v5 && v5 > 0, 7);
        deposit_maker_revenue_v8<T0>(arg0, arg1, arg2, arg4);
        issue_maker_access_pass<T0>(arg0, arg1, v1, v4, arg5, arg6);
    }

    public(friend) fun share_maker_treasury_v8<T0>(arg0: MakerTreasuryV8<T0>) {
        0x2::transfer::share_object<MakerTreasuryV8<T0>>(arg0);
    }

    public fun withdraw_maker_revenue_v8<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerAdminCapV8, arg2: &mut MakerTreasuryV8<T0>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_admin_v8<T0>(arg0, arg1);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_owner_v8<T0>(arg0) == 0x2::tx_context::sender(arg5), 4);
        assert_maker_treasury_v8<T0>(arg0, arg2);
        assert!(arg4 != @0x0, 3);
        assert!(arg3 > 0 && arg3 <= 0x2::balance::value<T0>(&arg2.revenue), 2);
        arg2.total_withdrawn = arg2.total_withdrawn + (arg3 as u128);
        let v0 = MakerRevenueV8Withdrawn{
            root_id     : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_id_v8<T0>(arg0),
            treasury_id : 0x2::object::id<MakerTreasuryV8<T0>>(arg2),
            operator    : 0x2::tx_context::sender(arg5),
            recipient   : arg4,
            amount      : arg3,
        };
        0x2::event::emit<MakerRevenueV8Withdrawn>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg2.revenue, arg3, arg5), arg4);
    }

    // decompiled from Move bytecode v7
}

