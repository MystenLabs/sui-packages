module 0x8f9358e060db0956f199867d99fcf250ab3bf6293b415cc52791abd0971059cc::gtemmybx {
    struct GTEMMYBX has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTEMMYBX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTEMMYBX>(arg0, 9, 0x1::string::utf8(b"GTEMMYBX"), 0x1::string::utf8(b"Emmy"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/VcqmYIOBPoVyrbgf-twP0tV6qMIPfFLfGHniX-0snQ8KGoNd5GI0vs_jOCErgHMeG66-yRsnCCkUUSOJtNsXZYUTynXhRPQA3ig4_cxjIkzKMy-X4rm1KVPQVZUaykNjzDTLfmjWgAbPxop_i4rnvm8nWeujjLOog3srp5EIItgeBNZY_74FGSkOLKaLshdRZOCaF92PDoJTVwysZTZuc3_316aiEoaOuKktwv9NOZ_m_oTRI61O1E4ICHiw9BCmFlmq7boyk-1-3sr4jYioQz5xg6TIYCbqPglm2StSLOBkMkjkN3AG2-70BXnyydPBE6FD2UloLr-ZNghQg2Yr2Q.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTEMMYBX>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTEMMYBX>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

