module 0xd37b00d8e1ab0af10ece0692e4090a1b1128a746f041b86aaf26978b0860ed07::ptstb {
    struct PTSTB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTSTB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::creator_authority::new_account(x"2ecf75aaf182eb60508395645d4e76ebce07b90af8130c6314d2548955e281ad")
        } else {
            0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::creator_authority::new_address(0x2::address::from_bytes(x"2ecf75aaf182eb60508395645d4e76ebce07b90af8130c6314d2548955e281ad"))
        };
        0x2::transfer::public_transfer<0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::launch_ticket::LaunchTicket<PTSTB>>(0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::launch_ticket::new<PTSTB>(arg0, 9, 0x1::string::utf8(b"PTSTB"), 0x1::string::utf8(b"POPULAR test PTSTB"), 0x1::string::utf8(b"POPULAR integration test, not a real coin"), 0x1::string::utf8(b""), v0, true, 100, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

