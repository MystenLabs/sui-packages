module 0xd8981588c8e00ef01655a586631a68a17b359f51525d5c6b7c4e0ebfac20116f::gtsuitheon {
    struct GTSUITHEON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSUITHEON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSUITHEON>(arg0, 9, 0x1::string::utf8(b"GTSUITHEON"), 0x1::string::utf8(b"Eternity.sui"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/PjsiEzrSvXyks-9vPxKBP4kPvhsgXHNCnrYLF3zoCs4g5CM-Mmil-GRazmO5tSHBaZvASMXskPxoT3y7Wv6k7vHV6DvXrstwrOc9JaTx3nMBueMY-aMJAq4wSckH927EuYgfYvzZVOwei_jWs_gm96g0c2gjzf7joEcxwofHWfXl6YpNhGt1WEk89pv5GB-HP6hUpFEqiRICVsatKIfmBSG-c4bh7Hb7kCIuYg1hZzjCBUFAG20CvheJz4LgpLp6XGPia1yoHFtCtRgXonBtrus8ECbPVXfBKCbEXQ8MTHo77OWOqryzTl6o2CApIXFqf4oYWuNewL-isiQ3mejeTw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSUITHEON>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSUITHEON>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

