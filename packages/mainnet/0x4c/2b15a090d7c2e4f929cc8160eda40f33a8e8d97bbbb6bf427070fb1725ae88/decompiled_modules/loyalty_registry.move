module 0x4c2b15a090d7c2e4f929cc8160eda40f33a8e8d97bbbb6bf427070fb1725ae88::loyalty_registry {
    struct LOYALTY_REGISTRY has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        program_version: u64,
    }

    struct LoyaltyRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        admin_cap_id: 0x2::object::ID,
        active_operator_cap_id: 0x2::object::ID,
        active: bool,
        max_discount_bps: u16,
        pass_count: u64,
        terms_hash: vector<u8>,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct LoyaltyPass has store, key {
        id: 0x2::object::UID,
        pass_number: u64,
        registry_id: 0x2::object::ID,
        customer_commitment: vector<u8>,
        distinct_vehicle_count: u8,
        discount_bps: u16,
        level: u8,
        status: u8,
        program_version: u64,
        created_at_ms: u64,
        updated_at_ms: u64,
        reviewed_vehicles: vector<vector<u8>>,
    }

    struct PassMinted has copy, drop {
        registry_id: 0x2::object::ID,
        pass_id: 0x2::object::ID,
        pass_number: u64,
        distinct_vehicle_count: u8,
        discount_bps: u16,
        level: u8,
        timestamp_ms: u64,
    }

    struct RegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        operator_cap_id: 0x2::object::ID,
        version: u64,
        timestamp_ms: u64,
    }

    struct PassUpgraded has copy, drop {
        registry_id: 0x2::object::ID,
        pass_id: 0x2::object::ID,
        distinct_vehicle_count: u8,
        discount_bps: u16,
        level: u8,
        timestamp_ms: u64,
    }

    struct RegistryPaused has copy, drop {
        registry_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct RegistryUnpaused has copy, drop {
        registry_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct OperatorRotated has copy, drop {
        registry_id: 0x2::object::ID,
        previous_operator_cap_id: 0x2::object::ID,
        active_operator_cap_id: 0x2::object::ID,
        program_version: u64,
        timestamp_ms: u64,
    }

    struct TermsUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        version: u64,
        timestamp_ms: u64,
    }

    fun assert_admin(arg0: &LoyaltyRegistry, arg1: &AdminCap) {
        assert!(arg1.registry_id == 0x2::object::id<LoyaltyRegistry>(arg0) && 0x2::object::id<AdminCap>(arg1) == arg0.admin_cap_id, 1);
    }

    fun assert_below_terminal_level(arg0: u8) {
        assert!(arg0 < 5, 8);
    }

    fun assert_commitments(arg0: &vector<u8>, arg1: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32 && 0x1::vector::length<u8>(arg1) == 32, 9);
    }

    fun assert_customer_available(arg0: bool) {
        assert!(!arg0, 5);
    }

    fun assert_operator(arg0: &LoyaltyRegistry, arg1: &OperatorCap) {
        assert!(arg0.active, 3);
        assert!(arg1.registry_id == 0x2::object::id<LoyaltyRegistry>(arg0), 11);
        assert!(arg1.program_version == arg0.version, 4);
        assert!(0x2::object::id<OperatorCap>(arg1) == arg0.active_operator_cap_id, 2);
    }

    fun assert_pass_exists(arg0: bool) {
        assert!(arg0, 7);
    }

    fun assert_vehicle_available(arg0: &vector<vector<u8>>, arg1: &vector<u8>) {
        assert!(!0x1::vector::contains<vector<u8>>(arg0, arg1), 6);
    }

    public fun create_display(arg0: &mut 0x2::display_registry::DisplayRegistry, arg1: &mut 0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) : 0x2::display_registry::DisplayCap<LoyaltyPass> {
        let (v0, v1) = 0x2::display_registry::new_with_publisher<LoyaltyPass>(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = v0;
        0x2::display_registry::set<LoyaltyPass>(&mut v3, &v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"AQFleet Lifetime Loyalty Pass #{pass_number}"));
        0x2::display_registry::set<LoyaltyPass>(&mut v3, &v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"AQFleet lifetime vehicle-rental loyalty status."));
        0x2::display_registry::set<LoyaltyPass>(&mut v3, &v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://aqfleet.com/loyalty"));
        0x2::display_registry::set<LoyaltyPass>(&mut v3, &v2, 0x1::string::utf8(b"level"), 0x1::string::utf8(b"{level}"));
        0x2::display_registry::set<LoyaltyPass>(&mut v3, &v2, 0x1::string::utf8(b"discount_bps"), 0x1::string::utf8(b"{discount_bps}"));
        0x2::display_registry::share<LoyaltyPass>(v3);
        v2
    }

    public fun create_registry(arg0: address, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : AdminCap {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 10);
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = AdminCap{
            id          : 0x2::object::new(arg3),
            registry_id : v1,
        };
        let v3 = OperatorCap{
            id              : 0x2::object::new(arg3),
            registry_id     : v1,
            program_version : 1,
        };
        let v4 = 0x2::clock::timestamp_ms(arg2);
        let v5 = LoyaltyRegistry{
            id                     : v0,
            version                : 1,
            admin_cap_id           : 0x2::object::id<AdminCap>(&v2),
            active_operator_cap_id : 0x2::object::id<OperatorCap>(&v3),
            active                 : true,
            max_discount_bps       : 2500,
            pass_count             : 0,
            terms_hash             : arg1,
            created_at_ms          : v4,
            updated_at_ms          : v4,
        };
        0x2::transfer::transfer<OperatorCap>(v3, arg0);
        let v6 = RegistryCreated{
            registry_id     : v1,
            admin_cap_id    : v5.admin_cap_id,
            operator_cap_id : v5.active_operator_cap_id,
            version         : 1,
            timestamp_ms    : v4,
        };
        0x2::event::emit<RegistryCreated>(v6);
        0x2::transfer::share_object<LoyaltyRegistry>(v5);
        v2
    }

    fun discount_for(arg0: u8) : u16 {
        let v0 = (arg0 as u16) * 500;
        if (v0 > 2500) {
            2500
        } else {
            v0
        }
    }

    fun init(arg0: LOYALTY_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<LOYALTY_REGISTRY>(arg0, arg1);
    }

    public fun mint(arg0: &mut LoyaltyRegistry, arg1: &OperatorCap, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_operator(arg0, arg1);
        assert_commitments(&arg2, &arg3);
        assert_customer_available(0x2::dynamic_object_field::exists<vector<u8>>(&arg0.id, arg2));
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v1, arg3);
        let v2 = LoyaltyPass{
            id                     : 0x2::object::new(arg5),
            pass_number            : arg0.pass_count + 1,
            registry_id            : 0x2::object::id<LoyaltyRegistry>(arg0),
            customer_commitment    : arg2,
            distinct_vehicle_count : 1,
            discount_bps           : 500,
            level                  : 1,
            status                 : 1,
            program_version        : arg0.version,
            created_at_ms          : v0,
            updated_at_ms          : v0,
            reviewed_vehicles      : v1,
        };
        arg0.pass_count = arg0.pass_count + 1;
        arg0.updated_at_ms = v0;
        0x2::dynamic_object_field::add<vector<u8>, LoyaltyPass>(&mut arg0.id, arg2, v2);
        let v3 = PassMinted{
            registry_id            : 0x2::object::id<LoyaltyRegistry>(arg0),
            pass_id                : 0x2::object::id<LoyaltyPass>(&v2),
            pass_number            : arg0.pass_count,
            distinct_vehicle_count : 1,
            discount_bps           : 500,
            level                  : 1,
            timestamp_ms           : v0,
        };
        0x2::event::emit<PassMinted>(v3);
    }

    public fun pause(arg0: &mut LoyaltyRegistry, arg1: &AdminCap, arg2: &0x2::clock::Clock) {
        assert_admin(arg0, arg1);
        arg0.active = false;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg2);
        let v0 = RegistryPaused{
            registry_id  : 0x2::object::id<LoyaltyRegistry>(arg0),
            timestamp_ms : arg0.updated_at_ms,
        };
        0x2::event::emit<RegistryPaused>(v0);
    }

    public fun rotate_operator(arg0: &mut LoyaltyRegistry, arg1: &AdminCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = OperatorCap{
            id              : 0x2::object::new(arg4),
            registry_id     : 0x2::object::id<LoyaltyRegistry>(arg0),
            program_version : arg0.version,
        };
        arg0.active_operator_cap_id = 0x2::object::id<OperatorCap>(&v0);
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg3);
        let v1 = OperatorRotated{
            registry_id              : 0x2::object::id<LoyaltyRegistry>(arg0),
            previous_operator_cap_id : arg0.active_operator_cap_id,
            active_operator_cap_id   : arg0.active_operator_cap_id,
            program_version          : arg0.version,
            timestamp_ms             : arg0.updated_at_ms,
        };
        0x2::event::emit<OperatorRotated>(v1);
        0x2::transfer::transfer<OperatorCap>(v0, arg2);
    }

    public fun unpause(arg0: &mut LoyaltyRegistry, arg1: &AdminCap, arg2: &0x2::clock::Clock) {
        assert_admin(arg0, arg1);
        arg0.active = true;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg2);
        let v0 = RegistryUnpaused{
            registry_id  : 0x2::object::id<LoyaltyRegistry>(arg0),
            timestamp_ms : arg0.updated_at_ms,
        };
        0x2::event::emit<RegistryUnpaused>(v0);
    }

    public fun update_terms(arg0: &mut LoyaltyRegistry, arg1: &AdminCap, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        assert_admin(arg0, arg1);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 10);
        arg0.terms_hash = arg2;
        arg0.version = arg0.version + 1;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg3);
        let v0 = TermsUpdated{
            registry_id  : 0x2::object::id<LoyaltyRegistry>(arg0),
            version      : arg0.version,
            timestamp_ms : arg0.updated_at_ms,
        };
        0x2::event::emit<TermsUpdated>(v0);
    }

    public fun upgrade(arg0: &mut LoyaltyRegistry, arg1: &OperatorCap, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        assert_operator(arg0, arg1);
        assert_commitments(&arg2, &arg3);
        let v0 = 0x2::object::id<LoyaltyRegistry>(arg0);
        assert_pass_exists(0x2::dynamic_object_field::exists<vector<u8>>(&arg0.id, arg2));
        let v1 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, LoyaltyPass>(&mut arg0.id, arg2);
        assert!(v1.registry_id == v0, 11);
        assert_vehicle_available(&v1.reviewed_vehicles, &arg3);
        assert_below_terminal_level(v1.distinct_vehicle_count);
        0x1::vector::push_back<vector<u8>>(&mut v1.reviewed_vehicles, arg3);
        v1.distinct_vehicle_count = v1.distinct_vehicle_count + 1;
        v1.discount_bps = discount_for(v1.distinct_vehicle_count);
        v1.level = v1.distinct_vehicle_count;
        v1.updated_at_ms = 0x2::clock::timestamp_ms(arg4);
        arg0.updated_at_ms = v1.updated_at_ms;
        let v2 = PassUpgraded{
            registry_id            : v0,
            pass_id                : 0x2::object::id<LoyaltyPass>(v1),
            distinct_vehicle_count : v1.distinct_vehicle_count,
            discount_bps           : v1.discount_bps,
            level                  : v1.level,
            timestamp_ms           : v1.updated_at_ms,
        };
        0x2::event::emit<PassUpgraded>(v2);
    }

    // decompiled from Move bytecode v7
}

