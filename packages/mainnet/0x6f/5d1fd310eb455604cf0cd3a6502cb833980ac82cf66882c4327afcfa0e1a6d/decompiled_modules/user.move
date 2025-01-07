module 0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::user {
    public fun burn_scallop_box(arg0: &0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::version::Version, arg1: &mut 0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::scallop_box::ScallopBoxStats, arg2: 0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::scallop_box::ScallopBox, arg3: &mut 0x2::tx_context::TxContext) {
        0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::version::assert_current_version(arg0);
        0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::scallop_box::burn(arg1, arg2, arg3);
    }

    public fun chad_redeem_scallop_box(arg0: &0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::version::Version, arg1: &0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::admin::GlobalConfig, arg2: &mut 0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::scallop_box::ScallopBoxStats, arg3: &mut 0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::scallop_score::ScallopScoreTable, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::version::assert_current_version(arg0);
        0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::admin::assert_redeem_enabled(arg1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::scallop_score::get_score(arg3, v0);
        if (v1 < 100 || v1 >= 1000) {
            return
        };
        let v2 = v1 / 100;
        if (v2 == 0) {
            return
        };
        let v3 = 0;
        while (v3 < v2) {
            0x2::transfer::public_transfer<0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::scallop_box::ScallopBox>(0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::scallop_box::mint(arg2, 0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::scallop_box::diamond(), arg4, arg5), v0);
            v3 = v3 + 1;
        };
        0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::scallop_score::decrease_score(arg3, v0, v2 * 100);
    }

    public fun draw_scallop_box_tickets(arg0: &0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::version::Version, arg1: &0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::admin::GlobalConfig, arg2: &mut 0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::scallop_score::ScallopScoreTable, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::version::assert_current_version(arg0);
        0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::admin::assert_redeem_enabled(arg1);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::scallop_score::get_score(arg2, v0);
        if (v1 >= 100) {
            return
        };
        let v2 = v1 / 1;
        if (v2 == 0) {
            return
        };
        let v3 = 0;
        while (v3 < v2) {
            0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::lucky_draw::draw_ticket(arg3, arg4, arg5, arg6, arg7);
            v3 = v3 + 1;
        };
        0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::scallop_score::decrease_score(arg2, v0, v2 * 1);
    }

    public fun redeem_scallop_box(arg0: &0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::version::Version, arg1: &0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::admin::GlobalConfig, arg2: &mut 0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::scallop_box::ScallopBoxStats, arg3: 0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::lucky_draw::LuckyDrawTicket, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::version::assert_current_version(arg0);
        0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::admin::assert_redeem_enabled(arg1);
        0x2::transfer::public_transfer<0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::scallop_box::ScallopBox>(0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::lucky_draw::redeem_ticket(arg2, arg3, arg4, arg5, arg6, arg7, arg8), 0x2::tx_context::sender(arg8));
    }

    public fun whale_redeem_scallop_box(arg0: &0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::version::Version, arg1: &0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::admin::GlobalConfig, arg2: &mut 0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::scallop_box::ScallopBoxStats, arg3: &mut 0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::scallop_score::ScallopScoreTable, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::version::assert_current_version(arg0);
        0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::admin::assert_redeem_enabled(arg1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::scallop_score::get_score(arg3, v0);
        if (v1 < 1000) {
            return
        };
        let v2 = v1 / 1000;
        if (v2 == 0) {
            return
        };
        let v3 = 0;
        while (v3 < v2) {
            0x2::transfer::public_transfer<0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::scallop_box::ScallopBox>(0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::scallop_box::mint(arg2, 0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::scallop_box::legendary(), arg4, arg5), v0);
            v3 = v3 + 1;
        };
        0x6f5d1fd310eb455604cf0cd3a6502cb833980ac82cf66882c4327afcfa0e1a6d::scallop_score::decrease_score(arg3, v0, v2 * 1000);
    }

    // decompiled from Move bytecode v6
}

