module 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury {
    struct Treasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        controllers: 0x2::table::Table<address, 0x2::object::ID>,
        mint_allowances: 0x2::table::Table<0x2::object::ID, 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::mint_allowance::MintAllowance<T0>>,
        roles: 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::roles::Roles<T0>,
        compatible_versions: 0x2::vec_set::VecSet<u64>,
    }

    struct MintCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DenyCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MintCapCreated<phantom T0> has copy, drop {
        mint_cap: 0x2::object::ID,
    }

    struct ControllerConfigured<phantom T0> has copy, drop {
        controller: address,
        mint_cap: 0x2::object::ID,
    }

    struct ControllerRemoved<phantom T0> has copy, drop {
        controller: address,
    }

    struct MinterConfigured<phantom T0> has copy, drop {
        controller: address,
        mint_cap: 0x2::object::ID,
        allowance: u64,
    }

    struct MinterRemoved<phantom T0> has copy, drop {
        controller: address,
        mint_cap: 0x2::object::ID,
    }

    struct MinterAllowanceIncremented<phantom T0> has copy, drop {
        controller: address,
        mint_cap: 0x2::object::ID,
        allowance_increment: u64,
        new_allowance: u64,
    }

    struct Mint<phantom T0> has copy, drop {
        mint_cap: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    struct Burn<phantom T0> has copy, drop {
        mint_cap: 0x2::object::ID,
        amount: u64,
    }

    struct Blocklisted<phantom T0> has copy, drop {
        address: address,
    }

    struct Unblocklisted<phantom T0> has copy, drop {
        address: address,
    }

    struct Pause<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    struct Unpause<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    struct MetadataUpdated<phantom T0> has copy, drop {
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
        description: 0x1::string::String,
        icon_url: 0x1::ascii::String,
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

    public fun burn<T0>(arg0: &mut Treasury<T0>, arg1: &MintCap<T0>, arg2: &0x2::deny_list::DenyList, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::tx_context::TxContext) {
        assert_is_compatible<T0>(arg0);
        assert!(!0x2::coin::deny_list_v2_is_global_pause_enabled_next_epoch<T0>(arg2), 9);
        assert!(!0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg2, 0x2::tx_context::sender(arg4)), 1);
        let v0 = 0x2::object::id<MintCap<T0>>(arg1);
        assert!(is_authorized_mint_cap<T0>(arg0, v0), 11);
        let v1 = 0x2::coin::value<T0>(&arg3);
        assert!(v1 > 0, 12);
        0x2::coin::burn<T0>(borrow_treasury_cap_mut<T0>(arg0), arg3);
        let v2 = Burn<T0>{
            mint_cap : v0,
            amount   : v1,
        };
        0x2::event::emit<Burn<T0>>(v2);
    }

    public fun total_supply<T0>(arg0: &Treasury<T0>) : u64 {
        0x2::coin::total_supply<T0>(borrow_treasury_cap<T0>(arg0))
    }

    public fun new<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::DenyCapV2<T0>, arg2: address, arg3: address, arg4: address, arg5: address, arg6: address, arg7: &mut 0x2::tx_context::TxContext) : Treasury<T0> {
        let v0 = Treasury<T0>{
            id                  : 0x2::object::new(arg7),
            controllers         : 0x2::table::new<address, 0x2::object::ID>(arg7),
            mint_allowances     : 0x2::table::new<0x2::object::ID, 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::mint_allowance::MintAllowance<T0>>(arg7),
            roles               : 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::roles::new<T0>(arg2, arg3, arg4, arg5, arg6, arg7),
            compatible_versions : 0x2::vec_set::singleton<u64>(0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::version_control::current_version()),
        };
        let v1 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&mut v0.id, v1, arg0);
        let v2 = DenyCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<DenyCapKey, 0x2::coin::DenyCapV2<T0>>(&mut v0.id, v2, arg1);
        v0
    }

    public fun mint_allowance<T0>(arg0: &Treasury<T0>, arg1: 0x2::object::ID) : u64 {
        if (!is_authorized_mint_cap<T0>(arg0, arg1)) {
            return 0
        };
        0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::mint_allowance::value<T0>(0x2::table::borrow<0x2::object::ID, 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::mint_allowance::MintAllowance<T0>>(&arg0.mint_allowances, arg1))
    }

    public fun roles<T0>(arg0: &Treasury<T0>) : &0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::roles::Roles<T0> {
        &arg0.roles
    }

    entry fun abort_migration<T0>(arg0: &mut Treasury<T0>, arg1: &0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::roles::OwnerRole<T0>>(0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::roles::owner_role<T0>(&arg0.roles), arg1);
        assert!(0x2::vec_set::size<u64>(&arg0.compatible_versions) == 2, 101);
        let v0 = 0x1::u64::max(*0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(&arg0.compatible_versions), 0), *0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(&arg0.compatible_versions), 1));
        assert!(v0 == 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::version_control::current_version(), 103);
        0x2::vec_set::remove<u64>(&mut arg0.compatible_versions, &v0);
        let v1 = MigrationAborted<T0>{compatible_versions: *0x2::vec_set::keys<u64>(&arg0.compatible_versions)};
        0x2::event::emit<MigrationAborted<T0>>(v1);
    }

    public(friend) fun assert_deny_cap_exists<T0>(arg0: &Treasury<T0>) {
        let v0 = DenyCapKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_with_type<DenyCapKey, 0x2::coin::DenyCapV2<T0>>(&arg0.id, v0), 2);
    }

    public(friend) fun assert_is_compatible<T0>(arg0: &Treasury<T0>) {
        0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::version_control::assert_object_version_is_compatible_with_package(arg0.compatible_versions);
    }

    public(friend) fun assert_treasury_cap_exists<T0>(arg0: &Treasury<T0>) {
        let v0 = TreasuryCapKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_with_type<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&arg0.id, v0), 10);
    }

    entry fun blocklist<T0>(arg0: &mut Treasury<T0>, arg1: &mut 0x2::deny_list::DenyList, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible<T0>(arg0);
        assert!(0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::roles::blocklister<T0>(&arg0.roles) == 0x2::tx_context::sender(arg3), 4);
        if (!0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg1, arg2)) {
            0x2::coin::deny_list_v2_add<T0>(arg1, borrow_deny_cap_mut<T0>(arg0), arg2, arg3);
        };
        let v0 = Blocklisted<T0>{address: arg2};
        0x2::event::emit<Blocklisted<T0>>(v0);
    }

    fun borrow_deny_cap_mut<T0>(arg0: &mut Treasury<T0>) : &mut 0x2::coin::DenyCapV2<T0> {
        assert_deny_cap_exists<T0>(arg0);
        let v0 = DenyCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<DenyCapKey, 0x2::coin::DenyCapV2<T0>>(&mut arg0.id, v0)
    }

    fun borrow_treasury_cap<T0>(arg0: &Treasury<T0>) : &0x2::coin::TreasuryCap<T0> {
        assert_treasury_cap_exists<T0>(arg0);
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&arg0.id, v0)
    }

    fun borrow_treasury_cap_mut<T0>(arg0: &mut Treasury<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        assert_treasury_cap_exists<T0>(arg0);
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v0)
    }

    public fun compatible_versions<T0>(arg0: &Treasury<T0>) : vector<u64> {
        *0x2::vec_set::keys<u64>(&arg0.compatible_versions)
    }

    entry fun complete_migration<T0>(arg0: &mut Treasury<T0>, arg1: &0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::roles::OwnerRole<T0>>(0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::roles::owner_role<T0>(&arg0.roles), arg1);
        assert!(0x2::vec_set::size<u64>(&arg0.compatible_versions) == 2, 101);
        let v0 = *0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(&arg0.compatible_versions), 0);
        let v1 = *0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(&arg0.compatible_versions), 1);
        let v2 = 0x1::u64::min(v0, v1);
        assert!(0x1::u64::max(v0, v1) == 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::version_control::current_version(), 103);
        0x2::vec_set::remove<u64>(&mut arg0.compatible_versions, &v2);
        let v3 = MigrationCompleted<T0>{compatible_versions: *0x2::vec_set::keys<u64>(&arg0.compatible_versions)};
        0x2::event::emit<MigrationCompleted<T0>>(v3);
    }

    entry fun configure_controller<T0>(arg0: &mut Treasury<T0>, arg1: address, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        assert_is_compatible<T0>(arg0);
        assert!(0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::roles::master_minter<T0>(&arg0.roles) == 0x2::tx_context::sender(arg3), 6);
        assert!(!is_controller<T0>(arg0, arg1), 0);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.controllers, arg1, arg2);
        let v0 = ControllerConfigured<T0>{
            controller : arg1,
            mint_cap   : arg2,
        };
        0x2::event::emit<ControllerConfigured<T0>>(v0);
    }

    entry fun configure_minter<T0>(arg0: &mut Treasury<T0>, arg1: &0x2::deny_list::DenyList, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_is_compatible<T0>(arg0);
        assert!(!0x2::coin::deny_list_v2_is_global_pause_enabled_next_epoch<T0>(arg1), 9);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_controller<T0>(arg0, v0), 5);
        let v1 = get_mint_cap_id<T0>(arg0, v0);
        let v2 = *0x1::option::borrow<0x2::object::ID>(&v1);
        if (!0x2::table::contains<0x2::object::ID, 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::mint_allowance::MintAllowance<T0>>(&arg0.mint_allowances, v2)) {
            let v3 = 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::mint_allowance::new<T0>();
            0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::mint_allowance::set<T0>(&mut v3, arg2);
            0x2::table::add<0x2::object::ID, 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::mint_allowance::MintAllowance<T0>>(&mut arg0.mint_allowances, v2, v3);
        } else {
            0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::mint_allowance::set<T0>(0x2::table::borrow_mut<0x2::object::ID, 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::mint_allowance::MintAllowance<T0>>(&mut arg0.mint_allowances, v2), arg2);
        };
        let v4 = MinterConfigured<T0>{
            controller : v0,
            mint_cap   : v2,
            allowance  : arg2,
        };
        0x2::event::emit<MinterConfigured<T0>>(v4);
    }

    entry fun configure_new_controller<T0>(arg0: &mut Treasury<T0>, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = create_mint_cap<T0>(arg0, arg3);
        configure_controller<T0>(arg0, arg1, 0x2::object::id<MintCap<T0>>(&v0), arg3);
        0x2::transfer::transfer<MintCap<T0>>(v0, arg2);
    }

    fun create_mint_cap<T0>(arg0: &Treasury<T0>, arg1: &mut 0x2::tx_context::TxContext) : MintCap<T0> {
        assert_is_compatible<T0>(arg0);
        assert!(0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::roles::master_minter<T0>(&arg0.roles) == 0x2::tx_context::sender(arg1), 6);
        let v0 = MintCap<T0>{id: 0x2::object::new(arg1)};
        let v1 = MintCapCreated<T0>{mint_cap: 0x2::object::id<MintCap<T0>>(&v0)};
        0x2::event::emit<MintCapCreated<T0>>(v1);
        v0
    }

    public fun get_mint_cap_id<T0>(arg0: &Treasury<T0>, arg1: address) : 0x1::option::Option<0x2::object::ID> {
        if (!0x2::table::contains<address, 0x2::object::ID>(&arg0.controllers, arg1)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        0x1::option::some<0x2::object::ID>(*0x2::table::borrow<address, 0x2::object::ID>(&arg0.controllers, arg1))
    }

    entry fun increment_mint_allowance<T0>(arg0: &mut Treasury<T0>, arg1: &0x2::deny_list::DenyList, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_is_compatible<T0>(arg0);
        assert!(!0x2::coin::deny_list_v2_is_global_pause_enabled_next_epoch<T0>(arg1), 9);
        assert!(arg2 > 0, 12);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_controller<T0>(arg0, v0), 5);
        let v1 = get_mint_cap_id<T0>(arg0, v0);
        let v2 = *0x1::option::borrow<0x2::object::ID>(&v1);
        assert!(is_authorized_mint_cap<T0>(arg0, v2), 11);
        0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::mint_allowance::increase<T0>(0x2::table::borrow_mut<0x2::object::ID, 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::mint_allowance::MintAllowance<T0>>(&mut arg0.mint_allowances, v2), arg2);
        let v3 = MinterAllowanceIncremented<T0>{
            controller          : v0,
            mint_cap            : v2,
            allowance_increment : arg2,
            new_allowance       : 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::mint_allowance::value<T0>(0x2::table::borrow<0x2::object::ID, 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::mint_allowance::MintAllowance<T0>>(&arg0.mint_allowances, v2)),
        };
        0x2::event::emit<MinterAllowanceIncremented<T0>>(v3);
    }

    public fun is_authorized_mint_cap<T0>(arg0: &Treasury<T0>, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::mint_allowance::MintAllowance<T0>>(&arg0.mint_allowances, arg1)
    }

    fun is_controller<T0>(arg0: &Treasury<T0>, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.controllers, arg1)
    }

    public fun mint<T0>(arg0: &mut Treasury<T0>, arg1: &MintCap<T0>, arg2: &0x2::deny_list::DenyList, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible<T0>(arg0);
        assert!(!0x2::coin::deny_list_v2_is_global_pause_enabled_next_epoch<T0>(arg2), 9);
        assert!(!0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg2, 0x2::tx_context::sender(arg5)), 1);
        assert!(!0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg2, arg4), 1);
        let v0 = 0x2::object::id<MintCap<T0>>(arg1);
        assert!(is_authorized_mint_cap<T0>(arg0, v0), 11);
        assert!(arg3 > 0, 12);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::mint_allowance::MintAllowance<T0>>(&mut arg0.mint_allowances, v0);
        assert!(0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::mint_allowance::value<T0>(v1) >= arg3, 3);
        0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::mint_allowance::decrease<T0>(v1, arg3);
        0x2::coin::mint_and_transfer<T0>(borrow_treasury_cap_mut<T0>(arg0), arg3, arg4, arg5);
        let v2 = Mint<T0>{
            mint_cap  : v0,
            recipient : arg4,
            amount    : arg3,
        };
        0x2::event::emit<Mint<T0>>(v2);
    }

    entry fun pause<T0>(arg0: &mut Treasury<T0>, arg1: &mut 0x2::deny_list::DenyList, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible<T0>(arg0);
        assert!(0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::roles::pauser<T0>(&arg0.roles) == 0x2::tx_context::sender(arg2), 8);
        let v0 = borrow_deny_cap_mut<T0>(arg0);
        if (!0x2::coin::deny_list_v2_is_global_pause_enabled_next_epoch<T0>(arg1)) {
            0x2::coin::deny_list_v2_enable_global_pause<T0>(arg1, v0, arg2);
        };
        let v1 = Pause<T0>{dummy_field: false};
        0x2::event::emit<Pause<T0>>(v1);
    }

    entry fun remove_controller<T0>(arg0: &mut Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_is_compatible<T0>(arg0);
        assert!(0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::roles::master_minter<T0>(&arg0.roles) == 0x2::tx_context::sender(arg2), 6);
        assert!(is_controller<T0>(arg0, arg1), 5);
        0x2::table::remove<address, 0x2::object::ID>(&mut arg0.controllers, arg1);
        let v0 = ControllerRemoved<T0>{controller: arg1};
        0x2::event::emit<ControllerRemoved<T0>>(v0);
    }

    entry fun remove_minter<T0>(arg0: &mut Treasury<T0>, arg1: &0x2::tx_context::TxContext) {
        assert_is_compatible<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(is_controller<T0>(arg0, v0), 5);
        let v1 = get_mint_cap_id<T0>(arg0, v0);
        let v2 = *0x1::option::borrow<0x2::object::ID>(&v1);
        0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::mint_allowance::destroy<T0>(0x2::table::remove<0x2::object::ID, 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::mint_allowance::MintAllowance<T0>>(&mut arg0.mint_allowances, v2));
        let v3 = MinterRemoved<T0>{
            controller : v0,
            mint_cap   : v2,
        };
        0x2::event::emit<MinterRemoved<T0>>(v3);
    }

    public(friend) fun roles_mut<T0>(arg0: &mut Treasury<T0>) : &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::roles::Roles<T0> {
        &mut arg0.roles
    }

    entry fun start_migration<T0>(arg0: &mut Treasury<T0>, arg1: &0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::roles::OwnerRole<T0>>(0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::roles::owner_role<T0>(&arg0.roles), arg1);
        assert!(0x2::vec_set::size<u64>(&arg0.compatible_versions) == 1, 100);
        assert!(*0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(&arg0.compatible_versions), 0) < 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::version_control::current_version(), 102);
        0x2::vec_set::insert<u64>(&mut arg0.compatible_versions, 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::version_control::current_version());
        let v0 = MigrationStarted<T0>{compatible_versions: *0x2::vec_set::keys<u64>(&arg0.compatible_versions)};
        0x2::event::emit<MigrationStarted<T0>>(v0);
    }

    entry fun unblocklist<T0>(arg0: &mut Treasury<T0>, arg1: &mut 0x2::deny_list::DenyList, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible<T0>(arg0);
        assert!(0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::roles::blocklister<T0>(&arg0.roles) == 0x2::tx_context::sender(arg3), 4);
        if (0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg1, arg2)) {
            0x2::coin::deny_list_v2_remove<T0>(arg1, borrow_deny_cap_mut<T0>(arg0), arg2, arg3);
        };
        let v0 = Unblocklisted<T0>{address: arg2};
        0x2::event::emit<Unblocklisted<T0>>(v0);
    }

    entry fun unpause<T0>(arg0: &mut Treasury<T0>, arg1: &mut 0x2::deny_list::DenyList, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible<T0>(arg0);
        assert!(0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::roles::pauser<T0>(roles<T0>(arg0)) == 0x2::tx_context::sender(arg2), 8);
        let v0 = borrow_deny_cap_mut<T0>(arg0);
        if (0x2::coin::deny_list_v2_is_global_pause_enabled_next_epoch<T0>(arg1)) {
            0x2::coin::deny_list_v2_disable_global_pause<T0>(arg1, v0, arg2);
        };
        let v1 = Unpause<T0>{dummy_field: false};
        0x2::event::emit<Unpause<T0>>(v1);
    }

    entry fun update_metadata<T0>(arg0: &Treasury<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::ascii::String, arg6: &0x2::tx_context::TxContext) {
        assert_is_compatible<T0>(arg0);
        assert!(0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::roles::metadata_updater<T0>(&arg0.roles) == 0x2::tx_context::sender(arg6), 7);
        0x2::coin::update_name<T0>(borrow_treasury_cap<T0>(arg0), arg1, arg2);
        0x2::coin::update_symbol<T0>(borrow_treasury_cap<T0>(arg0), arg1, arg3);
        0x2::coin::update_description<T0>(borrow_treasury_cap<T0>(arg0), arg1, arg4);
        0x2::coin::update_icon_url<T0>(borrow_treasury_cap<T0>(arg0), arg1, arg5);
        let v0 = MetadataUpdated<T0>{
            name        : arg2,
            symbol      : arg3,
            description : arg4,
            icon_url    : arg5,
        };
        0x2::event::emit<MetadataUpdated<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

