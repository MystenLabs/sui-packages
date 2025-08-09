module 0xf02b4aa501d6f749dafb2f5e1cb5bb958a38b36edf0f086c13f0c539494b2c51::arcade {
    struct ArcadeGlobalRegistry has key {
        id: 0x2::object::UID,
        game_registry: vector<0x1::string::String>,
    }

    struct ArcadeWrapper has key {
        id: 0x2::object::UID,
    }

    entry fun add_dof_objects<T0: store + key>(arg0: &0xf02b4aa501d6f749dafb2f5e1cb5bb958a38b36edf0f086c13f0c539494b2c51::arcade_role::OperatorCap, arg1: &0xf02b4aa501d6f749dafb2f5e1cb5bb958a38b36edf0f086c13f0c539494b2c51::arcade_role::OperatorCapsBag, arg2: &mut ArcadeWrapper, arg3: 0x1::string::String, arg4: T0, arg5: &0xf02b4aa501d6f749dafb2f5e1cb5bb958a38b36edf0f086c13f0c539494b2c51::arcade_version::Version) {
        0xf02b4aa501d6f749dafb2f5e1cb5bb958a38b36edf0f086c13f0c539494b2c51::arcade_version::validate_version(arg5, 1);
        0xf02b4aa501d6f749dafb2f5e1cb5bb958a38b36edf0f086c13f0c539494b2c51::arcade_role::is_operator(arg0, arg1);
        0x2::dynamic_object_field::add<0x1::string::String, T0>(&mut arg2.id, arg3, arg4);
    }

    public(friend) fun dof_get_cap_obj<T0: store + key>(arg0: &ArcadeWrapper, arg1: 0x1::string::String, arg2: &0xf02b4aa501d6f749dafb2f5e1cb5bb958a38b36edf0f086c13f0c539494b2c51::arcade_version::Version) : &T0 {
        0xf02b4aa501d6f749dafb2f5e1cb5bb958a38b36edf0f086c13f0c539494b2c51::arcade_version::validate_version(arg2, 1);
        0x2::dynamic_object_field::borrow<0x1::string::String, T0>(&arg0.id, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ArcadeGlobalRegistry{
            id            : 0x2::object::new(arg0),
            game_registry : 0x1::vector::empty<0x1::string::String>(),
        };
        let v1 = ArcadeWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<ArcadeWrapper>(v1);
        0x2::transfer::share_object<ArcadeGlobalRegistry>(v0);
    }

    // decompiled from Move bytecode v6
}

