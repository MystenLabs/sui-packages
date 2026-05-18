module 0x85fcc9707ce774f3041606fe47dca327b40ce90437fa65cf55129eaf6d099523::access {
    struct AccessApproved has copy, drop {
        id: vector<u8>,
        accessor: address,
    }

    public fun seal_approve(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AccessApproved{
            id       : arg0,
            accessor : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<AccessApproved>(v0);
    }

    // decompiled from Move bytecode v7
}

