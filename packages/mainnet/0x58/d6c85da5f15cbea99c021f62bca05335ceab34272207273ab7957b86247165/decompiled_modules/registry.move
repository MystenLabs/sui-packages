module 0x58d6c85da5f15cbea99c021f62bca05335ceab34272207273ab7957b86247165::registry {
    struct Root has copy, drop, store {
        job: 0x1::string::String,
        scheme: 0x1::string::String,
        key: vector<u8>,
        valid_from: 0x1::string::String,
        valid_to: 0x1::option::Option<0x1::string::String>,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        roots: vector<Root>,
    }

    struct RootEvent has copy, drop {
        registry: 0x2::object::ID,
        index: u64,
        job: 0x1::string::String,
        rotation: bool,
    }

    public fun count(arg0: &Registry) : u64 {
        0x1::vector::length<Root>(&arg0.roots)
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id    : 0x2::object::new(arg0),
            roots : 0x1::vector::empty<Root>(),
        };
        0x2::transfer::transfer<Registry>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun job_at(arg0: &Registry, arg1: u64) : 0x1::string::String {
        0x1::vector::borrow<Root>(&arg0.roots, arg1).job
    }

    public fun key_at(arg0: &Registry, arg1: u64) : vector<u8> {
        0x1::vector::borrow<Root>(&arg0.roots, arg1).key
    }

    fun open_index(arg0: &Registry, arg1: &0x1::string::String) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Root>(&arg0.roots)) {
            let v1 = 0x1::vector::borrow<Root>(&arg0.roots, v0);
            if (&v1.job == arg1 && 0x1::option::is_none<0x1::string::String>(&v1.valid_to)) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun open_key(arg0: &Registry, arg1: 0x1::string::String) : 0x1::option::Option<vector<u8>> {
        let v0 = open_index(arg0, &arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            0x1::option::some<vector<u8>>(0x1::vector::borrow<Root>(&arg0.roots, *0x1::option::borrow<u64>(&v0)).key)
        } else {
            0x1::option::none<vector<u8>>()
        }
    }

    public fun register(arg0: &mut Registry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<u8>, arg4: 0x1::string::String) {
        assert!(0x1::vector::length<u8>(&arg3) > 0, 3);
        let v0 = open_index(arg0, &arg1);
        assert!(0x1::option::is_none<u64>(&v0), 1);
        let v1 = Root{
            job        : arg1,
            scheme     : arg2,
            key        : arg3,
            valid_from : arg4,
            valid_to   : 0x1::option::none<0x1::string::String>(),
        };
        0x1::vector::push_back<Root>(&mut arg0.roots, v1);
        let v2 = RootEvent{
            registry : 0x2::object::id<Registry>(arg0),
            index    : 0x1::vector::length<Root>(&arg0.roots),
            job      : arg1,
            rotation : false,
        };
        0x2::event::emit<RootEvent>(v2);
    }

    public fun rotate(arg0: &mut Registry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<u8>, arg4: 0x1::string::String) {
        assert!(0x1::vector::length<u8>(&arg3) > 0, 3);
        let v0 = open_index(arg0, &arg1);
        assert!(0x1::option::is_some<u64>(&v0), 2);
        0x1::vector::borrow_mut<Root>(&mut arg0.roots, *0x1::option::borrow<u64>(&v0)).valid_to = 0x1::option::some<0x1::string::String>(arg4);
        let v1 = Root{
            job        : arg1,
            scheme     : arg2,
            key        : arg3,
            valid_from : arg4,
            valid_to   : 0x1::option::none<0x1::string::String>(),
        };
        0x1::vector::push_back<Root>(&mut arg0.roots, v1);
        let v2 = RootEvent{
            registry : 0x2::object::id<Registry>(arg0),
            index    : 0x1::vector::length<Root>(&arg0.roots),
            job      : arg1,
            rotation : true,
        };
        0x2::event::emit<RootEvent>(v2);
    }

    public fun scheme_at(arg0: &Registry, arg1: u64) : 0x1::string::String {
        0x1::vector::borrow<Root>(&arg0.roots, arg1).scheme
    }

    public fun valid_from_at(arg0: &Registry, arg1: u64) : 0x1::string::String {
        0x1::vector::borrow<Root>(&arg0.roots, arg1).valid_from
    }

    public fun valid_to_at(arg0: &Registry, arg1: u64) : 0x1::option::Option<0x1::string::String> {
        0x1::vector::borrow<Root>(&arg0.roots, arg1).valid_to
    }

    // decompiled from Move bytecode v7
}

