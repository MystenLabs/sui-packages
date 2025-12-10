module 0x1506ffbc6d717e37624b18b943965b9f5e6cdc2730bf08ea7e7949e296b000f::authority {
    public fun authorize(arg0: &mut 0x1506ffbc6d717e37624b18b943965b9f5e6cdc2730bf08ea7e7949e296b000f::dev::OracleAggregatorDevIntegration, arg1: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::AuthorityCap<0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::PACKAGE, 0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::ADMIN>) {
        0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::add_authorization(0x1506ffbc6d717e37624b18b943965b9f5e6cdc2730bf08ea7e7949e296b000f::dev::borrow_mut_id(arg0, arg1), arg1);
    }

    public fun deauthorize(arg0: &mut 0x1506ffbc6d717e37624b18b943965b9f5e6cdc2730bf08ea7e7949e296b000f::dev::OracleAggregatorDevIntegration, arg1: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::AuthorityCap<0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::PACKAGE, 0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::ADMIN>) {
        0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::remove_authorization(0x1506ffbc6d717e37624b18b943965b9f5e6cdc2730bf08ea7e7949e296b000f::dev::borrow_mut_id(arg0, arg1), arg1);
    }

    // decompiled from Move bytecode v6
}

