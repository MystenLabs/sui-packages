module 0x1a901a7bbbb2a315d0ce7319c4aa659385f0432d0efb1b76e68404efcf32a3c3::Building {
    struct Foundation has copy, drop {
        patarian_id: u64,
        phantom_id: u64,
        phantom_addr: address,
        version: u64,
        group_no: u16,
        type_no: u16,
        next_level: u16,
        build_time_as_seconds: u64,
        proof: u64,
    }

    public fun UpgradeFoundation(arg0: u64, arg1: u64, arg2: u64, arg3: u16, arg4: u16, arg5: u16, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = Foundation{
            patarian_id           : arg0,
            phantom_id            : arg1,
            phantom_addr          : 0x2::tx_context::sender(arg8),
            version               : arg2,
            group_no              : arg3,
            type_no               : arg4,
            next_level            : arg5,
            build_time_as_seconds : arg6,
            proof                 : arg7,
        };
        0x2::event::emit<Foundation>(v0);
    }

    // decompiled from Move bytecode v6
}

