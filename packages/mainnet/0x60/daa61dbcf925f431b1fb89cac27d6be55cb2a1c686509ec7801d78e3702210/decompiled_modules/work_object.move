module 0x60daa61dbcf925f431b1fb89cac27d6be55cb2a1c686509ec7801d78e3702210::work_object {
    struct WorkObject has store, key {
        id: 0x2::object::UID,
        object_type: 0x1::string::String,
        schema_version: u64,
        payload: vector<u8>,
        walrus_blob_id: 0x1::option::Option<0x1::string::String>,
        parent_objects: vector<0x2::object::ID>,
        producer_agent: address,
        consumer_agents: vector<address>,
        timestamp_ms: u64,
        payment_amount: u64,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct WorkObjectMinted has copy, drop {
        id: 0x2::object::ID,
        object_type: 0x1::string::String,
        producer: address,
        owner: address,
        parent_objects: vector<0x2::object::ID>,
        payment_amount: u64,
        timestamp_ms: u64,
    }

    struct WorkObjectConsumed has copy, drop {
        id: 0x2::object::ID,
        consumer: address,
    }

    public fun consumer_count(arg0: &WorkObject) : u64 {
        0x1::vector::length<address>(&arg0.consumer_agents)
    }

    public fun mint(arg0: address, arg1: 0x1::string::String, arg2: u64, arg3: vector<u8>, arg4: 0x1::option::Option<0x1::string::String>, arg5: vector<0x2::object::ID>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!0x1::vector::is_empty<u8>(&arg3) || 0x1::option::is_some<0x1::string::String>(&arg4), 1);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg7);
        let v2 = WorkObject{
            id              : 0x2::object::new(arg7),
            object_type     : arg1,
            schema_version  : arg2,
            payload         : arg3,
            walrus_blob_id  : arg4,
            parent_objects  : arg5,
            producer_agent  : v0,
            consumer_agents : vector[],
            timestamp_ms    : v1,
            payment_amount  : arg6,
            metadata        : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        };
        let v3 = 0x2::object::id<WorkObject>(&v2);
        let v4 = WorkObjectMinted{
            id             : v3,
            object_type    : v2.object_type,
            producer       : v0,
            owner          : arg0,
            parent_objects : v2.parent_objects,
            payment_amount : arg6,
            timestamp_ms   : v1,
        };
        0x2::event::emit<WorkObjectMinted>(v4);
        0x2::transfer::public_transfer<WorkObject>(v2, arg0);
        v3
    }

    public fun object_type(arg0: &WorkObject) : &0x1::string::String {
        &arg0.object_type
    }

    public fun parents(arg0: &WorkObject) : &vector<0x2::object::ID> {
        &arg0.parent_objects
    }

    public fun producer(arg0: &WorkObject) : address {
        arg0.producer_agent
    }

    public(friend) fun record_consumption(arg0: &mut WorkObject, arg1: address) {
        assert!(!0x1::vector::contains<address>(&arg0.consumer_agents, &arg1), 2);
        0x1::vector::push_back<address>(&mut arg0.consumer_agents, arg1);
        let v0 = WorkObjectConsumed{
            id       : 0x2::object::id<WorkObject>(arg0),
            consumer : arg1,
        };
        0x2::event::emit<WorkObjectConsumed>(v0);
    }

    public fun timestamp_ms(arg0: &WorkObject) : u64 {
        arg0.timestamp_ms
    }

    // decompiled from Move bytecode v7
}

