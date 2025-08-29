module 0x1bb3de40be4fc2fbc2d6f94c82f8f6e01f40e923264f1ca42f32910c4f1130a9::storage {
    struct TraitStorage has store, key {
        id: 0x2::object::UID,
        traits: 0x2::object_bag::ObjectBag,
        trait_count: u64,
    }

    struct TraitData has store, key {
        id: 0x2::object::UID,
        chunks: vector<0x1::string::String>,
        total_size: u64,
    }

    public fun add_chunk(arg0: &mut TraitStorage, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (trait_exists(arg0, arg1)) {
            let v0 = get_trait_mut(arg0, arg1);
            while (0x1::vector::length<0x1::string::String>(&v0.chunks) <= arg3) {
                0x1::vector::push_back<0x1::string::String>(&mut v0.chunks, 0x1::string::utf8(b""));
            };
            *0x1::vector::borrow_mut<0x1::string::String>(&mut v0.chunks, arg3) = arg2;
            v0.total_size = calculate_total_size(&v0.chunks);
        } else {
            let v1 = 0x1::vector::empty<0x1::string::String>();
            let v2 = 0;
            while (v2 <= arg3) {
                if (v2 == arg3) {
                    0x1::vector::push_back<0x1::string::String>(&mut v1, arg2);
                } else {
                    0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b""));
                };
                v2 = v2 + 1;
            };
            store_large_trait(arg0, arg1, v1, arg4);
        };
    }

    fun calculate_total_size(arg0: &vector<0x1::string::String>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(arg0)) {
            v0 = v0 + 0x1::string::length(0x1::vector::borrow<0x1::string::String>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun create_storage(arg0: &mut 0x2::tx_context::TxContext) : TraitStorage {
        TraitStorage{
            id          : 0x2::object::new(arg0),
            traits      : 0x2::object_bag::new(arg0),
            trait_count : 0,
        }
    }

    public fun get_trait(arg0: &TraitStorage, arg1: 0x1::string::String) : &TraitData {
        0x2::object_bag::borrow<0x1::string::String, TraitData>(&arg0.traits, arg1)
    }

    public fun get_trait_chunks(arg0: &TraitData) : &vector<0x1::string::String> {
        &arg0.chunks
    }

    public fun get_trait_count(arg0: &TraitStorage) : u64 {
        arg0.trait_count
    }

    public fun get_trait_mut(arg0: &mut TraitStorage, arg1: 0x1::string::String) : &mut TraitData {
        0x2::object_bag::borrow_mut<0x1::string::String, TraitData>(&mut arg0.traits, arg1)
    }

    public fun get_trait_size(arg0: &TraitData) : u64 {
        arg0.total_size
    }

    public fun reconstruct_trait(arg0: &TraitData) : 0x1::string::String {
        let v0 = &arg0.chunks;
        let v1 = 0x1::string::utf8(b"");
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(v0)) {
            0x1::string::append(&mut v1, *0x1::vector::borrow<0x1::string::String>(v0, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun remove_trait(arg0: &mut TraitStorage, arg1: 0x1::string::String) : TraitData {
        arg0.trait_count = arg0.trait_count - 1;
        0x2::object_bag::remove<0x1::string::String, TraitData>(&mut arg0.traits, arg1)
    }

    public fun store_large_trait(arg0: &mut TraitStorage, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = TraitData{
            id         : 0x2::object::new(arg3),
            chunks     : arg2,
            total_size : calculate_total_size(&arg2),
        };
        0x2::object_bag::add<0x1::string::String, TraitData>(&mut arg0.traits, arg1, v0);
        arg0.trait_count = arg0.trait_count + 1;
    }

    public fun trait_exists(arg0: &TraitStorage, arg1: 0x1::string::String) : bool {
        0x2::object_bag::contains<0x1::string::String>(&arg0.traits, arg1)
    }

    public fun update_trait(arg0: &mut TraitStorage, arg1: 0x1::string::String, arg2: vector<0x1::string::String>) {
        let v0 = get_trait_mut(arg0, arg1);
        v0.chunks = arg2;
        v0.total_size = calculate_total_size(&arg2);
    }

    // decompiled from Move bytecode v6
}

