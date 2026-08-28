module 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::protocol_config_v8 {
    struct PROTOCOL_CONFIG_V8 has drop {
        dummy_field: bool,
    }

    struct CorePackageMarkerV8 has drop {
        dummy_field: bool,
    }

    struct ProtocolConfigV8 has key {
        id: 0x2::object::UID,
        version: u64,
        core_original_package_id: 0x2::object::ID,
        core_callable_package_id: 0x2::object::ID,
        revision: u64,
        treasury_id: 0x1::option::Option<0x2::object::ID>,
        payment_coin_type: 0x1::string::String,
        primary_content_fee_bps: u16,
        fixed_complete_fee_atomic: u64,
        maker_market_fee_bps: u16,
        soul_market_fee_bps: u16,
        enabled: bool,
        commitment: vector<u8>,
    }

    struct ProtocolAdminCapV8 has key {
        id: 0x2::object::UID,
        version: u64,
        config_id: 0x2::object::ID,
    }

    struct ProtocolTreasuryV8<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        config_id: 0x2::object::ID,
        revenue: 0x2::balance::Balance<T0>,
        total_collected: u128,
        total_withdrawn: u128,
    }

    struct ProtocolConfigCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        config_id: 0x2::object::ID,
        core_original_package_id: 0x2::object::ID,
        core_callable_package_id: 0x2::object::ID,
        revision: u64,
        treasury_id: 0x1::option::Option<0x2::object::ID>,
        payment_coin_type: 0x1::string::String,
        primary_content_fee_bps: u16,
        fixed_complete_fee_atomic: u64,
        maker_market_fee_bps: u16,
        soul_market_fee_bps: u16,
        enabled: bool,
    }

    struct ProtocolV8EnabledChanged has copy, drop {
        config_id: 0x2::object::ID,
        revision: u64,
        enabled: bool,
        commitment: vector<u8>,
    }

    struct ProtocolTreasuryV8Initialized has copy, drop {
        config_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        revision: u64,
        commitment: vector<u8>,
    }

    struct ProtocolRevenueV8Withdrawn has copy, drop {
        config_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        operator: address,
        recipient: address,
        amount: u64,
    }

    fun assert_admin(arg0: &ProtocolConfigV8, arg1: &ProtocolAdminCapV8) {
        assert_protocol_admin_v8(arg0, arg1);
    }

    public fun assert_enabled_for_coin_v8<T0>(arg0: &ProtocolConfigV8) {
        assert_enabled_v8(arg0);
        assert!(arg0.payment_coin_type == payment_coin_type_name_v8<T0>(), 3);
    }

    public fun assert_enabled_v8(arg0: &ProtocolConfigV8) {
        assert!(arg0.version == 8, 2);
        assert!(arg0.enabled, 1);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.treasury_id), 6);
        assert!(arg0.core_original_package_id == current_core_original_package_id(), 4);
        assert!(arg0.core_callable_package_id == current_core_callable_package_id(), 4);
    }

    public(friend) fun assert_exact_protocol_treasury_v8<T0>(arg0: &ProtocolConfigV8, arg1: &ProtocolTreasuryV8<T0>) {
        assert_protocol_treasury<T0>(arg0, arg1);
    }

    public fun assert_exact_snapshot_v8<T0>(arg0: &ProtocolConfigV8, arg1: 0x2::object::ID, arg2: u64, arg3: &vector<u8>) {
        assert_enabled_for_coin_v8<T0>(arg0);
        assert!(0x2::object::id<ProtocolConfigV8>(arg0) == arg1, 2);
        assert!(arg0.revision == arg2, 2);
        assert!(&arg0.commitment == arg3, 2);
    }

    public fun assert_protocol_admin_v8(arg0: &ProtocolConfigV8, arg1: &ProtocolAdminCapV8) {
        assert!(arg1.version == 8, 0);
        assert!(arg1.config_id == 0x2::object::id<ProtocolConfigV8>(arg0), 0);
    }

    fun assert_protocol_treasury<T0>(arg0: &ProtocolConfigV8, arg1: &ProtocolTreasuryV8<T0>) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.treasury_id), 6);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.treasury_id) == 0x2::object::id<ProtocolTreasuryV8<T0>>(arg1), 7);
        assert!(arg1.version == 8, 7);
        assert!(arg1.config_id == 0x2::object::id<ProtocolConfigV8>(arg0), 7);
        assert!(arg0.payment_coin_type == payment_coin_type_name_v8<T0>(), 3);
    }

    public fun config_commitment_v8(arg0: &ProtocolConfigV8) : &vector<u8> {
        &arg0.commitment
    }

    public fun config_core_callable_package_id_v8(arg0: &ProtocolConfigV8) : 0x2::object::ID {
        arg0.core_callable_package_id
    }

    public fun config_core_original_package_id_v8(arg0: &ProtocolConfigV8) : 0x2::object::ID {
        arg0.core_original_package_id
    }

    public fun config_enabled_v8(arg0: &ProtocolConfigV8) : bool {
        arg0.enabled
    }

    public fun config_fixed_complete_fee_atomic_v8(arg0: &ProtocolConfigV8) : u64 {
        arg0.fixed_complete_fee_atomic
    }

    public fun config_id_v8(arg0: &ProtocolConfigV8) : 0x2::object::ID {
        0x2::object::id<ProtocolConfigV8>(arg0)
    }

    public fun config_maker_market_fee_bps_v8(arg0: &ProtocolConfigV8) : u16 {
        arg0.maker_market_fee_bps
    }

    public fun config_payment_coin_type_v8(arg0: &ProtocolConfigV8) : &0x1::string::String {
        &arg0.payment_coin_type
    }

    public fun config_primary_content_fee_bps_v8(arg0: &ProtocolConfigV8) : u16 {
        arg0.primary_content_fee_bps
    }

    public fun config_revision_v8(arg0: &ProtocolConfigV8) : u64 {
        arg0.revision
    }

    public fun config_soul_market_fee_bps_v8(arg0: &ProtocolConfigV8) : u16 {
        arg0.soul_market_fee_bps
    }

    public fun config_treasury_id_v8(arg0: &ProtocolConfigV8) : &0x1::option::Option<0x2::object::ID> {
        &arg0.treasury_id
    }

    fun current_core_callable_package_id() : 0x2::object::ID {
        0x2::object::id_from_address(0x1::type_name::defining_id<CorePackageMarkerV8>())
    }

    fun current_core_original_package_id() : 0x2::object::ID {
        0x2::object::id_from_address(0x1::type_name::original_id<CorePackageMarkerV8>())
    }

    public fun default_fixed_complete_fee_atomic_v8() : u64 {
        0
    }

    public fun default_maker_market_fee_bps_v8() : u16 {
        250
    }

    public fun default_primary_content_fee_bps_v8() : u16 {
        1000
    }

    public fun default_soul_market_fee_bps_v8() : u16 {
        250
    }

    public fun deposit_protocol_revenue_v8<T0>(arg0: &ProtocolConfigV8, arg1: &mut ProtocolTreasuryV8<T0>, arg2: 0x2::coin::Coin<T0>) {
        assert_enabled_for_coin_v8<T0>(arg0);
        assert_protocol_treasury<T0>(arg0, arg1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 9);
        0x2::coin::put<T0>(&mut arg1.revenue, arg2);
        arg1.total_collected = arg1.total_collected + (v0 as u128);
    }

    fun init(arg0: PROTOCOL_CONFIG_V8, arg1: &mut 0x2::tx_context::TxContext) {
        let PROTOCOL_CONFIG_V8 {  } = arg0;
        let v0 = 0x2::object::new(arg1);
        let v1 = ProtocolConfigV8{
            id                        : v0,
            version                   : 8,
            core_original_package_id  : current_core_original_package_id(),
            core_callable_package_id  : current_core_callable_package_id(),
            revision                  : 0,
            treasury_id               : 0x1::option::none<0x2::object::ID>(),
            payment_coin_type         : native_usdc_type_v8(),
            primary_content_fee_bps   : 1000,
            fixed_complete_fee_atomic : 0,
            maker_market_fee_bps      : 250,
            soul_market_fee_bps       : 250,
            enabled                   : false,
            commitment                : b"",
        };
        let v2 = &mut v1;
        refresh_commitment(v2);
        let v3 = ProtocolAdminCapV8{
            id        : 0x2::object::new(arg1),
            version   : 8,
            config_id : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::share_object<ProtocolConfigV8>(v1);
        0x2::transfer::transfer<ProtocolAdminCapV8>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun initialize_protocol_treasury_v8<T0>(arg0: &mut ProtocolConfigV8, arg1: &ProtocolAdminCapV8, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.treasury_id), 5);
        assert!(payment_coin_type_name_v8<T0>() == arg0.payment_coin_type, 3);
        let v0 = new_protocol_treasury<T0>(0x2::object::id<ProtocolConfigV8>(arg0), arg2);
        let v1 = 0x2::object::id<ProtocolTreasuryV8<T0>>(&v0);
        arg0.treasury_id = 0x1::option::some<0x2::object::ID>(v1);
        arg0.revision = arg0.revision + 1;
        refresh_commitment(arg0);
        let v2 = ProtocolTreasuryV8Initialized{
            config_id   : 0x2::object::id<ProtocolConfigV8>(arg0),
            treasury_id : v1,
            revision    : arg0.revision,
            commitment  : arg0.commitment,
        };
        0x2::event::emit<ProtocolTreasuryV8Initialized>(v2);
        0x2::transfer::share_object<ProtocolTreasuryV8<T0>>(v0);
    }

    public fun native_usdc_type_v8() : 0x1::string::String {
        0x1::string::utf8(b"0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC")
    }

    fun new_protocol_treasury<T0>(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : ProtocolTreasuryV8<T0> {
        ProtocolTreasuryV8<T0>{
            id              : 0x2::object::new(arg1),
            version         : 8,
            config_id       : arg0,
            revenue         : 0x2::balance::zero<T0>(),
            total_collected : 0,
            total_withdrawn : 0,
        }
    }

    public fun payment_coin_type_name_v8<T0>() : 0x1::string::String {
        let v0 = b"0x";
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())));
        0x1::string::utf8(v0)
    }

    public fun protocol_treasury_balance_v8<T0>(arg0: &ProtocolTreasuryV8<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.revenue)
    }

    public fun protocol_treasury_config_id_v8<T0>(arg0: &ProtocolTreasuryV8<T0>) : 0x2::object::ID {
        arg0.config_id
    }

    public fun protocol_treasury_id_v8<T0>(arg0: &ProtocolTreasuryV8<T0>) : 0x2::object::ID {
        0x2::object::id<ProtocolTreasuryV8<T0>>(arg0)
    }

    public fun protocol_treasury_total_collected_v8<T0>(arg0: &ProtocolTreasuryV8<T0>) : u128 {
        arg0.total_collected
    }

    public fun protocol_treasury_total_withdrawn_v8<T0>(arg0: &ProtocolTreasuryV8<T0>) : u128 {
        arg0.total_withdrawn
    }

    fun refresh_commitment(arg0: &mut ProtocolConfigV8) {
        let v0 = ProtocolConfigCommitmentInputV8{
            domain                    : b"animacraft-v8/protocol-config",
            version                   : arg0.version,
            config_id                 : 0x2::object::id<ProtocolConfigV8>(arg0),
            core_original_package_id  : arg0.core_original_package_id,
            core_callable_package_id  : arg0.core_callable_package_id,
            revision                  : arg0.revision,
            treasury_id               : arg0.treasury_id,
            payment_coin_type         : arg0.payment_coin_type,
            primary_content_fee_bps   : arg0.primary_content_fee_bps,
            fixed_complete_fee_atomic : arg0.fixed_complete_fee_atomic,
            maker_market_fee_bps      : arg0.maker_market_fee_bps,
            soul_market_fee_bps       : arg0.soul_market_fee_bps,
            enabled                   : arg0.enabled,
        };
        arg0.commitment = 0x1::hash::sha2_256(0x1::bcs::to_bytes<ProtocolConfigCommitmentInputV8>(&v0));
    }

    public fun set_protocol_enabled_v8(arg0: &mut ProtocolConfigV8, arg1: &ProtocolAdminCapV8, arg2: bool) {
        assert_admin(arg0, arg1);
        if (arg2) {
            assert!(0x1::option::is_some<0x2::object::ID>(&arg0.treasury_id), 6);
        };
        assert!(arg0.enabled != arg2, 2);
        arg0.enabled = arg2;
        arg0.revision = arg0.revision + 1;
        refresh_commitment(arg0);
        let v0 = ProtocolV8EnabledChanged{
            config_id  : 0x2::object::id<ProtocolConfigV8>(arg0),
            revision   : arg0.revision,
            enabled    : arg2,
            commitment : arg0.commitment,
        };
        0x2::event::emit<ProtocolV8EnabledChanged>(v0);
    }

    public fun version_v8() : u64 {
        8
    }

    public fun withdraw_protocol_revenue_v8<T0>(arg0: &ProtocolConfigV8, arg1: &ProtocolAdminCapV8, arg2: &mut ProtocolTreasuryV8<T0>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        assert_protocol_treasury<T0>(arg0, arg2);
        assert!(arg4 != @0x0, 8);
        assert!(arg3 > 0 && arg3 <= 0x2::balance::value<T0>(&arg2.revenue), 9);
        arg2.total_withdrawn = arg2.total_withdrawn + (arg3 as u128);
        let v0 = ProtocolRevenueV8Withdrawn{
            config_id   : 0x2::object::id<ProtocolConfigV8>(arg0),
            treasury_id : 0x2::object::id<ProtocolTreasuryV8<T0>>(arg2),
            operator    : 0x2::tx_context::sender(arg5),
            recipient   : arg4,
            amount      : arg3,
        };
        0x2::event::emit<ProtocolRevenueV8Withdrawn>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg2.revenue, arg3, arg5), arg4);
    }

    // decompiled from Move bytecode v7
}

