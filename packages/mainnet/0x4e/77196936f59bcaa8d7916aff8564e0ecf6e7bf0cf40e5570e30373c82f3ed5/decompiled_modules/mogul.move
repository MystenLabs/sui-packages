module 0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::mogul {
    struct MOGUL has drop {
        dummy_field: bool,
    }

    struct MogulCentral has store, key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u64>,
        managers: 0x2::vec_set::VecSet<address>,
        mogul_studios: 0x2::table::Table<address, MogulStudio>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MogulEntityKey has copy, drop, store {
        imdb_id: 0x1::string::String,
        name: 0x1::string::String,
        entity_type: 0x1::string::String,
    }

    struct MogulsExchange has store, key {
        id: 0x2::object::UID,
        entity_cost: 0x2::table::Table<MogulEntityKey, u64>,
    }

    struct MogulStudio has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        entities: 0x2::vec_set::VecSet<MogulEntityKey>,
        budget: u64,
    }

    struct StudioCreatedEvent has copy, drop {
        mogul_address: address,
        studio_name: 0x1::string::String,
        starting_budget: u64,
    }

    struct StudioBudgetAddedEvent has copy, drop {
        mogul_address: address,
        studio_name: 0x1::string::String,
        budget_added: u64,
    }

    struct StudioModifiedEvent has copy, drop {
        mogul_address: address,
        studio_name: 0x1::string::String,
        entity_cost: u64,
        imdb_id: 0x1::string::String,
        name: 0x1::string::String,
        entity_type: 0x1::string::String,
        is_buy: bool,
    }

    struct EntityValueSetEvent has copy, drop {
        imdb_id: 0x1::string::String,
        name: 0x1::string::String,
        entity_type: 0x1::string::String,
        entity_cost: u64,
    }

    public fun add_budget(arg0: &mut MogulCentral, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        assert_valid_manager(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::table::borrow_mut<address, MogulStudio>(&mut arg0.mogul_studios, arg1);
        v0.budget = arg2 + v0.budget;
        let v1 = StudioBudgetAddedEvent{
            mogul_address : arg1,
            studio_name   : v0.name,
            budget_added  : arg2,
        };
        0x2::event::emit<StudioBudgetAddedEvent>(v1);
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

    public(friend) fun assert_valid_manager_package(arg0: &MogulCentral, arg1: address) {
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

    public(friend) fun assert_valid_version_package(arg0: &MogulCentral) {
        let v0 = package_version();
        if (!0x2::vec_set::contains<u64>(&arg0.version_set, &v0)) {
            err_invalid_version();
        };
    }

    public fun buy_entity(arg0: &mut MogulCentral, arg1: &MogulsExchange, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        assert_valid_manager(arg0, 0x2::tx_context::sender(arg6));
        let v0 = MogulEntityKey{
            imdb_id     : arg3,
            name        : arg4,
            entity_type : arg5,
        };
        let v1 = 0x2::table::borrow_mut<address, MogulStudio>(&mut arg0.mogul_studios, arg2);
        let v2 = *0x2::table::borrow<MogulEntityKey, u64>(&arg1.entity_cost, v0);
        if (v2 > v1.budget) {
            err_insufficient_budget();
        };
        if (0x2::vec_set::contains<MogulEntityKey>(&v1.entities, &v0)) {
            err_entity_already_owned();
        };
        v1.budget = v1.budget - v2;
        0x2::vec_set::insert<MogulEntityKey>(&mut v1.entities, v0);
        let v3 = StudioModifiedEvent{
            mogul_address : arg2,
            studio_name   : v1.name,
            entity_cost   : v2,
            imdb_id       : arg3,
            name          : arg4,
            entity_type   : arg5,
            is_buy        : true,
        };
        0x2::event::emit<StudioModifiedEvent>(v3);
    }

    public fun buy_entity_cost_check(arg0: &mut MogulCentral, arg1: &MogulsExchange, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = MogulEntityKey{
            imdb_id     : arg3,
            name        : arg4,
            entity_type : arg5,
        };
        if (*0x2::table::borrow<MogulEntityKey, u64>(&arg1.entity_cost, v0) != arg6) {
            err_invalid_entity_cost();
        };
        buy_entity(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
    }

    public fun create_mogul_studio(arg0: &mut MogulCentral, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        assert_valid_manager(arg0, 0x2::tx_context::sender(arg4));
        let v0 = MogulStudio{
            id       : 0x2::object::new(arg4),
            name     : arg2,
            entities : 0x2::vec_set::empty<MogulEntityKey>(),
            budget   : arg3,
        };
        0x2::table::add<address, MogulStudio>(&mut arg0.mogul_studios, arg1, v0);
        let v1 = StudioCreatedEvent{
            mogul_address   : arg1,
            studio_name     : arg2,
            starting_budget : arg3,
        };
        0x2::event::emit<StudioCreatedEvent>(v1);
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

    fun err_invalid_entity_cost() {
        abort 6
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
            id            : 0x2::object::new(arg1),
            version_set   : 0x2::vec_set::singleton<u64>(1),
            managers      : 0x2::vec_set::empty<address>(),
            mogul_studios : 0x2::table::new<address, MogulStudio>(arg1),
        };
        0x2::transfer::share_object<MogulCentral>(v0);
        let v1 = MogulsExchange{
            id          : 0x2::object::new(arg1),
            entity_cost : 0x2::table::new<MogulEntityKey, u64>(arg1),
        };
        0x2::transfer::share_object<MogulsExchange>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun owned_entities(arg0: &MogulCentral, arg1: address) : vector<MogulEntityKey> {
        abort 0
    }

    public fun owned_entities_2(arg0: &MogulCentral, arg1: address) : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0x2::vec_set::into_keys<MogulEntityKey>(0x2::table::borrow<address, MogulStudio>(&arg0.mogul_studios, arg1).entities);
        0x1::vector::reverse<MogulEntityKey>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<MogulEntityKey>(&v1)) {
            let v3 = 0x1::vector::pop_back<MogulEntityKey>(&mut v1);
            0x1::vector::push_back<0x1::string::String>(&mut v0, v3.imdb_id);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<MogulEntityKey>(v1);
        v0
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

    public fun sell_entity(arg0: &mut MogulCentral, arg1: &MogulsExchange, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        assert_valid_manager(arg0, 0x2::tx_context::sender(arg6));
        let v0 = MogulEntityKey{
            imdb_id     : arg3,
            name        : arg4,
            entity_type : arg5,
        };
        let v1 = 0x2::table::borrow_mut<address, MogulStudio>(&mut arg0.mogul_studios, arg2);
        let v2 = *0x2::table::borrow<MogulEntityKey, u64>(&arg1.entity_cost, v0);
        if (!0x2::vec_set::contains<MogulEntityKey>(&v1.entities, &v0)) {
            err_entity_not_owned();
        };
        v1.budget = v1.budget + v2;
        0x2::vec_set::remove<MogulEntityKey>(&mut v1.entities, &v0);
        let v3 = StudioModifiedEvent{
            mogul_address : arg2,
            studio_name   : v1.name,
            entity_cost   : v2,
            imdb_id       : arg3,
            name          : arg4,
            entity_type   : arg5,
            is_buy        : false,
        };
        0x2::event::emit<StudioModifiedEvent>(v3);
    }

    public fun sell_entity_cost_check(arg0: &mut MogulCentral, arg1: &MogulsExchange, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = MogulEntityKey{
            imdb_id     : arg3,
            name        : arg4,
            entity_type : arg5,
        };
        if (*0x2::table::borrow<MogulEntityKey, u64>(&arg1.entity_cost, v0) != arg6) {
            err_invalid_entity_cost();
        };
        sell_entity(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
    }

    public fun set_mogul_entity_cost(arg0: &mut MogulCentral, arg1: &mut MogulsExchange, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        assert_valid_manager(arg0, 0x2::tx_context::sender(arg6));
        let v0 = MogulEntityKey{
            imdb_id     : arg2,
            name        : arg3,
            entity_type : arg4,
        };
        if (0x2::table::contains<MogulEntityKey, u64>(&arg1.entity_cost, v0)) {
            *0x2::table::borrow_mut<MogulEntityKey, u64>(&mut arg1.entity_cost, v0) = arg5;
        } else {
            0x2::table::add<MogulEntityKey, u64>(&mut arg1.entity_cost, v0, arg5);
        };
        let v1 = EntityValueSetEvent{
            imdb_id     : arg2,
            name        : arg3,
            entity_type : arg4,
            entity_cost : arg5,
        };
        0x2::event::emit<EntityValueSetEvent>(v1);
    }

    public fun studio_exists(arg0: &MogulCentral, arg1: address) : bool {
        0x2::table::contains<address, MogulStudio>(&arg0.mogul_studios, arg1)
    }

    // decompiled from Move bytecode v6
}

