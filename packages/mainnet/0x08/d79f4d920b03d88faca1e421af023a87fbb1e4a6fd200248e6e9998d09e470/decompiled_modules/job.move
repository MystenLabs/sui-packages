module 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::job {
    struct Job has key {
        id: 0x2::object::UID,
        name: vector<u8>,
        hash: vector<u8>,
        data: vector<u8>,
        created_at: u64,
    }

    public fun hash(arg0: &Job) : vector<u8> {
        arg0.hash
    }

    public fun new(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Job {
        Job{
            id         : 0x2::object::new(arg3),
            name       : arg0,
            hash       : 0x1::hash::sha3_256(arg1),
            data       : arg1,
            created_at : arg2,
        }
    }

    public fun freeze_job(arg0: Job) {
        0x2::transfer::freeze_object<Job>(arg0);
    }

    public fun job_address(arg0: &Job) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    // decompiled from Move bytecode v6
}

