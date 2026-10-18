module 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<INIT>(&arg0), 13906834238767890431);
        let (v0, v1) = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::create(arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>>(v2, 0x2::tx_context::sender(arg1));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::share_registry(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::market::create_registry(&v3, &v2, arg1));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::timelock::share(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::timelock::create(arg1));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::share(v3);
    }

    // decompiled from Move bytecode v7
}

