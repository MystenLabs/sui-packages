module 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct CreateLotteryCap<phantom T0> has key {
        id: 0x2::object::UID,
    }

    struct DrawLotteryCap<phantom T0> has key {
        id: 0x2::object::UID,
    }

    public(friend) fun create_admin_cap(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    public(friend) fun create_and_transfer_admin_cap(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        transfer_admin_cap(create_admin_cap(arg1), arg0);
    }

    public(friend) fun create_and_transfer_create_cap<T0>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::helper::CapInfo {
        let v0 = create_create_cap<T0>(arg1);
        transfer_create_cap<T0>(v0, arg0);
        0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::helper::create_cap_info<T0>(0x2::object::id<CreateLotteryCap<T0>>(&v0))
    }

    public fun create_and_transfer_draw_cap<T0>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::helper::CapInfo {
        let v0 = create_draw_cap<T0>(arg1);
        transfer_draw_cap<T0>(v0, arg0);
        0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::helper::create_cap_info<T0>(0x2::object::id<DrawLotteryCap<T0>>(&v0))
    }

    public fun create_cap_info<T0>(arg0: 0x2::object::ID) : 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::helper::CapInfo {
        0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::helper::create_cap_info<T0>(arg0)
    }

    public fun create_create_cap<T0>(arg0: &mut 0x2::tx_context::TxContext) : CreateLotteryCap<T0> {
        CreateLotteryCap<T0>{id: 0x2::object::new(arg0)}
    }

    public fun create_draw_cap<T0>(arg0: &mut 0x2::tx_context::TxContext) : DrawLotteryCap<T0> {
        DrawLotteryCap<T0>{id: 0x2::object::new(arg0)}
    }

    public fun get_admin_cap_id(arg0: &AdminCap) : 0x2::object::ID {
        0x2::object::id<AdminCap>(arg0)
    }

    public fun get_create_cap_id<T0>(arg0: &CreateLotteryCap<T0>) : 0x2::object::ID {
        0x2::object::id<CreateLotteryCap<T0>>(arg0)
    }

    public fun get_draw_cap_id<T0>(arg0: &DrawLotteryCap<T0>) : 0x2::object::ID {
        0x2::object::id<DrawLotteryCap<T0>>(arg0)
    }

    public(friend) fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public(friend) fun transfer_create_cap<T0>(arg0: CreateLotteryCap<T0>, arg1: address) {
        0x2::transfer::transfer<CreateLotteryCap<T0>>(arg0, arg1);
    }

    public(friend) fun transfer_draw_cap<T0>(arg0: DrawLotteryCap<T0>, arg1: address) {
        0x2::transfer::transfer<DrawLotteryCap<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

