module 0xd691896f2ff416a8fa4792ee30895b28d71cf8bb8291f6f222a66d3e47b2c1c7::collection_storage {
    struct State has key {
        id: 0x2::object::UID,
        collections: 0x2::table::Table<vector<u8>, CollectionData>,
    }

    struct CollectionData has copy, drop, store {
        collection_address: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        creator: address,
    }

    struct AddedToStorage has copy, drop {
        collection_address: address,
    }

    public(friend) fun add(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &mut State) {
        0x1::string::append(&mut arg1, arg2);
        let v0 = 0x2::hash::keccak256(0x1::string::as_bytes(&arg1));
        assert!(!0x2::table::contains<vector<u8>, CollectionData>(&arg4.collections, v0), 1);
        let v1 = CollectionData{
            collection_address : arg0,
            name               : arg1,
            symbol             : arg2,
            creator            : arg3,
        };
        0x2::table::add<vector<u8>, CollectionData>(&mut arg4.collections, v0, v1);
        let v2 = AddedToStorage{collection_address: arg0};
        0x2::event::emit<AddedToStorage>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = State{
            id          : 0x2::object::new(arg0),
            collections : 0x2::table::new<vector<u8>, CollectionData>(arg0),
        };
        0x2::transfer::share_object<State>(v0);
    }

    // decompiled from Move bytecode v6
}

