module 0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::events {
    struct JetpackMinted has copy, drop {
        jetpack_id: u64,
        object_id: 0x2::object::ID,
        player: address,
        play_count: u64,
        highest_score: u64,
        total_distance: u64,
        total_zaps: u64,
        character: 0x1::string::String,
        jetpack_type: 0x1::string::String,
    }

    struct JetpackBurned has copy, drop {
        jetpack_id: u64,
        object_id: 0x2::object::ID,
        burned_by: address,
    }

    public(friend) fun emit_jetpack_burned(arg0: u64, arg1: 0x2::object::ID, arg2: address) {
        let v0 = JetpackBurned{
            jetpack_id : arg0,
            object_id  : arg1,
            burned_by  : arg2,
        };
        0x2::event::emit<JetpackBurned>(v0);
    }

    public(friend) fun emit_jetpack_minted(arg0: u64, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String) {
        let v0 = JetpackMinted{
            jetpack_id     : arg0,
            object_id      : arg1,
            player         : arg2,
            play_count     : arg3,
            highest_score  : arg4,
            total_distance : arg5,
            total_zaps     : arg6,
            character      : arg7,
            jetpack_type   : arg8,
        };
        0x2::event::emit<JetpackMinted>(v0);
    }

    // decompiled from Move bytecode v7
}

