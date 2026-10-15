module 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::competition {
    struct CompetitionConfig has key {
        id: 0x2::object::UID,
        boost_bp: vector<u64>,
        is_active: bool,
        program_name: 0x1::ascii::String,
        u64_padding: vector<u64>,
    }

    struct CompetitionStatusEvent has copy, drop {
        program_name: 0x1::ascii::String,
        is_active: bool,
    }

    public(friend) fun add_score(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::ecosystem::Version, arg2: &mut 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::leaderboard::TypusLeaderboardRegistry, arg3: &CompetitionConfig, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::version_check(arg0);
        if (0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::typus_hooks_disabled(arg0)) {
            return
        };
        if (!arg3.is_active) {
            return
        };
        let v0 = score_for(arg3, arg4);
        if (v0 > 0) {
            0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::add_competition_leaderboard(arg0, arg1, arg2, arg3.program_name, arg5, v0, arg6, arg7);
        };
    }

    entry fun new_competition_config(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: vector<u64>, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg3);
        assert!(0x1::vector::length<u64>(&arg1) == 8, 0);
        let v0 = CompetitionConfig{
            id           : 0x2::object::new(arg3),
            boost_bp     : arg1,
            is_active    : true,
            program_name : arg2,
            u64_padding  : 0x1::vector::empty<u64>(),
        };
        0x2::transfer::share_object<CompetitionConfig>(v0);
    }

    entry fun resume_competition_config(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut CompetitionConfig, arg2: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg2);
        if (!arg1.is_active) {
            arg1.is_active = true;
            let v0 = CompetitionStatusEvent{
                program_name : arg1.program_name,
                is_active    : true,
            };
            0x2::event::emit<CompetitionStatusEvent>(v0);
        };
    }

    fun score_for(arg0: &CompetitionConfig, arg1: u64) : u64 {
        (((arg1 as u128) * (*0x1::vector::borrow<u64>(&arg0.boost_bp, 0) as u128) / (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_bp_scale() as u128)) as u64)
    }

    entry fun set_boost_bp(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut CompetitionConfig, arg2: vector<u64>, arg3: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg3);
        assert!(0x1::vector::length<u64>(&arg2) == 8, 0);
        assert!(arg1.is_active, 2100);
        arg1.boost_bp = arg2;
    }

    entry fun suspend_competition_config(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut CompetitionConfig, arg2: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg2);
        if (arg1.is_active) {
            arg1.is_active = false;
            let v0 = CompetitionStatusEvent{
                program_name : arg1.program_name,
                is_active    : false,
            };
            0x2::event::emit<CompetitionStatusEvent>(v0);
        };
    }

    // decompiled from Move bytecode v7
}

