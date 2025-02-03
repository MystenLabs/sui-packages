module 0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::receive {
    struct ObjectReceivedEvent has copy, drop {
        player_id: 0x2::object::ID,
        received_object_id: 0x2::object::ID,
        received_object_type: 0x1::type_name::TypeName,
    }

    public fun receive<T0: store + key>(arg0: &mut 0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::player::Player, arg1: 0x2::transfer::Receiving<T0>) : T0 {
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::alphabet::Alphabet>(), 0);
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::point::POINT>(), 0);
        let v0 = 0x2::transfer::public_receive<T0>(0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::player::uid_mut(arg0), arg1);
        let v1 = ObjectReceivedEvent{
            player_id            : 0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::player::id(arg0),
            received_object_id   : 0x2::object::id<T0>(&v0),
            received_object_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ObjectReceivedEvent>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

