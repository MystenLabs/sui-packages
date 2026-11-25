module 0x64f4ff79f4076ecc2c389688cee0de1e6f12bdd62747f00c8e6e18fc4d172195::gtdevilles {
    struct GTDEVILLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTDEVILLES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTDEVILLES>(arg0, 9, 0x1::string::utf8(b"GTDEVILLES"), 0x1::string::utf8(b"Deville"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/klc1LxHM1lbRogbU8B9ZAnKWXPCDhAZJZ5ZOeFhEK7_RvXNqweV1Jh7JYRtPM253dKdd-vSC1MUysNxE56kxfEDyZ8Cj6-uyVIEtWBof5vGj9EhJ3t0tnfFLrYcNhRwMXX05-1ZLPl1HP7kVE6q7vZob6vkWMPOIb7ir5tKmRFouElAMdxG3dx3xPII82ChL_qkrsH6MGVYN0w9yFvZTgmXk_HgAw8T_sZss9tgn2_jJIRhI8YXPPm0K65GhajE9l3r7PgHkLDuzr8M1xk_JOhW12M_o2S1IYUAayYhTh0diqRTcOy_Pb5odCkg-Aph6B_YcDlmhWx7Sn6OzaIEiJA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTDEVILLES>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTDEVILLES>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

