module 0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::venue_config {
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

