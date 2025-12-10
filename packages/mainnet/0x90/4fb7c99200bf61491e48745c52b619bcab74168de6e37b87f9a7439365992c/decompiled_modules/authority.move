module 0x904fb7c99200bf61491e48745c52b619bcab74168de6e37b87f9a7439365992c::authority {
    public fun authorize(arg0: &mut 0x904fb7c99200bf61491e48745c52b619bcab74168de6e37b87f9a7439365992c::pyth::OracleAggregatorPythIntegration, arg1: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::AuthorityCap<0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::PACKAGE, 0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::ADMIN>) {
        0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::add_authorization(0x904fb7c99200bf61491e48745c52b619bcab74168de6e37b87f9a7439365992c::pyth::borrow_mut_id(arg0, arg1), arg1);
    }

    public fun deauthorize(arg0: &mut 0x904fb7c99200bf61491e48745c52b619bcab74168de6e37b87f9a7439365992c::pyth::OracleAggregatorPythIntegration, arg1: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::AuthorityCap<0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::PACKAGE, 0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::ADMIN>) {
        0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::remove_authorization(0x904fb7c99200bf61491e48745c52b619bcab74168de6e37b87f9a7439365992c::pyth::borrow_mut_id(arg0, arg1), arg1);
    }

    // decompiled from Move bytecode v6
}

