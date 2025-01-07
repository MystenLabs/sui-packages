module 0x40fbb1a5c4e811a2254d0c2ce157c005f596dd320dc941f3fdf068bdd7166a49::sdao_naming {
    struct NameRegistry has key {
        id: 0x2::object::UID,
        name_to_address: 0x2::vec_map::VecMap<0x1::string::String, address>,
    }

    public fun get_address_by_mame(arg0: &NameRegistry, arg1: vector<u8>) : address {
        let v0 = 0x1::string::utf8(arg1);
        *0x2::vec_map::get<0x1::string::String, address>(&arg0.name_to_address, &v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NameRegistry{
            id              : 0x2::object::new(arg0),
            name_to_address : 0x2::vec_map::empty<0x1::string::String, address>(),
        };
        0x2::transfer::share_object<NameRegistry>(v0);
    }

    public entry fun mint_name(arg0: vector<u8>, arg1: &mut NameRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg0);
        assert!(0x2::vec_map::contains<0x1::string::String, address>(&arg1.name_to_address, &v0) == false, 0);
        0x2::vec_map::insert<0x1::string::String, address>(&mut arg1.name_to_address, 0x1::string::utf8(arg0), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

