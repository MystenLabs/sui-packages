module 0xda1664866fa8e101414d53522042f056374188d2f0fa6fb510f694af584e739::jblue {
    struct JBLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JBLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::creator_authority::new_account(x"52ecee5e58e2f3a7461cc604f4efcc3b68031e4715456d821e3a2719b0593600")
        } else {
            0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::creator_authority::new_address(0x2::address::from_bytes(x"52ecee5e58e2f3a7461cc604f4efcc3b68031e4715456d821e3a2719b0593600"))
        };
        0x2::transfer::public_transfer<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::launch_ticket::LaunchTicket<JBLUE>>(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::launch_ticket::new<JBLUE>(arg0, 9, 0x1::string::utf8(b"JBLUE"), 0x1::string::utf8(b"Blast noncanonical bluefin test"), 0x1::string::utf8(b"Worthless token for on-chain journey tests"), 0x1::string::utf8(b""), v0, true, 100, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

