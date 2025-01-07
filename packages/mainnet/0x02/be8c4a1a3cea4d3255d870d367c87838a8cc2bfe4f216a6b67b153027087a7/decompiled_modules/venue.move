module 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::venue {
    struct Venue has store, key {
        id: 0x2::object::UID,
        start_date: u64,
        end_date: u64,
        is_whitelisted: bool,
    }

    public fun delete<T0: store, T1: copy + drop + store>(arg0: T1, arg1: Venue) : T0 {
        let Venue {
            id             : v0,
            start_date     : _,
            end_date       : _,
            is_whitelisted : _,
        } = arg1;
        0x2::object::delete(v0);
        0x2::dynamic_field::remove<T1, T0>(&mut arg1.id, arg0)
    }

    public fun new<T0: store, T1: copy + drop + store>(arg0: T1, arg1: T0, arg2: u64, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : Venue {
        let v0 = 0x2::object::new(arg5);
        0x2::dynamic_field::add<T1, T0>(&mut v0, arg0, arg1);
        Venue{
            id             : v0,
            start_date     : arg2,
            end_date       : arg3,
            is_whitelisted : arg4,
        }
    }

    public fun assert_is_live(arg0: &Venue, arg1: &0x2::clock::Clock) {
        assert!(is_live(arg0, arg1), 1);
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

    public fun borrow_market_mut<T0: store, T1: copy + drop + store>(arg0: T1, arg1: &mut Venue) : &mut T0 {
        assert_market<T0, T1>(arg0, arg1);
        0x2::dynamic_field::borrow_mut<T1, T0>(&mut arg1.id, arg0)
    }

    public fun init_venue<T0: store, T1: copy + drop + store>(arg0: T1, arg1: T0, arg2: u64, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = new<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<Venue>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun is_live(arg0: &Venue, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.end_date >= v0 && arg0.start_date <= v0
    }

    public fun is_whitelisted(arg0: &Venue) : bool {
        arg0.is_whitelisted
    }

    public entry fun set_live(arg0: &mut Venue, arg1: u64, arg2: u64) {
        arg0.start_date = arg1;
        arg0.end_date = arg2;
    }

    public entry fun set_whitelisted(arg0: &mut Venue, arg1: bool) {
        arg0.is_whitelisted = arg1;
    }

    // decompiled from Move bytecode v6
}

