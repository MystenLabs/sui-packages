module 0x19856de6f63091f2e52f22884530e0eb1e494ea8440fc43d7afd0fc8ee0f041e::ptstc {
    struct PTSTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTSTC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::creator_authority::new_account(x"2ecf75aaf182eb60508395645d4e76ebce07b90af8130c6314d2548955e281ad")
        } else {
            0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::creator_authority::new_address(0x2::address::from_bytes(x"2ecf75aaf182eb60508395645d4e76ebce07b90af8130c6314d2548955e281ad"))
        };
        0x2::transfer::public_transfer<0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::launch_ticket::LaunchTicket<PTSTC>>(0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::launch_ticket::new<PTSTC>(arg0, 9, 0x1::string::utf8(b"PTSTC"), 0x1::string::utf8(b"POPULAR test PTSTC"), 0x1::string::utf8(b"POPULAR integration test, not a real coin"), 0x1::string::utf8(b""), v0, true, 100, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

