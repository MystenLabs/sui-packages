module 0x9b68b36399a3cd87680878d72253b3e8fdf82edb8ed74f7ec440b8bddd51f85d::state {
    struct STATE has drop {
        dummy_field: bool,
    }

    struct InitCap has key {
        id: 0x2::object::UID,
    }

    struct State has key {
        id: 0x2::object::UID,
        emitter_cap: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap,
        token_bridge_emitter_address: address,
        package_id: address,
    }

    public fun create_state(arg0: InitCap, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let InitCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = State{
            id                           : 0x2::object::new(arg4),
            emitter_cap                  : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::new(arg1, arg4),
            token_bridge_emitter_address : arg2,
            package_id                   : arg3,
        };
        0x2::transfer::share_object<State>(v1);
    }

    public fun emitter_cap(arg0: &State) : &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap {
        &arg0.emitter_cap
    }

    fun init(arg0: STATE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = InitCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<InitCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun package_id(arg0: &State) : address {
        arg0.package_id
    }

    public fun token_bridge_emitter_address(arg0: &State) : address {
        arg0.token_bridge_emitter_address
    }

    // decompiled from Move bytecode v6
}

