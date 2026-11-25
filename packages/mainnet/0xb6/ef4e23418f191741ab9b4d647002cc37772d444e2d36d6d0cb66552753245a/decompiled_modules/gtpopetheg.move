module 0xb6ef4e23418f191741ab9b4d647002cc37772d444e2d36d6d0cb66552753245a::gtpopetheg {
    struct GTPOPETHEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTPOPETHEG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTPOPETHEG>(arg0, 9, 0x1::string::utf8(b"GTPOPETHEG"), 0x1::string::utf8(b"POPE"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/c0HsjN3J0RHrmnCukAy7Z8Now-DAfku8BrAI1826MrRABhkOKzikWFHAbPAbml4F1WucXCQIjDOKD6EtudERt8HTa8Jg7d-3oSldLjEFp-C5XsJvk_9l3tpCvmVxaMyXz7c7hlLELgY_JQE-nwT7C4PUrPX5ExWgZ3KDzco_zdHpRWTQJE_lF4RsZvmwEkpXPKmykPa5MZn_e5Czr1ypT7uE5BGMD4mxlfFcWzZBd0F1KZHyU6bePVOmQ-WhcLQ6qV0aaZh5150GyYn3zpILxo2Iau69gnlVUQTAUNRgEQYZa_6rTeIBQC1Ya9g3JXD5U0Xf1S98BWyE-0xUw9Kipw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTPOPETHEG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTPOPETHEG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

