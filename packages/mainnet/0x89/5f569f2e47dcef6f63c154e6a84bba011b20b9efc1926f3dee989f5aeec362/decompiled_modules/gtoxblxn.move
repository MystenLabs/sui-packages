module 0x895f569f2e47dcef6f63c154e6a84bba011b20b9efc1926f3dee989f5aeec362::gtoxblxn {
    struct GTOXBLXN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTOXBLXN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTOXBLXN>(arg0, 9, 0x1::string::utf8(b"GTOXBLXN"), 0x1::string::utf8(b"Blxn"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/F5KtIMO851RQpJVRkk179tO9v2zZqS7vgptHzToSiJ-_F_xpeb6NYJZ95WwW1xFP6pOlb1J01L8-Ykd1a0UeQYbw9mR8jBskx7LgLAF1uL_6k5T1ywn2Tp663od9OWRVMcpT3H0myP0uk4SwP7cAuthc9UuGb4ruw8jOrzNA4h-E7xza66BN6WMBTvq8z_YRXeWlqULXiaMq78RLRLK89NTOGyuD6ILVww_EhRKZas5XXjXnLVfXydMqaKsffOvVs0SgZ5BwZzn8WCw9HrsrEpOjl9tXkbRn2wMMUY3a0rRF8FR7NFQbb2SqQPzvLECK7yNdcT2b0keEFOQ4f1lWhA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTOXBLXN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTOXBLXN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

