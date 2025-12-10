module 0xf6c84fddbeaf59356ab53d1bc4b96f6a0547883ea0c5f25fc686ce04c8278d34::authority {
    public fun authorize(arg0: &mut 0xf6c84fddbeaf59356ab53d1bc4b96f6a0547883ea0c5f25fc686ce04c8278d34::stork::OracleAggregatorStorkIntegration, arg1: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::AuthorityCap<0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::PACKAGE, 0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::ADMIN>) {
        0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::add_authorization(0xf6c84fddbeaf59356ab53d1bc4b96f6a0547883ea0c5f25fc686ce04c8278d34::stork::borrow_mut_id<0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::ADMIN>(arg0, arg1), arg1);
    }

    public fun deauthorize(arg0: &mut 0xf6c84fddbeaf59356ab53d1bc4b96f6a0547883ea0c5f25fc686ce04c8278d34::stork::OracleAggregatorStorkIntegration, arg1: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::AuthorityCap<0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::PACKAGE, 0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::ADMIN>) {
        0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::remove_authorization(0xf6c84fddbeaf59356ab53d1bc4b96f6a0547883ea0c5f25fc686ce04c8278d34::stork::borrow_mut_id<0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::ADMIN>(arg0, arg1), arg1);
    }

    // decompiled from Move bytecode v6
}

