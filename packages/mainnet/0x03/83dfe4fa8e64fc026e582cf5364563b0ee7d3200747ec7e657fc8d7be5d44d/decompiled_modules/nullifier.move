module 0x383dfe4fa8e64fc026e582cf5364563b0ee7d3200747ec7e657fc8d7be5d44d::nullifier {
    struct NullifierRegistry has store, key {
        id: 0x2::object::UID,
        count: u64,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : NullifierRegistry {
        NullifierRegistry{
            id    : 0x2::object::new(arg0),
            count : 0,
        }
    }

    public fun count(arg0: &NullifierRegistry) : u64 {
        arg0.count
    }

    public fun is_spent(arg0: &NullifierRegistry, arg1: vector<u8>) : bool {
        0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)
    }

    public fun mark_spent(arg0: &mut NullifierRegistry, arg1: vector<u8>) {
        0x2::dynamic_field::add<vector<u8>, bool>(&mut arg0.id, arg1, true);
        arg0.count = arg0.count + 1;
    }

    // decompiled from Move bytecode v6
}

