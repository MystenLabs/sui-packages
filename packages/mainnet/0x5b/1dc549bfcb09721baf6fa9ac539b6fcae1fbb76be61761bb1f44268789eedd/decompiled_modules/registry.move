module 0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::registry {
    struct RegistryCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        toys: 0x2::table::Table<0x1::type_name::TypeName, 0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::toy::Toy>,
    }

    public fun add_new_toy<T0>(arg0: &mut Registry, arg1: &RegistryCap, arg2: 0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::toy::Toy) {
        0x2::table::add<0x1::type_name::TypeName, 0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::toy::Toy>(&mut arg0.toys, 0x1::type_name::with_defining_ids<T0>(), arg2);
    }

    public fun borrow_toy<T0>(arg0: &Registry) : &0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::toy::Toy {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::toy::Toy>(&arg0.toys, v0), 0);
        0x2::table::borrow<0x1::type_name::TypeName, 0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::toy::Toy>(&arg0.toys, v0)
    }

    public(friend) fun borrow_toy_mut<T0>(arg0: &mut Registry) : &mut 0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::toy::Toy {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::toy::Toy>(&arg0.toys, v0), 0);
        0x2::table::borrow_mut<0x1::type_name::TypeName, 0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::toy::Toy>(&mut arg0.toys, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RegistryCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<RegistryCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Registry{
            id   : 0x2::object::new(arg0),
            toys : 0x2::table::new<0x1::type_name::TypeName, 0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::toy::Toy>(arg0),
        };
        0x2::transfer::share_object<Registry>(v1);
    }

    public fun toggle_listing<T0>(arg0: &mut Registry, arg1: &RegistryCap) {
        0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::toy::toggle_listing(borrow_toy_mut<T0>(arg0));
    }

    public fun update_points_price<T0>(arg0: &mut Registry, arg1: &RegistryCap, arg2: u64) {
        0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::toy::update_points_price(borrow_toy_mut<T0>(arg0), arg2);
    }

    public fun update_usd_price<T0>(arg0: &mut Registry, arg1: &RegistryCap, arg2: u64) {
        0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::toy::update_usd_price(borrow_toy_mut<T0>(arg0), arg2);
    }

    // decompiled from Move bytecode v7
}

