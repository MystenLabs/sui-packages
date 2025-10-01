module 0xd412a95bfe4645ddb920e3c08cfb8f7cfe9c8fe9897e957ca161cc6b85987fc5::set_worker_ptb {
    struct SetWorkerPtbParam has copy, drop, store {
        get_fee_ptb: vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>,
        assign_job_ptb: vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>,
    }

    public fun assign_job_ptb(arg0: &SetWorkerPtbParam) : &vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall> {
        &arg0.assign_job_ptb
    }

    public fun create_param(arg0: vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>, arg1: vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>) : SetWorkerPtbParam {
        SetWorkerPtbParam{
            get_fee_ptb    : arg0,
            assign_job_ptb : arg1,
        }
    }

    public fun get_fee_ptb(arg0: &SetWorkerPtbParam) : &vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall> {
        &arg0.get_fee_ptb
    }

    public fun unpack(arg0: SetWorkerPtbParam) : (vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>, vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>) {
        let SetWorkerPtbParam {
            get_fee_ptb    : v0,
            assign_job_ptb : v1,
        } = arg0;
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

