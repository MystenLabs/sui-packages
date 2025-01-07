module 0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct World has store, key {
        id: 0x2::object::UID,
        name: 0x1::ascii::String,
        description: 0x1::ascii::String,
        comps: 0x2::bag::Bag,
        compnames: vector<0x1::ascii::String>,
        admin: 0x2::object::ID,
        version: u64,
    }

    struct CompRemoveField has copy, drop {
        comp: address,
        key: address,
    }

    struct CompAddField has copy, drop {
        comp: address,
        key: address,
        data: vector<u8>,
    }

    struct CompUpdateField has copy, drop {
        comp: address,
        key: 0x1::option::Option<address>,
        data: vector<u8>,
    }

    public fun contains(arg0: &mut World, arg1: address) : bool {
        assert!(arg0.version == 1, 4);
        0x2::bag::contains<address>(&mut arg0.comps, arg1)
    }

    public fun add_comp<T0: store>(arg0: &mut World, arg1: vector<u8>, arg2: T0) {
        assert!(arg0.version == 1, 4);
        let v0 = 0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::entity_key::from_bytes(arg1);
        assert!(!0x2::bag::contains<address>(&arg0.comps, v0), 1);
        0x1::vector::push_back<0x1::ascii::String>(&mut arg0.compnames, 0x1::ascii::string(arg1));
        0x2::bag::add<address, T0>(&mut arg0.comps, v0, arg2);
    }

    public fun compnames(arg0: &World) : vector<0x1::ascii::String> {
        arg0.compnames
    }

    public fun create(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) : World {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        let v1 = World{
            id          : 0x2::object::new(arg2),
            name        : arg0,
            description : arg1,
            comps       : 0x2::bag::new(arg2),
            compnames   : 0x1::vector::empty<0x1::ascii::String>(),
            admin       : 0x2::object::id<AdminCap>(&v0),
            version     : 1,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg2));
        v1
    }

    public fun emit_add_event(arg0: address, arg1: address, arg2: vector<u8>) {
        let v0 = CompAddField{
            comp : arg0,
            key  : arg1,
            data : arg2,
        };
        0x2::event::emit<CompAddField>(v0);
    }

    public fun emit_remove_event(arg0: address, arg1: address) {
        let v0 = CompRemoveField{
            comp : arg0,
            key  : arg1,
        };
        0x2::event::emit<CompRemoveField>(v0);
    }

    public fun emit_update_event(arg0: address, arg1: 0x1::option::Option<address>, arg2: vector<u8>) {
        let v0 = CompUpdateField{
            comp : arg0,
            key  : arg1,
            data : arg2,
        };
        0x2::event::emit<CompUpdateField>(v0);
    }

    public fun get_comp<T0: store>(arg0: &World, arg1: address) : &T0 {
        assert!(arg0.version == 1, 4);
        assert!(0x2::bag::contains<address>(&arg0.comps, arg1), 0);
        0x2::bag::borrow<address, T0>(&arg0.comps, arg1)
    }

    public fun get_mut_comp<T0: store>(arg0: &mut World, arg1: address) : &mut T0 {
        assert!(arg0.version == 1, 4);
        assert!(0x2::bag::contains<address>(&arg0.comps, arg1), 0);
        0x2::bag::borrow_mut<address, T0>(&mut arg0.comps, arg1)
    }

    public fun info(arg0: &World) : (0x1::ascii::String, 0x1::ascii::String, u64) {
        (arg0.name, arg0.description, arg0.version)
    }

    entry fun migrate(arg0: &mut World, arg1: &AdminCap) {
        assert!(arg0.admin == 0x2::object::id<AdminCap>(arg1), 2);
        assert!(arg0.version < 1, 3);
        arg0.version = 1;
    }

    // decompiled from Move bytecode v6
}

