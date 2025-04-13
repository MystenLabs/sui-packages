module 0x2acc3ac9b41551552ee477bdc73e12ce195f7f3cfe956f9163df67c5296744db::zklogin_capture {
    struct UserData has drop, store {
        message: vector<u8>,
    }

    struct UserStore has key {
        id: 0x2::object::UID,
        data: 0x2::table::Table<address, UserData>,
    }

    struct UserDataChanged has copy, drop {
        user: address,
        message: vector<u8>,
    }

    public fun get_user_data(arg0: &UserStore, arg1: address) : vector<u8> {
        if (0x2::table::contains<address, UserData>(&arg0.data, arg1)) {
            0x2::table::borrow<address, UserData>(&arg0.data, arg1).message
        } else {
            b""
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UserStore{
            id   : 0x2::object::new(arg0),
            data : 0x2::table::new<address, UserData>(arg0),
        };
        0x2::transfer::share_object<UserStore>(v0);
    }

    public entry fun set_user_data(arg0: &mut UserStore, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = UserData{message: arg1};
        if (0x2::table::contains<address, UserData>(&arg0.data, v0)) {
            0x2::table::remove<address, UserData>(&mut arg0.data, v0);
        };
        0x2::table::add<address, UserData>(&mut arg0.data, v0, v1);
        let v2 = UserDataChanged{
            user    : v0,
            message : arg1,
        };
        0x2::event::emit<UserDataChanged>(v2);
    }

    // decompiled from Move bytecode v7
}

