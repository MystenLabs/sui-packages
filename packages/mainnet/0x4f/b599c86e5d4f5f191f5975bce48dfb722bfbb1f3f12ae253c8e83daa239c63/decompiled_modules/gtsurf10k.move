module 0x4fb599c86e5d4f5f191f5975bce48dfb722bfbb1f3f12ae253c8e83daa239c63::gtsurf10k {
    struct GTSURF10K has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSURF10K, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSURF10K>(arg0, 9, 0x1::string::utf8(b"GTSURF10K"), 0x1::string::utf8(b"Surf 10k"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/U_T3lMK8OLs8nAlqIZqYgzwS-y5VCwfPC5EL9gi-AorHC5VqUg1Geylag0ZeIrAtb6Or-r38KPuGk6exhl9z2U7pzSKqN4cDhmUrOpAIX3AjIT4eGMcGH3z_A2vD_h4M7JoFs6xzMxEv4kYlb-JKIlDaJzRIeQ83Y3HXJxEyaaAeZxl50Sk7QcaG2xnR_297BLcYwp95pOCS8-jbUYYpqWaMDSolItDN4L5p2lpwhuml9doop5L-P3pXpbdi6fX0XNd7Oalfvu75i2fjIRVTa7DsmnBuV8WR1hN_52_KNMZXzC_KdXUKy0cnsotJjtSN7lbULH13Zn77tqUyQi_5DQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSURF10K>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSURF10K>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

