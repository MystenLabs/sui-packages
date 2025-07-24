module 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_current_status_info {
    struct SystemCurrentStatusInfo has drop {
        current_epoch: u64,
        is_mid_epoch_time: bool,
        is_end_epoch_time: bool,
        current_epoch_active_committee: 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee,
        next_epoch_active_committee: 0x1::option::Option<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee>,
    }

    public fun create(arg0: u64, arg1: bool, arg2: bool, arg3: 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee, arg4: 0x1::option::Option<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee>, arg5: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_object_cap::SystemObjectCap) : SystemCurrentStatusInfo {
        SystemCurrentStatusInfo{
            current_epoch                  : arg0,
            is_mid_epoch_time              : arg1,
            is_end_epoch_time              : arg2,
            current_epoch_active_committee : arg3,
            next_epoch_active_committee    : arg4,
        }
    }

    public fun current_epoch(arg0: &SystemCurrentStatusInfo) : u64 {
        arg0.current_epoch
    }

    public fun current_epoch_active_committee(arg0: &SystemCurrentStatusInfo) : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee {
        arg0.current_epoch_active_committee
    }

    public fun is_end_epoch_time(arg0: &SystemCurrentStatusInfo) : bool {
        arg0.is_end_epoch_time
    }

    public fun is_mid_epoch_time(arg0: &SystemCurrentStatusInfo) : bool {
        arg0.is_mid_epoch_time
    }

    public fun next_epoch_active_committee(arg0: &SystemCurrentStatusInfo) : 0x1::option::Option<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee> {
        arg0.next_epoch_active_committee
    }

    // decompiled from Move bytecode v6
}

