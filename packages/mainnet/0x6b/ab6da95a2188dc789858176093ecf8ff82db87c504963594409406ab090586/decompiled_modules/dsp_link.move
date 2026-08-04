module 0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link {
    struct DspLink<T0: copy + drop + store> has copy, drop, store {
        data: T0,
    }

    struct DspLinkKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun borrow<T0: copy + drop + store>(arg0: &0x2::object::UID) : &DspLink<T0> {
        let v0 = DspLinkKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<DspLinkKey<T0>>(arg0, v0), 0);
        let v1 = DspLinkKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<DspLinkKey<T0>, DspLink<T0>>(arg0, v1)
    }

    public fun borrow_mut<T0: copy + drop + store>(arg0: &mut 0x2::object::UID) : &mut DspLink<T0> {
        let v0 = DspLinkKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<DspLinkKey<T0>>(arg0, v0), 0);
        let v1 = DspLinkKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<DspLinkKey<T0>, DspLink<T0>>(arg0, v1)
    }

    public fun remove<T0: copy + drop + store>(arg0: &mut 0x2::object::UID) : DspLink<T0> {
        let v0 = DspLinkKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<DspLinkKey<T0>>(arg0, v0), 0);
        let v1 = DspLinkKey<T0>{dummy_field: false};
        0x2::dynamic_field::remove<DspLinkKey<T0>, DspLink<T0>>(arg0, v1)
    }

    public fun clear<T0: copy + drop + store>(arg0: &mut 0x2::object::UID) {
        let v0 = DspLinkKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists<DspLinkKey<T0>>(arg0, v0)) {
            let v1 = DspLinkKey<T0>{dummy_field: false};
            0x2::dynamic_field::remove<DspLinkKey<T0>, DspLink<T0>>(arg0, v1);
        };
    }

    public fun data<T0: copy + drop + store>(arg0: &DspLink<T0>) : T0 {
        arg0.data
    }

    public fun exists_<T0: copy + drop + store>(arg0: &0x2::object::UID) : bool {
        let v0 = DspLinkKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists<DspLinkKey<T0>>(arg0, v0)
    }

    public fun get<T0: copy + drop + store>(arg0: &0x2::object::UID) : 0x1::option::Option<DspLink<T0>> {
        let v0 = DspLinkKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists<DspLinkKey<T0>>(arg0, v0)) {
            let v2 = DspLinkKey<T0>{dummy_field: false};
            0x1::option::some<DspLink<T0>>(*0x2::dynamic_field::borrow<DspLinkKey<T0>, DspLink<T0>>(arg0, v2))
        } else {
            0x1::option::none<DspLink<T0>>()
        }
    }

    public fun new<T0: copy + drop + store>(arg0: T0) : DspLink<T0> {
        DspLink<T0>{data: arg0}
    }

    public fun set<T0: copy + drop + store>(arg0: &mut 0x2::object::UID, arg1: DspLink<T0>) {
        let v0 = DspLinkKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists<DspLinkKey<T0>>(arg0, v0)) {
            let v1 = DspLinkKey<T0>{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<DspLinkKey<T0>, DspLink<T0>>(arg0, v1) = arg1;
        } else {
            let v2 = DspLinkKey<T0>{dummy_field: false};
            0x2::dynamic_field::add<DspLinkKey<T0>, DspLink<T0>>(arg0, v2, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

