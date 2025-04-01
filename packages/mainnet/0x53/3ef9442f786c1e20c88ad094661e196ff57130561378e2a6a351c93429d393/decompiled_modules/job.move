module 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::job {
    struct Job has store, key {
        id: 0x2::object::UID,
        owner: address,
        guid: 0x1::string::String,
        content: 0x1::string::String,
        user_id: 0x1::string::String,
        job_type_id: u64,
        time_out: u64,
        status: u64,
        estimated_cost: u64,
        created_at: u64,
    }

    public(friend) fun delete_job(arg0: Job) {
        let Job {
            id             : v0,
            owner          : _,
            guid           : _,
            content        : _,
            user_id        : _,
            job_type_id    : _,
            time_out       : _,
            status         : _,
            estimated_cost : _,
            created_at     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_estimated_cost(arg0: &Job) : u64 {
        arg0.estimated_cost
    }

    public fun get_guid(arg0: &Job) : 0x1::string::String {
        arg0.guid
    }

    public fun get_id(arg0: &Job) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_job_type_id(arg0: &Job) : u64 {
        arg0.job_type_id
    }

    public fun get_status(arg0: &Job) : u64 {
        arg0.status
    }

    public fun get_time_out(arg0: &Job) : u64 {
        arg0.time_out
    }

    public fun get_user_id(arg0: &Job) : 0x1::string::String {
        arg0.user_id
    }

    public(friend) fun new_job(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Job {
        let v0 = 0x1::string::length(&arg1);
        assert!(v0 > 1 && v0 <= 1000, 1);
        Job{
            id             : 0x2::object::new(arg6),
            owner          : arg0,
            guid           : arg2,
            content        : arg1,
            user_id        : arg3,
            job_type_id    : arg4,
            time_out       : 0,
            status         : 0,
            estimated_cost : arg5,
            created_at     : 0x2::tx_context::epoch_timestamp_ms(arg6),
        }
    }

    public fun update_job(arg0: &mut Job, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        arg0.user_id = arg1;
        arg0.job_type_id = arg2;
        arg0.time_out = arg3;
        arg0.status = arg4;
        arg0.estimated_cost = arg5;
    }

    public fun update_job_estimated_cost(arg0: &mut Job, arg1: u64) {
        arg0.estimated_cost = arg1;
    }

    public fun update_job_status(arg0: &mut Job, arg1: u64) {
        arg0.status = arg1;
    }

    // decompiled from Move bytecode v6
}

