module 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::treasury {
    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PolicyCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ToCoinCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct FromCoinCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct ToCoinCapCreated<phantom T0> has copy, drop {
        to_coin_cap: 0x2::object::ID,
    }

    struct FromCoinCapCreated<phantom T0> has copy, drop {
        from_coin_cap: 0x2::object::ID,
    }

    struct MigrationStarted<phantom T0> has copy, drop {
        compatible_versions: vector<u64>,
    }

    struct MigrationAborted<phantom T0> has copy, drop {
        compatible_versions: vector<u64>,
    }

    struct MigrationCompleted<phantom T0> has copy, drop {
        compatible_versions: vector<u64>,
    }

    struct Treasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        roles: 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::lk_roles::Roles<T0>,
        active_authorizations: 0x2::table::Table<0x2::object::ID, bool>,
        compatible_versions: 0x2::vec_set::VecSet<u64>,
    }

    public fun new<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::token::TokenPolicyCap<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : Treasury<T0> {
        let v0 = Treasury<T0>{
            id                    : 0x2::object::new(arg3),
            roles                 : 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::lk_roles::new<T0>(arg2, arg3),
            active_authorizations : 0x2::table::new<0x2::object::ID, bool>(arg3),
            compatible_versions   : 0x2::vec_set::singleton<u64>(0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::token_version_control::current_version()),
        };
        let v1 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&mut v0.id, v1, arg0);
        let v2 = PolicyCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<PolicyCapKey, 0x2::token::TokenPolicyCap<T0>>(&mut v0.id, v2, arg1);
        v0
    }

    public fun from_coin<T0>(arg0: &Treasury<T0>, arg1: &FromCoinCap<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<T0> {
        assert_is_compatible<T0>(arg0);
        assert_active_auth<T0>(arg0, 0x2::object::id<FromCoinCap<T0>>(arg1));
        let (v0, v1) = 0x2::token::from_coin<T0>(arg2, arg3);
        let (_, _, _, _) = 0x2::token::confirm_with_policy_cap<T0>(policy_cap_ref<T0>(arg0), v1, arg3);
        v0
    }

    public fun to_coin<T0>(arg0: &Treasury<T0>, arg1: &ToCoinCap<T0>, arg2: 0x2::token::Token<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_is_compatible<T0>(arg0);
        assert_active_auth<T0>(arg0, 0x2::object::id<ToCoinCap<T0>>(arg1));
        let (v0, v1) = 0x2::token::to_coin<T0>(arg2, arg3);
        let (_, _, _, _) = 0x2::token::confirm_with_policy_cap<T0>(policy_cap_ref<T0>(arg0), v1, arg3);
        v0
    }

    public fun abort_migration<T0>(arg0: &mut Treasury<T0>, arg1: &0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::lk_roles::OwnerRole<T0>>(0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::lk_roles::owner_role<T0>(&arg0.roles), arg1);
        assert!(0x2::vec_set::size<u64>(&arg0.compatible_versions) == 2, 4);
        let v0 = 0x1::u64::max(*0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(&arg0.compatible_versions), 0), *0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(&arg0.compatible_versions), 1));
        assert!(v0 == 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::token_version_control::current_version(), 6);
        0x2::vec_set::remove<u64>(&mut arg0.compatible_versions, &v0);
        let v1 = MigrationAborted<T0>{compatible_versions: *0x2::vec_set::keys<u64>(&arg0.compatible_versions)};
        0x2::event::emit<MigrationAborted<T0>>(v1);
    }

    public fun accept_ownership<T0>(arg0: &mut Treasury<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::lk_roles::pending_owner<T0>(&arg0.roles);
        let v1 = if (0x1::option::is_some<address>(&v0)) {
            let v2 = 0x2::tx_context::sender(arg1);
            0x1::option::borrow<address>(&v0) == &v2
        } else {
            false
        };
        assert!(v1, 1);
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::accept_role<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::lk_roles::OwnerRole<T0>>(0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::lk_roles::owner_role_mut<T0>(&mut arg0.roles), arg1);
    }

    public fun assert_active_auth<T0>(arg0: &Treasury<T0>, arg1: 0x2::object::ID) {
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg0.active_authorizations, arg1) && *0x2::table::borrow<0x2::object::ID, bool>(&arg0.active_authorizations, arg1), 2);
    }

    public(friend) fun assert_is_compatible<T0>(arg0: &Treasury<T0>) {
        0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::token_version_control::assert_object_version_is_compatible_with_package(arg0.compatible_versions);
    }

    public fun compatible_versions<T0>(arg0: &Treasury<T0>) : vector<u64> {
        *0x2::vec_set::keys<u64>(&arg0.compatible_versions)
    }

    public fun complete_migration<T0>(arg0: &mut Treasury<T0>, arg1: &0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::lk_roles::OwnerRole<T0>>(0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::lk_roles::owner_role<T0>(&arg0.roles), arg1);
        assert!(0x2::vec_set::size<u64>(&arg0.compatible_versions) == 2, 4);
        let v0 = *0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(&arg0.compatible_versions), 0);
        let v1 = *0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(&arg0.compatible_versions), 1);
        let v2 = 0x1::u64::min(v0, v1);
        assert!(0x1::u64::max(v0, v1) == 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::token_version_control::current_version(), 6);
        0x2::vec_set::remove<u64>(&mut arg0.compatible_versions, &v2);
        let v3 = MigrationCompleted<T0>{compatible_versions: *0x2::vec_set::keys<u64>(&arg0.compatible_versions)};
        0x2::event::emit<MigrationCompleted<T0>>(v3);
    }

    fun create_from_coin_cap<T0>(arg0: &mut Treasury<T0>, arg1: &mut 0x2::tx_context::TxContext) : FromCoinCap<T0> {
        assert!(0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::lk_roles::owner<T0>(&arg0.roles) == 0x2::tx_context::sender(arg1), 1);
        let v0 = FromCoinCap<T0>{id: 0x2::object::new(arg1)};
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.active_authorizations, 0x2::object::id<FromCoinCap<T0>>(&v0), true);
        let v1 = FromCoinCapCreated<T0>{from_coin_cap: 0x2::object::id<FromCoinCap<T0>>(&v0)};
        0x2::event::emit<FromCoinCapCreated<T0>>(v1);
        v0
    }

    fun create_to_coin_cap<T0>(arg0: &mut Treasury<T0>, arg1: &mut 0x2::tx_context::TxContext) : ToCoinCap<T0> {
        assert!(0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::lk_roles::owner<T0>(&arg0.roles) == 0x2::tx_context::sender(arg1), 1);
        let v0 = ToCoinCap<T0>{id: 0x2::object::new(arg1)};
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.active_authorizations, 0x2::object::id<ToCoinCap<T0>>(&v0), true);
        let v1 = ToCoinCapCreated<T0>{to_coin_cap: 0x2::object::id<ToCoinCap<T0>>(&v0)};
        0x2::event::emit<ToCoinCapCreated<T0>>(v1);
        v0
    }

    public fun current_active_version<T0>(arg0: &Treasury<T0>) : u64 {
        let v0 = 0x2::vec_set::keys<u64>(&arg0.compatible_versions);
        if (0x1::vector::length<u64>(v0) == 1) {
            *0x1::vector::borrow<u64>(v0, 0)
        } else {
            0x1::u64::min(*0x1::vector::borrow<u64>(v0, 0), *0x1::vector::borrow<u64>(v0, 1))
        }
    }

    public fun is_migration_in_progress<T0>(arg0: &Treasury<T0>) : bool {
        0x2::vec_set::size<u64>(&arg0.compatible_versions) > 1
    }

    public fun mint_coin_to_receiver<T0>(arg0: &mut Treasury<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible<T0>(arg0);
        assert!(0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::lk_roles::owner<T0>(&arg0.roles) == 0x2::tx_context::sender(arg3), 1);
        0x2::coin::mint_and_transfer<T0>(treasury_mut_cap_ref<T0>(arg0), arg1, arg2, arg3);
    }

    public fun pending_version<T0>(arg0: &Treasury<T0>) : 0x1::option::Option<u64> {
        if (0x2::vec_set::size<u64>(&arg0.compatible_versions) == 2) {
            let v1 = 0x2::vec_set::keys<u64>(&arg0.compatible_versions);
            0x1::option::some<u64>(0x1::u64::max(*0x1::vector::borrow<u64>(v1, 0), *0x1::vector::borrow<u64>(v1, 1)))
        } else {
            0x1::option::none<u64>()
        }
    }

    fun policy_cap_ref<T0>(arg0: &Treasury<T0>) : &0x2::token::TokenPolicyCap<T0> {
        let v0 = PolicyCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<PolicyCapKey, 0x2::token::TokenPolicyCap<T0>>(&arg0.id, v0)
    }

    public fun revoke_authorization<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::lk_roles::owner<T0>(&arg0.roles) == 0x2::tx_context::sender(arg2), 1);
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg0.active_authorizations, arg1), 7);
        0x2::table::remove<0x2::object::ID, bool>(&mut arg0.active_authorizations, arg1);
    }

    public fun start_migration<T0>(arg0: &mut Treasury<T0>, arg1: &0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::lk_roles::OwnerRole<T0>>(0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::lk_roles::owner_role<T0>(&arg0.roles), arg1);
        assert!(0x2::vec_set::size<u64>(&arg0.compatible_versions) == 1, 3);
        assert!(*0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(&arg0.compatible_versions), 0) < 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::token_version_control::current_version(), 5);
        0x2::vec_set::insert<u64>(&mut arg0.compatible_versions, 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::token_version_control::current_version());
        let v0 = MigrationStarted<T0>{compatible_versions: *0x2::vec_set::keys<u64>(&arg0.compatible_versions)};
        0x2::event::emit<MigrationStarted<T0>>(v0);
    }

    public fun transfer_from_coin<T0>(arg0: &mut Treasury<T0>, arg1: address, arg2: &FromCoinCap<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible<T0>(arg0);
        let v0 = from_coin<T0>(arg0, arg2, arg3, arg4);
        let (_, _, _, _) = 0x2::token::confirm_with_policy_cap<T0>(policy_cap_ref<T0>(arg0), 0x2::token::transfer<T0>(v0, arg1, arg4), arg4);
    }

    public fun transfer_from_coin_cap<T0>(arg0: &mut Treasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible<T0>(arg0);
        0x2::transfer::transfer<FromCoinCap<T0>>(create_from_coin_cap<T0>(arg0, arg2), arg1);
    }

    public fun transfer_ownership<T0>(arg0: &mut Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::lk_roles::owner<T0>(&arg0.roles) == 0x2::tx_context::sender(arg2), 1);
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::begin_role_transfer<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::lk_roles::OwnerRole<T0>>(0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::lk_roles::owner_role_mut<T0>(&mut arg0.roles), arg1, arg2);
    }

    public fun transfer_to_coin_cap<T0>(arg0: &mut Treasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible<T0>(arg0);
        0x2::transfer::transfer<ToCoinCap<T0>>(create_to_coin_cap<T0>(arg0, arg2), arg1);
    }

    fun treasury_cap_ref<T0>(arg0: &Treasury<T0>) : &0x2::coin::TreasuryCap<T0> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&arg0.id, v0)
    }

    fun treasury_mut_cap_ref<T0>(arg0: &mut Treasury<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v0)
    }

    // decompiled from Move bytecode v6
}

