module 0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::competition {
    struct CompetitionConfig has key {
        id: 0x2::object::UID,
        boost_bp: vector<u64>,
        is_active: bool,
        program_name: 0x1::ascii::String,
        u64_padding: vector<u64>,
    }

    public(friend) fun add_score(arg0: &0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::admin::Version, arg1: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg3: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::tails_staking::TailsStakingRegistry, arg4: &CompetitionConfig, arg5: u64, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::admin::version_check(arg0);
        let v0 = if (arg4.is_active) {
            *0x1::vector::borrow<u64>(&arg4.boost_bp, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::tails_staking::get_max_staking_level(arg1, arg3, arg6))
        } else {
            0
        };
        let v1 = (((arg5 as u128) * (v0 as u128) / 10000) as u64);
        if (v1 > 0) {
            0x21a4105ad68a7314d1842bd6b2ef72fcc46e41d58fb7e68403ed82b936686c52::admin::add_competition_leaderboard(arg0, arg1, arg2, arg4.program_name, arg6, v1, arg7, arg8);
        };
    }

    // decompiled from Move bytecode v6
}

