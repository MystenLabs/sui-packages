module 0xa891d06df501eab7f07fdf97b540747ff3f4b604b562bb61d90e127a82d19156::authority {
    public fun authorize(arg0: &mut 0xa891d06df501eab7f07fdf97b540747ff3f4b604b562bb61d90e127a82d19156::pyth::OracleAggregatorPythIntegration, arg1: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::authority::AuthorityCap<0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::authority::PACKAGE, 0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::authority::ADMIN>) {
        0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::authority::add_authorization(0xa891d06df501eab7f07fdf97b540747ff3f4b604b562bb61d90e127a82d19156::pyth::borrow_mut_id(arg0, arg1), arg1);
    }

    public fun deauthorize(arg0: &mut 0xa891d06df501eab7f07fdf97b540747ff3f4b604b562bb61d90e127a82d19156::pyth::OracleAggregatorPythIntegration, arg1: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::authority::AuthorityCap<0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::authority::PACKAGE, 0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::authority::ADMIN>) {
        0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::authority::remove_authorization(0xa891d06df501eab7f07fdf97b540747ff3f4b604b562bb61d90e127a82d19156::pyth::borrow_mut_id(arg0, arg1), arg1);
    }

    // decompiled from Move bytecode v6
}

