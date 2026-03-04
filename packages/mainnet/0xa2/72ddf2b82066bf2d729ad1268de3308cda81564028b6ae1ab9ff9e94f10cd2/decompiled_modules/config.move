module 0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::config {
    struct Config has key {
        id: 0x2::object::UID,
        id_vector: vector<0x2::object::ID>,
    }

    public fun add_id(arg0: &mut Config, arg1: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg2: 0x2::object::ID) {
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.id_vector, arg2);
    }

    public fun new_config(arg0: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id        : 0x2::object::new(arg1),
            id_vector : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun remove_id(arg0: &mut Config, arg1: &0xa272ddf2b82066bf2d729ad1268de3308cda81564028b6ae1ab9ff9e94f10cd2::admin::AdminCap, arg2: u64) {
        0x1::vector::swap_remove<0x2::object::ID>(&mut arg0.id_vector, arg2);
    }

    // decompiled from Move bytecode v6
}

