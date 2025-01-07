module 0xa6973a6f5fba2920a955d7641e78f622effe9f2c6baf9f6145384b743695c2a9::field {
    struct Field has store, key {
        id: 0x2::object::UID,
        plots: vector<0x1::option::Option<Slot>>,
    }

    struct Slot has drop, store {
        name: 0x2::object::ID,
        planted: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Field {
        let v0 = 0x1::vector::empty<0x1::option::Option<Slot>>();
        let v1 = 0;
        while (v1 < 9) {
            0x1::vector::push_back<0x1::option::Option<Slot>>(&mut v0, 0x1::option::none<Slot>());
            v1 = v1 + 1;
        };
        Field{
            id    : 0x2::object::new(arg0),
            plots : v0,
        }
    }

    fun check_harvestable<T0>(arg0: &mut Field, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x1::vector::borrow<0x1::option::Option<Slot>>(&arg0.plots, arg1);
        assert!(0x1::option::is_some<Slot>(v0), 2);
        let v1 = 0x1::option::borrow<Slot>(v0);
        assert!(0x2::clock::timestamp_ms(arg2) - v1.planted >= 0xa6973a6f5fba2920a955d7641e78f622effe9f2c6baf9f6145384b743695c2a9::fruit::get_harvest_time<T0>(0x2::dynamic_field::borrow_mut<0x2::object::ID, 0xa6973a6f5fba2920a955d7641e78f622effe9f2c6baf9f6145384b743695c2a9::fruit::Fruit<T0>>(&mut arg0.id, v1.name)), 3);
    }

    public fun destroy_field(arg0: Field) {
        while (!0x1::vector::is_empty<0x1::option::Option<Slot>>(&arg0.plots)) {
            let v0 = 0x1::vector::pop_back<0x1::option::Option<Slot>>(&mut arg0.plots);
            if (0x1::option::is_some<Slot>(&v0)) {
                let Slot {
                    name    : _,
                    planted : _,
                } = 0x1::option::extract<Slot>(&mut v0);
            };
        };
        let Field {
            id    : v3,
            plots : _,
        } = arg0;
        0x2::object::delete(v3);
    }

    public fun get_plot(arg0: &Field, arg1: u64) : &0x1::option::Option<Slot> {
        0x1::vector::borrow<0x1::option::Option<Slot>>(&arg0.plots, arg1)
    }

    public fun get_plots(arg0: &Field) : &vector<0x1::option::Option<Slot>> {
        &arg0.plots
    }

    public fun harvest_fruit<T0>(arg0: &mut Field, arg1: u64, arg2: &0x2::clock::Clock) : 0xa6973a6f5fba2920a955d7641e78f622effe9f2c6baf9f6145384b743695c2a9::fruit::Fruit<T0> {
        assert!(arg1 < 9, 0);
        check_harvestable<T0>(arg0, arg1, arg2);
        let v0 = 0x1::vector::borrow_mut<0x1::option::Option<Slot>>(&mut arg0.plots, arg1);
        assert!(0x1::option::is_some<Slot>(v0), 2);
        let v1 = 0x1::option::extract<Slot>(v0);
        let Slot {
            name    : _,
            planted : _,
        } = v1;
        *v0 = 0x1::option::none<Slot>();
        0x2::dynamic_field::remove<0x2::object::ID, 0xa6973a6f5fba2920a955d7641e78f622effe9f2c6baf9f6145384b743695c2a9::fruit::Fruit<T0>>(&mut arg0.id, v1.name)
    }

    public fun plant_fruit<T0>(arg0: &mut Field, arg1: u64, arg2: 0xa6973a6f5fba2920a955d7641e78f622effe9f2c6baf9f6145384b743695c2a9::fruit::Fruit<T0>, arg3: &mut 0x2::tx_context::TxContext, arg4: &0x2::clock::Clock) {
        assert!(arg1 < 9, 0);
        let v0 = 0x1::vector::borrow_mut<0x1::option::Option<Slot>>(&mut arg0.plots, arg1);
        assert!(0x1::option::is_none<Slot>(v0), 1);
        let v1 = 0x2::object::new(arg3);
        let v2 = Slot{
            name    : 0x2::object::uid_to_inner(&v1),
            planted : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::dynamic_field::add<0x2::object::ID, 0xa6973a6f5fba2920a955d7641e78f622effe9f2c6baf9f6145384b743695c2a9::fruit::Fruit<T0>>(&mut arg0.id, v2.name, arg2);
        0x2::object::delete(v1);
        *v0 = 0x1::option::some<Slot>(v2);
    }

    // decompiled from Move bytecode v6
}

