module 0x4a8d55b8eebd31a5dd73620ccc1c8590d0315c10e77e4736f04d30c3d278698::venue {
    struct Venue has store, key {
        id: 0x2::object::UID,
        is_live: bool,
        is_whitelisted: bool,
    }

    public(friend) fun delete<T0: store, T1: copy + drop + store>(arg0: T1, arg1: Venue) : T0 {
        let Venue {
            id             : v0,
            is_live        : _,
            is_whitelisted : _,
        } = arg1;
        0x2::object::delete(v0);
        0x2::dynamic_field::remove<T1, T0>(&mut arg1.id, arg0)
    }

    public fun new<T0: store, T1: copy + drop + store>(arg0: T1, arg1: T0, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : Venue {
        let v0 = 0x2::object::new(arg3);
        0x2::dynamic_field::add<T1, T0>(&mut v0, arg0, arg1);
        Venue{
            id             : v0,
            is_live        : false,
            is_whitelisted : arg2,
        }
    }

    public fun assert_is_live(arg0: &Venue) {
        assert!(is_live(arg0), 1);
    }

    public fun assert_is_not_whitelisted(arg0: &Venue) {
        assert!(!is_whitelisted(arg0), 2);
    }

    public fun assert_is_whitelisted(arg0: &Venue) {
        assert!(is_whitelisted(arg0), 3);
    }

    public fun assert_market<T0: store, T1: copy + drop + store>(arg0: T1, arg1: &Venue) : bool {
        0x2::dynamic_field::exists_with_type<T1, T0>(&arg1.id, arg0)
    }

    public fun borrow_market<T0: store, T1: copy + drop + store>(arg0: T1, arg1: &Venue) : &T0 {
        assert_market<T0, T1>(arg0, arg1);
        0x2::dynamic_field::borrow<T1, T0>(&arg1.id, arg0)
    }

    public(friend) fun borrow_market_mut<T0: store, T1: copy + drop + store>(arg0: T1, arg1: &mut Venue) : &mut T0 {
        assert_market<T0, T1>(arg0, arg1);
        0x2::dynamic_field::borrow_mut<T1, T0>(&mut arg1.id, arg0)
    }

    public fun init_venue<T0: store, T1: copy + drop + store>(arg0: T1, arg1: T0, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = new<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<Venue>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun is_live(arg0: &Venue) : bool {
        arg0.is_live
    }

    public fun is_whitelisted(arg0: &Venue) : bool {
        arg0.is_whitelisted
    }

    public(friend) fun set_live(arg0: &mut Venue, arg1: bool) {
        arg0.is_live = arg1;
    }

    public(friend) fun set_whitelisted(arg0: &mut Venue, arg1: bool) {
        arg0.is_whitelisted = arg1;
    }

    // decompiled from Move bytecode v6
}

