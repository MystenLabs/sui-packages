module 0xbb40504003ab3645f526dd2051808f2ed4fdf3265e6dc10627732876b9a13710::fishing_1 {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Fishing_1 has key {
        id: 0x2::object::UID,
    }

    struct FISHING_1 has drop {
        dummy_field: bool,
    }

    struct ConfigKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun add_config<T0: drop + store>(arg0: &AdminCap, arg1: &mut Fishing_1, arg2: T0) {
        let v0 = ConfigKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<ConfigKey<T0>, T0>(&mut arg1.id, v0, arg2);
    }

    public fun borrow_config<T0: drop + store>(arg0: &Fishing_1) : &T0 {
        let v0 = ConfigKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<ConfigKey<T0>, T0>(&arg0.id, v0)
    }

    fun init(arg0: FISHING_1, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<FISHING_1>(arg0, arg1);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = Fishing_1{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<Fishing_1>(v1);
    }

    public fun new_for_testing(arg0: &mut 0x2::tx_context::TxContext) : (Fishing_1, AdminCap) {
        let v0 = Fishing_1{id: 0x2::object::new(arg0)};
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        (v0, v1)
    }

    public fun remove_config<T0: drop + store>(arg0: &AdminCap, arg1: &mut Fishing_1) : T0 {
        let v0 = ConfigKey<T0>{dummy_field: false};
        0x2::dynamic_field::remove<ConfigKey<T0>, T0>(&mut arg1.id, v0)
    }

    // decompiled from Move bytecode v6
}

