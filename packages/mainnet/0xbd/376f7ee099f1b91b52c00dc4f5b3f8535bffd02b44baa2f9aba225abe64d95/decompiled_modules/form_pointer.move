module 0xbd376f7ee099f1b91b52c00dc4f5b3f8535bffd02b44baa2f9aba225abe64d95::form_pointer {
    struct FormPointer has key {
        id: 0x2::object::UID,
        owner: address,
        current_blob_id: vector<u8>,
        version: u64,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct FormPublished has copy, drop {
        pointer_id: 0x2::object::ID,
        owner: address,
        blob_id: vector<u8>,
        created_at_ms: u64,
    }

    struct FormUpdated has copy, drop {
        pointer_id: 0x2::object::ID,
        owner: address,
        new_blob_id: vector<u8>,
        version: u64,
        updated_at_ms: u64,
    }

    public fun created_at_ms(arg0: &FormPointer) : u64 {
        arg0.created_at_ms
    }

    public fun current_blob_id(arg0: &FormPointer) : vector<u8> {
        arg0.current_blob_id
    }

    public fun owner(arg0: &FormPointer) : address {
        arg0.owner
    }

    entry fun publish(arg0: vector<u8>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<u8>(&arg0), 1);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = FormPointer{
            id              : 0x2::object::new(arg2),
            owner           : v1,
            current_blob_id : arg0,
            version         : 1,
            created_at_ms   : v0,
            updated_at_ms   : v0,
        };
        let v3 = FormPublished{
            pointer_id    : 0x2::object::id<FormPointer>(&v2),
            owner         : v1,
            blob_id       : arg0,
            created_at_ms : v0,
        };
        0x2::event::emit<FormPublished>(v3);
        0x2::transfer::share_object<FormPointer>(v2);
    }

    entry fun update(arg0: &mut FormPointer, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 0);
        assert!(!0x1::vector::is_empty<u8>(&arg1), 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg0.current_blob_id = arg1;
        arg0.version = arg0.version + 1;
        arg0.updated_at_ms = v0;
        let v1 = FormUpdated{
            pointer_id    : 0x2::object::id<FormPointer>(arg0),
            owner         : arg0.owner,
            new_blob_id   : arg1,
            version       : arg0.version,
            updated_at_ms : v0,
        };
        0x2::event::emit<FormUpdated>(v1);
    }

    public fun updated_at_ms(arg0: &FormPointer) : u64 {
        arg0.updated_at_ms
    }

    public fun version(arg0: &FormPointer) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

