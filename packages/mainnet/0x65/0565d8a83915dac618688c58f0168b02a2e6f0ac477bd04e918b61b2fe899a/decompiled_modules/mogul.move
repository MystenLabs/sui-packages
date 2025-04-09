module 0x650565d8a83915dac618688c58f0168b02a2e6f0ac477bd04e918b61b2fe899a::mogul {
    struct MOGUL has drop {
        dummy_field: bool,
    }

    struct MogulCentral has store, key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u64>,
        managers: 0x2::vec_set::VecSet<address>,
        mogul_teams: 0x2::table::Table<address, MogulTeam>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MogulEntityKey has copy, drop, store {
        entity_name: 0x1::string::String,
        entity_type: 0x1::string::String,
    }

    struct MogulsExchange has store, key {
        id: 0x2::object::UID,
        entity_cost: 0x2::table::Table<MogulEntityKey, u64>,
    }

    struct MogulTeam has store, key {
        id: 0x2::object::UID,
        team_members: 0x2::vec_set::VecSet<MogulEntityKey>,
        budget: u64,
    }

    struct TeamCreatedEvent has copy, drop {
        mogul_address: address,
        starting_budget: u64,
    }

    struct TeamBudgetAddedEvent has copy, drop {
        mogul_address: address,
        budget_added: u64,
    }

    struct TeamModifiedEvent has copy, drop {
        mogul_address: address,
        entity_cost: u64,
        entity_name: 0x1::string::String,
        entity_type: 0x1::string::String,
        is_buy: bool,
    }

    struct EntityValueSetEvent has copy, drop {
        entity_name: 0x1::string::String,
        entity_type: 0x1::string::String,
        entity_cost: u64,
    }

    public fun add_budget(arg0: &mut MogulCentral, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        assert_valid_manager(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::table::borrow_mut<address, MogulTeam>(&mut arg0.mogul_teams, arg1);
        v0.budget = arg2 + v0.budget;
        let v1 = TeamBudgetAddedEvent{
            mogul_address : arg1,
            budget_added  : arg2,
        };
        0x2::event::emit<TeamBudgetAddedEvent>(v1);
    }

    public fun add_manager(arg0: &mut MogulCentral, arg1: &AdminCap, arg2: address) {
        assert_valid_version(arg0);
        0x2::vec_set::insert<address>(&mut arg0.managers, arg2);
    }

    public fun add_version(arg0: &mut MogulCentral, arg1: &AdminCap, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.version_set, arg2);
    }

    fun assert_valid_manager(arg0: &MogulCentral, arg1: address) {
        if (!0x2::vec_set::contains<address>(&arg0.managers, &arg1)) {
            err_invalid_manager();
        };
    }

    fun assert_valid_version(arg0: &MogulCentral) {
        let v0 = package_version();
        if (!0x2::vec_set::contains<u64>(&arg0.version_set, &v0)) {
            err_invalid_version();
        };
    }

    public fun buy_entity(arg0: &mut MogulCentral, arg1: &MogulsExchange, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        assert_valid_manager(arg0, 0x2::tx_context::sender(arg5));
        let v0 = MogulEntityKey{
            entity_name : arg3,
            entity_type : arg4,
        };
        let v1 = 0x2::table::borrow_mut<address, MogulTeam>(&mut arg0.mogul_teams, arg2);
        let v2 = *0x2::table::borrow<MogulEntityKey, u64>(&arg1.entity_cost, v0);
        if (v2 > v1.budget) {
            err_insufficient_budget();
        };
        if (0x2::vec_set::contains<MogulEntityKey>(&v1.team_members, &v0)) {
            err_entity_already_owned();
        };
        v1.budget = v1.budget - v2;
        0x2::vec_set::insert<MogulEntityKey>(&mut v1.team_members, v0);
        let v3 = TeamModifiedEvent{
            mogul_address : arg2,
            entity_cost   : v2,
            entity_name   : arg3,
            entity_type   : arg4,
            is_buy        : true,
        };
        0x2::event::emit<TeamModifiedEvent>(v3);
    }

    public fun create_mogul_team(arg0: &mut MogulCentral, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        assert_valid_manager(arg0, 0x2::tx_context::sender(arg3));
        let v0 = MogulTeam{
            id           : 0x2::object::new(arg3),
            team_members : 0x2::vec_set::empty<MogulEntityKey>(),
            budget       : arg2,
        };
        0x2::table::add<address, MogulTeam>(&mut arg0.mogul_teams, arg1, v0);
        let v1 = TeamCreatedEvent{
            mogul_address   : arg1,
            starting_budget : arg2,
        };
        0x2::event::emit<TeamCreatedEvent>(v1);
    }

    fun err_entity_already_owned() {
        abort 4
    }

    fun err_entity_not_owned() {
        abort 5
    }

    fun err_insufficient_budget() {
        abort 3
    }

    fun err_invalid_manager() {
        abort 1
    }

    fun err_invalid_version() {
        abort 2
    }

    fun init(arg0: MOGUL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<MOGUL>(arg0, arg1);
        let v0 = MogulCentral{
            id          : 0x2::object::new(arg1),
            version_set : 0x2::vec_set::empty<u64>(),
            managers    : 0x2::vec_set::empty<address>(),
            mogul_teams : 0x2::table::new<address, MogulTeam>(arg1),
        };
        0x2::transfer::public_transfer<MogulCentral>(v0, 0x2::tx_context::sender(arg1));
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun package_version() : u64 {
        1
    }

    public fun remove_manager(arg0: &mut MogulCentral, arg1: &AdminCap, arg2: address) {
        assert_valid_version(arg0);
        0x2::vec_set::remove<address>(&mut arg0.managers, &arg2);
    }

    public fun remove_version(arg0: &mut MogulCentral, arg1: &AdminCap, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg0.version_set, &arg2);
    }

    public fun sell_entity(arg0: &mut MogulCentral, arg1: &MogulsExchange, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        assert_valid_manager(arg0, 0x2::tx_context::sender(arg5));
        let v0 = MogulEntityKey{
            entity_name : arg3,
            entity_type : arg4,
        };
        let v1 = 0x2::table::borrow_mut<address, MogulTeam>(&mut arg0.mogul_teams, arg2);
        let v2 = *0x2::table::borrow<MogulEntityKey, u64>(&arg1.entity_cost, v0);
        if (!0x2::vec_set::contains<MogulEntityKey>(&v1.team_members, &v0)) {
            err_entity_not_owned();
        };
        v1.budget = v1.budget + v2;
        0x2::vec_set::remove<MogulEntityKey>(&mut v1.team_members, &v0);
        let v3 = TeamModifiedEvent{
            mogul_address : arg2,
            entity_cost   : v2,
            entity_name   : arg3,
            entity_type   : arg4,
            is_buy        : false,
        };
        0x2::event::emit<TeamModifiedEvent>(v3);
    }

    public fun set_mogul_entity_cost(arg0: &mut MogulCentral, arg1: &mut MogulsExchange, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        assert_valid_manager(arg0, 0x2::tx_context::sender(arg5));
        let v0 = MogulEntityKey{
            entity_name : arg2,
            entity_type : arg3,
        };
        if (0x2::table::contains<MogulEntityKey, u64>(&arg1.entity_cost, v0)) {
            0x2::table::remove<MogulEntityKey, u64>(&mut arg1.entity_cost, v0);
        };
        0x2::table::add<MogulEntityKey, u64>(&mut arg1.entity_cost, v0, arg4);
        let v1 = EntityValueSetEvent{
            entity_name : arg2,
            entity_type : arg3,
            entity_cost : arg4,
        };
        0x2::event::emit<EntityValueSetEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

