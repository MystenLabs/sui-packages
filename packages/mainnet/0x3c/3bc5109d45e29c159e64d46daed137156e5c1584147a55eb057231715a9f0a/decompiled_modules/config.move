module 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::config {
    struct VaultRecord has copy, drop, store {
        vault_id: 0x2::object::ID,
        owner_cap_id: 0x2::object::ID,
        vault_metadata_id: 0x2::object::ID,
        created_at_ms: u64,
    }

    struct UserLpCoinRecord has copy, drop, store {
        user_lp_coin_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        collateral_pfs_tolerance: u64,
        max_lock_period: u64,
        max_force_withdraw_delay: u64,
        max_owner_fee_rate: u256,
        min_owner_lock_usd: u256,
        max_owner_lock_usd: u256,
        min_deposit_usd: u256,
        max_markets_in_vault: u64,
        max_pending_orders_per_position: u64,
        force_withdraw_pause_ms: u64,
        max_assistants_per_vault: u64,
        extra_fields: 0x2::bag::Bag,
    }

    public(friend) fun assert_authority_cap_id_is_authorized<T0>(arg0: &Config, arg1: 0x2::object::ID) {
        assert!(is_authority_cap_authorized<T0>(arg0, arg1), 13835624200691515397);
    }

    public(friend) fun assert_authority_cap_is_valid<T0>(arg0: &Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, T0>) {
        assert_package_version(arg0);
        assert!(has_authority<T0>(arg0, arg1), 13835624058957594629);
    }

    public(friend) fun assert_is_active_package_freeze_guardian_cap(arg0: &Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::FREEZE_GUARDIAN>) {
        assert!(has_freeze_guardian_authority(arg0, arg1), 13835624170626744325);
    }

    public(friend) fun assert_is_active_package_maintenance_cap(arg0: &Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::MAINTENANCE>) {
        assert_package_version(arg0);
        assert!(has_maintenance_authority(arg0, arg1), 13835624127677071365);
    }

    public(friend) fun assert_is_active_package_pause_guardian_cap(arg0: &Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PAUSE_GUARDIAN>) {
        assert_package_version(arg0);
        assert!(has_pause_guardian_authority(arg0, arg1), 13835624093317332997);
    }

    public fun assert_package_version(arg0: &Config) {
        assert!(arg0.version <= 1, 13835342549621014531);
    }

    public(friend) fun assert_user_lp_coin_record_exists(arg0: &Config, arg1: 0x2::object::ID) {
        assert!(has_user_lp_coin_record(arg0, arg1), 13836748133503860749);
    }

    public(friend) fun authorize_authority_cap<T0>(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, T0>) {
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::authorize_cap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, T0>(&mut arg0.id, arg1);
    }

    public(friend) fun collateral_pfs_tolerance(arg0: &Config) : u64 {
        arg0.collateral_pfs_tolerance
    }

    public(friend) fun create_config_and_share<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13835058721002094593);
        let v0 = Config{
            id                              : 0x2::object::new(arg1),
            version                         : 1,
            collateral_pfs_tolerance        : 30000,
            max_lock_period                 : 5259600000,
            max_force_withdraw_delay        : 172800000,
            max_owner_fee_rate              : 200000000000000000,
            min_owner_lock_usd              : 950000000000000000,
            max_owner_lock_usd              : 2000000000000000000,
            min_deposit_usd                 : 950000000000000000,
            max_markets_in_vault            : 20,
            max_pending_orders_per_position : 50,
            force_withdraw_pause_ms         : 10000,
            max_assistants_per_vault        : 20,
            extra_fields                    : 0x2::bag::new(arg1),
        };
        0x2::transfer::public_transfer<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>>(0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::create_package_admin_cap<T0>(arg0, &mut v0.id), 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Config>(v0);
    }

    public(friend) fun create_package_assistant_cap_(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT> {
        let v0 = 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::create_multiton_package_assistant_cap(&mut arg0.id, arg2);
        authorize_authority_cap<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg0, &v0);
        0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::events::emit_create_package_assistant_cap(0x2::object::id<Config>(arg0), 0x2::object::id<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>>(&v0));
        v0
    }

    public(friend) fun create_package_freeze_guardian_cap_(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::FREEZE_GUARDIAN> {
        let v0 = 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::create_multiton_package_freeze_guardian_cap(&mut arg0.id, arg2);
        authorize_authority_cap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::FREEZE_GUARDIAN>(arg0, &v0);
        0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::events::emit_created_package_freeze_guardian_cap(0x2::object::id<Config>(arg0), 0x2::object::id<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::FREEZE_GUARDIAN>>(&v0));
        v0
    }

    public(friend) fun create_package_maintenance_cap_(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::MAINTENANCE> {
        let v0 = 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::create_multiton_package_maintenance_cap(&mut arg0.id, arg2);
        authorize_authority_cap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::MAINTENANCE>(arg0, &v0);
        0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::events::emit_create_package_maintenance_cap(0x2::object::id<Config>(arg0), 0x2::object::id<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::MAINTENANCE>>(&v0));
        v0
    }

    public(friend) fun create_package_pause_guardian_cap_(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PAUSE_GUARDIAN> {
        let v0 = 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::create_multiton_package_pause_guardian_cap(&mut arg0.id, arg2);
        authorize_authority_cap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PAUSE_GUARDIAN>(arg0, &v0);
        0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::events::emit_create_package_pause_guardian_cap(0x2::object::id<Config>(arg0), 0x2::object::id<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PAUSE_GUARDIAN>>(&v0));
        v0
    }

    public(friend) fun deauthorize_authority_cap_<T0>(arg0: &mut Config, arg1: 0x2::object::ID) {
        assert_authority_cap_id_is_authorized<T0>(arg0, arg1);
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::deauthorize_cap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, T0>(&mut arg0.id, arg1);
    }

    public(friend) fun deauthorize_package_authority_cap_<T0>(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: 0x2::object::ID) {
        0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::assert_is_not_admin<T0>();
        deauthorize_authority_cap_<T0>(arg0, arg2);
        0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::events::emit_revoked_package_authority_cap(0x2::object::id<Config>(arg0), 0x1::type_name::with_defining_ids<T0>(), arg2);
    }

    public(friend) fun force_withdraw_pause_ms(arg0: &Config) : u64 {
        arg0.force_withdraw_pause_ms
    }

    public fun freeze_package(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::FREEZE_GUARDIAN>) {
        assert_package_version(arg0);
        assert_is_active_package_freeze_guardian_cap(arg0, arg1);
        let v0 = arg0.version;
        0x2::dynamic_field::add<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::keys::FrozenVersionKey, u64>(&mut arg0.id, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::keys::frozen_version_key(), v0);
        arg0.version = 18446744073709551615;
        0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::events::emit_froze(0x2::object::uid_to_inner(&arg0.id), v0, 0x2::object::id<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::FREEZE_GUARDIAN>>(arg1));
    }

    fun has_authority<T0>(arg0: &Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, T0>) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::for<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, T0>(arg1) == 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::package_id() && (v0 == 0x1::type_name::with_defining_ids<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>() || v0 == 0x1::type_name::with_defining_ids<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>() && is_authority_cap_authorized<T0>(arg0, 0x2::object::id<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, T0>>(arg1)))
    }

    fun has_freeze_guardian_authority(arg0: &Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::FREEZE_GUARDIAN>) : bool {
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::for<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::FREEZE_GUARDIAN>(arg1) == 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::package_id() && is_authority_cap_authorized<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::FREEZE_GUARDIAN>(arg0, 0x2::object::id<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::FREEZE_GUARDIAN>>(arg1))
    }

    fun has_maintenance_authority(arg0: &Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::MAINTENANCE>) : bool {
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::for<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::MAINTENANCE>(arg1) == 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::package_id() && is_authority_cap_authorized<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::MAINTENANCE>(arg0, 0x2::object::id<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::MAINTENANCE>>(arg1))
    }

    fun has_pause_guardian_authority(arg0: &Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PAUSE_GUARDIAN>) : bool {
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::for<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PAUSE_GUARDIAN>(arg1) == 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::package_id() && is_authority_cap_authorized<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PAUSE_GUARDIAN>(arg0, 0x2::object::id<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PAUSE_GUARDIAN>>(arg1))
    }

    public(friend) fun has_user_lp_coin_record(arg0: &Config, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_field::exists<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::keys::UserLpCoinRecordKey>(&arg0.id, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::keys::user_lp_coin_record_key(arg1))
    }

    public(friend) fun has_vault_record(arg0: &Config, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_field::exists<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::keys::VaultRecordKey>(&arg0.id, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::keys::vault_record_key(arg1))
    }

    public fun is_authority_cap_authorized<T0>(arg0: &Config, arg1: 0x2::object::ID) : bool {
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::is_cap_authorized<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, T0>(&arg0.id, arg1)
    }

    public fun is_frozen(arg0: &Config) : bool {
        0x2::dynamic_field::exists<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::keys::FrozenVersionKey>(&arg0.id, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::keys::frozen_version_key())
    }

    public(friend) fun max_assistants_per_vault(arg0: &Config) : u64 {
        arg0.max_assistants_per_vault
    }

    public(friend) fun max_force_withdraw_delay(arg0: &Config) : u64 {
        arg0.max_force_withdraw_delay
    }

    public(friend) fun max_lock_period(arg0: &Config) : u64 {
        arg0.max_lock_period
    }

    public(friend) fun max_markets_in_vault(arg0: &Config) : u64 {
        arg0.max_markets_in_vault
    }

    public(friend) fun max_owner_fee_rate(arg0: &Config) : u256 {
        arg0.max_owner_fee_rate
    }

    public(friend) fun max_owner_lock_usd(arg0: &Config) : u256 {
        arg0.max_owner_lock_usd
    }

    public(friend) fun max_pending_orders_per_position(arg0: &Config) : u64 {
        arg0.max_pending_orders_per_position
    }

    public(friend) fun min_deposit_usd(arg0: &Config) : u256 {
        arg0.min_deposit_usd
    }

    public(friend) fun min_owner_lock_usd(arg0: &Config) : u256 {
        arg0.min_owner_lock_usd
    }

    public(friend) fun register_user_lp_coin(arg0: &mut Config, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        assert!(!has_user_lp_coin_record(arg0, arg1), 13836466817440808971);
        let v0 = UserLpCoinRecord{
            user_lp_coin_id : arg1,
            vault_id        : arg2,
        };
        0x2::dynamic_field::add<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::keys::UserLpCoinRecordKey, UserLpCoinRecord>(&mut arg0.id, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::keys::user_lp_coin_record_key(arg1), v0);
    }

    public(friend) fun register_vault(arg0: &mut Config, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64) {
        assert!(!has_vault_record(arg0, arg1), 13836185247974686729);
        let v0 = VaultRecord{
            vault_id          : arg1,
            owner_cap_id      : arg2,
            vault_metadata_id : arg3,
            created_at_ms     : arg4,
        };
        0x2::dynamic_field::add<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::keys::VaultRecordKey, VaultRecord>(&mut arg0.id, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::keys::vault_record_key(arg1), v0);
    }

    public fun set_force_withdraw_pause_ms<T0>(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, T0>, arg2: u64) {
        assert_authority_cap_is_valid<T0>(arg0, arg1);
        assert!(arg2 <= arg0.max_force_withdraw_delay, 13835905052898099207);
        arg0.force_withdraw_pause_ms = arg2;
    }

    public fun set_max_assistants_per_vault<T0>(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, T0>, arg2: u64) {
        assert_authority_cap_is_valid<T0>(arg0, arg1);
        arg0.max_assistants_per_vault = arg2;
    }

    public fun set_max_force_withdraw_delay<T0>(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, T0>, arg2: u64) {
        assert_authority_cap_is_valid<T0>(arg0, arg1);
        assert!(arg0.force_withdraw_pause_ms <= arg2, 13835904756545355783);
        arg0.max_force_withdraw_delay = arg2;
    }

    public fun set_max_lock_period<T0>(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, T0>, arg2: u64) {
        assert_authority_cap_is_valid<T0>(arg0, arg1);
        arg0.max_lock_period = arg2;
    }

    public fun set_max_markets_in_vault<T0>(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, T0>, arg2: u64) {
        assert_authority_cap_is_valid<T0>(arg0, arg1);
        arg0.max_markets_in_vault = arg2;
    }

    public fun set_max_owner_fee_rate<T0>(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, T0>, arg2: u256) {
        assert_authority_cap_is_valid<T0>(arg0, arg1);
        arg0.max_owner_fee_rate = arg2;
    }

    public fun set_max_owner_lock_usd<T0>(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, T0>, arg2: u256) {
        assert_authority_cap_is_valid<T0>(arg0, arg1);
        assert!(arg0.min_owner_lock_usd <= arg2, 13835904885394374663);
        arg0.max_owner_lock_usd = arg2;
    }

    public fun set_max_pending_orders_per_position<T0>(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, T0>, arg2: u64) {
        assert_authority_cap_is_valid<T0>(arg0, arg1);
        arg0.max_pending_orders_per_position = arg2;
    }

    public fun set_min_deposit_usd<T0>(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, T0>, arg2: u256) {
        assert_authority_cap_is_valid<T0>(arg0, arg1);
        arg0.min_deposit_usd = arg2;
    }

    public fun set_min_owner_lock_usd<T0>(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, T0>, arg2: u256) {
        assert_authority_cap_is_valid<T0>(arg0, arg1);
        assert!(arg2 <= arg0.max_owner_lock_usd, 13835904842444701703);
        arg0.min_owner_lock_usd = arg2;
    }

    public fun share(arg0: Config) {
        0x2::transfer::share_object<Config>(arg0);
    }

    public fun unfreeze_package(arg0: &mut Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>) {
        assert!(is_frozen(arg0), 13837030295675469839);
        let v0 = 0x2::dynamic_field::remove<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::keys::FrozenVersionKey, u64>(&mut arg0.id, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::keys::frozen_version_key());
        assert!(v0 <= 1, 13837311787832180753);
        arg0.version = v0;
        0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::events::emit_unfroze(0x2::object::uid_to_inner(&arg0.id), v0);
    }

    public(friend) fun unregister_user_lp_coin(arg0: &mut Config, arg1: 0x2::object::ID) {
        assert!(has_user_lp_coin_record(arg0, arg1), 13836748374022029325);
        0x2::dynamic_field::remove<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::keys::UserLpCoinRecordKey, UserLpCoinRecord>(&mut arg0.id, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::keys::user_lp_coin_record_key(arg1));
    }

    public(friend) fun upgrade_version(arg0: &mut Config) {
        let v0 = 1;
        assert!(v0 > arg0.version, 13837594276421304339);
        arg0.version = v0;
        0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::events::emit_upgrade_config_version(0x2::object::uid_to_inner(&arg0.id), v0);
    }

    public(friend) fun user_lp_coin_record(arg0: &Config, arg1: 0x2::object::ID) : &UserLpCoinRecord {
        assert_user_lp_coin_record_exists(arg0, arg1);
        0x2::dynamic_field::borrow<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::keys::UserLpCoinRecordKey, UserLpCoinRecord>(&arg0.id, 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::keys::user_lp_coin_record_key(arg1))
    }

    public(friend) fun user_lp_coin_record_vault_id(arg0: &UserLpCoinRecord) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v7
}

