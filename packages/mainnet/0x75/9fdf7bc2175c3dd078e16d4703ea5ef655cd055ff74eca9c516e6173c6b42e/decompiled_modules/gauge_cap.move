module 0x759fdf7bc2175c3dd078e16d4703ea5ef655cd055ff74eca9c516e6173c6b42e::gauge_cap {
    struct GAUGE_CAP has drop {
        dummy_field: bool,
    }

    struct CreateCap has store, key {
        id: 0x2::object::UID,
    }

    struct GaugeCap has store, key {
        id: 0x2::object::UID,
        gauge_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
    }

    public fun create_gauge_cap(arg0: &CreateCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : GaugeCap {
        GaugeCap{
            id       : 0x2::object::new(arg3),
            gauge_id : arg2,
            pool_id  : arg1,
        }
    }

    public fun get_gauge_id(arg0: &GaugeCap) : 0x2::object::ID {
        arg0.gauge_id
    }

    public fun get_pool_id(arg0: &GaugeCap) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun grant_create_cap(arg0: &0x2::package::Publisher, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<CreateCap>(arg0), 923752748582334234);
        let v0 = CreateCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<CreateCap>(v0, arg1);
    }

    fun init(arg0: GAUGE_CAP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<GAUGE_CAP>(arg0, arg1);
        let v0 = CreateCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<CreateCap>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

