module 0x7ced627732424c03899cbcbcf51ac3401eddadda1662dbaa89dc7ef95fda2c04::set_worker_ptb {
    struct SetWorkerPtbParam has copy, drop, store {
        get_fee_ptb: vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>,
        assign_job_ptb: vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>,
    }

    public fun assign_job_ptb(arg0: &SetWorkerPtbParam) : &vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall> {
        &arg0.assign_job_ptb
    }

    public fun create_param(arg0: vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>, arg1: vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>) : SetWorkerPtbParam {
        SetWorkerPtbParam{
            get_fee_ptb    : arg0,
            assign_job_ptb : arg1,
        }
    }

    public fun get_fee_ptb(arg0: &SetWorkerPtbParam) : &vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall> {
        &arg0.get_fee_ptb
    }

    public fun unpack(arg0: SetWorkerPtbParam) : (vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>, vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>) {
        let SetWorkerPtbParam {
            get_fee_ptb    : v0,
            assign_job_ptb : v1,
        } = arg0;
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

