module 0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::counter_system {
    public entry fun inc(arg0: &mut 0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::World) {
        0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::counter_comp::update(arg0, 0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::counter_comp::get(arg0) + 1);
    }

    public entry fun my_reg(arg0: &mut 0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::World, arg1: &0x57138e18b82cc8ea6e92c3d5737d6078b1304b655f59cf5ae9668cc44aad4ead::profile::Profile, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (!0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::player_comp::contains(arg0, v0)) {
            0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::player_comp::add(arg0, v0, v0);
        };
    }

    // decompiled from Move bytecode v6
}

