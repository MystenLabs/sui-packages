module 0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::listing {
    struct ListingCap has store, key {
        id: 0x2::object::UID,
        aggregator_map: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    fun err_already_listed() {
        abort 101
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ListingCap{
            id             : 0x2::object::new(arg0),
            aggregator_map : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::object::ID>(),
        };
        0x2::transfer::transfer<ListingCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun register<T0>(arg0: &mut ListingCap, arg1: 0x2::object::ID) : 0x1::type_name::TypeName {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.aggregator_map, &v0)) {
            err_already_listed();
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.aggregator_map, v0, arg1);
        v0
    }

    // decompiled from Move bytecode v6
}

