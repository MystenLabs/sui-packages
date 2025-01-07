module 0x99d363210a9937d0ab337d91b6e2df2126d83fda1c27e3d99c0473e42ea62bcd::supply_bag {
    struct SupplyBag has store, key {
        id: 0x2::object::UID,
        bag: 0x2::bag::Bag,
    }

    struct NewWithBagAndSharedEvent has copy, drop {
        id: 0x2::object::ID,
        sender: address,
    }

    public(friend) fun destroy_empty(arg0: SupplyBag) {
        let SupplyBag {
            id  : v0,
            bag : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x2::bag::destroy_empty(v1);
    }

    public fun bag(arg0: &SupplyBag) : &0x2::bag::Bag {
        &arg0.bag
    }

    public fun contains<T0>(arg0: &SupplyBag) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.bag, 0x1::type_name::get<T0>())
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : SupplyBag {
        SupplyBag{
            id  : 0x2::object::new(arg0),
            bag : 0x2::bag::new(arg0),
        }
    }

    public(friend) fun decrease_supply<T0>(arg0: &mut SupplyBag, arg1: 0x2::balance::Balance<T0>) : u64 {
        0x2::balance::decrease_supply<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Supply<T0>>(&mut arg0.bag, 0x1::type_name::get<T0>()), arg1)
    }

    public(friend) fun increase_supply<T0>(arg0: &mut SupplyBag, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::increase_supply<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Supply<T0>>(&mut arg0.bag, 0x1::type_name::get<T0>()), arg1)
    }

    public fun supply_value<T0>(arg0: &SupplyBag) : u64 {
        0x2::balance::supply_value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Supply<T0>>(&arg0.bag, 0x1::type_name::get<T0>()))
    }

    public(friend) fun add_supply<T0>(arg0: 0x2::balance::Supply<T0>, arg1: &mut SupplyBag) {
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Supply<T0>>(&mut arg1.bag, 0x1::type_name::get<T0>(), arg0);
    }

    public(friend) fun init_supply<T0: drop>(arg0: T0, arg1: &mut SupplyBag) {
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Supply<T0>>(&mut arg1.bag, 0x1::type_name::get<T0>(), 0x2::balance::create_supply<T0>(arg0));
    }

    public(friend) fun new_with_bag_and_shared(arg0: &mut 0x2::tx_context::TxContext, arg1: 0x2::bag::Bag) {
        let v0 = SupplyBag{
            id  : 0x2::object::new(arg0),
            bag : arg1,
        };
        0x2::transfer::share_object<SupplyBag>(v0);
        let v1 = NewWithBagAndSharedEvent{
            id     : 0x2::object::id<SupplyBag>(&v0),
            sender : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<NewWithBagAndSharedEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

