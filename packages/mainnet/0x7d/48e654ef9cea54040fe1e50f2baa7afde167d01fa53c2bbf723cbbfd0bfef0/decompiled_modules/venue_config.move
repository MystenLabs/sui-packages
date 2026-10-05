module 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::venue_config {
    struct VenueConfig has key {
        id: 0x2::object::UID,
    }

    public(friend) fun object<T0: copy + drop + store, T1: store + key>(arg0: &VenueConfig, arg1: T0) : &T1 {
        0x2::dynamic_object_field::borrow<T0, T1>(&arg0.id, arg1)
    }

    public(friend) fun add_object<T0: copy + drop + store, T1: store + key>(arg0: &mut VenueConfig, arg1: T0, arg2: T1) {
        0x2::dynamic_object_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VenueConfig{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<VenueConfig>(v0);
    }

    // decompiled from Move bytecode v7
}

