module 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft {
    struct Nft<phantom T0> has store, key {
        id: 0x2::object::UID,
        collection: 0x2::object::ID,
        n: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public(friend) fun new<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Nft<T0> {
        Nft<T0>{
            id         : 0x2::object::new(arg2),
            collection : arg0,
            n          : arg1,
            attributes : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        }
    }

    public fun attributes<T0>(arg0: &Nft<T0>) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public fun collection<T0>(arg0: &Nft<T0>) : 0x2::object::ID {
        arg0.collection
    }

    public fun n<T0>(arg0: &Nft<T0>) : u64 {
        arg0.n
    }

    public(friend) fun set_attributes<T0>(arg0: &mut Nft<T0>, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>) {
        arg0.attributes = 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

