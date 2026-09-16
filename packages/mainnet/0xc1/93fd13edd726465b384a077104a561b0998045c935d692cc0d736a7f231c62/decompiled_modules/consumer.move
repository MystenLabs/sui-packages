module 0xc193fd13edd726465b384a077104a561b0998045c935d692cc0d736a7f231c62::consumer {
    public fun take_via_uid<T0: store + key>(arg0: &mut 0xa684d12435a8ce17c68e1e91b97226e501d300eea2af83caf76f4ea88738d080::tto_demo::Box, arg1: 0x2::transfer::Receiving<T0>) : T0 {
        0x2::transfer::public_receive<T0>(0xa684d12435a8ce17c68e1e91b97226e501d300eea2af83caf76f4ea88738d080::tto_demo::uid_mut(arg0), arg1)
    }

    // decompiled from Move bytecode v7
}

