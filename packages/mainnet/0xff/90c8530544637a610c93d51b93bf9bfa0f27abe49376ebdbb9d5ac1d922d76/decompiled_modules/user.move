module 0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::user {
    public fun chad_redeem_scallop_box(arg0: &0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::version::Version, arg1: &mut 0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::scallop_score::ScallopScoreTable, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::version::assert_current_version(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::scallop_score::get_score(arg1, v0);
        if (v1 < 100 || v1 >= 1000) {
            return
        };
        let v2 = v1 / 100;
        if (v2 == 0) {
            return
        };
        let v3 = 0;
        while (v3 < v2) {
            0x2::transfer::public_transfer<0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::scallop_box::ScallopBox>(0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::scallop_box::mint(0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::scallop_box::diamond(), arg2, arg3), v0);
            v3 = v3 + 1;
        };
        0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::scallop_score::decrease_score(arg1, v0, v2 * 100);
    }

    public fun draw_scallop_box_tickets(arg0: &0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::version::Version, arg1: &mut 0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::scallop_score::ScallopScoreTable, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::version::assert_current_version(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::scallop_score::get_score(arg1, v0);
        if (v1 >= 100) {
            return
        };
        let v2 = v1 / 1;
        if (v2 == 0) {
            return
        };
        let v3 = 0;
        while (v3 < v2) {
            0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::lucky_draw::draw_ticket(arg2, arg3, arg4, arg5, arg6);
            v3 = v3 + 1;
        };
        0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::scallop_score::decrease_score(arg1, v0, v2 * 1);
    }

    public fun redeem_scallop_box(arg0: &0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::version::Version, arg1: 0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::lucky_draw::LuckyDrawTicket, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::version::assert_current_version(arg0);
        0x2::transfer::public_transfer<0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::scallop_box::ScallopBox>(0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::lucky_draw::redeem_ticket(arg1, arg2, arg3, arg4, arg5, arg6), 0x2::tx_context::sender(arg6));
    }

    public fun whale_redeem_scallop_box(arg0: &0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::version::Version, arg1: &mut 0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::scallop_score::ScallopScoreTable, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::version::assert_current_version(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::scallop_score::get_score(arg1, v0);
        if (v1 < 1000) {
            return
        };
        let v2 = v1 / 1000;
        if (v2 == 0) {
            return
        };
        let v3 = 0;
        while (v3 < v2) {
            0x2::transfer::public_transfer<0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::scallop_box::ScallopBox>(0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::scallop_box::mint(0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::scallop_box::legendary(), arg2, arg3), v0);
            v3 = v3 + 1;
        };
        0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::scallop_score::decrease_score(arg1, v0, v2 * 1000);
    }

    // decompiled from Move bytecode v6
}

