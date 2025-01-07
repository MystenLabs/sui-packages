module 0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::init {
    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::create(0x1::ascii::string(b"Counter"), 0x1::ascii::string(b"Examples counter"), arg0);
        0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::player_comp::register(&mut v0, arg0);
        0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::counter_comp::register(&mut v0);
        0x2::transfer::public_share_object<0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::World>(v0);
    }

    // decompiled from Move bytecode v6
}

