module 0x17192ccd391112180395ca60d6cd68ad97816ed1a8557e83c995c43c24b7a67f::global {
    struct Global has store, key {
        id: 0x2::object::UID,
        is_pause: bool,
        initialization_list: 0x2::vec_map::VecMap<0x2::object::ID, bool>,
    }

    struct UpdateInitializationList has copy, drop {
        object: 0x2::object::ID,
        is_valid: bool,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id                  : 0x2::object::new(arg0),
            is_pause            : true,
            initialization_list : 0x2::vec_map::empty<0x2::object::ID, bool>(),
        };
        0x2::transfer::public_share_object<Global>(v0);
    }

    public fun assert_object_invalid(arg0: &Global, arg1: &0x2::object::UID) {
        assert!(object_is_valid(arg0, 0x2::object::uid_as_inner(arg1)), 1);
    }

    public fun assert_paused(arg0: &Global) {
        assert!(!arg0.is_pause, 0);
    }

    public fun is_pause(arg0: &Global) : bool {
        arg0.is_pause
    }

    public fun object_is_valid(arg0: &Global, arg1: &0x2::object::ID) : bool {
        0x2::vec_map::contains<0x2::object::ID, bool>(&arg0.initialization_list, arg1) && *0x2::vec_map::get<0x2::object::ID, bool>(&arg0.initialization_list, arg1)
    }

    public(friend) fun pause(arg0: &mut Global) {
        arg0.is_pause = true;
    }

    public(friend) fun un_pause(arg0: &mut Global) {
        arg0.is_pause = false;
    }

    public(friend) fun update_initialization_list(arg0: &mut Global, arg1: 0x2::object::ID, arg2: bool) {
        if (0x2::vec_map::contains<0x2::object::ID, bool>(&arg0.initialization_list, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x2::object::ID, bool>(&mut arg0.initialization_list, &arg1);
        };
        0x2::vec_map::insert<0x2::object::ID, bool>(&mut arg0.initialization_list, arg1, arg2);
        let v2 = UpdateInitializationList{
            object   : arg1,
            is_valid : arg2,
        };
        0x2::event::emit<UpdateInitializationList>(v2);
    }

    // decompiled from Move bytecode v6
}

