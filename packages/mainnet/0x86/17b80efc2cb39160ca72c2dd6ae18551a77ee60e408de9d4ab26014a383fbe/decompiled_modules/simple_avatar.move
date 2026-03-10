module 0x8617b80efc2cb39160ca72c2dd6ae18551a77ee60e408de9d4ab26014a383fbe::simple_avatar {
    struct Avatar has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        rig: 0x1::string::String,
        model_url: 0x1::string::String,
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Avatar{
            id        : 0x2::object::new(arg3),
            name      : arg0,
            rig       : arg1,
            model_url : arg2,
        };
        0x2::transfer::transfer<Avatar>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

