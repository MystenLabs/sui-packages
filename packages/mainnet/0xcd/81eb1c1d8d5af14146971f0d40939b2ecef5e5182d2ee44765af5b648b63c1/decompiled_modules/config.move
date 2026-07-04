module 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::config {
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
        active_assistants: vector<0x2::object::ID>,
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

    public fun active_assistants(arg0: &Config) : vector<0x2::object::ID> {
        arg0.active_assistants
    }

    public(friend) fun assert_authority_cap_is_valid<T0>(arg0: &Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T0>) {
        assert_package_version(arg0);
        assert!(has_authority<T0>(arg0, arg1), 13835623590806159365);
    }

    public(friend) fun assert_is_active_package_maintenance_cap(arg0: &Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::MAINTENANCE>) {
        assert_package_version(arg0);
        assert!(has_maintenance_authority(arg0, arg1), 13835623659525636101);
    }

    public(friend) fun assert_is_active_package_pause_guardian_cap(arg0: &Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PAUSE_GUARDIAN>) {
        assert_package_version(arg0);
        assert!(has_pause_guardian_authority(arg0, arg1), 13835623625165897733);
    }

    public fun assert_package_version(arg0: &Config) {
        assert!(arg0.version <= 2, 13835342081469579267);
    }

    public(friend) fun assert_user_lp_coin_record_exists(arg0: &Config, arg1: 0x2::object::ID) {
        assert!(has_user_lp_coin_record(arg0, arg1), 13836748077669285901);
    }

    public(friend) fun collateral_pfs_tolerance(arg0: &Config) : u64 {
        arg0.collateral_pfs_tolerance
    }

    public(friend) fun create_config_and_share<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13835058712412160001);
        let v0 = Config{
            id                              : 0x2::object::new(arg1),
            version                         : 2,
            active_assistants               : 0x1::vector::empty<0x2::object::ID>(),
            collateral_pfs_tolerance        : 30000,
            max_lock_period                 : 1209600000,
            max_force_withdraw_delay        : 86400000,
            max_owner_fee_rate              : 200000000000000000,
            min_owner_lock_usd              : 1000000000000000000,
            max_owner_lock_usd              : 2000000000000000000,
            min_deposit_usd                 : 950000000000000000,
            max_markets_in_vault            : 15,
            max_pending_orders_per_position : 60,
            force_withdraw_pause_ms         : 10000,
            max_assistants_per_vault        : 10,
            extra_fields                    : 0x2::bag::new(arg1),
        };
        let v1 = 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::create_package_admin_cap<T0>(arg0, &mut v0.id);
        0x2::dynamic_field::add<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::PackageAdminCapIdKey, 0x2::object::ID>(&mut v0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::package_admin_cap_id_key(), 0x2::object::id<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>>(&v1));
        0x2::transfer::public_transfer<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Config>(v0);
    }

    public(friend) fun create_package_assistant_cap_(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT> {
        let v0 = 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::create_multiton_package_assistant_cap(&mut arg0.id, arg2);
        let v1 = 0x2::object::id<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>>(&v0);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.active_assistants, v1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_create_package_assistant_cap(0x2::object::id<Config>(arg0), v1);
        v0
    }

    public(friend) fun create_package_maintenance_cap_(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::MAINTENANCE> {
        let v0 = 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::create_multiton_package_maintenance_cap(&mut arg0.id, arg2);
        let v1 = 0x2::object::id<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::MAINTENANCE>>(&v0);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.active_assistants, v1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_create_package_maintenance_cap(0x2::object::id<Config>(arg0), v1);
        v0
    }

    public(friend) fun create_package_pause_guardian_cap_(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PAUSE_GUARDIAN> {
        let v0 = 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::create_multiton_package_pause_guardian_cap(&mut arg0.id, arg2);
        let v1 = 0x2::object::id<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PAUSE_GUARDIAN>>(&v0);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.active_assistants, v1);
        0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_create_package_pause_guardian_cap(0x2::object::id<Config>(arg0), v1);
        v0
    }

    public(friend) fun force_withdraw_pause_ms(arg0: &Config) : u64 {
        arg0.force_withdraw_pause_ms
    }

    fun has_authority<T0>(arg0: &Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T0>) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::for<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T0>(arg1) == 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::package_id()) {
            if (v0 == 0x1::type_name::with_defining_ids<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>()) {
                true
            } else if (v0 == 0x1::type_name::with_defining_ids<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>()) {
                let v2 = 0x2::object::id<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T0>>(arg1);
                0x1::vector::contains<0x2::object::ID>(&arg0.active_assistants, &v2)
            } else {
                false
            }
        } else {
            false
        }
    }

    fun has_maintenance_authority(arg0: &Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::MAINTENANCE>) : bool {
        if (0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::for<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::MAINTENANCE>(arg1) == 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::package_id()) {
            let v1 = 0x2::object::id<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::MAINTENANCE>>(arg1);
            0x1::vector::contains<0x2::object::ID>(&arg0.active_assistants, &v1)
        } else {
            false
        }
    }

    fun has_pause_guardian_authority(arg0: &Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PAUSE_GUARDIAN>) : bool {
        if (0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::for<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PAUSE_GUARDIAN>(arg1) == 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::package_id()) {
            let v1 = 0x2::object::id<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PAUSE_GUARDIAN>>(arg1);
            0x1::vector::contains<0x2::object::ID>(&arg0.active_assistants, &v1)
        } else {
            false
        }
    }

    public(friend) fun has_user_lp_coin_record(arg0: &Config, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_field::exists<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::UserLpCoinRecordKey>(&arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::user_lp_coin_record_key(arg1))
    }

    public(friend) fun has_vault_record(arg0: &Config, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_field::exists<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::VaultRecordKey>(&arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::vault_record_key(arg1))
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

    public(friend) fun package_admin_cap_id(arg0: &Config) : 0x2::object::ID {
        *0x2::dynamic_field::borrow<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::PackageAdminCapIdKey, 0x2::object::ID>(&arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::package_admin_cap_id_key())
    }

    public(friend) fun register_user_lp_coin(arg0: &mut Config, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        assert!(!has_user_lp_coin_record(arg0, arg1), 13836466761606234123);
        let v0 = UserLpCoinRecord{
            user_lp_coin_id : arg1,
            vault_id        : arg2,
        };
        0x2::dynamic_field::add<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::UserLpCoinRecordKey, UserLpCoinRecord>(&mut arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::user_lp_coin_record_key(arg1), v0);
    }

    public(friend) fun register_vault(arg0: &mut Config, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64) {
        assert!(!has_vault_record(arg0, arg1), 13836185192140111881);
        let v0 = VaultRecord{
            vault_id          : arg1,
            owner_cap_id      : arg2,
            vault_metadata_id : arg3,
            created_at_ms     : arg4,
        };
        0x2::dynamic_field::add<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::VaultRecordKey, VaultRecord>(&mut arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::vault_record_key(arg1), v0);
    }

    public(friend) fun revoke_package_assistant_cap_(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: 0x2::object::ID) {
        let v0 = &arg0.active_assistants;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(v0, v1) == arg2) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                if (0x1::option::is_some<u64>(&v2)) {
                    0x1::vector::remove<0x2::object::ID>(&mut arg0.active_assistants, 0x1::option::destroy_some<u64>(v2));
                } else {
                    0x1::option::destroy_none<u64>(v2);
                };
                0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_revoke_package_assistant_cap(0x2::object::id<Config>(arg0), arg2);
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun revoke_package_maintenance_cap_(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: 0x2::object::ID) {
        let v0 = &arg0.active_assistants;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(v0, v1) == arg2) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                if (0x1::option::is_some<u64>(&v2)) {
                    0x1::vector::remove<0x2::object::ID>(&mut arg0.active_assistants, 0x1::option::destroy_some<u64>(v2));
                } else {
                    0x1::option::destroy_none<u64>(v2);
                };
                0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_revoke_package_maintenance_cap(0x2::object::id<Config>(arg0), arg2);
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun revoke_package_pause_guardian_cap_(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: 0x2::object::ID) {
        let v0 = &arg0.active_assistants;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(v0, v1) == arg2) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                if (0x1::option::is_some<u64>(&v2)) {
                    0x1::vector::remove<0x2::object::ID>(&mut arg0.active_assistants, 0x1::option::destroy_some<u64>(v2));
                } else {
                    0x1::option::destroy_none<u64>(v2);
                };
                0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::events::emit_revoke_package_pause_guardian_cap(0x2::object::id<Config>(arg0), arg2);
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun set_force_withdraw_pause_ms<T0>(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T0>, arg2: u64) {
        assert_authority_cap_is_valid<T0>(arg0, arg1);
        assert!(arg2 <= arg0.max_force_withdraw_delay, 13835904773725224967);
        arg0.force_withdraw_pause_ms = arg2;
    }

    public fun set_max_assistants_per_vault<T0>(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T0>, arg2: u64) {
        assert_authority_cap_is_valid<T0>(arg0, arg1);
        arg0.max_assistants_per_vault = arg2;
    }

    public fun set_max_force_withdraw_delay<T0>(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T0>, arg2: u64) {
        assert_authority_cap_is_valid<T0>(arg0, arg1);
        assert!(arg0.force_withdraw_pause_ms <= arg2, 13835904477372481543);
        arg0.max_force_withdraw_delay = arg2;
    }

    public fun set_max_lock_period<T0>(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T0>, arg2: u64) {
        assert_authority_cap_is_valid<T0>(arg0, arg1);
        arg0.max_lock_period = arg2;
    }

    public fun set_max_markets_in_vault<T0>(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T0>, arg2: u64) {
        assert_authority_cap_is_valid<T0>(arg0, arg1);
        arg0.max_markets_in_vault = arg2;
    }

    public fun set_max_owner_fee_rate<T0>(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T0>, arg2: u256) {
        assert_authority_cap_is_valid<T0>(arg0, arg1);
        arg0.max_owner_fee_rate = arg2;
    }

    public fun set_max_owner_lock_usd<T0>(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T0>, arg2: u256) {
        assert_authority_cap_is_valid<T0>(arg0, arg1);
        assert!(arg0.min_owner_lock_usd <= arg2, 13835904606221500423);
        arg0.max_owner_lock_usd = arg2;
    }

    public fun set_max_pending_orders_per_position<T0>(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T0>, arg2: u64) {
        assert_authority_cap_is_valid<T0>(arg0, arg1);
        arg0.max_pending_orders_per_position = arg2;
    }

    public fun set_min_deposit_usd<T0>(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T0>, arg2: u256) {
        assert_authority_cap_is_valid<T0>(arg0, arg1);
        arg0.min_deposit_usd = arg2;
    }

    public fun set_min_owner_lock_usd<T0>(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority::PACKAGE, T0>, arg2: u256) {
        assert_authority_cap_is_valid<T0>(arg0, arg1);
        assert!(arg2 <= arg0.max_owner_lock_usd, 13835904563271827463);
        arg0.min_owner_lock_usd = arg2;
    }

    public fun share(arg0: Config) {
        0x2::transfer::share_object<Config>(arg0);
    }

    public(friend) fun unregister_user_lp_coin(arg0: &mut Config, arg1: 0x2::object::ID) {
        assert!(has_user_lp_coin_record(arg0, arg1), 13836748318187454477);
        0x2::dynamic_field::remove<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::UserLpCoinRecordKey, UserLpCoinRecord>(&mut arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::user_lp_coin_record_key(arg1));
    }

    public(friend) fun user_lp_coin_record(arg0: &Config, arg1: 0x2::object::ID) : &UserLpCoinRecord {
        assert_user_lp_coin_record_exists(arg0, arg1);
        0x2::dynamic_field::borrow<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::UserLpCoinRecordKey, UserLpCoinRecord>(&arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::user_lp_coin_record_key(arg1))
    }

    public(friend) fun user_lp_coin_record_user_lp_coin_id(arg0: &UserLpCoinRecord) : 0x2::object::ID {
        arg0.user_lp_coin_id
    }

    public(friend) fun user_lp_coin_record_vault_id(arg0: &UserLpCoinRecord) : 0x2::object::ID {
        arg0.vault_id
    }

    public(friend) fun vault_record(arg0: &Config, arg1: 0x2::object::ID) : &VaultRecord {
        0x2::dynamic_field::borrow<0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::VaultRecordKey, VaultRecord>(&arg0.id, 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::keys::vault_record_key(arg1))
    }

    public(friend) fun vault_record_created_at_ms(arg0: &VaultRecord) : u64 {
        arg0.created_at_ms
    }

    public(friend) fun vault_record_metadata_id(arg0: &VaultRecord) : 0x2::object::ID {
        arg0.vault_metadata_id
    }

    public(friend) fun vault_record_owner_cap_id(arg0: &VaultRecord) : 0x2::object::ID {
        arg0.owner_cap_id
    }

    public(friend) fun vault_record_vault_id(arg0: &VaultRecord) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v7
}

