module 0x2a868a56d32a46cb7590e52a5da5bb320000d251129c3b324b72c230a3d48573::nova {
    struct NOVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOVA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"2ec8f75c44ec10fc4bf6fbc95ee5904b2fc1f90b982a3984888511e01b4dfb91")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"2ec8f75c44ec10fc4bf6fbc95ee5904b2fc1f90b982a3984888511e01b4dfb91"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<NOVA>(arg0, 9, 0x1::string::utf8(b"NOVA"), 0x1::string::utf8(b"Nova"), 0x1::string::utf8(b"Every launch is a supernova. gonova.fun"), 0x1::string::utf8(b"https://gonova.fun/brand/pp.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<NOVA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NOVA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

