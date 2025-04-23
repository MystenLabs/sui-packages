module 0xc441dac0335300ee0c37280f5daad227cbe86b3ad59b428e486cb6a981f43c1a::registry {
    struct REGISTRY has drop {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        nfts: 0x2::table::Table<address, 0x2::object::ID>,
    }

    public(friend) fun add(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: address) {
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.nfts, arg2, arg1);
    }

    public(friend) fun remove(arg0: &mut Registry, arg1: &0x2::tx_context::TxContext) {
        0x2::table::remove<address, 0x2::object::ID>(&mut arg0.nfts, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun assert_not_exists(arg0: &Registry, arg1: &0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.nfts, 0x2::tx_context::sender(arg1)), 0);
    }

    fun init(arg0: REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id   : 0x2::object::new(arg1),
            nfts : 0x2::table::new<address, 0x2::object::ID>(arg1),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public(friend) fun size(arg0: &Registry) : u64 {
        0x2::table::length<address, 0x2::object::ID>(&arg0.nfts)
    }

    // decompiled from Move bytecode v6
}

