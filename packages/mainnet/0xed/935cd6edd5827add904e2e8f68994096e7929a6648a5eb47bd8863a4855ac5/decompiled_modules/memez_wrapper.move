module 0xed935cd6edd5827add904e2e8f68994096e7929a6648a5eb47bd8863a4855ac5::memez_wrapper {
    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    struct UpdateMetadata has copy, drop {
        pool: address,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun update_metadata<T0, T1, T2>(arg0: &mut 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<T0, T1, T2>, arg1: &0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::MetadataCap, arg2: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) {
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::update_metadata<T0, T1, T2>(arg0, arg1, arg2);
        let v0 = UpdateMetadata{
            pool     : 0x2::object::id_address<0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezFun<T0, T1, T2>>(arg0),
            metadata : arg2,
        };
        let v1 = Event<UpdateMetadata>{pos0: v0};
        0x2::event::emit<Event<UpdateMetadata>>(v1);
    }

    // decompiled from Move bytecode v6
}

