module 0x3fef274ab2363f7bb99b937bc303299e59d5330066416cf61fa2e3f7d99fad70::permission {
    struct Admin has key {
        id: 0x2::object::UID,
        users: vector<address>,
    }

    struct AdminInitEvent has copy, drop {
        id: 0x2::object::ID,
    }

    struct UserAddedEvent has copy, drop {
        user: address,
    }

    struct UserRemovedEvent has copy, drop {
        user: address,
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = Admin{
            id    : 0x2::object::new(arg0),
            users : v0,
        };
        let v2 = AdminInitEvent{id: 0x2::object::id<Admin>(&v1)};
        0x2::event::emit<AdminInitEvent>(v2);
        0x2::transfer::share_object<Admin>(v1);
    }

    public(friend) fun is_admin(arg0: &Admin, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.users, &arg1)
    }

    public(friend) fun remove_admin(arg0: &mut Admin, arg1: address) : bool {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.users, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.users, v1);
            let v2 = UserRemovedEvent{user: arg1};
            0x2::event::emit<UserRemovedEvent>(v2);
        };
        v0
    }

    public(friend) fun set_admin(arg0: &mut Admin, arg1: address) : vector<address> {
        if (!0x1::vector::contains<address>(&arg0.users, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.users, arg1);
        };
        let v0 = UserAddedEvent{user: arg1};
        0x2::event::emit<UserAddedEvent>(v0);
        arg0.users
    }

    // decompiled from Move bytecode v6
}

