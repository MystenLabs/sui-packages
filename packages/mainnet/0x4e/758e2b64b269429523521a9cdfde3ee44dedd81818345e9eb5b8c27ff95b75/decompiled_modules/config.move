module 0x4e758e2b64b269429523521a9cdfde3ee44dedd81818345e9eb5b8c27ff95b75::config {
    struct Config has key {
        id: 0x2::object::UID,
        mint_rules: 0x2::vec_map::VecMap<u8, 0x1::type_name::TypeName>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun add_mint_rule<T0: drop>(arg0: &AdminCap, arg1: &mut Config, arg2: u8) {
        0x2::vec_map::insert<u8, 0x1::type_name::TypeName>(&mut arg1.mint_rules, arg2, 0x1::type_name::get<T0>());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id         : 0x2::object::new(arg0),
            mint_rules : 0x2::vec_map::empty<u8, 0x1::type_name::TypeName>(),
        };
        0x2::transfer::share_object<Config>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_valid_mint_rule<T0: drop>(arg0: &Config, arg1: u8) : bool {
        0x2::vec_map::contains<u8, 0x1::type_name::TypeName>(&arg0.mint_rules, &arg1) && *0x2::vec_map::get<u8, 0x1::type_name::TypeName>(&arg0.mint_rules, &arg1) == 0x1::type_name::get<T0>()
    }

    public fun remove_mint_rule(arg0: &AdminCap, arg1: &mut Config, arg2: u8) {
        let (_, _) = 0x2::vec_map::remove<u8, 0x1::type_name::TypeName>(&mut arg1.mint_rules, &arg2);
    }

    // decompiled from Move bytecode v6
}

