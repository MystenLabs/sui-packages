module 0x470409f1f6d843025a1f14eec745c0802dec6921556265d3d2f7649a791a584::competition {
    struct CompetitionConfig has key {
        id: 0x2::object::UID,
        boost_bp: vector<u64>,
        is_active: bool,
        program_name: 0x1::ascii::String,
        u64_padding: vector<u64>,
    }

    public(friend) fun add_score(arg0: &0x470409f1f6d843025a1f14eec745c0802dec6921556265d3d2f7649a791a584::admin::Version, arg1: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg3: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::tails_staking::TailsStakingRegistry, arg4: &CompetitionConfig, arg5: u64, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x470409f1f6d843025a1f14eec745c0802dec6921556265d3d2f7649a791a584::admin::version_check(arg0);
        let v0 = if (arg4.is_active) {
            *0x1::vector::borrow<u64>(&arg4.boost_bp, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::tails_staking::get_max_staking_level(arg1, arg3, arg6))
        } else {
            0
        };
        let v1 = (((arg5 as u128) * (v0 as u128) / (0x470409f1f6d843025a1f14eec745c0802dec6921556265d3d2f7649a791a584::math::get_bp_scale() as u128)) as u64);
        if (v1 > 0) {
            0x470409f1f6d843025a1f14eec745c0802dec6921556265d3d2f7649a791a584::admin::add_competition_leaderboard(arg0, arg1, arg2, arg4.program_name, arg6, v1, arg7, arg8);
        };
    }

    entry fun new_competition_config(arg0: &0x470409f1f6d843025a1f14eec745c0802dec6921556265d3d2f7649a791a584::admin::Version, arg1: vector<u64>, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) {
        0x470409f1f6d843025a1f14eec745c0802dec6921556265d3d2f7649a791a584::admin::verify(arg0, arg3);
        assert!(0x1::vector::length<u64>(&arg1) == 8, 0x470409f1f6d843025a1f14eec745c0802dec6921556265d3d2f7649a791a584::error::invalid_boost_bp_array_length());
        let v0 = CompetitionConfig{
            id           : 0x2::object::new(arg3),
            boost_bp     : arg1,
            is_active    : true,
            program_name : arg2,
            u64_padding  : 0x1::vector::empty<u64>(),
        };
        0x2::transfer::share_object<CompetitionConfig>(v0);
    }

    entry fun set_boost_bp(arg0: &0x470409f1f6d843025a1f14eec745c0802dec6921556265d3d2f7649a791a584::admin::Version, arg1: &mut CompetitionConfig, arg2: vector<u64>, arg3: &0x2::tx_context::TxContext) {
        0x470409f1f6d843025a1f14eec745c0802dec6921556265d3d2f7649a791a584::admin::verify(arg0, arg3);
        assert!(0x1::vector::length<u64>(&arg2) == 8, 0x470409f1f6d843025a1f14eec745c0802dec6921556265d3d2f7649a791a584::error::invalid_boost_bp_array_length());
        assert!(arg1.is_active, 0x470409f1f6d843025a1f14eec745c0802dec6921556265d3d2f7649a791a584::error::invalid_boost_bp_array_length());
        arg1.boost_bp = arg2;
    }

    // decompiled from Move bytecode v6
}

