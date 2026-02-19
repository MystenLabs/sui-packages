module 0x4868190ad739a71a1a3c4655f4b803ba13195de15bae5a4341be3672614598da::position_registry {
    struct PositionRegistry has key {
        id: 0x2::object::UID,
        by_owner: 0x2::table::Table<address, vector<0x2::object::ID>>,
    }

    fun contains_id(arg0: &vector<0x2::object::ID>, arg1: &0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(arg0, v0) == *arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun copy_ids(arg0: &vector<0x2::object::ID>) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v0, *0x1::vector::borrow<0x2::object::ID>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun create_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PositionRegistry{
            id       : 0x2::object::new(arg0),
            by_owner : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
        };
        0x2::transfer::share_object<PositionRegistry>(v0);
    }

    public fun get_positions(arg0: &PositionRegistry, arg1: address) : vector<0x2::object::ID> {
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.by_owner, arg1)) {
            return 0x1::vector::empty<0x2::object::ID>()
        };
        copy_ids(0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.by_owner, arg1))
    }

    public fun register_position(arg0: &mut PositionRegistry, arg1: address, arg2: 0x2::object::ID) {
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.by_owner, arg1)) {
            let v0 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v0, arg2);
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.by_owner, arg1, v0);
            return
        };
        let v1 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.by_owner, arg1);
        if (!contains_id(v1, &arg2)) {
            0x1::vector::push_back<0x2::object::ID>(v1, arg2);
        };
    }

    fun remove_id(arg0: &mut vector<0x2::object::ID>, arg1: &0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(arg0, v0) == *arg1) {
                0x1::vector::remove<0x2::object::ID>(arg0, v0);
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun unregister_position(arg0: &mut PositionRegistry, arg1: address, arg2: 0x2::object::ID) {
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.by_owner, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.by_owner, arg1);
        remove_id(v0, &arg2);
    }

    // decompiled from Move bytecode v6
}

