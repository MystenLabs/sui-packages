module 0xaee5c99f525ab61b66b092c31e5225261e8c4b72358a5b3c31be2338fdbda9e4::jemp {
    struct JEMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::creator_authority::new_account(x"52ecee5e58e2f3a7461cc604f4efcc3b68031e4715456d821e3a2719b0593600")
        } else {
            0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::creator_authority::new_address(0x2::address::from_bytes(x"52ecee5e58e2f3a7461cc604f4efcc3b68031e4715456d821e3a2719b0593600"))
        };
        0x2::transfer::public_transfer<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::launch_ticket::LaunchTicket<JEMP>>(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::launch_ticket::new<JEMP>(arg0, 9, 0x1::string::utf8(b"JEMP"), 0x1::string::utf8(b"Blast noncanonical opening-empty test"), 0x1::string::utf8(b"Worthless token for on-chain journey tests"), 0x1::string::utf8(b""), v0, true, 100, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

