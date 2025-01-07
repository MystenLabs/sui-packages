module 0x982840be4cfd4d0753deb00d2ebc73d3a3c72e967e3fb43f60e2e85681cabbdb::kapy_world {
    struct KapyWorld has key {
        id: 0x2::object::UID,
        pirate_rules: 0x2::vec_map::VecMap<u8, 0x1::type_name::TypeName>,
        crew_supply: u32,
        strength_threshold: u16,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct GodPower has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun add_crew(arg0: &mut KapyWorld) {
        arg0.crew_supply = crew_supply(arg0) + 1;
    }

    public fun add_pirate_rule<T0: drop>(arg0: &mut KapyWorld, arg1: &GodPower, arg2: u8) {
        0x2::vec_map::insert<u8, 0x1::type_name::TypeName>(&mut arg0.pirate_rules, arg2, 0x1::type_name::get<T0>());
    }

    public fun add_treasure(arg0: &mut KapyWorld, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x982840be4cfd4d0753deb00d2ebc73d3a3c72e967e3fb43f60e2e85681cabbdb::events::emit_add_treasure(0x2::coin::value<0x2::sui::SUI>(&arg1));
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.treasury, arg1);
    }

    public fun crew_supply(arg0: &KapyWorld) : u32 {
        arg0.crew_supply
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = KapyWorld{
            id                 : 0x2::object::new(arg0),
            pirate_rules       : 0x2::vec_map::empty<u8, 0x1::type_name::TypeName>(),
            crew_supply        : 0,
            strength_threshold : 31,
            treasury           : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<KapyWorld>(v0);
        let v1 = GodPower{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<GodPower>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_valid_pirate_rule<T0: drop>(arg0: &KapyWorld, arg1: u8) : bool {
        if (0x2::vec_map::contains<u8, 0x1::type_name::TypeName>(pirate_rules(arg0), &arg1)) {
            let v1 = 0x1::type_name::get<T0>();
            0x2::vec_map::get<u8, 0x1::type_name::TypeName>(pirate_rules(arg0), &arg1) == &v1
        } else {
            false
        }
    }

    public fun pirate_rules(arg0: &KapyWorld) : &0x2::vec_map::VecMap<u8, 0x1::type_name::TypeName> {
        &arg0.pirate_rules
    }

    public fun remove_pirate_rule(arg0: &mut KapyWorld, arg1: &GodPower, arg2: u8) {
        let (_, _) = 0x2::vec_map::remove<u8, 0x1::type_name::TypeName>(&mut arg0.pirate_rules, &arg2);
    }

    public fun set_strength_threshold(arg0: &mut KapyWorld, arg1: &GodPower, arg2: u16) {
        arg0.strength_threshold = arg2;
    }

    public fun ship_price() : u64 {
        10000000000
    }

    public fun strength_threshold(arg0: &KapyWorld) : u16 {
        arg0.strength_threshold
    }

    public(friend) fun take_treasure(arg0: &mut KapyWorld, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.treasury, treasure_amount(), arg1)
    }

    public fun treasure_amount() : u64 {
        10000000000
    }

    public fun treasury(arg0: &KapyWorld) : &0x2::balance::Balance<0x2::sui::SUI> {
        &arg0.treasury
    }

    // decompiled from Move bytecode v6
}

