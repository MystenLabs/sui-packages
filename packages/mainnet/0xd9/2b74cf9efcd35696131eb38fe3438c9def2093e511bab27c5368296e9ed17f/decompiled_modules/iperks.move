module 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks {
    struct PerksMetadataHolder has store, key {
        id: 0x2::object::UID,
        perks: vector<0x1::string::String>,
        perks_price: 0x2::table::Table<0x1::string::String, u64>,
        daily_supplies: 0x2::table::Table<0x1::string::String, DailySupply>,
        faucet_holder: address,
    }

    struct PerksMetadata has store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        life: u64,
        image: 0x1::string::String,
    }

    struct Perk has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        expire_ts: u64,
        image: 0x1::string::String,
        life: u64,
        expected_expire_ts: u64,
        dvd_id: 0x2::object::ID,
    }

    struct DailySupply has store {
        max_daily: u64,
        current_daily: u64,
        last_reset_ts: u64,
        reset_duration_ms: u64,
    }

    struct PerksRegistry has key {
        id: 0x2::object::UID,
        registry: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    public(friend) fun new(arg0: &PerksMetadataHolder, arg1: 0x1::string::String, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : Perk {
        let v0 = 0x2::dynamic_field::borrow<0x1::string::String, PerksMetadata>(&arg0.id, arg1);
        Perk{
            id                 : 0x2::object::new(arg3),
            name               : v0.name,
            description        : v0.description,
            expire_ts          : 0,
            image              : v0.image,
            life               : v0.life,
            expected_expire_ts : 0,
            dvd_id             : arg2,
        }
    }

    public(friend) fun add_perk_daily_supply(arg0: &mut PerksMetadataHolder, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = DailySupply{
            max_daily         : arg2,
            current_daily     : 0,
            last_reset_ts     : 0x2::clock::timestamp_ms(arg4),
            reset_duration_ms : arg3,
        };
        0x2::table::add<0x1::string::String, DailySupply>(&mut arg0.daily_supplies, arg1, v0);
    }

    public(friend) fun add_perk_metadata(arg0: &mut PerksMetadataHolder, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        let v0 = PerksMetadata{
            name        : arg1,
            description : arg2,
            life        : arg3,
            image       : arg4,
        };
        add_perk_to_vector(arg0, arg1);
        set_perk_price(arg0, arg1, arg5);
        add_perk_metadata_df(arg0, arg1, v0);
        add_perk_daily_supply(arg0, arg1, arg7, arg6, arg8);
    }

    public(friend) fun add_perk_metadata_df(arg0: &mut PerksMetadataHolder, arg1: 0x1::string::String, arg2: PerksMetadata) {
        0x2::dynamic_field::add<0x1::string::String, PerksMetadata>(&mut arg0.id, arg1, arg2);
    }

    public(friend) fun add_perk_supply(arg0: &mut PerksMetadataHolder, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = DailySupply{
            max_daily         : arg2,
            current_daily     : 0,
            last_reset_ts     : 0x2::clock::timestamp_ms(arg4),
            reset_duration_ms : arg3,
        };
        0x2::table::add<0x1::string::String, DailySupply>(&mut arg0.daily_supplies, arg1, v0);
    }

    public(friend) fun add_perk_to_vector(arg0: &mut PerksMetadataHolder, arg1: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.perks, arg1);
    }

    public fun borrow_all_perks(arg0: &PerksMetadataHolder) : vector<0x1::string::String> {
        arg0.perks
    }

    public(friend) fun borrow_category_name(arg0: &PerksMetadataHolder, arg1: 0x1::string::String) : 0x1::string::String {
        *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(0x2::dynamic_field::borrow<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.id, 0x1::string::utf8(b"perks_category")), &arg1)
    }

    public fun borrow_faucet_holder_address(arg0: &PerksMetadataHolder) : address {
        arg0.faucet_holder
    }

    public(friend) fun borrow_id(arg0: &mut PerksMetadataHolder) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun borrow_mut_perk_supply_info(arg0: &mut PerksMetadataHolder, arg1: 0x1::string::String) : &mut DailySupply {
        0x2::table::borrow_mut<0x1::string::String, DailySupply>(&mut arg0.daily_supplies, arg1)
    }

    public fun borrow_perk_df<T0: store>(arg0: &PerksMetadataHolder, arg1: 0x1::string::String) : &T0 {
        0x2::dynamic_field::borrow<0x1::string::String, T0>(&arg0.id, arg1)
    }

    public fun borrow_perk_expire_ts(arg0: &Perk) : u64 {
        arg0.expire_ts
    }

    public fun borrow_perk_id(arg0: &Perk) : 0x2::object::ID {
        0x2::object::id<Perk>(arg0)
    }

    public fun borrow_perk_life(arg0: &Perk) : u64 {
        arg0.life
    }

    public fun borrow_perk_name(arg0: &Perk) : 0x1::string::String {
        arg0.name
    }

    public fun borrow_perk_price(arg0: &PerksMetadataHolder, arg1: 0x1::string::String) : u64 {
        *0x2::table::borrow<0x1::string::String, u64>(&arg0.perks_price, arg1)
    }

    public fun borrow_perk_supply_info(arg0: &PerksMetadataHolder, arg1: 0x1::string::String) : &DailySupply {
        0x2::table::borrow<0x1::string::String, DailySupply>(&arg0.daily_supplies, arg1)
    }

    public fun borrow_value(arg0: &PerksRegistry, arg1: 0x1::string::String) : u64 {
        *0x2::vec_map::get<0x1::string::String, u64>(&arg0.registry, &arg1)
    }

    public fun can_reset_supply(arg0: &DailySupply, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.last_reset_ts + arg0.reset_duration_ms
    }

    public fun has_perk_supply(arg0: &PerksMetadataHolder, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, DailySupply>(&arg0.daily_supplies, arg1)
    }

    public(friend) fun increase_supply(arg0: &mut DailySupply, arg1: u64) {
        arg0.current_daily = arg0.current_daily + arg1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PerksMetadataHolder{
            id             : 0x2::object::new(arg0),
            perks          : 0x1::vector::empty<0x1::string::String>(),
            perks_price    : 0x2::table::new<0x1::string::String, u64>(arg0),
            daily_supplies : 0x2::table::new<0x1::string::String, DailySupply>(arg0),
            faucet_holder  : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::public_share_object<PerksMetadataHolder>(v0);
    }

    public(friend) fun initialize_perk_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PerksRegistry{
            id       : 0x2::object::new(arg0),
            registry : 0x2::vec_map::empty<0x1::string::String, u64>(),
        };
        0x2::transfer::share_object<PerksRegistry>(v0);
    }

    public fun is_supply_at_limit(arg0: &DailySupply) : bool {
        arg0.current_daily <= arg0.max_daily
    }

    public(friend) fun reset_supply(arg0: &mut DailySupply, arg1: &0x2::clock::Clock) {
        arg0.current_daily = 0;
        arg0.last_reset_ts = 0x2::clock::timestamp_ms(arg1);
    }

    public(friend) fun set_perk_expire_ts(arg0: &mut Perk, arg1: &0x2::clock::Clock, arg2: u64) {
        arg0.expire_ts = 0x2::clock::timestamp_ms(arg1) + arg2;
    }

    public(friend) fun set_perk_price(arg0: &mut PerksMetadataHolder, arg1: 0x1::string::String, arg2: u64) {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.perks_price, arg1)) {
            *0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg0.perks_price, arg1) = arg2;
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg0.perks_price, arg1, arg2);
        };
    }

    public(friend) fun set_perk_registry_values(arg0: &mut PerksRegistry, arg1: 0x1::string::String, arg2: u64) {
        if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.registry, &arg1)) {
            *0x2::vec_map::get_mut<0x1::string::String, u64>(&mut arg0.registry, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.registry, arg1, arg2);
        };
    }

    public(friend) fun set_perk_treasury(arg0: &mut PerksMetadataHolder, arg1: address) {
        arg0.faucet_holder = arg1;
    }

    public(friend) fun set_perks_category(arg0: &mut PerksMetadataHolder, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"perks_category"))) {
            let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut arg0.id, 0x1::string::utf8(b"perks_category"));
            if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(v0, &arg1)) {
                *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(v0, &arg1) = arg2;
            } else {
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(v0, arg1, arg2);
            };
        } else {
            let v1 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, arg1, arg2);
            0x2::dynamic_field::add<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut arg0.id, 0x1::string::utf8(b"perks_category"), v1);
        };
    }

    public(friend) fun set_supply_max_daily(arg0: &mut DailySupply, arg1: u64) {
        arg0.max_daily = arg1;
    }

    public(friend) fun set_supply_reset_duration(arg0: &mut DailySupply, arg1: u64) {
        arg0.reset_duration_ms = arg1;
    }

    public(friend) fun transfer_perk(arg0: Perk, arg1: address) {
        0x2::transfer::transfer<Perk>(arg0, arg1);
    }

    public(friend) fun update_perk_metadata_description(arg0: &mut PerksMetadata, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String) {
        arg0.description = arg1;
        arg0.life = arg2;
        arg0.image = arg3;
    }

    public(friend) fun update_supply_config(arg0: &mut DailySupply, arg1: u64, arg2: u64) {
        set_supply_max_daily(arg0, arg1);
        set_supply_reset_duration(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

