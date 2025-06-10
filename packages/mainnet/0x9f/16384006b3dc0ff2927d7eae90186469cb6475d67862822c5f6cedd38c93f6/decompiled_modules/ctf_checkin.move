module 0x9f16384006b3dc0ff2927d7eae90186469cb6475d67862822c5f6cedd38c93f6::ctf_checkin {
    struct CalculateFlagEvent has copy, drop {
        github_id: vector<u8>,
        flag_str: vector<u8>,
        flag: vector<u8>,
    }

    entry fun calculate_flag(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<vector<u8>>(&arg1);
        0x1::vector::append<u8>(&mut v0, arg0);
        let v1 = 0x1::hash::sha3_256(v0);
        let v2 = CalculateFlagEvent{
            github_id : arg0,
            flag_str  : arg1,
            flag      : v1,
        };
        0x2::event::emit<CalculateFlagEvent>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

