module 0xea847a7eee0e55f52a121829cc6ede9603649a39290e6d46566e9206d5e9761f::set_worker_ptb {
    struct SetWorkerPtbParam has copy, drop, store {
        get_fee_ptb: vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall>,
        assign_job_ptb: vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall>,
    }

    public fun assign_job_ptb(arg0: &SetWorkerPtbParam) : &vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall> {
        &arg0.assign_job_ptb
    }

    public fun create_param(arg0: vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall>, arg1: vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall>) : SetWorkerPtbParam {
        SetWorkerPtbParam{
            get_fee_ptb    : arg0,
            assign_job_ptb : arg1,
        }
    }

    public fun get_fee_ptb(arg0: &SetWorkerPtbParam) : &vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall> {
        &arg0.get_fee_ptb
    }

    public fun unpack(arg0: SetWorkerPtbParam) : (vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall>, vector<0xdd38c96b282271279247c26dba1f51d6e45209396a9e548154881e04549db66::move_call::MoveCall>) {
        let SetWorkerPtbParam {
            get_fee_ptb    : v0,
            assign_job_ptb : v1,
        } = arg0;
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

