module 0xfccf75cc7947ce3762bf63717235ad4d5f1e618b061d94fb93a3ff5a23cb026a::gtlongitud {
    struct GTLONGITUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTLONGITUD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTLONGITUD>(arg0, 9, 0x1::string::utf8(b"GTLONGITUD"), 0x1::string::utf8(b"PopArc"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/e5rib9TT9YDLSQ_CJbAiIGc85Mj3l8rHwJJbNoYh5k-fHG81JMcMICthAhzTvB1-polwiqkpRUdyJvYjrjpmWQIuA8kmQlM35c_QBdiBssOQKVrk-dHKSzXbdAJeFo48WkuYsU7yjsygMzb5jynFES-Ofy0VrrcZJH27DLYQA61F-zTF8xIYT-RbaVA3HjLFh91s31tmuOxWfnNAGcXCTPEqKRfuRLf6JuY2suLG6CgXZfzTXPpBQ6VuaKzOCmjN4wQld4lmjfo5bWP_3xB2u864B9LkNI_SYB0g-Q8a4jXcq7juB1s5oeAa4q8UxvqWBjMhvz-Nk9-SKo427MBcBA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTLONGITUD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTLONGITUD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

