module 0x64076ca1e80ec560c4c3701f9d4f90990a4888c748ba9262abbf5fe78d0d279b::loria_pack {
    struct LoriaPack has key {
        id: 0x2::object::UID,
        blob_id: 0x1::string::String,
        owner: address,
        collection_id: 0x2::object::ID,
        unpacked_cards: vector<0x2::object::ID>,
    }

    public(friend) fun add_unpacked_card(arg0: &mut LoriaPack, arg1: 0x2::object::ID) {
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.unpacked_cards, arg1);
    }

    public fun get_collection_id(arg0: &LoriaPack) : 0x2::object::ID {
        arg0.collection_id
    }

    public fun get_unpacked_cards(arg0: &LoriaPack) : vector<0x2::object::ID> {
        arg0.unpacked_cards
    }

    public(friend) fun mint(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = LoriaPack{
            id             : 0x2::object::new(arg2),
            blob_id        : arg1,
            owner          : 0x2::tx_context::sender(arg2),
            collection_id  : arg0,
            unpacked_cards : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::transfer<LoriaPack>(v0, 0x2::tx_context::sender(arg2));
        0x2::object::id<LoriaPack>(&v0)
    }

    // decompiled from Move bytecode v6
}

