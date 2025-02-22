module 0x8b9d073d744f19194e2c7b5516872a0739c98a57e39150af501c83d4682bb01d::passwordmanager {
    struct Password has store, key {
        id: 0x2::object::UID,
        website: 0x1::string::String,
        username: 0x1::string::String,
        pw: 0x1::string::String,
        iv: 0x1::string::String,
        salt: 0x1::string::String,
    }

    struct AddPasswordEvent has copy, drop {
        pid: 0x2::object::ID,
        website: 0x1::string::String,
        username: 0x1::string::String,
        owner: address,
    }

    struct ChangePasswordEvent has copy, drop {
        pid: 0x2::object::ID,
        website: 0x1::string::String,
        username: 0x1::string::String,
        owner: address,
    }

    struct DeletePasswordEvent has copy, drop {
        pid: 0x2::object::ID,
        website: 0x1::string::String,
        username: 0x1::string::String,
        owner: address,
    }

    public entry fun add_password(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Password{
            id       : 0x2::object::new(arg5),
            website  : arg0,
            username : arg1,
            pw       : arg2,
            iv       : arg3,
            salt     : arg4,
        };
        0x2::transfer::public_transfer<Password>(v0, 0x2::tx_context::sender(arg5));
        let v1 = AddPasswordEvent{
            pid      : 0x2::object::uid_to_inner(&v0.id),
            website  : arg0,
            username : arg1,
            owner    : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<AddPasswordEvent>(v1);
    }

    public entry fun change_password(arg0: &mut Password, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        arg0.pw = arg1;
        arg0.iv = arg2;
        arg0.salt = arg3;
        let v0 = ChangePasswordEvent{
            pid      : 0x2::object::uid_to_inner(&arg0.id),
            website  : arg0.website,
            username : arg0.username,
            owner    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<ChangePasswordEvent>(v0);
    }

    public entry fun delete_password(arg0: Password, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DeletePasswordEvent{
            pid      : 0x2::object::uid_to_inner(&arg0.id),
            website  : arg0.website,
            username : arg0.username,
            owner    : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<DeletePasswordEvent>(v0);
        let Password {
            id       : v1,
            website  : _,
            username : _,
            pw       : _,
            iv       : _,
            salt     : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

