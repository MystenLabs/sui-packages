module 0x30f630fd324043b965c0e986d697e205145adf829e057c3550bd5761c136066e::gtiamrust0 {
    struct GTIAMRUST0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTIAMRUST0, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTIAMRUST0>(arg0, 9, 0x1::string::utf8(b"GTIAMRUST0"), 0x1::string::utf8(b"rust"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/jkEa4r1sjjiwzgpA125mhBFUJjyJ_ssVR2oksaFnbbNRBfwmBWfFfkrw-_4KJl0CV3gFl_6FWNvDDu3dx9pb475_Vcl7Qfzm75Ctu_gu6evVOQkkd6CR8y6czj9QHjzfIrMoOd3aDc1_vAIkQiEIJk4znq1IUj3VgoN5-yeI77hNoHt4LUu_rblMduUB-Kn7pLtdZ1uI2ddD8eUkcTcjtJza4Q8YPkwHmjC5XTeOmviYEQiE1QYzXBcCiw3_8aCVJVHBNcEXMcONMdZ0DW4Sufh-BaxsFIbz0Pgf0DJSrVZUaFaNgptBi3Q0CQ09KhapOe8ZrNJW4FOYJieUBC6ObQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTIAMRUST0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTIAMRUST0>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

